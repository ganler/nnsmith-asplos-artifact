#!/bin/bash

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
[ -d "$(pwd)/tvm" ] ||  git clone https://github.com/ganler/tvm.git --recursive
cd tvm || exit 1
git checkout coverage
git checkout 3d2b032917078c2efec26631ed4b0b504589bf3a
mkdir -p build && cd build || exit 1
cmake .. -DCMAKE_BUILD_TYPE=Release \
         -DCMAKE_CXX_COMPILER="$(which clang++-14)" -DCMAKE_C_COMPILER="$(which clang-14)" \
         -DCMAKE_EXPORT_COMPILE_COMMANDS=1 \
         -DUSE_MEMCOV=0 -DUSE_ASTCOV=1 \
         -DUSE_LLVM="$(which llvm-config-14)"
make -j"$(nproc)"
echo "To use TVM: export PYTHONPATH=$(realpath ../python)"

cd ..
python3 python/gen_requirements.py
python3 -m pip install -r python/requirements/core.txt
