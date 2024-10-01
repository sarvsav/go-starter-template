#!/usr/bin/env bash

docker run  --rm \
            --publish 3307:3307 \
            --name casdoor-dolt-sql-server \
            --network go-starter-template \
            --volume $HOME/opt/dolt/data:/data \
            --volume $HOME/etc/dolt:/etc/dolt \
            dolthub/dolt-sql-server:latest --config /etc/dolt/config.yaml