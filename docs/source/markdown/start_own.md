# Evaluation on your own machine

## Setup and Kick the tire

`````{admonition} Prerequisites
1. **OS:** A Linux System with [Docker](https://docs.docker.com/get-docker/) Support;
2. **Hardware:** X86 CPU; 16GB RAM; 512GB Storage; Good Network to [GitHub](https://github.com/) and [Docker Hub](https://hub.docker.com/);

```{warning} **Avoid super-multi-core test-bed**
The artifact is based on the exact [version](https://github.com/ise-uiuc/nnsmith/commit/620645967a14d6a7b077cedd9c2c03ed74af50d9) used in our paper,
where ONNXRuntime might use [all CPU threads](https://github.com/ise-uiuc/nnsmith/blob/620645967a14d6a7b077cedd9c2c03ed74af50d9/nnsmith/backends/ort_graph.py#L37) which could bring troubles on test-bed with very many cores (our test-bed has only 8 cores). 
```

Before you start, please make sure you have [**Docker**](https://docs.docker.com/engine/install/) installed.
```bash
# Test docker availability
sudo docker --version
# Output looks like: (no error)
# Docker version 20.10.12, build e91ed5707e
```
Otherwise please follow the [**installation page**](https://docs.docker.com/engine/install/) of Docker.
`````

``````{note}
The experiements could take more than one day, it is recommended to open a tmux session to start it in the background and come back when the experiments are finished.

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

To start evaluation:

```bash
# Pull docker image from docker hub;
sudo docker run -it --name ${USER}-nnsmith ganler/nnsmith-asplos23-ae
# By using this command, you will "get into" the image like entering a virtual machine.
# The session will be kept under the name "${USER}-nnsmith"

# Inside the image;
cd /artifact
source env.sh     # Use a virtual environment
bash kick_tire.sh # 40 seconds
# Running NNSmith fuzzing 20 seconds for each of tvm and onnxruntime.
```

## Next step

Please go to [](./evaluation.md) for detailed evaluation steps.