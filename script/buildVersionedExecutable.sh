function buildVersionedExecutable {
  local tmpDir=$1
  local githubUser=$2
  local pgmName=$3
  local version=$4

  local package=github.com/${githubUser}/${pgmName}
  local newPgm=$tmpDir/${pgmName}_${version}

  GOPATH=$tmpDir go get -d $package

  cat $tmpDir/src/${package}/${pgmName}.go |\
      sed 's/version = 0/version = '${version}'/' \
      >${newPgm}.go

  echo Compiling ${newPgm}.go
  GOPATH=$tmpDir CGO_ENABLED=0 GOOS=linux go build \
      -o $tmpDir/${pgmName} \
      -a -installsuffix cgo ${newPgm}.go
}
