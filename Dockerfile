FROM ubuntu:latest

RUN apt -y update && apt -y upgrade
RUN apt -y install build-essential m4 scons python3-dev python-is-python3 git

WORKDIR /Digital-Twin

# Clone gem5 repository
RUN git clone --recursive https://gem5.googlesource.com/public/gem5 -b stable

# Copy custom configuration directories to gem5
COPY configs/ gem5/configs/

# Build gem5 
RUN cd gem5/ && python3 `which scons` build/ARM/gem5.opt -j $(($(nproc) + 1))
