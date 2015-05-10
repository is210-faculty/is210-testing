# infosys-pytest-env
# 
# Version 0.2.0

FROM ubuntu:trusty
MAINTAINER Chad Heuschober "chad.heuschober@cuny.edu"

# Set locale
RUN locale-gen --no-purge en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Setup ENV's
ENV WORKSPACE /var/workspace
ENV APPPATH /application
ENV VIRTUALENV $APPPATH/virtualenv
ENV PYLINTRC $APPPATH/pylintrc
ENV TESTDIR $WORKSPACE/tests
ENV LOGDIR /var/log/

# Make the virtualenv folder
RUN mkdir -p $VIRTUALENV

# Install python
RUN apt-get update && apt-get install -y \
    python-virtualenv \
    python-dev \
    libxml2-dev \
    build-essential \
    libcurl3-gnutls \
    locales

# Adds the requirements file first
ADD ./files/requirements.txt $APPPATH/requirements.txt

# Create a virtualenv
RUN virtualenv $VIRTUALENV

# Install python libs
RUN $VIRTUALENV/bin/pip install -r $APPPATH/requirements.txt

# Adds the pylintrc
ADD ./files/pylintrc $PYLINTRC

# Adds the remaining application files to get a post-pip slice
ADD ./files/bin $APPPATH/bin

# Sets binary files executable
RUN chmod ugo+x $APPPATH/bin/*

WORKDIR $WORKSPACE

CMD ["/application/bin/runtests"]
