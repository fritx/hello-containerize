function buildVersionedExecutable {
  local tmpDir=$1
  local githubUser=$2
  local pgmName=$3
  local version=$4

  local package=github.com/${githubUser}/${pgmName}
  local newPgm=$tmpDir/${pgmName}_${version}

  # go: go.mod file not found in current directory or any parent directory.
  #         'go get' is no longer supported outside a module.
  #         To build and install a command, use 'go install' with a version,
  #         like 'go install example.com/cmd@latest'
  #         For more information, see https://golang.org/doc/go-get-install-deprecation
  #         or run 'go help get' or 'go help install'.
  # GOPATH=$tmpDir go get -d $package
  GOPATH=$tmpDir go install $package@latest

  cat $tmpDir/pkg/mod/${package}@v*/${pgmName}.go |\
      sed 's/version = 0/version = '${version}'/' \
      >${newPgm}.go

  echo Compiling ${newPgm}.go
  GOPATH=$tmpDir CGO_ENABLED=0 GOOS=linux go build \
      -o $tmpDir/${pgmName} \
      -a -installsuffix cgo ${newPgm}.go
}
