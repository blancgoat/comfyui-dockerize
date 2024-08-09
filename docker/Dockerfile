# ARG values are defaults. Override them by creating a .env file or using --build-arg
ARG IMAGE_VERSION=2.4.0-cuda12.1-cudnn9-runtime
FROM pytorch/pytorch:${IMAGE_VERSION}
ARG COMFYUI_VERSION=v0.0.4
ARG COMFYUI_MANAGER_VERSION=2.48.6
ARG MIRROR_URL=""
ENV DEBIAN_FRONTEND=noninteractive PIP_PREFER_BINARY=1
ENV NVIDIA_VISIBLE_DEVICES=all

RUN if [ -n "$MIRROR_URL" ]; then \
        sed -i "s@archive.ubuntu.com@$MIRROR_URL@g" /etc/apt/sources.list; \
    fi && \
    apt update && \
    apt -y install git && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /comfyUI

RUN git clone --branch ${COMFYUI_VERSION} https://github.com/comfyanonymous/ComfyUI.git . && \
    pip install -r requirements.txt

RUN git clone --branch ${COMFYUI_MANAGER_VERSION} https://github.com/ltdrdata/ComfyUI-Manager.git ./custom_nodes/ComfyUI-Manager

ENTRYPOINT ["python", "main.py", "--listen"]
