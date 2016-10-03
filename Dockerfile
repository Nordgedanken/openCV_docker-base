FROM python:2.7

MAINTAINER MTRNord <info@nordgedanken.de>

# Various Python and C/build deps
RUN apt-get update && apt-get install -y \ 
    python-dev \
    libopencv-dev \
    python-opencv \
    && ln -s /usr/lib/python2.7/dist-packages/cv2.x86_64-linux-gnu.so /usr/lib/python2.7/dist-packages/cv2.so
