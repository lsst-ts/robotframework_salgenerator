FROM lsstts/robot:kafka
LABEL org.opencontainers.image.authors="trekkie2@gmail.com"
ARG USER=saluser
ARG HOME=/home/${USER}

# System EnvVars
ENV PYTHONPATH="$PYTHONPATH:$TS_XML_DIR/python"
ENV JAVA_HOME=/usr/lib/jvm/java-17-zulu-openjdk-jdk
ENV MAVEN_HOME=/opt/maven
ENV M2_HOME=${MAVEN_HOME}
ENV PATH=${MAVEN_HOME}/bin:${PATH}

# SAL/XML EnvVars
ENV LSST_SDK_INSTALL=$HOME/repos/ts_sal
ENV OSPL_HOME=/opt/OpenSpliceDDS/V6.10.4/HDE/x86_64.linux
ENV LSST_DDS_DOMAIN=citest
ENV LSST_DDS_PARTITION_PREFIX=citest
## Version variables
ENV MAVEN_RELEASE=3.9.8
ENV AVRO_RELEASE=1.11.1
ENV BOOST_RELEASE=1.78
ENV JDK_RELEASE=17
ENV KAFKA_RELEASE=7.6
ENV JACKSON_RELEASE=2.15.2
## Path variables
ENV LSST_SAL_PREFIX=$HOME/ts_sal_stage
ENV LSST_KAFKA_CLASSDIR=${LSST_SAL_PREFIX}/lib
ENV LSST_KAFKA_PREFIX=lsst.sal
ENV LSST_KAFKA_HOST=broker
ENV LSST_KAFKA_LOCAL_SCHEMAS=${LSST_SAL_PREFIX}
ENV LSST_AVRO_TEMPLATES=${LSST_SAL_PREFIX}/avro
ENV LSST_KAFKA_BROKER_PORT=29092
ENV LSST_KAFKA_BROKER_ADDR=broker:${LSST_KAFKA_BROKER_PORT}
ENV LSST_SCHEMA_REGISTRY_URL=http://schema-registry:8081
ENV AVRO_CLASSPATH=lsst/sal
ENV AVRO_INCL=${LSST_SAL_PREFIX}/include/avro
ENV AVRO_HOME=${LSST_SAL_PREFIX}/lib
ENV AVRO_PREFIX=lsst.sal
ENV LD_LIBRARY_PATH="/usr/lib64/boost1.78:${LSST_SAL_PREFIX}/lib:/usr/local/lib:$LD_LIBRARY_PATH"
ENV CPPFLAGS="-I $LSST_SAL_PREFIX/include/avro"

USER root
WORKDIR /

RUN mkdir /root/.aws
ADD aws_config /root/.aws/config
ADD lv_includes.tgz /
ADD mavenrepo69.tgz /root
ADD mavenrepo69.tgz ${HOME}
ADD settings.xml ${HOME}/.m2
RUN chown -R 73006:73006 ${HOME}/.m2 

# AWS CLI
RUN python3.11 -m pip install awscli --upgrade

# Enable EPEL repo for fmt packages.
RUN dnf -y install epel-release

## Enable the CodeReady Builder repo for snappy and jansson packages on Alma9
#RUN dnf config-manager --set-enabled crb
# Enable the Powertools repo for snappy and jansson packages on Alma8
RUN dnf config-manager -y --set-enabled powertools && dnf -y update

# Install packages and dependencies
RUN dnf -y install tk-devel \
ncurses-libs xterm \
xorg-x11-fonts-misc \
gnome-terminal iproute \
ant make cmake \
fmt fmt-devel \
boost${BOOST_RELEASE}-devel \
snappy-devel csnappy-devel \
jansson-devel libcurl-devel \
rpm-build && \
dnf clean all && \
rm -rf /var/cache/dnf

#RUN dnf -y install gcc-toolset-12 && source scl_source enable gcc-toolset-12

# Maven
ADD maven.sh /etc/profile.d/
RUN wget -P /tmp https://mirrors.gigenet.com/apache/maven/maven-3/3.9.8/binaries/apache-maven-3.9.8-bin.tar.gz
RUN tar xf /tmp/apache-maven-3.9.8-bin.tar.gz -C /opt && \
ln -s /opt/apache-maven-3.9.8 /opt/maven

# Switch to image user and complete setup
USER ${USER}
WORKDIR ${HOME}

COPY --chown=73006:73006 start.sh ${HOME}/.
COPY --chown=73006:73006 rpmmacros ${HOME}/.rpmmacros
COPY --chown=0:0 rpmmacros /root/.rpmmacros

# Set safe.directory
RUN git config --global --add safe.directory ${HOME}/repos/ts_sal && git config --global --add safe.directory ${HOME}/repos/ts_xml

