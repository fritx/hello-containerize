function buildDockerImage {
  local tmpDir=$1
  local pgmName=$2
  local version=$3

  # Repo holds just one image, give repo same name as image.
  local dockerRepo=$pgmName

  local dockerFile=$tmpDir/Dockerfile
  cat <<EOF >$dockerFile
FROM scratch
ADD $pgmName /
CMD ["/$pgmName"]
EOF
  echo Docker build
  docker build -t $dockerRepo:$version -f $dockerFile $tmpDir
  echo End docker build
}
