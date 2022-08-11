FROM almalinux:latest
MAINTAINER Rob Bovill (trekkie2@gmail.com)
ARG USER=appuser
ARG HOME=/home/${USER}

USER root

RUN groupadd -r -g 1003 ${USER} && \
groupadd -r -g 993 docker && \
useradd -r -u 1003 -g ${USER} -G docker -m ${USER} -d ${HOME} && \
chown ${USER}:docker ${HOME}

RUN dnf -y update
RUN dnf -y groupinstall "Development Tools"
RUN dnf -y install wget make

RUN dnf -y install git which mlocate \
openssl-devel make gcc-c++ bzip2-devel libffi-devel zlib-devel && \
dnf clean all && \
rm -rf /var/cache/dnf

RUN updatedb

RUN cd /tmp && \
wget https://www.python.org/ftp/python/3.10.4/Python-3.10.4.tgz && \
tar xvf Python-3.10.4.tgz

RUN cd /tmp/Python-3.10.4 && \
./configure --enable-optimizations && \
make altinstall && \
ln /usr/local/bin/python3.10 /usr/local/bin/python3 && \
python3 --version && pip3.10 --version

RUN python3.10 -m pip install --upgrade pip setuptools numpy && \
python3.10 -m pip install robotframework && \
python3.10 -m pip install astropy && \
python3.10 -m pip install pytest

RUN cd /tmp && \
curl -s http://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/x/xmlstarlet-1.6.1-1.el7.x86_64.rpm --output xmlstarlet-1.6.1-1.el7.x86_64.rpm && \
yum -y install xmlstarlet-1.6.1-1.el7.x86_64.rpm

WORKDIR ${HOME}
RUN pwd

USER ${USER}
RUN mkdir bin && mkdir trunk && mkdir Reports
ENV PATH $PATH:${HOME}/bin:${HOME}/.local/bin
ENV ROBOTFRAMEWORK_SAL_DIR ${HOME}/trunk/robotframework_SAL
ENV TS_XML_DIR ${HOME}/trunk/ts_xml

# Apparently Docker does not support variable expansion in the ADD and COPY context.
# ... Therefore, the ownership must be hardcoded.
COPY --chown=1003:1003 Test_Vars.txt ${HOME}/bin/Test_Vars.txt
COPY --chown=1003:1003 bash_profile ${HOME}/.bash_profile
RUN echo 'source ~/.bash_profile' >> ${HOME}/.bashrc