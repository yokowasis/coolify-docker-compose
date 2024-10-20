# yokowasis/jupyterlab

FROM mambaorg/micromamba

USER root

RUN apt-get update && apt-get install -y curl unzip && apt-get clean && rm -rf /var/lib/apt/lists/*

USER mambauser

RUN mkdir -p /home/mambauser/data

WORKDIR /home/mambauser/data

RUN curl -fsSL https://deno.land/x/install/install.sh | sh

ENV CONDA_PACKAGES=""
ENV PIP_PACKAGES=""

RUN micromamba install --yes --name base -c bioconda -c conda-forge python=3.10 pip xeus-cling jupyterlab 
      
RUN micromamba clean --all --yes
RUN ~/.deno/bin/deno jupyter --install --unstable --quiet

#if you need to run pip install in the same environment, uncomment the following lines

ARG MAMBA_DOCKERFILE_ACTIVATE=1

ENV PORT=8008
ENV TOKEN=SomeRandomToken

EXPOSE ${PORT}

ENTRYPOINT ["/usr/local/bin/_entrypoint.sh", "sh", "-c", "micromamba install --yes --name base -c bioconda -c conda-forge python=3.10 pip xeus-cling jupyterlab ${CONDA_PACKAGES} && micromamba run -n base pip install --no-cache pip ${PIP_PACKAGES} && jupyter lab --ip=0.0.0.0 --port=${PORT} --no-browser --allow-root --ServerApp.allow_origin='*' --ServerApp.token=${TOKEN}"]
