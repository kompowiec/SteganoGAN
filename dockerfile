FROM debian:buster

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    python3.7 python3.7-venv python3.7-dev \
    python3-distutils \
    curl git build-essential \
    libjpeg-dev zlib1g-dev libopenjp2-7 \
    libtiff5 libfreetype6 liblcms2-2 \
    libwebp6 libharfbuzz0b libfribidi0 \
    libxcb1 libgl1 wget && \
    apt-get clean

RUN curl https://bootstrap.pypa.io/pip/3.7/get-pip.py | python3.7

WORKDIR /steganogan
COPY . .

RUN python3.7 -m venv venv && \
    . venv/bin/activate && \
    pip install --upgrade pip && \
    pip install --no-cache-dir \
        numpy==1.21.6 \
        torch==1.10.2+cpu \
        torchvision==0.11.3+cpu \
        -f https://download.pytorch.org/whl/torch_stable.html \
        steganogan && \
    steganogan --help

ENTRYPOINT ["/steganogan/venv/bin/steganogan"]
