function runAndQuitRawBinaryToTest {
  local tmpDir=$1
  local pgmName=$2
  local port=$3

  echo Running server $tmpDir/$pgmName
  ALT_GREETING=salutations \
      $tmpDir/$pgmName --enableRiskyFeature --port $port &

  # Let it get ready
  sleep 2

  # Dump html to stdout
  curl --fail --silent -m 1 localhost:$port/godzilla

  # Send query of death
  curl --fail --silent -m 1 localhost:$port/quit
  echo Server stopped
}
