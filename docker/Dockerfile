FROM pytorch/pytorch:2.4.0-cuda12.4-cudnn9-runtime
ENV DEBIAN_FRONTEND=noninteractive PIP_PREFER_BINARY=1
RUN sed -i 's@archive.ubuntu.com@mirror.navercorp.com@g' /etc/apt/sources.list

RUN apt-get update
RUN apt-get -y install git

WORKDIR /comfyUI
RUN git clone --branch v0.0.4 https://github.com/comfyanonymous/ComfyUI.git .

RUN pip install -r requirements.txt

RUN git clone --branch 2.48.6 https://github.com/ltdrdata/ComfyUI-Manager.git ./custom_nodes/ComfyUI-Manager
  
ENV NVIDIA_VISIBLE_DEVICES=all
EXPOSE 8188
ENTRYPOINT ["python", "main.py", "--listen"]
