(faq)=
# **FAQ**

## I cannot use docker after installation

If you are a sudoer, there are a few post-installation [steps](https://docs.docker.com/engine/install/linux-postinstall/) on Linux:

```shell
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
docker run hello-world # Test a hello-world
```

If you still encounter problems, you are encouraged to concat me for access to the original test-bed or try to start as a non-root according to the [Dockerfile](https://github.com/ganler/nnsmith-asplos-artifact/blob/master/Dockerfile).

## The OSS-dev version of NNSmith

NNSmith has been sharpened towards practical and real-world usage, continously developed on [GitHub](https://github.com/ise-uiuc/nnsmith).
It has better features, stability, usability, and extensibility. For example, TensorFlow fuzzing is supported at this point (Oct 13, 2022) and you can install it via [PyPI](https://pypi.org/project/nnsmith/).
Note that the OSS-dev version might not necessarily reflect the implementation mentioned in the original NNSmith paper[^nsh].
You are encouraged to use this artifact to reflect the implementation of our ASPLOS'23 paper.

[^nsh]: Liu, Jiawei, et al. "NNSmith: Generating Diverse and Valid Test Cases for Deep Learning Compilers." Proceedings of the 28th ACM International Conference on Architectural Support for Programming Languages and Operating Systems. 2023.

(exp-extra)=
# **Extra experiments**

## Experiments for Ablation Study (Section 5.3)

### EX1: NNSmith-base coverage

``````{admonition} E1: Evaluating NNSmith base (binning disabled) on {tvm, ort}
:class: important

- **Fuzzer type**: NNSmith base (without binning);
- **System under test (SUT)**:
    - TVM (LLVM CPU backend);
    - ONNXRuntime (CPU backend);
- **Experiment time**: 8 hours;
- **Outputs** (will be used in [visualization section](viz-sec)):
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

TBD;

### EX2: Gradient-based value search

TBD;

(gen-lemon)=
## Generate LEMON models from scratch

TBD;
