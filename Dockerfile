FROM ubuntu:15.10

# Install everything needed from Ubuntu repository
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
        gcc \
        gfortran \
        git \
        python\
        curl \
        autoconf \
        build-essential \
        bison 

# Install Spack
RUN cd /home && git clone https://github.com/llnl/spack
ENV PATH=/home/spack/bin:$PATH

# Install everything needed from Spack
RUN spack install llvm 
