FROM almalinux:8
LABEL org.opencontainers.image.authors="trekkie2@gmail.com"
ARG USER=appuser
ARG HOME=/home/${USER}

USER root

# Setup users
RUN groupadd -r -g 73006 ${USER} && \
groupadd -r -g 993 docker && \
useradd -r -u 73006 -g ${USER} -G docker -m ${USER} -d ${HOME} && \
chown ${USER}:docker ${HOME}

# Install packages and dependencies
RUN dnf -y update
RUN dnf -y groupinstall "Development Tools"
RUN dnf -y install wget make

RUN dnf -y install git which mlocate \
openssl-devel make gcc-c++ bzip2-devel libffi-devel zlib-devel && \
dnf clean all && \
rm -rf /var/cache/dnf

RUN updatedb

# Python3.11
RUN cd /tmp && \
wget https://www.python.org/ftp/python/3.11.9/Python-3.11.9.tgz && \
tar xvf Python-3.11.9.tgz

RUN cd /tmp/Python-3.11.9 && \
./configure --enable-optimizations && \
make altinstall && \
ln /usr/local/bin/python3.11 /usr/local/bin/python3 && \
python3 --version && pip3.11 --version

# Install required Python packages
RUN python3.11 -m pip install --upgrade pip setuptools numpy && \
python3.11 -m pip install robotframework && \
python3.11 -m pip install astropy pytest gnureadline

# Java17 Azul
ADD zulu17.52.17-ca-jdk17.0.12-linux.x86_64.rpm ${HOME}
RUN dnf -y install ${HOME}/zulu17.52.17-ca-jdk17.0.12-linux.x86_64.rpm
RUN rm ${HOME}/zulu17.52.17-ca-jdk17.0.12-linux.x86_64.rpm

# XMLStarlet
RUN cd /tmp && \
curl -s https://archives.fedoraproject.org/pub/archive/epel/7/x86_64/Packages/x/xmlstarlet-1.6.1-1.el7.x86_64.rpm --output xmlstarlet-1.6.1-1.el7.x86_64.rpm && \
yum -y install xmlstarlet-1.6.1-1.el7.x86_64.rpm

# Setup environment
WORKDIR ${HOME}
USER ${USER}

RUN mkdir bin && mkdir trunk && mkdir Reports
ENV PATH=$PATH:${HOME}/bin:${HOME}/.local/bin
ENV ROBOTFRAMEWORK_SAL_DIR=${HOME}/trunk/robotframework_SAL
ENV TS_XML_DIR=${HOME}/trunk/ts_xml

# Apparently Docker does not support variable expansion in the ADD and COPY context.
# ... Therefore, the ownership must be hardcoded.
COPY --chown=73006:73006 Test_Vars.txt ${HOME}/bin/Test_Vars.txt
COPY --chown=73006:73006 bash_profile ${HOME}/.bash_profile
RUN echo 'export TS_XML_DIR=${HOME}/trunk/ts_xml' >> ${HOME}/.bash_profile
RUN echo 'source ~/.bash_profile' >> ${HOME}/.bashrc
