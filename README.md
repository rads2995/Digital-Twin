# Digital-Twin

## Build Instructions

To build the Docker image:

`docker build --force-rm -t digital_twin . --build-arg ISA=[model]`

where `[model]:` is either `X86`, or `ARM`.

To run the Docker container interactively: 

`docker run --rm -it  digital_twin:latest`

To run the simulator system (i.e., x86 ISA):

`build/X86/gem5.opt configs/test/arm/simple.py`

## Simulation Examples

### x86 ISA calling "hello world" binary file
```
root@309b55121ae6:/Digital-Twin/gem5# build/X86/gem5.opt configs/test/x86/simple.py 
gem5 Simulator System.  https://www.gem5.org
gem5 is copyrighted software; use the --copyright option for details.

gem5 version 22.0.0.2
gem5 compiled Nov 20 2022 19:03:46
gem5 started Nov 20 2022 19:10:11
gem5 executing on 309b55121ae6, pid 19
command line: build/X86/gem5.opt configs/test/x86/simple.py

Global frequency set at 1000000000000 ticks per second
warn: No dot file generated. Please install pydot to generate the dot file and pdf.
build/X86/mem/dram_interface.cc:690: warn: DRAM device capacity (8192 Mbytes) does not match the address range assigned (512 Mbytes)
0: system.remote_gdb: listening for remote gdb on port 7000
Beginning simulation!
build/X86/sim/simulate.cc:194: info: Entering event queue @ 0.  Starting simulation...
Hello world!
Exiting @ tick 454646000 because exiting with last active thread context

```
