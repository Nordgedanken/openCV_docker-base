FROM python:2.7

MAINTAINER MTRNord <info@nordgedanken.de>

RUN mkdir -p /usr/src/app 
WORKDIR /usr/src/app 

# Various Python and C/build deps
RUN apt-get update && apt-get install -y \ 
    cmake \
    build-essential \ 
    git \
    pkg-config \
    libjpeg62-turbo-dev \
    libtiff5-dev \
    libjasper-dev \
    libpng12-dev \
    libatlas-base-dev \
    gfortran \
    python2.7-dev \
    python2.7

# Install Open CV - Warning, this takes absolutely forever
RUN cd ~ && \
    git clone https://github.com/Itseez/opencv.git && \
    cd opencv && \
    git checkout 3.1.0 && \
    cd ~ && \
    git clone https://github.com/Itseez/opencv_contrib.git && \
    cd opencv_contrib && \
    git checkout 3.1.0 && \
    mkdir build && \ 
    cd build && \
    cd ~/opencv && \
    cmake \
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

COPY . /usr/src/app 
