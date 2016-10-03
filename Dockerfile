FROM python:2.7

MAINTAINER MTRNord <info@nordgedanken.de>

RUN mkdir -p /usr/src/app 
WORKDIR /usr/src/app 

# Various Python and C/build deps
RUN apt-get update && apt-get install -y \ 
    python-dev \
    libopencv-dev \
    python-opencv \


# COPY requirements.txt /usr/src/app/
# RUN pip install --no-cache-dir -r requirements.txt
# RUN echo 'export PYTHONPATH=/usr/local/lib/python2.7/site-packages' >> ~/.bashrc
