# Evaluation on orginal test-bed

(org-setup)=
## Setup & Kick the tire

``````{admonition} Access the original test-bed
:class: important

Dear reviewers, please follow the following steps:

- **Step 1**: please kindly send your public key to us via HotCRP.
- **Step 2**: once confirmed you can login with one of the options:
    - U.S: `ssh ${reviewer-id}@us-sj-cuvip-1.natfrp.cloud -p 56789`
    - Germany: `ssh ${reviewer-id}@de-fr-ol-1.natfrp.cloud -p 56789`
    - China: `ssh ${reviewer-id}@cn-cd-dx-6.natfrp.cloud -p 35853`

Note the test-bed is located in Illinois, US and you can simply regard the locations above as that of the jump servers. You are recommended to choose the one near to your location for better network connectivity.

Please do not hesitate contacting the author over HotCRP or `jiawei6@illinois.edu` for any technical issues.
``````

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
docker run -it --name ${USER}-nnsmith -v /data/artifact/:/artifact/data/ ganler/nnsmith-asplos23-ae
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
