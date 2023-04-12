FROM ubuntu

ARG DEBIAN_FRONTEND=noninteractive

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

WORKDIR /app

COPY pip_docker_requirements /app

RUN apt-get update -qq && \
    apt-get install -qqy \
      apt-transport-https \
      build-essential \
      ca-certificates \
      curl \
      git  \
      python3-pip \
      software-properties-common \
      vim \
      wget

RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

RUN pip3 install -r /app/pip_docker_requirements

RUN export DEBIAN_FRONTEND=noninteractive && \
    ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime && \
    apt-get install -y tzdata && \
    dpkg-reconfigure --frontend noninteractive tzdata

RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - && \
    apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main" && \
    apt install terraform=1.4.4-*

RUN rm * && apt autoremove && apt clean 