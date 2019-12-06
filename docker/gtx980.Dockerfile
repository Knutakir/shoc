# Same version as nvidia/cuda:latest as of 20.11.2019, just more specified
FROM nvidia/cuda:10.1-devel-ubuntu18.04

WORKDIR /usr/src/shoc

COPY . .

# Configure with mpi for the target architecture and compile the sources
RUN ./configure CUDA_CPPFLAGS="-gencode=arch=compute_52,code=sm_52"
# TODO: is this needed ? check this: make clean
RUN make clean
RUN make
RUN make install

# Example command to run benchmark on the single GPU with size 1
CMD perl ./tools/driver.pl -s 1 -cuda -d 0