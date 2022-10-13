# Evaluating artifact

## Coverage experiments

| Experiment ID | NNSmith[base] | NNSmith[binning] | GraphFuzzer  | LEMON        |
| ------------- | ------------- | ---------------- | ------------ | ------------ |
| TVM           | [E1](exp-e1)  | [E1](exp-e1)     | [E2](exp-e2) | [E3](exp-e3) |
| ONNXRuntime   | [E1](exp-e1)  | [E1](exp-e1)     | [E2](exp-e2) | [E3](exp-e3) |


```{note}
We call `ONNXRuntime` as "ORT" for short.
```

```{admonition} Expect time cost
:class: tip
- `32` hour **machine** time;
- `1` hour **human** time;
```

### TL;DR

If you want to evaluate the artifact in the fastest way:

- Just run this in a [tmux](https://github.com/tmux/tmux/wiki) session;

```shell
bash artifact/eval_nnsmith.sh      # 16hr
bash artifact/eval_graphfuzzer.sh  # 11hr
bash artifact/eval_lemon.sh        # 5hr
```

- Come back 1.5 days later;
- Jump to the [result visualization section](viz-sec) to verify the results.

Or if you want to understand the scripts you are running, you can continue reading the following sub-sections (about 15-min read).

(exp-e1)=
### E1: Collecting NNSmith coverage

``````{admonition} E1: Evaluating NNSmith on {tvm, ort} x {base, binning}
:class: important

- **Fuzzer type**:
    - NNSmith base;
    - NNSmith binning;
- **System under test (SUT)**:
    - TVM (LLVM CPU backend);
    - ONNXRuntime (CPU backend);
- **Experiment time**: 16 hours;
- **Outputs** (will be used in [visualization section](viz-sec)):
    - `nnsmith-tvm-base/`
    - `nnsmith-tvm-binning/`
    - `nnsmith-ort-base/`
    - `nnsmith-ort-binning/`
- **Script**:
```shell
cd /artifact # In the container
bash eval_nnsmith.sh
```
``````

(exp-e2)=
### E2: Collecting GraphFuzzer coverage


``````{admonition} E2: Evaluating GraphFuzzer on {tvm, ort}
:class: important

- **Fuzzer type**: GraphFuzzer;
- **System under test (SUT)**:
    - TVM (LLVM CPU backend);
    - ONNXRuntime (CPU backend);
- **Experiment time**: 11 hours;
- **Outputs** (will be used in [visualization section](viz-sec)):
    - `graphfuzzer-tvm/`
    - `graphfuzzer-ort/`
- **Script**:
```shell
cd /artifact # In the container
bash eval_graphfuzzer.sh
```
``````

(exp-e3)=
### E3: Collecting LEMON coverage

``````{admonition} E3: Evaluate LEMON on {tvm, ort}
:class: important

- **Fuzzer type**: LEMON;
- **System under test (SUT)**:
    - TVM (LLVM CPU backend);
    - ONNXRuntime (CPU backend);
- **Experiment time**: up-to 5 hours;
- **Outputs** (will be used in [visualization section](viz-sec)):
    - `lemon-tvm/`
    - `lemon-ort/`
- **Script**:
```shell
cd /artifact # In the container
bash eval_lemon.sh
```

```{warning} **Pre-built LEMON models.**
Due to the complexity and intensive storage cost of running LEMON, the LEMON models are pre-generated and pre-converted for convenience.
The scripts above are evaluating the models offline to get coverage.
```
``````

(viz-sec)=
## Visualizing and understanding results

```{admonition} Randomness in Experiments
:class: caution
Note that there will be randomness in fuzzing given different system performance and random seeds.
This means detailed reproduced data might not be strictly equivalent to that presented in the paper, but the overall trend should be consistent in the long run (say 4 hours).
```