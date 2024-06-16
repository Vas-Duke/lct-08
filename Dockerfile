# Use the official Alpine image as a base
FROM python:alpine

# Set environment variables to ensure non-interactive installation
ENV PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

# Install dependencies
RUN apk add --update --no-cache --virtual=.build-dependencies \
    build-base \
    libffi-dev \
    musl-dev \
    gcc \
    g++ \
    make \
    openssl-dev \
    alpine-sdk \
    nodejs \
    ca-certificates \
    musl-dev \
    gcc \
#   python3=3.7.10-r0 \
#   python3-dev=3.7.10-r0 \
    make \
    cmake \
    g++ \
    gfortran \
    libpng-dev \
    freetype-dev \
    libxml2-dev \
    libxslt-dev

RUN apk add --update py3-pip py3-setuptools
RUN apk add --update git

# Install pip packages
RUN pip install --upgrade pip
    # pip install networkx \
    # matplotlib \
    # numpy \
    # pandas \
    # seaborn \
    # statsmodels \
    # PyQt5

# Install Jupyter
RUN pip install jupyter
RUN pip install ipywidgets
RUN pip install jupyter_contrib_nbextensions
# RUN jupyter nbextension enable --py widgetsnbextension

# Install Jupyter Lab
RUN pip install jupyterlab

# Run server extension for Jupyter Lab
# RUN jupyter serverextension enable --py jupyterlab

# Set the working directory in the container
WORKDIR /lct-08

# Copy your application code to the container (if you have any)
COPY . /lct-08

# Install Python Packages & Requirements (Done near end to avoid invalidating cache)
COPY requirements.txt /lct-08/requirements.txt
RUN pip install -r /lct-08/requirements.txt

# Expose Jupyter port & cmd
EXPOSE 8888
CMD jupyter lab --ip=* --allow-root --port=8888 --no-browser --notebook-dir=/lct-08
