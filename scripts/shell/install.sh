#!/usr/bin/env bash

set -euo pipefail

# This script will install the dependencies required for the project

go install github.com/bufbuild/buf/cmd/buf@v1.32.1
go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
go install github.com/nats-io/natscli/nats@latest
go install github.com/nats-io/nats-server/v2@latest