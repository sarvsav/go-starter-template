#!/usr/bin/env bash

## list all proto files inside project_root/proto directory excluding google directory
function list_all_protofiles {
    find ./proto -type f -name "*.proto" -not -path "./proto/google/*"
}

## Using protoc to generate protobuffer for the file
function generate_protobuffer {
    # Generate protobuffer for the file
    protoc --go_out=gen -I./proto --go_opt=paths=source_relative --go-grpc_out=gen --go-grpc_opt=paths=source_relative "$1"
}

## main function
function main {
    # Use output from list_all_protofiles function to print one by one
    for file in $(list_all_protofiles); do
        echo "Generating protobuffer for $file"
        # Generate protobuffer for each file
        generate_protobuffer "$file"
    done
}

main
