function pushToDockerHub {
  local dockerUser=$1
  local pgmName=$2
  local version=$3

  local repoName=$pgmName

  local id=$(docker images |\
      grep $pgmName | grep " $version " | awk '{printf $3}')
  docker tag $id $dockerUser/$repoName:$version
  docker push $dockerUser/$repoName:$version
}
