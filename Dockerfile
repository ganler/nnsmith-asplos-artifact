FROM ubuntu:20.04

RUN apt update --allow-unauthenticated

RUN DEBIAN_FRONTEND="noninteractive" apt install -y python3.8-dev python3.8-venv python3-numpy \
    git lz4 lsb-release wget software-properties-common gnupg build-essential \
    texlive dvipng texlive-latex-extra cm-super texlive-fonts-recommended graphviz

RUN wget https://apt.llvm.org/llvm.sh && bash llvm.sh 14 && apt update --allow-unauthenticated

RUN DEBIAN_FRONTEND="noninteractive" apt install -y clang-14 libclang-14-dev llvm-14-dev

COPY ./ /artifact

RUN python3 -m venv /artifact/venv

RUN . /artifact/venv/bin/activate && python3 -m pip install cmake numpy setuptools wheel

RUN . /artifact/venv/bin/activate && bash /artifact/sut/build_ort.sh

RUN . /artifact/venv/bin/activate && bash /artifact/sut/build_tvm.sh

RUN . /artifact/venv/bin/activate && bash /artifact/install_nnsmith.sh

ENV PYTHONPATH=/artifact/nnsmith:/artifact/sut/tvm/python
