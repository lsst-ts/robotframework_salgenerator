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

RUN dnf -y install epel-release && \
dnf config-manager -y --set-enabled powertools

RUN dnf -y install tk-devel \
ncurses-libs xterm \
xorg-x11-fonts-misc \
java-11-openjdk \
java-11-openjdk-devel \
gnome-terminal iproute \
make cmake gcc-c++ \
boost-devel jansson-devel \
snappy-devel libcurl-devel \
rpm-build && \
yum clean all && \
rm -rf /var/cache/yum

# Java and Maven ENVs
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk
ENV M2_HOME=/opt/maven
ENV MAVEN_HOME=/opt/maven
ENV PATH=${PATH}:${M2_HOME}/bin:/usr/share
# Install Maven
RUN wget -P /tmp https://mirrors.gigenet.com/apache/maven/maven-3/3.9.4/binaries/apache-maven-3.9.4-bin.tar.gz
RUN tar xf /tmp/apache-maven-3.9.4-bin.tar.gz -C /opt && \
ln -s /opt/apache-maven-3.9.4 /opt/maven 

# Install OpenSpliceDDS
ADD OpenSpliceDDS-6.10.4-2.el8.x86_64.rpm ${HOME}
RUN yum -y install ${HOME}/OpenSpliceDDS-6.10.4-2.el8.x86_64.rpm

# Switch to image user and complete setup
USER ${USER}
WORKDIR ${HOME}

COPY --chown=73006:73006 start.sh ${HOME}/.
COPY --chown=73006:73006 rpmmacros ${HOME}/.rpmmacros
COPY --chown=0:0 rpmmacros /root/.rpmmacros

# SAL/XML ENVs
ENV LSST_SDK_INSTALL=$HOME/trunk/ts_sal
ENV OSPL_HOME=/opt/OpenSpliceDDS/V6.10.4/HDE/x86_64.linux
ENV LSST_DDS_DOMAIN=citest
ENV LSST_DDS_PARTITION_PREFIX=citest
ENV PYTHONPATH=$PYTHONPATH:$TS_XML_DIR/python

# SAL Kafka/Avro EnvVars
ENV LSST_SAL_PREFIX=$HOME/ts_sal_stage
ENV LSST_KAFKA_PREFIX=lsst.sal
ENV LSST_KAFKA_HOST=localhost
ENV LSST_KAFKA_IP=localhost
ENV LSST_KAFKA_LOCAL_SCHEMAS=${LSST_SDK_INSTALL}/test
ENV LSST_KAFKA_BROKER_PORT=9092
ENV LSST_KAFKA_BROKER_ADDR=localhost
ENV LSST_SCHEMA_REGISTRY_URL=https://localhost:8081
ENV AVRO_CLASSPATH=lsst/sal
ENV AVRO_RELEASE=1.11.1
ENV AVRO_INCL=${LSST_SDK_INSTALL}/lsstsal/include/avro
ENV AVRO_HOME=${LSST_SDK_INSTALL}/lsstsal/lib
ENV AVRO_PREFIX=lsst.sal
ENV LD_LIBRARY_PATH=${LSST_SAL_PREFIX}/lib:$LD_LIBRARY_PATH
ENV CPPFLAGS="-I $LSST_SAL_PREFIX/include/avro"

# Install Avro
ARG AVRO_RELEASE=1.11.1
RUN mkdir $HOME/external-packages && mkdir -p $LSST_SAL_PREFIX/include/avro && mkdir $LSST_SAL_PREFIX/lib && mkdir $LSST_SAL_PREFIX/bin
WORKDIR $HOME/external-packages
RUN wget https://archive.apache.org/dist/avro/avro-${AVRO_RELEASE}/avro-src-${AVRO_RELEASE}.tar.gz
# Build C++
RUN tar xvzf avro-src-${AVRO_RELEASE}.tar.gz
WORKDIR $HOME/external-packages/avro-src-${AVRO_RELEASE}/lang/c++
RUN ./build.sh test
RUN cp build/lib* $LSST_SAL_PREFIX/lib/. && \
cp build/avrogencpp $LSST_SAL_PREFIX/bin/. && \
cp -r api/* $LSST_SAL_PREFIX/include/avro/. && \
cp -r impl $LSST_SAL_PREFIX/include/.
# Build C
WORKDIR $HOME/external-packages/avro-src-${AVRO_RELEASE}/lang/c
RUN ./build.sh test && ./cmake_avrolib.sh || true
RUN cp build/avrolib/lib64/lib* $LSST_SAL_PREFIX/lib/. && \
cp -r build/avrolib/include/* $LSST_SAL_PREFIX/include/.
#Build Java
WORKDIR $HOME/external-packages/avro-src-${AVRO_RELEASE}/lang/java
RUN ./build.sh test && ./build.sh dist
RUN cp ./avro/target/avro-1.11.1.jar $LSST_SAL_PREFIX/lib/. && \
cp ./compiler/target/avro-compiler-1.11.1.jar $LSST_SAL_PREFIX/lib/. && \
cp ./maven-plugin/target/avro-maven-plugin-1.11.1.jar $LSST_SAL_PREFIX/lib/. && \
cp ./tools/target/avro-tools-1.11.1.jar $LSST_SAL_PREFIX/lib/.

# Download and build librdkafka
WORKDIR $HOME/external-packages
RUN git clone https://github.com/confluentinc/librdkafka
RUN cd librdkafka && ./configure --prefix=$LSST_SAL_PREFIX && \
make && make install

# Download and build libserdes
RUN git clone https://github.com/confluentinc/libserdes
RUN cd libserdes && ./configure --prefix=$LSST_SAL_PREFIX --includedir=$LSST_SAL_PREFIX/include --libdir=$LSST_SAL_PREFIX/lib && \
make && make install

# Setup startup environment
USER ${USER}
WORKDIR ${HOME}
RUN echo "" >> ${HOME}/.bash_profile && \
echo 'source $LSST_SDK_INSTALL/setupKafka.env' >> ${HOME}/.bash_profile
