#!/bin/bash

set -e
set -x

source "$(dirname "$0")"/env.sh
cd "$(dirname "$0")" || exit 1

python3 -m pip install -r "$(pwd)/nnsmith_requirements.txt"
[ -d "$(pwd)/nnsmith" ] || git clone https://github.com/ise-uiuc/nnsmith.git
cd nnsmith && git checkout 620645967a14d6a7b077cedd9c2c03ed74af50d9
