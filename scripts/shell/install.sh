#!/usr/bin/env bash

set -euo pipefail

# This script will install the dependencies required for the project

go install github.com/bufbuild/buf/cmd/buf@v1.32.1
