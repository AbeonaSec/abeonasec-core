# abeonasec-morpheus.Dockerfile
# dockerfile to build a morpheus container
# written by Aaron Krapes
# Feb 10, 2026

FROM docker.io/nvidia/cuda:12.8.0-runtime-ubuntu24.04

RUN apt-get update &&\
    apt-get install -y wget &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/*

WORKDIR /
# install miniconda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /miniconda.sh &&\
	bash miniconda.sh -b -u -p /opt/conda &&\
	rm /miniconda.sh

# add conda to PATH
ENV PATH=/opt/conda/bin:$PATH
ENV CONDA_PLUGINS_AUTO_ACCEPT_TOS=yes

# create morpheus environment
# then need to add channels
# then we install morpheus package and its dependencies
RUN conda create -n morpheus python=3.12
RUN . /opt/conda/etc/profile.d/conda.sh && \
    conda activate morpheus && \
    conda config --add channels conda-forge &&\
    conda config --add channels nvidia &&\
    conda config --add channels rapidsai &&\
    conda config --add channels pytorch &&\
    conda install -c nvidia morpheus-core=25.06
RUN . /opt/conda/etc/profile.d/conda.sh && \
    conda activate morpheus && \
    pip install -r $(dirname $(python -c "import morpheus; print(morpheus.__file__)"))/requirements_morpheus_core_arch-$(arch).txt

CMD ["bash", "-c", "nvidia-smi"]