# Install Avro
ARG AVRO_RELEASE=${AVRO_RELEASE}
RUN mkdir $HOME/external-packages && mkdir -p $LSST_SAL_PREFIX/include/avro && mkdir $LSST_SAL_PREFIX/lib && \
mkdir $LSST_SAL_PREFIX/bin && ln -s $LSST_SDK_INSTALL/test/avro-templates $LSST_SAL_PREFIX/avro-templates
WORKDIR $HOME/external-packages
RUN wget https://archive.apache.org/dist/avro/avro-${AVRO_RELEASE}/avro-src-${AVRO_RELEASE}.tar.gz
RUN tar xvzf avro-src-${AVRO_RELEASE}.tar.gz
# Build C++
WORKDIR $HOME/external-packages/avro-src-${AVRO_RELEASE}/lang/c++
USER root
RUN ./build.sh install
USER ${USER}
RUN cp build/lib* $LSST_SAL_PREFIX/lib/. && \
cp --no-preserve=mode,ownership /usr/local/lib/libavrocpp.so.${AVRO_RELEASE} $LSST_SAL_PREFIX/lib/. && \
cp build/avrogencpp $LSST_SAL_PREFIX/bin/. && \
cp -r api/* $LSST_SAL_PREFIX/include/avro/. && \
cp -r impl $LSST_SAL_PREFIX/include/.
# Build C
WORKDIR $HOME/external-packages/avro-src-${AVRO_RELEASE}/lang/c
RUN ./build.sh test && ./cmake_avrolib.sh || true
RUN cp build/avrolib/lib64/lib* $LSST_SAL_PREFIX/lib/. && \
cp -r build/avrolib/include/* $LSST_SAL_PREFIX/include/.

# Install Kafka
ARG KAFKA_RELEASE=7.6
WORKDIR $HOME/external-packages
RUN curl -O https://packages.confluent.io/archive/${KAFKA_RELEASE}/confluent-community-${KAFKA_RELEASE}.0.tar.gz
RUN tar xzf confluent-community-${KAFKA_RELEASE}.0.tar.gz
WORKDIR confluent-${KAFKA_RELEASE}.0/share/java
RUN cp kafka-rest-lib/common-config*.jar ${LSST_SAL_PREFIX}/lib/. && \
cp kafka-rest-lib/common-utils*.jar ${LSST_SAL_PREFIX}/lib/. && \
cp kafka-rest-lib/kafka_*.jar ${LSST_SAL_PREFIX}/lib/. && \
cp kafka-rest-lib/kafka-clients*.jar ${LSST_SAL_PREFIX}/lib/. && \
cp kafka-rest-lib/kafka-schema-registry-client*.jar ${LSST_SAL_PREFIX}/lib/. && \
cp kafka-rest-lib/kafka-avro-serializer*.jar ${LSST_SAL_PREFIX}/lib/. && \
cp kafka-rest-lib/lz4-java*.jar ${LSST_SAL_PREFIX}/lib/. && \
cp kafka-rest-bin/slf4j-api*.jar ${LSST_SAL_PREFIX}/lib/. && \
cp kafka-rest-lib/snappy-java*.jar ${LSST_SAL_PREFIX}/lib/. && \
cp kafka-rest-lib/zstd-jni*.jar ${LSST_SAL_PREFIX}/lib/.

# Install jackson-dataformat-avro
ARG JACKSON_RELEASE=2.15.2
RUN curl -O https://repo1.maven.org/maven2/com/fasterxml/jackson/dataformat/jackson-dataformat-avro/${JACKSON_RELEASE}/jackson-dataformat-avro-${JACKSON_RELEASE}.jar && \
mv jackson-dataformat-avro-${JACKSON_RELEASE}.jar ${LSST_SAL_PREFIX}/lib/.

# Download and build librdkafka
WORKDIR $HOME/external-packages
RUN git clone https://github.com/confluentinc/librdkafka
RUN cd librdkafka && git checkout v1.9.0 && ./configure --prefix=$LSST_SAL_PREFIX && \
make && make install

# Download and build libserdes
RUN ln -sf /usr/include/boost$BOOST_RELEASE/boost $LSST_SAL_PREFIX/include/boost
RUN git clone https://github.com/confluentinc/libserdes
RUN cd libserdes && ./configure --prefix=$LSST_SAL_PREFIX --includedir=$LSST_SAL_PREFIX/include --libdir=$LSST_SAL_PREFIX/lib && \
make || true && \
cd src-cpp && g++ -MD -MP  -I$LSST_SAL_PREFIX/include/avro -I$LSST_SAL_PREFIX/include -g -O2 -fPIC -Wall -Wsign-compare -Wfloat-equal -Wpointer-arith -Wcast-align -I../src  -Wno-non-virtual-dtor  -std=c++17 -c Serdes.cpp -o Serdes.o && make && \
cd ../ && make install

# Setup startup environment
USER ${USER}
WORKDIR ${HOME}
RUN echo "" >> ${HOME}/.bash_profile && \
echo 'source $LSST_SDK_INSTALL/setupKafka.env' >> ${HOME}/.bash_profile
