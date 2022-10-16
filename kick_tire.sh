#!/bin/bash

set -e
set -x

# shellcheck source=/dev/null
source "$(dirname "$0")"/env.sh
cd "$(dirname "$0")"/nnsmith

# Make sure the commit is correct.
git checkout 620645967a14d6a7b077cedd9c2c03ed74af50d9

NNSMITH_DCE=0.1 LIB_PATH="$(pwd)/../sut/tvm/build/libtvm.so $(pwd)/../sut/tvm/build/libtvm_runtime.so" \
python nnsmith/fuzz.py --mode guided --time 20 \
                       --max_nodes 10 --eval_freq 10 \
                       --backend tvm --root kk-tire-tvm

NNSMITH_DCE=0.1 LIB_PATH="$(pwd)/../sut/onnxruntime/build/Linux/RelWithDebInfo/libonnxruntime_providers_shared.so $(pwd)/../sut/onnxruntime/build/Linux/RelWithDebInfo/libonnxruntime.so" \
python nnsmith/fuzz.py --mode guided --time 20 \
                       --max_nodes 10 --eval_freq 10 \
                       --backend ort --root kk-tire-ort
