function runAndQuitInsideDockerToTest {
  local pgmName=$1
  local version=$2
  local port=$3

  echo Docker run, mapping $port to internal 8080
  docker run -d -p $port:8080 $pgmName:$version
  sleep 3
  docker ps | grep $pgmName

  echo Requesting docker server
  curl -m 1 localhost:$port/kingGhidorah
  curl -m 1 localhost:$port/quit
}
