#!/bin/bash

set -e
set -x

cd "$(dirname "$0")"/nnsmith || exit 1
DATA_DRIVE="$(pwd)/../data"
export DATA_DRIVE
# Note this does not need to be full 4 hours because it only takes "generation" into account.
# While evaluation time will pad it until 4 full hours are reached.
export TVM_TIME_BUDGET=3600  # TVM evaluation time is way slower than generation time.
                             # Models generated in 1hr can take even 8hr to evaluate.
                             # So 1hr generation time is way enough for TVM.
export ORT_TIME_BUDGET=12000 # ORT evaluation is fast so we should be conservative.

# Remove old coverage files
rm default.profraw
# Make sure TVM/ORT dtype support config file is generated.
python3 nnsmith/dtype_test.py --cache config/ort_cpu_dtype.pkl
# TVM
python3 experiments/graphfuzz.py --time_budget $TVM_TIME_BUDGET --onnx_dir "$DATA_DRIVE"/graphfuzzer-tvm-onnx
python3 experiments/cov_eval.py --model_dir "$DATA_DRIVE"/graphfuzzer-tvm-onnx    \
                               --report_folder graphfuzzer-tvm \
                               --backend tvm --lib "$(pwd)/../sut/tvm/build/libtvm.so $(pwd)/../sut/tvm/build/libtvm_runtime.so" \
                               --llvm-version 14

# ORT
python3 experiments/graphfuzz.py --time_budget $ORT_TIME_BUDGET --onnx_dir "$DATA_DRIVE"/graphfuzzer-ort-onnx --ort_cache config/ort_cpu_dtype.pkl
python3 experiments/cov_eval.py --model_dir "$DATA_DRIVE"/graphfuzzer-ort-onnx \
                               --report_folder graphfuzzer-ort \
                               --backend ort \
                               --lib "$(pwd)/../sut/onnxruntime/build/Linux/RelWithDebInfo/libonnxruntime_providers_shared.so $(pwd)/../sut/onnxruntime/build/Linux/RelWithDebInfo/libonnxruntime.so" \
                               --llvm-version 14

python3 experiments/cov_merge.py -f graphfuzzer-tvm graphfuzzer-ort # generate merged_cov.pkl
