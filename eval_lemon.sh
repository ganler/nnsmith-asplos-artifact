#!/bin/bash

set -e
set -x

source "$(dirname "$0")"/env.sh
cd "$(dirname "$0")"/nnsmith || exit 1

LEMON_ONNX="$(pwd)/../data/lemon-onnx"
export LEMON_ONNX

# skip if not exists
[ -d "$LEMON_ONNX" ] || ( echo "Skip evaluating LEMON as $LEMON_ONNX is not available" && exit 0 )

# Remove old coverage files
[ -f default.profraw ] && rm default.profraw

python3 experiments/cov_eval.py --model_dir $LEMON_ONNX   \
                               --report_folder lemon-tvm \
                               --backend tvm --lib "$(pwd)/../sut/tvm/build/libtvm.so $(pwd)/../sut/tvm/build/libtvm_runtime.so" \
                               --llvm-version 14 # if you compile tvm w/ llvm 14 instrumented on ubuntu.
# For ORT:
python3 experiments/cov_eval.py --model_dir $LEMON_ONNX \
                               --report_folder lemon-ort \
                               --backend ort \
                               --lib "$(pwd)/../sut/onnxruntime/build/Linux/RelWithDebInfo/libonnxruntime_providers_shared.so $(pwd)/../sut/onnxruntime/build/Linux/RelWithDebInfo/libonnxruntime.so" \
                               --llvm-version 14
python3 experiments/cov_merge.py -f lemon-tvm lemon-ort # generate merged_cov.pkl
