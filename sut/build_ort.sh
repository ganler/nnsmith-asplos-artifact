#!/bin/bash

source "$(dirname "$0")"/../env.sh
cd "$(dirname "$0")" || exit 1
# check clang-14
if ! command -v clang++-14 &> /dev/null; then
    echo "clang++-14 could not be found"
    exit 1
fi
# check llvm-cov-14
if ! command -v llvm-cov-14 &> /dev/null; then
    echo "llvm-cov-14 could not be found"
    exit 1
fi
git clone https://github.com/ganler/onnxruntime.git --recursive
cd onnxruntime || exit 1
git checkout coverage
git checkout 78374844aa048b36bd81a8f8e921367406952fd2

./build.sh --config RelWithDebInfo --build_shared_lib --parallel --build_wheel --skip_tests
python3 -m pip install build/Linux/RelWithDebInfo/dist/*.whl
