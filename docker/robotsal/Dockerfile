FROM lsstts/robot:latest
MAINTAINER Rob Bovill (trekkie2@gmail.com)
ARG USER=appuser
ARG HOME=/home/${USER}

USER root
WORKDIR /

RUN mkdir /root/.aws
ADD aws_config /root/.aws/config
ADD lv_includes.tgz /
ADD mavenrepo69.tgz /root
ADD mavenrepo69.tgz ${HOME}
ADD settings.xml ${HOME}/.m2
RUN chown -R 73006:73006 ${HOME}/.m2 

RUN python3.11 -m pip install awscli --upgrade

RUN dnf -y install tk tk-devel \
ncurses-libs xterm \
xorg-x11-fonts-misc \
maven java-1.8.0-openjdk-devel \
gnome-terminal iproute \
mariadb make gcc-c++ \
rpm-build && \
yum clean all && \
rm -rf /var/cache/yum

ADD maven.sh /etc/profile.d/
RUN wget -P /tmp https://mirrors.gigenet.com/apache/maven/maven-3/3.9.4/binaries/apache-maven-3.9.4-bin.tar.gz
RUN tar xf /tmp/apache-maven-3.9.4-bin.tar.gz -C /opt && \
ln -s /opt/apache-maven-3.9.4 /opt/maven && \
source /etc/profile.d/maven.sh && mvn --version

ADD OpenSpliceDDS-6.10.4-2.el8.x86_64.rpm ${HOME}
RUN yum -y install ${HOME}/OpenSpliceDDS-6.10.4-2.el8.x86_64.rpm

USER ${USER}

COPY --chown=73006:73006 start.sh ${HOME}/.
COPY --chown=73006:73006 rpmmacros ${HOME}/.rpmmacros
COPY --chown=0:0 rpmmacros /root/.rpmmacros

ENV LSST_SDK_INSTALL=$HOME/trunk/ts_sal
ENV OSPL_HOME=/opt/OpenSpliceDDS/V6.10.4/HDE/x86_64.linux
ENV JAVA_HOME=/etc/alternatives/java_sdk_1.8.0_openjdk
ENV LSST_DDS_DOMAIN=citest

RUN echo "" >> ${HOME}/.bash_profile && \
echo 'source /etc/profile.d/maven.sh' >> ${HOME}/.bash_profile && \
echo 'source $LSST_SDK_INSTALL/setup.env' >> ${HOME}/.bash_profile && \
echo 'export TS_XML_DIR=${HOME}/trunk/ts_xml' >> ${HOME}/.bash_profile

ENV LSST_DDS_PARTITION_PREFIX=citest
