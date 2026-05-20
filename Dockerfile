# basic python3 image as base
FROM python:3.7-slim-bullseye

#RUN apt-get update
#RUN apt-get install -y --no-install-recommends build-essential
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
     build-essential \
     libssl-dev \
     libffi-dev \
  && rm -rf /var/lib/apt/lists/*

RUN pip install vantage6-client==2.3.5

# This is a placeholder that should be overloaded by invoking
# docker build with '--build-arg PKG_NAME=...'
ARG PKG_NAME="v6-utils-py"

# install federated algorithm
COPY . /app
RUN pip install /app

ENV PKG_NAME=${PKG_NAME}

# Tell docker to execute `docker_wrapper()` when the image is run.
CMD python -c "from vantage6.tools.docker_wrapper import docker_wrapper; docker_wrapper('${PKG_NAME}')"