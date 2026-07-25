# ARG values are defaults. Override them by creating a .env file or using --build-arg
ARG IMAGE_VERSION=2.13.0-cuda13.0-cudnn9-devel
FROM pytorch/pytorch:${IMAGE_VERSION}
ENV DEBIAN_FRONTEND=noninteractive PIP_PREFER_BINARY=1
ENV NVIDIA_VISIBLE_DEVICES=all

ARG MIRROR_URL=""
RUN if [ -n "$MIRROR_URL" ]; then \
        sed -i "s@archive.ubuntu.com@$MIRROR_URL@g" /etc/apt/sources.list; \
    fi

RUN apt update && \
    apt -y install git

RUN apt clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /comfyUI

ENV COMFYUI_PATH=/comfyUI
ENV PIP_BREAK_SYSTEM_PACKAGES=1 UV_BREAK_SYSTEM_PACKAGES=1
ARG COMFYUI_VERSION=v0.28.0
ARG COMFYUI_MANAGER_VERSION=4.2.2

RUN git clone --branch ${COMFYUI_VERSION} https://github.com/comfyanonymous/ComfyUI.git . && \
    pip install -r requirements.txt

RUN pip install comfyui_manager==${COMFYUI_MANAGER_VERSION}

RUN mkdir -p /comfy_defaults && \
    cp -r /comfyUI/models /comfy_defaults/ && \
    cp -r /comfyUI/custom_nodes /comfy_defaults/

COPY startup.sh .
ENTRYPOINT [ "./startup.sh" ]
