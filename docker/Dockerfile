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

# 커스텀노드들이 opencv-python-headless 를 사용해주면 해결되지만 불행히도 대부분 opencv-python을 사용하고있어서 여기에 추가합니다.
RUN apt -y install python3-opencv

RUN apt clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /comfyUI

ARG COMFYUI_VERSION=v0.27.0
RUN git clone --branch ${COMFYUI_VERSION} https://github.com/comfyanonymous/ComfyUI.git . && \
    pip install -r requirements.txt --break-system-packages

ARG COMFYUI_MANAGER_VERSION=4.2.2
RUN git clone --branch ${COMFYUI_MANAGER_VERSION} https://github.com/ltdrdata/ComfyUI-Manager.git ./custom_nodes/ComfyUI-Manager && \
    pip install -r ./custom_nodes/ComfyUI-Manager/requirements.txt --break-system-packages

RUN mkdir -p /comfy_defaults && \
    cp -r /comfyUI/models /comfy_defaults/ && \
    cp -r /comfyUI/custom_nodes /comfy_defaults/

COPY startup.sh .
ENTRYPOINT [ "./startup.sh" ]
