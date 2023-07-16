FROM ubuntu:latest

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
      unzip \
      git  \
      python3-pip \
      software-properties-common \
      vim \
      wget

# RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin

RUN pip3 install -r /app/pip_docker_requirements

RUN export DEBIAN_FRONTEND=noninteractive && \
    ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime && \
    apt-get install -y tzdata && \
    dpkg-reconfigure --frontend noninteractive tzdata

RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - && \
    apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main" && \
    apt install terraform=1.5.0-*

RUN rm -Rf * && apt autoremove && apt clean 