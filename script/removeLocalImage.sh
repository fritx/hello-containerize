function removeLocalImage {
  local pgmName=$1
  local version=$2

  echo docker rmi $pgmName:$version
  docker rmi $pgmName:$version
  id=$(docker images | grep $pgmName | grep " $version " | awk '{printf $3}')
  echo docker rmi -f $id
  docker rmi -f $id
}
