FROM resin/raspberrypi3-debian
MAINTAINER ctc94 <mir948040@naver.com>

RUN echo "Keras & scikit-learn install version"

RUN apt-get update && apt-get install -y \
        build-essential \
        libpng-dev \
        libfreetype6-dev \
        libhdf5-serial-dev \
        libzmq3-dev \
        pkg-config \
        python \
        python-dev \
        libhdf5-dev \
        python-h5py \
        python-yaml \
        python-pip \
        python3-pip \
        libblas-dev \
        liblapack-dev \
        gfortran 

RUN apt-get install -y \
  python3-dev

RUN pip3 install \
  tokenizer \
  setuptools

RUN pip3 install -v \
   nltk \
   numpy

RUN pip3 install -v \
   scipy

RUN pip3 install -v \
   scikit-learn

RUN pip3 install -v \
   keras

RUN pip3 install -v \
   matplotlib

RUN pip3 install -v \
   ipython 
RUN pip3 install -v \
   pandas

RUN pip3 install -v \
   sympy \
   nose \
   jupyter 


RUN apt-get install -y wget
RUN wget https://github.com/samjabrahams/tensorflow-on-raspberry-pi/releases/download/v1.1.0/tensorflow-1.1.0-cp34-cp34m-linux_armv7l.whl
RUN pip3 install tensorflow-1.1.0-cp34-cp34m-linux_armv7l.whl

# Set up our notebook config.
COPY jupyter_notebook_config.py /root/.jupyter/

# Copy sample notebooks.
COPY notebooks /notebooks

# Jupyter has issues with being run directly:
#   https://github.com/ipython/ipython/issues/7062
# We just add a little wrapper script.
COPY run_jupyter.sh /

# TensorBoard
EXPOSE 6006
# IPython
EXPOSE 8888

WORKDIR "/notebooks"

CMD ["/run_jupyter.sh", "--allow-root"]
RUN python3 -m ipykernel.kernelspec
