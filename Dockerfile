FROM poldracklab/neuroimaging-core:freesurfer-0.0.2

WORKDIR /root

COPY docker/files/run_* /usr/bin/
RUN chmod +x /usr/bin/run_*

# Install miniconda
RUN curl -sSLO https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh && \
    /bin/bash Miniconda2-latest-Linux-x86_64.sh -b -p /usr/local/miniconda && \
    rm Miniconda2-latest-Linux-x86_64.sh
ENV PATH=/usr/local/miniconda/bin:$PATH \
    PYTHONPATH=/usr/local/miniconda/lib/python2.7/site-packages \
    PYTHONNOUSERSITE=1

# Create conda environment
RUN conda config --add channels conda-forge && \
    conda install -y numpy>=1.12.0 scipy matplotlib && \
    python -c "from matplotlib import font_manager"

# Install INFOMAP

WORKDIR /root/src/mriqc
COPY . /root/src/mriqc/
RUN pip install -r requirements.txt && \
    pip install -e .[all]

WORKDIR /scratch
ENTRYPOINT ["/usr/bin/run_mriqc"]
CMD ["--help"]
