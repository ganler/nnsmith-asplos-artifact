# Evaluating artifact

## Coverage experiments

We will go through the main experiments corresponding to Section 5.2 in the paper, which evaluates end-to-end coverage efficiency of NNSmith and baselines.

```{admonition} Expected time cost
:class: tip
- `20` hour **machine** time;
- `1` hour **human** time;
```

| Experiment ID | NNSmith[binning]   | GraphFuzzer        | LEMON              |
| ------------- | ------------------ | ------------------ | ------------------ |
| TVM           | [E1](exp-e1) (4hr) | [E2 ](exp-e2)(4hr) | [E3](exp-e3) (2hr) |
| ONNXRuntime   | [E1](exp-e1) (4hr) | [E2](exp-e2) (4hr) | [E3](exp-e3) (2hr) |

```{note}
We call `ONNXRuntime` as "ort" for short.
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

Or if you want to understand the scripts being executed, you can continue reading the following sub-sections ([E1](exp-e1)~[E3](exp-e3)).

(exp-e1)=
### E1: NNSmith Coverage

``````{admonition} E1: Evaluating NNSmith on {tvm, ort}
:class: important

- **Fuzzer type**:
    - NNSmith base;
    - NNSmith binning;
- **System under test (SUT)**:
    - TVM (LLVM CPU backend);
    - ONNXRuntime (CPU backend);
- **Experiment time**: 8 hours;
- **Outputs** (will be used in [visualization section](viz-sec)):
    - `nnsmith-tvm-binning/`
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
### E2: GraphFuzzer[^gf] Coverage

```{dropdown} "*GraphFuzzer*" (..huh?)
The paper by *Luo, Weisi, et al*[^gf] does not give a name to the fuzzer. We call it "*GraphFuzzer*" for convenience.
```

[^gf]: Luo, Weisi, et al. "Graph-based fuzz testing for deep learning inference engines." 2021 IEEE/ACM 43rd International Conference on Software Engineering (ICSE). IEEE, 2021.

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
### E3: LEMON[^lm] Coverage

[^lm]: Wang, Zan, et al. "Deep learning library testing via effective model generation." Proceedings of the 28th ACM Joint Meeting on European Software Engineering Conference and Symposium on the Foundations of Software Engineering. 2020.

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
