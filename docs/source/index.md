# **NNSmith ASPLOS'23 Artifact!**

<p align="center">
    <a href="https://github.com/ganler/nnsmith-asplos-artifact"><img src="https://img.shields.io/badge/github-%23121011.svg?style=for-the-badge&logo=github&logoColor=white">
    <a href="https://github.com/ise-uiuc/nnsmith"><img src="https://img.shields.io/badge/OSS-dev-%23121011.svg?style=for-the-badge&logo=github&logoColor=white">
</p>

<p align="center">
    <a href="https://nnsmith-asplos.readthedocs.io/"><img src="https://github.com/ganler/nnsmith-asplos-artifact/actions/workflows/doc.yaml/badge.svg">
    <a href="https://doi.org/10.5281/zenodo.7222132"><img src="https://zenodo.org/badge/DOI/10.5281/zenodo.7222132.svg" alt="DOI"></a>
    <a href="https://arxiv.org/abs/2207.13066"><img src="https://img.shields.io/badge/arXiv-2207.13066-b31b1b.svg">
    <a href="https://hub.docker.com/repository/docker/ganler/nnsmith-asplos23-ae"><img src="https://img.shields.io/docker/image-size/ganler/nnsmith-asplos23-ae">
    <a href="https://github.com/ganler/nnsmith-asplos-artifact/blob/main/LICENSE"><img src="https://img.shields.io/badge/License-Apache_2.0-blue.svg"></a>
</p>

(gstart)=
## Getting Started!

`````{admonition} **Prerequisites**
1. **OS:** A Linux System with [Docker](https://docs.docker.com/get-docker/) Support;
2. **Hardware:** X86 CPU; 16GB RAM; 512GB Storage; Good Network to [GitHub](https://github.com/) and [Docker Hub](https://hub.docker.com/);

```{dropdown} **Warning: Super-multi-core & SLURM-based test-bed are not recommended**
:icon: alert
:color: warning

We observed performance issues when running NNSmith-ONNXRuntime on a cluster managed by SLURM and on a 64-core workstation.
Therefore, users might want to avoid the mentioned settings.
Nevertheless, users may set `export NNSMITH_CORE=1` (inside the container) to stabilize the performance.

We are not sure about the reason but it could be that ONNXRuntime can use [all CPU cores](https://github.com/ise-uiuc/nnsmith/blob/620645967a14d6a7b077cedd9c2c03ed74af50d9/nnsmith/backends/ort_graph.py#L37) by default, causing over-threading.
```

Before you start, please make sure you have [**Docker**](https://docs.docker.com/engine/install/) installed.
```bash
docker --version # Test docker availability
# Docker version 20.10.12, build e91ed5707e
```
Otherwise please follow the [**installation page**](https://docs.docker.com/engine/install/) of Docker.


**ASPLOS'23 AE reviewers**: you may also directly access the original test-bed if such information is given on HotCRP. Otherwise, the option for using the original test-bed remotely is disabled.
`````

``````{dropdown} **Use TMUX to run long experiments in the background**
:color: info
:icon: unlock

The experiements could take **one day**, it is recommended to open a `tmux` session to start it in the background and come back when the experiments are finished.

Create a tmux session.
```bash
tmux new -s nnsmith-artifact   # create a tmux session.
```

To leave the job running in the background:
- `ctr + b`
- `d`

To resume the session:
```bash
tmux at -t nnsmith-artifact
```
``````

````{dropdown} **Install/Import the image!**
:open:
:icon: code

- **Method 1: [Docker Hub](https://hub.docker.com/r/ganler/nnsmith-asplos23-ae) (Recommended)**:

```shell
docker pull ganler/nnsmith-asplos23-ae
```

- Method 2: [Zenodo archive](https://zenodo.org/record/7200841):

```shell
tar xf NNSmith-ASPLOS23-Artifact.tar.gz
export NNSMITH_DOCKER=ganler/nnsmith-asplos23-ae:latest
cat nnsmith-ae.tar | docker import - $NNSMITH_DOCKER
```
````

````{dropdown} **Download pre-generated LEMON models**
:open:
:icon: code

Evaluating the LEMON baseline in NNSmith's setting is complicated ([why?](gen-lemon)).
For reviewers' convenience, the LEMON models (55.7GB) are pre-generated/converted.
Nevertheless, you can refer to [](gen-lemon) to re-generate them.

You can download the pre-generated models from [OneDrive](https://uillinoisedu-my.sharepoint.com/:u:/g/personal/jiawei6_illinois_edu/EciCT0E4v0tJlyXHgnbDeeIBB0UzhYB01qBuy_b-GtY6IA?e=qG7RyI)[^drive] and then use the script below to extract the files.

[^drive]: According to the univerisity's policy, the link will be expired after 90 days. Please contact the artifact author if the link is expired.

```bash
md5sum lemon-onnx.tar    # check data integrity
# ab7b8416a841ef8ba9bb09acc3dd6a21  lemon-onnx.tar
tar xvf lemon-onnx.tar   # About 2~4 minutes
# Models are stored in ./lemon-onnx
# rm lemon-onnx.tar      # No longer needed
```
````


````{dropdown} **Kick the tire!**
:open:
:icon: code
:color: success
```bash
# Run docker image
docker run -it --name ${USER}-nnsmith -v ./lemon-onnx:/artifact/data/lemon-onnx ganler/nnsmith-asplos23-ae
# Now, you will "get into" the image like entering a virtual machine.
# By using this command, you will "get into" the image like entering a virtual machine.
# The session will be kept under the name "${USER}-nnsmith"

# Inside the image;
cd /artifact
git remote set-url origin https://github.com/ganler/nnsmith-asplos-artifact.git
git pull origin master
source env.sh     # Use a virtual environment
bash kick_tire.sh # 40 seconds
# Running NNSmith fuzzing 20 seconds for each of tvm and onnxruntime.
```

If you can see `/artifact/nnsmith/kk-tire-ort` and `/artifact/nnsmith/kk-tire-tvm` (bug report folders), then congratulations for successfully running the artifact!
````

## Next step

Please go to **[](./markdown/evaluation.md)** for detailed evaluation steps.


```{toctree}
---
caption: Episodes
maxdepth: 1
---

markdown/evaluation
markdown/rdmore
```
