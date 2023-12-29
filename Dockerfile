
# building command: 
# docker build -f Dockerfile -t lumeny/scalingup:latest .
FROM nvidia/cuda:12.3.1-devel-ubuntu22.04

USER root

RUN apt-get update && apt-get install -y git python3 python3-pip curl cmake libglu1-mesa-dev

WORKDIR /mamba

SHELL ["/bin/bash", "-c"]

RUN curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest | tar -xvj bin/micromamba \
  # && ls \
  && export MAMBA_ROOT_PREFIX=$(pwd) \
  && eval "$(./bin/micromamba shell hook -s posix)"  

ENV MAMBA_ROOT_PREFIX=/mamba

COPY . /scalingup

WORKDIR /scalingup

RUN /mamba/bin/micromamba env create --yes -f scalingup.yml

# RUN exec bash && /mamba/bin/micromamba activate scalingup # This way you can already activate the environment
