# Image to run GDL source code
#
# Ubuntu 20 + nvidia cudaa
#
# crafted from nvidia cuda image and jupyter docker stacks
# https://hub.docker.com/r/nvidia/cuda
# https://jupyter-docker-stacks.readthedocs.io/en/latest/

ARG ROOT_CONTAINER=tensorflow/tensorflow:2.6.0-gpu-jupyter

FROM $ROOT_CONTAINER

LABEL maintainer="Dzmitry Nichyparuk <dnichyparuk@gmail.com>"

# Copy and prepare sources
COPY GDL_code "/tf/GDL_code"
WORKDIR "/tf/GDL_code"

RUN apt-get update --yes & \
    apt-get install --yes graphviz

RUN python3 -m pip install --upgrade pip
RUN pip install -r requirements.txt

WORKDIR "/tf"

EXPOSE 8888

# Configure container startup
CMD ["bash", "-c", "source /etc/bash.bashrc && jupyter notebook --notebook-dir=/tf --ip 0.0.0.0 --no-browser --allow-root --NotebookApp.token='' --NotebookApp.password=''"]