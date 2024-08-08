FROM pytorch/pytorch:2.4.0-cuda12.4-cudnn9-runtime
ENV DEBIAN_FRONTEND=noninteractive PIP_PREFER_BINARY=1
RUN sed -i 's@archive.ubuntu.com@mirror.navercorp.com@g' /etc/apt/sources.list

RUN apt-get update
RUN apt-get -y install git

WORKDIR /comfyUI
RUN git clone https://github.com/comfyanonymous/ComfyUI.git .
RUN git reset --hard v0.0.4

RUN pip install -r requirements.txt
  
ENV NVIDIA_VISIBLE_DEVICES=all
EXPOSE 8188
ENTRYPOINT ["python", "main.py", "--listen"]
