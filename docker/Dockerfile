FROM pytorch/pytorch:2.4.0-cuda12.4-cudnn9-runtime
ENV DEBIAN_FRONTEND=noninteractive PIP_PREFER_BINARY=1
ENV NVIDIA_VISIBLE_DEVICES=all

RUN sed -i 's@archive.ubuntu.com@mirror.navercorp.com@g' /etc/apt/sources.list && \
    apt update && \
    apt -y install git && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /comfyUI

RUN git clone --branch v0.0.4 https://github.com/comfyanonymous/ComfyUI.git . && \
    pip install -r requirements.txt

RUN git clone --branch 2.48.6 https://github.com/ltdrdata/ComfyUI-Manager.git ./custom_nodes/ComfyUI-Manager

ENTRYPOINT ["python", "main.py", "--listen"]
