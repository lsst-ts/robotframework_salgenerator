FROM almalinux:9
LABEL org.opencontainers.image.authors="trekkie2@gmail.com"
ARG USER=saluser
ARG HOME=/home/${USER}

USER root

# Setup users
RUN groupadd -r -g 73006 ${USER} && \
groupadd -r -g 993 docker && \
useradd -r -u 73006 -g ${USER} -G docker -m ${USER} -d ${HOME} && \
chown ${USER}:docker ${HOME}

RUN if [ -d "$HOME/.cache" ]; then \
        chown -R saluser:saluser "$HOME/.cache"; \
    fi

# Install packages and dependencies
RUN dnf -y update
RUN dnf -y groupinstall "Development Tools"

RUN dnf -y install git which mlocate wget \
openssl-devel make gcc-c++ bzip2-devel libffi-devel zlib-devel && \
dnf clean all && \
rm -rf /var/cache/dnf

RUN updatedb

# Set EnvVars
ENV PATH=$PATH:${HOME}/bin:${HOME}/.local/bin
ENV ROBOTFRAMEWORK_SAL_DIR=${HOME}/repos/robotframework_SAL
ENV TS_XML_DIR=${HOME}/repos/ts_xml
ENV PYTHONPATH="$TS_XML_DIR/python"
ENV JAVA_HOME=/usr/lib/jvm/java-17-zulu-openjdk-jdk
ENV CONDA_PLUGINS_AUTO_ACCEPT_TOS=true

# Python3.12
RUN cd /tmp && \
wget https://www.python.org/ftp/python/3.12.9/Python-3.12.9.tgz && \
tar xvf Python-3.12.9.tgz

RUN cd /tmp/Python-3.12.9 && \
./configure --enable-optimizations && \
make altinstall && \
ln /usr/local/bin/python3.12 /usr/local/bin/python3

# Install required Python packages
RUN python3.12 -m pip install --upgrade pip setuptools numpy && \
python3.12 -m pip install robotframework && \
python3.12 -m pip install astropy pytest gnureadline

# Java17 Azul
ADD zulu17.52.17-ca-jdk17.0.12-linux.x86_64.rpm ${HOME}
RUN dnf -y install ${HOME}/zulu17.52.17-ca-jdk17.0.12-linux.x86_64.rpm
RUN rm ${HOME}/zulu17.52.17-ca-jdk17.0.12-linux.x86_64.rpm

# XMLStarlet
RUN cd /tmp && \
curl -s https://archives.fedoraproject.org/pub/archive/epel/7/x86_64/Packages/x/xmlstarlet-1.6.1-1.el7.x86_64.rpm --output xmlstarlet-1.6.1-1.el7.x86_64.rpm && \
yum -y install xmlstarlet-1.6.1-1.el7.x86_64.rpm

WORKDIR ${HOME}
USER ${USER}

RUN mkdir bin repos Reports miniconda3

# Conda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh && \
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3 && \
rm ~/miniconda3/miniconda.sh

RUN source miniconda3/bin/activate && \
conda update conda -y && \
conda config --add channels defaults && \
conda config --add channels conda-forge && \
conda install -c conda-forge 'python=3.12'  'libarchive' 'libmamba' -y && \
pip3 install -U setuptools robotframework numpy astropy gnureadline && \
conda clean --all

# Setup environment
# Apparently Docker does not support variable expansion in the ADD and COPY context.
# ... Therefore, the ownership must be hardcoded.
COPY --chown=73006:73006 Test_Vars.txt ${HOME}/bin/Test_Vars.txt
COPY --chown=73006:73006 bash_profile ${HOME}/.bash_profile
RUN echo 'export TS_XML_DIR=${HOME}/repos/ts_xml' >> ${HOME}/.bash_profile
RUN echo 'source ~/.bash_profile' >> ${HOME}/.bashrc
