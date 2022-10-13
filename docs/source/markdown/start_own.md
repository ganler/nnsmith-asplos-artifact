# **Evaluation on your own machine**

## Setup and Kick the tire

`````{admonition} Prerequisites
1. **OS:** A Linux System with [Docker](https://docs.docker.com/get-docker/) Support;
2. **Hardware:** X86 CPU; 16GB RAM; 512GB Storage; Good Network to [GitHub](https://github.com/) and [Docker Hub](https://hub.docker.com/);

```{dropdown} **Warning: Super-multi-core test-bed are not recommended**
:icon: alert
:color: warning

The artifact is based on the exact [version](https://github.com/ise-uiuc/nnsmith/commit/620645967a14d6a7b077cedd9c2c03ed74af50d9) used in our paper,
where ONNXRuntime might use [all CPU cores](https://github.com/ise-uiuc/nnsmith/blob/620645967a14d6a7b077cedd9c2c03ed74af50d9/nnsmith/backends/ort_graph.py#L37) which could bring trouble on servers with very many cores. However, you may alleviate it with `export NNSMITH_CORE=16` or smaller.
```

Before you start, please make sure you have [**Docker**](https://docs.docker.com/engine/install/) installed.
```bash
docker --version # Test docker availability
# Docker version 20.10.12, build e91ed5707e
```
Otherwise please follow the [**installation page**](https://docs.docker.com/engine/install/) of Docker.
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

:::{dropdown} **Kick the tire!**
:open:
:icon: code
:color: success
```bash
# Pull docker image from docker hub;
docker run -it --name ${USER}-nnsmith ganler/nnsmith-asplos23-ae
# By using this command, you will "get into" the image like entering a virtual machine.
# The session will be kept under the name "${USER}-nnsmith"

# Inside the image;
cd /artifact
git pull
source env.sh     # Use a virtual environment
bash kick_tire.sh # 40 seconds
# Running NNSmith fuzzing 20 seconds for each of tvm and onnxruntime.
# It generates bug reports (if any) in `/artifact/nnsmith/kk-tire-ort` and `/artifact/nnsmith/kk-tire-tvm`.
```
:::

## Next step

Please go to **[](./evaluation.md)** for detailed evaluation steps.