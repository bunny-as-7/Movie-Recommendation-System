
set -euo pipefail

source util.sh

main() {
  # Get our working project, or exit if it's not set.
  local project_id=$(get_project_id)
  if [[ -z "$project_id" ]]; then
    exit 1
  fi
  # Because our included app uses query string parameters, we can include
  # them directly in the URL. We use -H to specify a header with our API key.
  QUERY="curl -H 'x-api-key: $API_KEY' \"https://${project_id}.appspot.com/recommendation?userId=${USER_ID}\""
  # First, print the command so the user can see what's being executed.
  echo "$QUERY"
  # Then actually execute it.
  # shellcheck disable=SC2086
  eval $QUERY
  # Our API doesn't print newlines. So we do it ourselves.
  printf '\n'
}

# Defaults.
USER_ID="5448543647176335931"

if [[ "$#" == 1 ]]; then
  API_KEY="$1"
elif [[ "$#" == 2 ]]; then
  # "Quiet mode" won't print the curl command.
  API_KEY="$1"
  USER_ID="$2"
else
  echo "Wrong number of arguments specified."
  echo "Usage: query_api_auth.sh api-key [user-id]"
  exit 1
fi

main "$@"
