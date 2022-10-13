.. _header-label:
# Evaluation on orginal test-bed

(org-setup)=
## Setup & Kick the tire

``````{admonition} Accessing the original test-bed
:class: important

Dear reviewers, please follow the following steps:

- **Step 1**: please kindly send your public key to us via HotCRP.
- **Step 2**: once confirmed you can login with one of the options:
    - U.S: `ssh ${reviewer-id}@us-sj-cuvip-1.natfrp.cloud:56789`
    - Germany: `ssh ${reviewer-id}@de-fr-ol-1.natfrp.cloud:56789`
    - China: `ssh ${reviewer-id}@cn-cd-dx-6.natfrp.cloud:35853`

Note the test-bed is located in Illinois, US and you can simply regard the locations above as that of the jump servers. You are recommended to choose the one near to your location for better network connectivity.

Please do not hesitate contact the author over HotCRP or `jiawei6@illinois.com` for any technical issues.
``````

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
sudo docker run -it --name ${USER}-nnsmith ganler/nnsmith-asplos23-ae -v /data/ganler-data/lemon-onnx:/artifact/data/lemon-onnx
# By using this command, you will "get into" the image like entering a virtual machine.
# The session will be kept under the name "${USER}-nnsmith"

# Inside the image;
cd /artifact
git pull
source env.sh     # Use a virtual environment
bash kick_tire.sh # 40 seconds
# Running NNSmith fuzzing 20 seconds for each of tvm and onnxruntime.
```

## Next step

Please go to [](./evaluation.md) for detailed evaluation steps.
