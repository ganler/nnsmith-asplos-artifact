FROM ubuntu:20.04

RUN apt update --allow-unauthenticated

RUN DEBIAN_FRONTEND="noninteractive" apt install -y clang-14 libclang-14-dev llvm-14-dev cmake git python3 lz4

# visualization
RUN DEBIAN_FRONTEND="noninteractive" apt install -y texlive dvipng texlive-latex-extra cm-super texlive-fonts-recommended

COPY ./ /artifact

RUN source /artifact/env.sh

RUN /artifact/venv/bin/activate && /artifact/sut/build_ort.sh

RUN /artifact/venv/bin/activate && /artifact/sut/build_tvm.sh

RUN /artifact/venv/bin/activate && /artifact/install_nnsmith.sh

ENV PYTHONPATH=/artifact/nnsmith:/artifact/sut/tvm/python
