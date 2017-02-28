FROM nipype/nipype:latest

## Install the validator
RUN apt-get update && \
    apt-get install -y curl

RUN mkdir -p /opt/infomap && \
    git clone https://github.com/mapequation/infomap.git

WORKDIR /opt/infomap && \
    make

WORKDIR /opt/infomap/examples/python && \
    make

RUN pip install networkx
RUN pip install nilearn
