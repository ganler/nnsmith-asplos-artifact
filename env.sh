#!/bin/bash

cd "$(dirname "$0")"
[ -d "$(pwd)/venv" ] || python3 -m venv "$(pwd)/venv"
activate () {
    . $(pwd)/venv/bin/activate
    export PYTHONPATH="$(pwd)/sut/tvm/python:$(pwd)/nnsmith:$PYTHONPATH"
}

activate
