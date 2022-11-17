FROM ubuntu:latest

RUN apt -y update && apt -y upgrade
RUN apt -y install build-essential m4 scons python3-dev python-is-python3 git

RUN git clone --recursive https://gem5.googlesource.com/public/gem5

COPY configs/test gem5/
