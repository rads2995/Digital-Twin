FROM ubuntu:latest

# Docker build argument for specific ISA
ARG ISA

# Update, upgrade, and install dependencies
RUN apt -y update && apt -y upgrade
RUN apt -y install build-essential m4 scons python3-dev python-is-python3 git

# Define work directory
WORKDIR /Digital-Twin

# Clone gem5 repository
RUN git clone --recursive https://gem5.googlesource.com/public/gem5 -b stable

# Copy custom configuration directories to gem5 repository
COPY configs/ gem5/configs/

# Build gem5 for valid ISA
RUN if [ "$ISA" = "X86" ]; then \
        cd gem5/ && python3 `which scons` build/X86/gem5.opt -j $(($(nproc) + 1)) ; \
    elif [ "$ISA" = "ARM" ]; then \ 
        cd gem5/ && python3 `which scons` build/ARM/gem5.opt -j $(($(nproc) + 1)) ; \
    else \
        echo "Invalid argument for Instruction Set Architecture (ISA). Try docker build -t cool_name . --build-arg ISA=X86." ; \
    fi
