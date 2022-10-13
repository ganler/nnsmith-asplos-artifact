#!/bin/bash

set -e
set -x

cd "$(dirname "$0")"/nnsmith || exit 1

LEMON_ONNX="$(pwd)/../data/lemon-onnx"
export LEMON_ONNX

# Remove old coverage files
rm default.profraw

python experiments/cov_eval.py --model_dir $LEMON_ONNX   \
                               --report_folder lemon-tvm \
                               --backend tvm --lib "$(pwd)/../sut/tvm/build/libtvm.so $(pwd)/../sut/tvm/build/libtvm_runtime.so" \
                               --llvm-version 14 # if you compile tvm w/ llvm 14 instrumented on ubuntu.
# For ORT:
python experiments/cov_eval.py --model_dir $LEMON_ONNX \
                               --report_folder lemon-ort \
                               --backend ort \
                               --lib "$(pwd)/../sut/onnxruntime/build/Linux/RelWithDebInfo/libonnxruntime_providers_shared.so $(pwd)/../sut/onnxruntime/build/Linux/RelWithDebInfo/libonnxruntime.so" \
                               --llvm-version 14
python experiments/cov_merge.py -f lemon-tvm lemon-ort # generate merged_cov.pkl
