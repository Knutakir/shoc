# Same version as nvidia/cuda:latest as of 20.11.2019, just more specified
FROM nvidia/cuda:10.1-devel-ubuntu18.04

WORKDIR /usr/src/shoc

# Install dependencies
RUN apt-get update && apt-get install -y \
    openmpi-bin \
    openssh-client \
    libopenmpi-dev

COPY . .

# Configure with mpi for the target architecture and compile the sources
RUN ./configure CUDA_CPPFLAGS="-gencode=arch=compute_70,code=sm_70" --with-mpi
RUN make clean
RUN make
RUN make install

# Example command to run benchmark on two GPUs with size 1
CMD perl ./tools/driver.pl -s 1 -cuda -d 14,15