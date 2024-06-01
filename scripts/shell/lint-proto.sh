#!/usr/bin/env bash

set -euo pipefail

# This script is used to lint the proto files in the repository.

## Verify api-linter has been installed or not. If not, install it.
install_api_linter() {
  if ! command -v api-linter &> /dev/null; then
    echo "api-linter is not installed. Installing it..."
    go install github.com/googleapis/api-linter/cmd/api-linter@latest
  fi
  echo "api-linter is installed."
}

## lint proto files uses api-linter and takes $1 as the directory to lint
lint_proto_files() {
  local dir=$1
  if [ -z "$dir" ]; then
    echo "Directory is not provided. Please provide the directory to lint."
    exit 1
  fi

  if [ ! -d "$dir" ]; then
    echo "Directory $dir does not exist."
    exit 1
  fi

  echo "Linting proto files in $dir..."

  ### find all proto files in dir as well as subdirectories to lint
  local proto_files
  proto_files=$(find "$dir" -name "*.proto")

  ### run api-linter on each proto file and save the result
  for file in $proto_files; do
    echo "Linting $file..."
    api-linter "$file" --proto-path=proto/ --output-format=json --output-path=reports/linter/proto/results.json
  done

  echo "Proto files linted successfully and results are saved in reports/linter/proto/results.json"
}

## prettify the json report using jq
prettify_json_report() {
  local report=$1
  if [ -f "$report" ]; then
    echo "Prettifying the json report..."
    jq . "$report" >"$report.tmp" && mv "$report.tmp" "$report"
    echo "Json report prettified successfully."
  else
    echo "Json report $report does not exist."
  fi
}

main() {
  install_api_linter
  lint_proto_files "$1"
  prettify_json_report reports/linter/proto/results.json
}

main "$@"
