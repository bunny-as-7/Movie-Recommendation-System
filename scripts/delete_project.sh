source util.sh

main() {
  local project_id="$(get_project_id)"
  if [[ -z "$project_id" ]]; then
    exit 1
  fi
  gcloud -q projects delete "$project_id"
}

main "$@"
