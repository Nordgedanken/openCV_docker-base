FROM python:2.7

MAINTAINER MTRNord <info@nordgedanken.de>

RUN mkdir -p /usr/src/app 
WORKDIR /usr/src/app 

# Various Python and C/build deps
RUN apt-get update && apt-get install -y \ 
    build-essential \
    git \
    cmake \
    libgtk2.0-dev \
    pkg-config \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    python-dev \
    python-numpy \
    libtbb2 \
    libtbb-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libjasper-dev \
    libdc1394-22-dev

# Install Open CV - Warning, this takes absolutely forever
RUN cd ~ && \
    git clone https://github.com/opencv/opencv.git && \
    cd opencv && \
    git checkout 3.1.0 && \
    cd ~ && \
    git clone https://github.com/opencv/opencv_contrib.git && \
    cd opencv_contrib && \
    git checkout 3.1.0 && \
    cd ~/opencv && \ 
    mkdir build && \ 
    cd build && \
    cmake \
    -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \ 
    -D INSTALL_C_EXAMPLES=OFF \ 
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules \
    -D BUILD_EXAMPLES=ON .. && \
    make -j4 && \
    make install && \ 
    ldconfig && \
    cd ~ && rm -R opencv_contrib && rm -R opencv

COPY requirements.txt /usr/src/app/
RUN pip install --no-cache-dir -r requirements.txt
ENV PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH

COPY . /usr/src/app 
