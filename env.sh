#!/bin/bash

cd "$(dirname "$0")" || exit 1
[ -d "$(pwd)/venv" ] || python3 -m venv "$(pwd)/venv"
activate () {
    # shellcheck source=/dev/null
    . "$(pwd)/venv/bin/activate"
    PYTHONPATH="$(pwd)/sut/tvm/python:$(pwd)/nnsmith:$PYTHONPATH"
    export PYTHONPATH
}

activate
