# Evaluating artifact

## Coverage experiments

| Experiment ID | NNSmith[base]      | NNSmith[binning]   | GraphFuzzer        | LEMON              |
| ------------- | ------------------ | ------------------ | ------------------ | ------------------ |
| TVM           | [E1](exp-e1) (4hr) | [E1](exp-e1) (4hr) | [E2 ](exp-e2)(4hr) | [E3](exp-e3) (2hr) |
| ONNXRuntime   | [E1](exp-e1) (4hr) | [E1](exp-e1) (4hr) | [E2](exp-e2) (4hr) | [E3](exp-e3) (2hr) |


```{note}
We call `ONNXRuntime` as "ORT" for short.
```

```{admonition} Expected time cost
:class: tip
- `28` hour **machine** time;
- `1` hour **human** time;
```

### TL;DR

Evaluate the artifact in the fastest way:

- Just run this in a [tmux](https://github.com/tmux/tmux/wiki) session;

:::{dropdown} **Script**
:open:
:icon: code
:color: light
```shell
bash /artifact/eval_nnsmith.sh;      \
bash /artifact/eval_graphfuzzer.sh;  \
bash /artifact/eval_lemon.sh
```
:::

- Come back 1.5 days later;
- Jump to the [result visualization section](viz-sec) to verify the results.

Or if you want to understand the scripts you are running, you can continue reading the following sub-sections (about 15-min read).

(exp-e1)=
### E1: NNSmith Coverage

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

:::{dropdown} **Script**
:open:
:icon: code
:color: light
```shell
cd /artifact # In the container
bash eval_nnsmith.sh
```
:::

``````

(exp-e2)=
### E2: GraphFuzzer Coverage


``````{admonition} E2: Evaluating GraphFuzzer on {tvm, ort}
:class: important

- **Fuzzer type**: GraphFuzzer;
- **System under test (SUT)**:
    - TVM (LLVM CPU backend);
    - ONNXRuntime (CPU backend);
- **Experiment time**: 8 hours;
- **Outputs** (will be used in [visualization section](viz-sec)):
    - `graphfuzzer-tvm/`
    - `graphfuzzer-ort/`

:::{dropdown} **Script**
:open:
:icon: code
:color: light
```shell
cd /artifact # In the container
bash eval_graphfuzzer.sh
```
:::
``````

(exp-e3)=
### E3: LEMON Coverage

``````{admonition} E3: Evaluate LEMON on {tvm, ort}
:class: important

```{dropdown} **Pre-generated LEMON models**
:color: warning
:icon: unlock

Evaluating LEMON in NNSmith's setting is very complicated ([why?](gen-lemon)).
For reviewers' convenience, the LEMON models are pre-generated and pre-converted (see `-v /data/artifact:/...` in the [docker command](org-setup)).
```

```{admonition} **This section is *only* available for the *original* test-bed**
:class: warning

This section won't work out of the box if you are working on <u>your own machine</u>.
Some complicated [steps](gen-lemon) are needed to generate LEMON models, but you might skip it as it's not a mandatory baseline for NNSmith.
```

- **Fuzzer type**: LEMON;
- **System under test (SUT)**:
    - TVM (LLVM CPU backend);
    - ONNXRuntime (CPU backend);
- **Experiment time**: 4 hours;
- **Outputs** (will be used in [visualization section](viz-sec)):
    - `lemon-tvm/`
    - `lemon-ort/`

:::{dropdown} **Script**
:open:
:icon: code
:color: light
```shell
cd /artifact # In the container
bash eval_lemon.sh
```
:::
``````

(viz-sec)=
## Visualizing and understanding results

```{dropdown} Randomness in Experiments
:color: warning
:icon: alert

Note that there will be randomness in fuzzing given different system performance and random seeds.
This means detailed reproduced data might not be strictly equivalent to that presented in the paper, but the overall trend should be consistent in the long run (say 4 hours).
```
