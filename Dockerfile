# This is the ROS2 Base Image for DNN deployment in the STADT:up Consortia with cuda installed

FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu22.04
ENV FORCE_CUDA="1"
ENV DEBIAN_FRONTEND=noninteractive

USER root
RUN apt-get -o Acquire::Check-Valid-Until=false -o Acquire::Check-Date=false update
RUN apt update && apt upgrade -y && apt install --no-install-recommends -y \
    git \
    build-essential \
    curl \
    software-properties-common \
    locales

RUN locale-gen en_US en_US.UTF-8
RUN update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
RUN LANG=en_US.UTF-8

# install bootstrap tools
RUN apt-get update && apt-get install --no-install-recommends -y \
    build-essential \
    git \
    sudo \
    python3-pip \
    python-is-python3

#########    
RUN apt-get update && apt-get install -y libgl1-mesa-glx

# Install basic python packages
RUN pip3 install \
    opencv-python \
    numpy

RUN apt install libboost-all-dev -y
RUN pip3 install torch==2.0.1 torchvision==0.15.2 torchaudio==2.0.2 --index-url https://download.pytorch.org/whl/cu118
RUN pip3 install spconv-cu118
RUN pip3 install numpy
RUN pip3 install qoi
RUN pip3 install "numba==0.57"
ENV TORCH_CUDA_ARCH_LIST="7.5"

RUN apt-get update && apt-get install -y \
    libturbojpeg-dev \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libxrender1 \
    libsm6 \
    libxext6 \
    ninja-build \
    cmake \
    gcc \
    g++ \
    curl \
    wget \
    unzip \
    git \
    python3-dev

# Install mmcv-full==1.5.3 from source with proper torch/cuda
RUN pip3 install -U pip setuptools wheel
RUN pip3 install -U openmim
RUN mim install mmengine


####
RUN apt-get update && apt-get install -y libturbojpeg-dev
RUN git clone -b v1.5.3 https://github.com/open-mmlab/mmcv.git && \
    cd mmcv && \
    MMCV_WITH_OPS=1 FORCE_CUDA=1 TORCH_CUDA_ARCH_LIST="7.5" \
    python setup.py develop

RUN pip3 install mmdet==2.25.1
RUN pip3 install pyquaternion 

#########
RUN git clone -b v0.30.0 https://github.com/open-mmlab/mmsegmentation.git && \
    cd mmsegmentation && \
    pip install -e .
