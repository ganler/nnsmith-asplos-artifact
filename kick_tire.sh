#!/bin/bash

set -e
set -x

cd "$(dirname "$0")"/nnsmith

NNSMITH_DCE=0.1 LIB_PATH="$(pwd)/../sut/tvm/build/libtvm.so $(pwd)/../sut/tvm/build/libtvm_runtime.so" \
python nnsmith/fuzz.py --mode guided --time 20 \
                       --max_nodes 10 --eval_freq 10 \
                       --backend tvm --root kk-tire-tvm

NNSMITH_DCE=0.1 LIB_PATH="$(pwd)/../sut/onnxruntime/build/Linux/RelWithDebInfo/libonnxruntime_providers_shared.so $(pwd)/../sut/onnxruntime/build/Linux/RelWithDebInfo/libonnxruntime.so" \
python nnsmith/fuzz.py --mode guided --time 20 \
                       --max_nodes 10 --eval_freq 10 \
                       --backend ort --root kk-tire-ort
