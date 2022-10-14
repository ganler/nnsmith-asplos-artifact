#!/bin/bash

[ -d "$(dirname "$0")/venv" ] || python3 -m venv "$(dirname "$0")/venv"
activate () {
    # shellcheck source=/dev/null
    . "$(dirname "$0")/venv/bin/activate"
    PYTHONPATH="$(dirname "$0")/sut/tvm/python:$(dirname "$0")/nnsmith:$PYTHONPATH"
    export PYTHONPATH
}

activate
