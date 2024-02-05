DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

source $DIR/buildVersionedExecutable.sh
source $DIR/runAndQuitRawBinaryToTest.sh
source $DIR/buildDockerImage.sh
source $DIR/runAndQuitInsideDockerToTest.sh

function buildContainer {
  local githubOrg=$1
  local pgmName=$2
  local version=$3
  local testPort=$4
  local tmpDir=$(mktemp -d)

  echo tmpDir=$tmpDir
  buildVersionedExecutable $tmpDir $githubOrg $pgmName $version
  runAndQuitRawBinaryToTest $tmpDir $pgmName $testPort

  buildDockerImage $tmpDir $pgmName $version
  docker images --no-trunc | grep $pgmName
  sleep 4
  runAndQuitInsideDockerToTest $pgmName $version $testPort
}
