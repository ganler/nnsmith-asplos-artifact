.. _header-label:
# Evaluation on orginal test-bed

(org-setup)=
## Setup & Kick the tire

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

## Next step

Please go to [](./evaluation.md) for detailed evaluation steps.