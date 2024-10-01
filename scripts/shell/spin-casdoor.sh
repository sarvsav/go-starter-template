#!/usr/bin/env bash

docker run  --rm -p 8010:8010 \
            --network go-starter-template \
            --name casdoor-app \
            -v $HOME/etc/casdoor/conf:/conf casbin/casdoor:latest