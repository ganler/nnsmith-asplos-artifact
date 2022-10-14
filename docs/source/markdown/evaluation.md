# **Evaluating artifact**

## Coverage experiments

We will go through the main experiments corresponding to Section 5.2 in the paper, which evaluates end-to-end coverage efficiency of NNSmith and baselines.

```{admonition} Expected time cost
:class: tip
- `21` hours **machine** time;
- `<1` hour **human** time;
```

| Experiment ID | NNSmith[^nsh]      | GraphFuzzer[^gf]   | LEMON[^lm]         |
| ------------- | ------------------ | ------------------ | ------------------ |
| TVM           | [E1](exp-e1) (4hr) | [E2](exp-e2) (5hr) | [E3](exp-e3) (2hr) |
| ONNXRuntime   | [E1](exp-e1) (4hr) | [E2](exp-e2) (5hr) | [E3](exp-e3) (1hr) |

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

- Come back 1 day later;
- Jump to the [result visualization section](viz-sec) to verify the results.

Or if you want to understand the scripts being executed, you can continue reading the following sub-sections ([E1](exp-e1)~[E3](exp-e3)).

(exp-e1)=
### E1: NNSmith[^nsh] Coverage

[^nsh]: Liu, Jiawei, et al. "NNSmith: Generating Diverse and Valid Test Cases for Deep Learning Compilers." Proceedings of the 28th ACM International Conference on Architectural Support for Programming Languages and Operating Systems. 2023.

``````{admonition} E1: Evaluating NNSmith on {tvm, ort}
:class: important

- **Fuzzer type**: NNSmith (with binning);
- **System under test (SUT)**:
    - TVM (LLVM CPU backend);
    - ONNXRuntime (CPU backend);
- **Experiment time**: 8 hours;
- **Outputs** (will be used in [visualization section](viz-sec)):
    - `/artifact/nnsmith/nnsmith-tvm-binning/`
    - `/artifact/nnsmith/nnsmith-ort-binning/`

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
- **Experiment time**: 10 hours;
- **Outputs** (will be used in [visualization section](viz-sec)):
    - `/artifact/nnsmith/graphfuzzer-tvm/`
    - `/artifact/nnsmith/graphfuzzer-ort/`

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

```{dropdown} Pre-generated LEMON models
:color: warning
:icon: unlock

Evaluating LEMON in NNSmith's setting is very complicated ([why?](gen-lemon)).
For reviewers' convenience, the LEMON models are pre-generated and pre-converted (see `-v /data/artifact:/...` in the [docker command](org-setup)).
```

```{admonition} **This section *only* works out-of-the-box on the *original* test-bed**
:class: warning

This section won't work out of the box if you are working on <u>your own machine</u>.
Some complicated [steps](gen-lemon) are needed to generate LEMON models, but you might skip it as it's not a mandatory baseline for NNSmith.
```

- **Fuzzer type**: LEMON;
- **System under test (SUT)**:
    - TVM (LLVM CPU backend);
    - ONNXRuntime (CPU backend);
- **Experiment time**: 3 hours;
- **Outputs** (will be used in [visualization section](viz-sec)):
    - `/artifact/nnsmith/lemon-tvm/`
    - `/artifact/nnsmith/lemon-ort/`

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

:::{dropdown} **Visualizing coverage**
:open:
:icon: code
:color: light

Run the following script to generate images in `/artifact/nnsmith/tvm-cov` and `/artifact/nnsmith/ort-cov`.

```shell
bash /artifact/viz_main.sh
```

```shell
# Check the outputs.
$ ls /artifact/nnsmith/tvm-cov
# tvm_br_cov_venn.png      tvm_branch_cov-time.png  tvm_opt_branch_cov-iter.png
# tvm_branch_cov-iter.png  tvm_opt_br_cov_venn.png  tvm_opt_branch_cov-time.png
$ ls /artifact/nnsmith/ort-cov/
# ort_br_cov_venn.png      ort_branch_cov-time.png  ort_opt_branch_cov-iter.png
# ort_branch_cov-iter.png  ort_opt_br_cov_venn.png  ort_opt_branch_cov-time.png
```
:::

``````{admonition} Check the results
:class: important

