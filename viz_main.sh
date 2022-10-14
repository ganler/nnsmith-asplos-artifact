#!/bin/bash

set -e
set -x

# shellcheck source=/dev/null
source "$(dirname "$0")"/env.sh
LEMON_ONNX_DIR=$(realpath "$(dirname "$0")"/data/lemon-onnx)
cd nnsmith

# Go to tag which uses the exact plotting scripts.
git checkout 5873a77734e25868912219d853dfc6bc0a210ace

if [ -d "$LEMON_ONNX_DIR" ]; then
    echo "$LEMON_ONNX_DIR found. Taking LEMON baseline into visualization."
    # TVM coverage.
    python experiments/viz_merged_cov.py --folders lemon-tvm graphfuzzer-tvm nnsmith-tvm-binning --tvm \
                                        --tags 'LEMON' 'GraphFuzzer' 'NNSmith' --venn \
                                        --output tvm-cov
    # ORT coverage.
    python experiments/viz_merged_cov.py --folders lemon-ort graphfuzzer-ort nnsmith-ort-binning --ort \
                                        --tags 'LEMON' 'NNSmith' 'GraphFuzzer' --venn \
                                        --output ort-cov
else
    echo "$LEMON_ONNX_DIR not found. Skiping LEMON baseline in visualization."
    # TVM coverage.
    python experiments/viz_merged_cov.py --folders graphfuzzer-tvm nnsmith-tvm-binning --tvm \
                                        --tags 'GraphFuzzer' 'NNSmith' --venn \
                                        --output tvm-cov
    # ORT coverage.
    python experiments/viz_merged_cov.py --folders graphfuzzer-ort nnsmith-ort-binning --ort \
                                        --tags 'GraphFuzzer' 'NNSmith' --venn \
                                        --output ort-cov
fi

# Go back.
git checkout 620645967a14d6a7b077cedd9c2c03ed74af50d9
