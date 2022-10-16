#!/bin/bash

set -e
set -x

# ====================================
# It can take 4 x 4 = 8 hours to run.
# ====================================
# This file will run NNSmith-binning:
# on       TVM & ORT
# (`guided` means `binning`)
# ====================================
# Output:
#  - `nnsmith-tvm-binning/`
#  - `nnsmith-ort-binning/`
# ====================================

export NNSMITH_DCE=0.1

# shellcheck source=/dev/null
source "$(dirname "$0")"/env.sh
cd "$(dirname "$0")"/nnsmith || exit 1
# Also see: https://github.com/ise-uiuc/nnsmith/blob/620645967a14d6a7b077cedd9c2c03ed74af50d9/README.md#coverage-evaluation

# Make sure the commit is correct.
git checkout 620645967a14d6a7b077cedd9c2c03ed74af50d9

# Remove old coverage files
[ -f default.profraw ] && rm default.profraw
# Make sure TVM/ORT dtype support config file is generated.
mkdir -p config
python3 nnsmith/dtype_test.py --cache config/ort_cpu_dtype.pkl

# TVM.
LIB_PATH="$(pwd)/../sut/tvm/build/libtvm.so $(pwd)/../sut/tvm/build/libtvm_runtime.so"
export LIB_PATH
start_time=$(date +%s)
python3 nnsmith/fuzz.py --time 14400 --max_nodes 10 --eval_freq 256 \
                --mode guided --backend tvm --root nnsmith-tvm-binning
exp0_t=$(($(date +%s) - start_time))

# ONNXRuntime.
LIB_PATH="$(pwd)/../sut/onnxruntime/build/Linux/RelWithDebInfo/libonnxruntime_providers_shared.so $(pwd)/../sut/onnxruntime/build/Linux/RelWithDebInfo/libonnxruntime.so"
export LIB_PATH

start_time=$(date +%s)
python3 nnsmith/fuzz.py --time 14400 --max_nodes 10 --eval_freq 256 \
                --mode guided --backend ort --root nnsmith-ort-binning
exp1_t=$(($(date +%s) - start_time))

echo "Experiment time of last 4 runs: '$exp0_t','$exp1_t' seconds."

echo "Merging coverage..."
python3 experiments/cov_merge.py -f nnsmith-tvm-binning nnsmith-ort-binning