The image results are still in the docker container, we need pull those images out of it to see how they look like.

````{dropdown} **Get image outputs from docker to local**
:open:
:icon: code
:color: light

First you need to temporarily leave the current container, there are three ways to do it:
1. **TMUX**: `ctr + b` then `d`;
2. **Local (recommended)**: just open a new terminal on the machine which is by default out of the container;
3. **Local**: type `exit` to exit the container environment (later you can resume the container with `docker start -i ${USER}-nnsmith`);

```shell
# Now in the local environment
docker cp ${USER}-nnsmith:/artifact/nnsmith/tvm-cov . # copy TVM results to local folder `tvm-cov`
docker cp ${USER}-nnsmith:/artifact/nnsmith/ort-cov . # copy ORT results to local folder `ort-cov`
```
````

Now let's check the results corresponding to figures in the paper:

```{dropdown} Fuzzing randomness
:color: warning
:icon: alert

The sample images below are freshly generated when testing the artifact on the original test-bed (Oct. 14, 2022). They can slightly differ from that in the paper due to fuzzing randomness.

The randomness in fuzzing could come from performance divergence in different system and random seeds.
This means detailed reproduced data might not be strictly equivalent to that presented in the paper, but the overall trend should be consistent in the long run (say 4 hours).
```

```{dropdown} Potential legend style shifting (*if you skipped LEMON*)
:color: warning
:icon: alert

According to [](exp-e3), the curve/pie for LEMON baseline might not be available if not starting with the original test-bed). As a result, showing only two baselines make the  curves or pies of the figures below shifted with legend styles. In this case, please distinguish the systems by **tagged labels** as the colors might not match that in the original paper.
```

`````{admonition} **Figure 4: Total branch coverage over time (all files)**
:class: tip

```{figure} ../img/ort-cov/ort_branch_cov-time.png
---
scale: 53%
align: left
name: f4a
---
Figure 4.(a) **ONNXRuntime** \
See `./ort-cov/ort_branch_cov-time.png`
```

```{figure} ../img/tvm-cov/tvm_branch_cov-time.png
---
scale: 53%
align: right
name: f4b
---
Figure 4.(b) **TVM** \
See `./tvm-cov/tvm_branch_cov-time.png`
```
`````


`````{admonition} **Figure 5: Total branch coverage over test cases (all files)**
:class: tip

```{figure} ../img/ort-cov/ort_branch_cov-iter.png
---
scale: 60%
align: left
name: f5a
---
Figure 5.(a) **ONNXRuntime** \
See `./ort-cov/ort_branch_cov-iter.png`
```

```{figure} ../img/tvm-cov/tvm_branch_cov-iter.png
---
scale: 60%
align: right
name: f5b
---
Figure 5.(b) **TVM** \
See `./tvm-cov/tvm_branch_cov-iter.png`
```
`````

````{admonition} **Figure 6:  Total branch coverage over time (pass files)**
:class: tip

```{figure} ../img/ort-cov/ort_opt_branch_cov-time.png
---
scale: 53%
align: left
name: f6a
---
Figure 6.(a) **ONNXRuntime** \
See `./ort-cov/ort_opt_branch_cov-time.png`
```

```{figure} ../img/tvm-cov/tvm_opt_branch_cov-time.png
---
scale: 53%
align: right
name: f6b
---
Figure 6.(b) **TVM** \
See `./tvm-cov/tvm_opt_branch_cov-time.png`
```
````

````{admonition} **Figure 7: Venn diagram of overall coverage (total coverage shown in parenthesis)**
:class: tip

```{figure} ../img/ort-cov/ort_br_cov_venn.png
---
scale: 60%
align: left
name: f7a
---
Figure 7.(a) **ONNXRuntime** \
See `./ort-cov/ort_br_cov_venn.png`
```

```{figure} ../img/tvm-cov/tvm_br_cov_venn.png
---
scale: 60%
align: right
name: f7b
---
Figure 7.(b) **TVM** \
See `./tvm-cov/tvm_br_cov_venn.png`
```
````

``````

Congratulations! You have successfully finished the main experiments of NNSmith!!! 🎉🎉🎉

## Read more

You may further refer to [](./faq.md) for potential questions and extra/non-main experiments.
