FROM ubuntu:16.04

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

# Install everything needed from Spack. We could install directly dealii but
# the flags are not given to the dependencies. Thus, they would install all of
# their own dependencies even if we do not use them.
RUN spack install llvm 
RUN spack install openmpi
RUN spack install boost +icu_support +mpi +python
RUN spack install p4est ~tests
# Need to give the options we want for boost otherwise spack will reinstall the
# default version.
RUN spack install trilinos ~hdf5 ~hypre ~metis ~mumps ~suite-sparse ~superlu-dist ^boost +icu_support +mpi +python 
#RUN spack install dealii ~arpack ~gsl ~hdf5 ~metis ~netcdf ~oce ~slepc ~petsc +mpi +trilinos +boost ^p4est ~tests ^trilinos ~hdf5 ~hypre ~metis ~mumps ~suite-sparse ~superlu-dist ^boost +icu_support +mpi +python 
