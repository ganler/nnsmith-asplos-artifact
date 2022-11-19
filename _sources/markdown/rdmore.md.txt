# **Read more**

## FAQ

### I cannot use docker after installation

If you are a sudoer, there are a few post-installation [steps](https://docs.docker.com/engine/install/linux-postinstall/) on Linux:

```shell
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
docker run hello-world # Test a hello-world
```

If you still encounter problems, you are encouraged to concat me for access to the original test-bed or try to start as a non-root according to the [Dockerfile](https://github.com/ganler/nnsmith-asplos-artifact/blob/master/Dockerfile).

### The OSS-dev version of NNSmith

NNSmith has been sharpened towards practical and real-world usage, continously developed on [GitHub](https://github.com/ise-uiuc/nnsmith).
It has better features, stability, usability, and extensibility. For example, TensorFlow fuzzing is supported at this point (Oct 13, 2022) and you can install it via [PyPI](https://pypi.org/project/nnsmith/).
Note that the OSS-dev version might not necessarily reflect the implementation mentioned in the original NNSmith paper[^nsh].
You are encouraged to use this artifact to reflect the implementation of our ASPLOS'23 paper.

[^nsh]: Liu, Jiawei, et al. "NNSmith: Generating Diverse and Valid Test Cases for Deep Learning Compilers." Proceedings of the 28th ACM International Conference on Architectural Support for Programming Languages and Operating Systems. 2023.

(exp-extra)=
## Extra experiments

### EX1: NNSmith-base coverage (Section 5.3 ablation study)

``````{admonition} EX1: Evaluating NNSmith base (binning disabled) on {tvm, ort}
:class: important

- **Fuzzer type**: NNSmith base (without binning);
- **System under test (SUT)**:
    - TVM (LLVM CPU backend);
    - ONNXRuntime (CPU backend);
- **Experiment time**: 8 hours;
- **Outputs** (will be used for visualization soon):
    - `/artifact/nnsmith/nnsmith-tvm-base/`
    - `/artifact/nnsmith/nnsmith-ort-base/`

:::{dropdown} **Script**
:open:
:icon: code
:color: light
```shell
cd /artifact # In the container
bash eval_nnsmith_base.sh
```
:::

``````

````{dropdown} **Generate image results**
:open:
:icon: code
:color: light

First generate image data with:

```shell
cd /artifact/
source env.sh
cd /artifact/nnsmith
git checkout 5873a77734e25868912219d853dfc6bc0a210ace # checkout to the visualization commit
python3 experiments/viz_merged_cov.py --folders nnsmith-tvm-base nnsmith-tvm-binning --tvm \
                                        --tags 'no binning' 'w/ binning' --venn \
                                        --output tvm-binning
python3 experiments/viz_merged_cov.py --folders nnsmith-ort-base nnsmith-ort-binning --ort \
                                        --tags 'no binning' 'w/ binning' --venn \
                                        --output ort-binning
git checkout 620645967a14d6a7b077cedd9c2c03ed74af50d9 # going back
```

```shell
# Check the outputs.
$ ls /artifact/nnsmith/tvm-binning
# tvm_br_cov_venn.png      tvm_branch_cov-time.png  tvm_opt_branch_cov-iter.png
# tvm_branch_cov-iter.png  tvm_opt_br_cov_venn.png  tvm_opt_branch_cov-time.png
$ ls /artifact/nnsmith/ort-binning/
# ort_br_cov_venn.png      ort_branch_cov-time.png  ort_opt_branch_cov-iter.png
# ort_branch_cov-iter.png  ort_opt_br_cov_venn.png  ort_opt_branch_cov-time.png
```

To get images in your local directory, you need to temporarily leave the current container, there are three ways to do it:
1. **TMUX**: `ctr + b` then `d`;
2. **Local (recommended)**: just open a new terminal on the machine which is by default out of the container;
3. **Local**: type `exit` to exit the container environment (later you can resume the container with `docker start -i ${USER}-nnsmith`);

```shell
# Now in the local environment
docker cp ${USER}-nnsmith:/artifact/nnsmith/tvm-binning . # copy TVM results to local folder `tvm-binning`
docker cp ${USER}-nnsmith:/artifact/nnsmith/ort-binning . # copy ORT results to local folder `ort-binning`
```
````


``````{admonition} Check the results
:class: important

```{dropdown} Fuzzing randomness
:color: warning
:icon: alert

The sample images below are freshly generated when testing the artifact on the original test-bed (Oct. 14, 2022). They can slightly differ from that in the paper due to fuzzing randomness.

The randomness in fuzzing could come from performance divergence in different system and random seeds.
This means detailed reproduced data might not be strictly equivalent to that presented in the paper, but the overall trend should be consistent in the long run (say 4 hours).
```

````{admonition} **Figure 10: Impact of attribute binning on coverage.**
:class: tip

```{figure} ../img/ort-binning/ort_br_cov_venn.png
---
scale: 75%
align: left
name: f10a
---
Figure 7.(a) **ONNXRuntime** \
See `./ort-binning/ort_br_cov_venn.png`
```

```{figure} ../img/tvm-binning/tvm_br_cov_venn.png
---
scale: 75%
align: right
name: f10b
---
Figure 7.(b) **TVM** \
See `./tvm-binning/tvm_br_cov_venn.png`
```
````

``````

### EX2: Gradient-based value search (Section 5.3 ablation study)

``````{admonition} EX2: Evaluating gradient-based value search
:class: important

- **Experiment time**: 1.5 hours;
- **Outputs** (will be used for visualization soon):
    - `/artifact/nnsmith/512-model-10-node-exp/`
    - `/artifact/nnsmith/512-model-20-node-exp/`
    - `/artifact/nnsmith/512-model-30-node-exp/`

:::{dropdown} **Script**
:open:
:icon: code
:color: light

```shell
cd /artifact
source env.sh
cd /artifact/nnsmith
mkdir -p config

# Run experiments.
git checkout 1a3ad5863cf8ee5e1db3fbd046cd854b87bf26c9 # checkout to the gradient commit
bash experiments/input_search_exp.sh 10
bash experiments/input_search_exp.sh 20
bash experiments/input_search_exp.sh 30

# visualization
git checkout 5873a77734e25868912219d853dfc6bc0a210ace # going to the visualization commit
mkdir -p gradient
python experiments/plot_inp_search_merge.py --output gradient            \
                                            --root 512-model-10-node-exp \
                                                   512-model-20-node-exp \
                                                   512-model-30-node-exp

git checkout 620645967a14d6a7b077cedd9c2c03ed74af50d9 # going back
```
:::
``````

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
docker cp ${USER}-nnsmith:/artifact/nnsmith/gradient . # copy gradient results to local folder `gradient`
```
````


````{admonition} **Figure 11: Effectiveness of gradient-based search**
:class: tip

```{figure} ../img/input-search-merge.png
---
scale: 75%
name: f11
---
Figure 11 \
See `./gradient/input-search-merge.png`
```

````

(gen-lemon)=
### Generate LEMON models from scratch

Running LEMON in NNSmith's setting is very complicated. That's why running it from scratch is not suggested and we generated those data on the test-bed in advance.

```{admonition} Extra constraints for running LEMON from scratch
:class: danger

- LEMON's GitHub repository: [https://github.com/Jacob-yen/LEMON](https://github.com/Jacob-yen/LEMON);
- LEMON requires **GPUs** and **nvidia-docker2** installed;
- An extra disk space of **256+GB** is encouraged;
- The whole experiment takes **at least 5 hours** (if you succeed in one pass) but in practice it could take more time due to setup complexity;
```

Here is the overview:

1. We evaluated LEMON based on LEMON's official docker image;
2. We tweaked the code to make it work and compare fairly:
   - The code version is in a [fork](https://github.com/ganler/LEMON/tree/a55f608e98d44a58d0fcfc6e0e9280a88bc29aae);
   - The main change is to disable LEMON's testing phase, which is not necessary for the purpose of "model generation". Note we did this change to make LEMON run faster to make the comparison fair;
   - We also changed the configuration file to make it work.

```{admonition} **Step 1: Setup LEMON's docker image**
:class: important
Please refer to the [environment](https://github.com/ganler/LEMON/tree/a55f608e98d44a58d0fcfc6e0e9280a88bc29aae#environment) and [Redis startup](https://github.com/ganler/LEMON/tree/a55f608e98d44a58d0fcfc6e0e9280a88bc29aae#redis-startup) sections from the original repository to setup the LEMON environment.
```

`````{admonition} **Step 2: Running LEMON**
:class: important

Don't follow instructions in the [Running LEMON](https://github.com/ganler/LEMON/tree/a55f608e98d44a58d0fcfc6e0e9280a88bc29aae#running-lemon) section. Instead, follow the instructions below:

```shell
# In the LEMON docker container
cd /
git clone https://github.com/ganler/LEMON.git LEMON-nnsmith
cd /LEMON-nnsmith
source activate lemon
python -u -m run.mutation_executor tzer.conf
```

And wait for about 4 hours.
`````

`````{admonition} **Step 3: Coverting LEMON models to ONNX models**
:class: important

Next copy the generated models located in `/LEMON-nnsmith/lemon_outputs` from docker image to local.
Say you can put them in `/path/to/lemon_outputs` on your local machine.

Next can convert the LEMON models (i.e., Keras) to ONNX models in NNSmith's container:

```shell
cd /artifact/
source env.sh
cd /artifact/nnsmith
python3 experiments/lemon_tf2onnx.py --lemon_output_dir /path/to/lemon_outputs \
                                     --onnx_dir /artifact/data/lemon-onnx
```
`````

Now you can go back to [](exp-e3) to continue evaluating LEMON.


### Other mini-experiments?

In this artifact, we elaborated the main experiments ([](./evaluation.md)) and extra experiments ([](exp-extra)) in the paper.
There is, honestly, still a few more experiments such as Figure 8 and Figure 9. 
They are not included in the artifact due to their minor importance and the cost of time (e.g., Figure 9 requires re-running the coverage experiments again in another setting which could take another day) & computing resources.
Nevertheless, feel free to contact the artifact author over HotCRP if you are interested in these experiments and the artifact author will setup them on demand.
