FROM ubuntu:latest

# Docker build argument for specific ISA
ARG ISA

# Update, upgrade, and install dependencies
RUN apt -y update && apt -y upgrade
RUN apt -y install build-essential m4 scons python3-dev python-is-python3 git wget

# Define work directory
WORKDIR /Digital-Twin

# Clone gem5 repository
RUN git clone --recursive https://gem5.googlesource.com/public/gem5 -b stable

# Copy custom source and configuration directories to gem5 repository
COPY configs gem5/configs
COPY src gem5/src
COPY fs_images gem5/fs_images

# Obtain Arm FS Binaries
RUN wget -P gem5/fs_images/arm http://dist.gem5.org/dist/v22-0/arm/aarch-system-20220707.tar.bz2
RUN tar -xvf gem5/fs_images/arm/aarch-system-20220707.tar.bz2 --directory gem5/fs_images/arm
RUN rm -rf gem5/fs_images/arm/aarch-system-20220707.tar.bz2

# Build gem5 for valid ISA
RUN if [ "$ISA" = "X86" ]; then \
        cd gem5 && python3 `which scons` build/X86/gem5.opt -j $(($(nproc) + 1)); \
    elif [ "$ISA" = "ARM" ]; then \ 
        cd gem5 && python3 `which scons` build/ARM/gem5.opt -j $(($(nproc) + 1)); \
    else \
        echo "Invalid argument for Instruction Set Architecture (ISA). Try docker build -t cool_name . --build-arg ISA=X86." ; \
    fi

# Run ARM Full System Simulation
# RUN ./build/ARM/gem5.opt configs/example/arm/fs_bigLITTLE.py \
#     --caches \
#     --bootloader="fs_images/arm/binaries/<bootloader-name>" \
#     --kernel="fs_images/arm/binaries/<kernel-name>" \
#     --disk="fs_images/arm/disks/<disk-image-name>" \
#     --bootscript=path/to/bootscript.rcS
