#!/bin/bash

paperspace jobs create \
    --container "docker.io/pathtrk/sent2vec:develop" \
    --machineType "C7" \
    --command "$1" \
    --project "sent2vec"
