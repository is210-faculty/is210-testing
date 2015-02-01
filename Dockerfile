# infosys-pytest-env
# 
# Version 0.2.0

FROM ubuntu:trusty
MAINTAINER Chad Heuschober "chad.heuschober@cuny.edu"

# Set locale
RUN locale-gen --no-purge en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Install python
RUN apt-get update && apt-get install -y \
    python \
    python-dev \
    python-pip \
    libxml2-dev \
    build-essential \
    libcurl3-gnutls \
    locales

# Adds the requirements file first
ADD ./files/requirements.txt /application/requirements.txt

# Install python libs
RUN pip install -r /application/requirements.txt

# Setup ENV's
ENV WORKSPACE /var/workspace

ENV APPFILES /application

ENV PYTHONPATH $APPFILES/python

ENV PYLINTRC $APPFILES/pylintrc

ENV TESTDIR $WORKSPACE/tests

ENV LOGDIR /var/log/

# Adds the remaining application files to get a post-pip slice
ADD ./files /application

WORKDIR $WORKSPACE

CMD ["/application/runtests.sh"]
