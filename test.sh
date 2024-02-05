#!/bin/sh

set -e

source script/buildContainer.sh
source script/pushToDockerHub.sh
source script/removeLocalImage.sh

# login
printf "\nEnter docker password, followed by C-d: "
docker login --username=$dockerUser --password-stdin

# doVersion1
buildContainer $githubOrg hello 1 8999
pushToDockerHub $dockerUser hello 1

# doVersion2
buildContainer $githubOrg hello 2 8999
pushToDockerHub $dockerUser hello 2

##########################################
# Remove the images from the local cache, then run them.
# This forces a new pull.
removeLocalImage hello 1
removeLocalImage hello 2

docker run -d -p 8999:8080 docker.io/$dockerUser/hello:1
curl -m 1 localhost:8999/shouldBeV1
curl -m 1 localhost:8999/quit

docker run -d -p 8999:8080 docker.io/$dockerUser/hello:2
curl -m 1 localhost:8999/shouldBeV2
curl -m 1 localhost:8999/quit
