
set -euo pipefail

source util.sh

main() {
  # Get our working project, or exit if it's not set.
  local project_id=$(get_project_id)
  if [[ -z "$project_id" ]]; then
    exit 1
  fi
  local url="https://${project_id}.appspot.com/recommendation?userId=${USER_ID}&numRecs=${NUM_RECS}"
  echo "This command will exit automatically in $TIMEOUT_SECONDS seconds."
  echo "Generating traffic to ${url}..."
  echo "Press Ctrl-C to stop."
  local endtime=$(($(date +%s) + $TIMEOUT_SECONDS))
  # Send queries repeatedly until TIMEOUT_SECONDS seconds have elapsed.
  while [[ $(date +%s) -lt $endtime ]]; do
    curl "$url" &> /dev/null
  done
}

# Defaults.
USER_ID="5448543647176335931"
NUM_RECS=5
TIMEOUT_SECONDS=$((5 * 60)) # Timeout after 5 minutes.

if [[ "$#" == 0 ]]; then
  : # Use defaults.
elif [[ "$#" == 1 ]]; then
  USER_ID="$1"
else
  echo "Wrong number of arguments specified."
  echo "Usage: generate_traffic.sh [user_id]"
  exit 1
fi

main "$@"
