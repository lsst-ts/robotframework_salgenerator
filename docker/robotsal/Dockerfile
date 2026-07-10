FROM lsstts/robot:latest
LABEL org.opencontainers.image.authors="trekkie2@gmail.com"
ARG USER=saluser
ARG HOME=/home/${USER}

# System EnvVars
ENV PYTHONPATH="$PYTHONPATH:$TS_XML_DIR/python"
ENV MAVEN_HOME=/opt/maven
ENV M2_HOME=${MAVEN_HOME}

# SAL/XML EnvVars
ENV LSST_SDK_INSTALL=$HOME/repos/ts_sal
ENV OSPL_HOME=/opt/OpenSpliceDDS/V6.10.4/HDE/x86_64.linux
ENV LSST_DDS_DOMAIN=citest
ENV LSST_DDS_PARTITION_PREFIX=citest
## Version variables
ENV MAVEN_RELEASE=3.9.16
ENV AVRO_RELEASE=1.12.0
ENV BOOST_RELEASE=1.78
ENV JDK_RELEASE=17
ENV KAFKA_RELEASE=7.6
ENV JACKSON_RELEASE=2.15.2
ENV LIBRDKAFKA_RELEASE=2.6.1
ENV LIBSCHEMAREG_RELEASE=0.1.3
## Path variables
ENV LSST_SAL_PREFIX=$HOME/ts_sal_stage
ENV LSST_KAFKA_SECURITY_PROTOCOL=PLAINTEXT
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
ENV VCPKG_ROOT=/opt/vcpkg
ENV LIBRARY_PATH=/usr/lib64/boost1.78:${LSST_SAL_PREFIX}/lib
ENV LD_LIBRARY_PATH="/usr/lib64/boost1.78:${LSST_SAL_PREFIX}/lib:/usr/local/lib"
ENV CPPFLAGS="-I $LSST_SAL_PREFIX/include/avro"
ENV PATH=${MAVEN_HOME}/bin:${VCPKG_ROOT}:/usr/bin/ninja:${PATH}

USER root
WORKDIR /

RUN mkdir /root/.aws
ADD aws_config /root/.aws/config
ADD lv_includes.tgz /
ADD mavenrepo69.tgz /root
ADD mavenrepo69.tgz ${HOME}
ADD settings.xml ${HOME}/.m2
ADD libschemaregistry-vcpkg-avro-only.patch ${HOME}
RUN chown -R 73006:73006 ${HOME}/.m2 

# AWS CLI and fastavro
RUN python3.13 -m pip install fastavro awscli --upgrade

# Enable EPEL repo for fmt packages
RUN dnf -y install epel-release

# Enable the CodeReady Builder repo for snappy and jansson packages
RUN dnf config-manager --set-enabled crb

# Install packages and dependencies
RUN dnf -y install tk-devel tcllib \
ncurses-libs xterm \
xorg-x11-fonts-misc \
gnome-terminal iproute \
make cmake gcc-c++ \
fmt fmt-devel \
boost${BOOST_RELEASE}-devel jansson-devel \
snappy-devel libcurl-devel \
cyrus-sasl-devel lz4-devel \
catch-devel perl \
ninja-build pkgconfig \
rpm-build && \
dnf clean all && \
rm -rf /var/cache/dnf

#RUN dnf -y install gcc-toolset-12 && source scl_source enable gcc-toolset-12

# Maven
ADD maven.sh /etc/profile.d/
RUN wget -P /tmp https://mirrors.gigenet.com/apache/maven/maven-3/${MAVEN_RELEASE}/binaries/apache-maven-${MAVEN_RELEASE}-bin.tar.gz
RUN tar xf /tmp/apache-maven-${MAVEN_RELEASE}-bin.tar.gz -C /opt && \
ln -s /opt/apache-maven-${MAVEN_RELEASE} /opt/maven

# Pre-load the vcpkg package manager
RUN git clone https://github.com/microsoft/vcpkg.git $VCPKG_ROOT && $VCPKG_ROOT/bootstrap-vcpkg.sh -disableMetrics && \
chown -R 73006:73006 $VCPKG_ROOT

# Switch to image user and complete setup
USER ${USER}
WORKDIR ${HOME}

RUN mkdir -p ccs/maven ccs/scripts
COPY --chown=73006:73006 start.sh ${HOME}/.
COPY --chown=73006:73006 rpmmacros ${HOME}/.rpmmacros
COPY --chown=0:0 rpmmacros /root/.rpmmacros
COPY --chown=73006:73006 --chmod=664 pipeline-settings.xml ccs/maven/pipeline-settings.xml
COPY --chown=73006:73006 --chmod=775 updateJiraVersions.sh ccs/scripts/updateJiraVersions.sh

# Set safe.directory
RUN git config --global --add safe.directory ${HOME}/repos/ts_sal && git config --global --add safe.directory ${HOME}/repos/ts_xml

# Setup build directories
RUN mkdir $HOME/external-packages && mkdir -p $LSST_SAL_PREFIX/include/avro && mkdir $LSST_SAL_PREFIX/lib && \
  mkdir $LSST_SAL_PREFIX/bin && ln -s $LSST_SDK_INSTALL/test/avro-templates $LSST_SAL_PREFIX/avro-templates
RUN ln -sf /usr/include/boost$BOOST_RELEASE/boost $LSST_SAL_PREFIX/include/boost

# Install Avro
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
  cp -r include/avro/* $LSST_SAL_PREFIX/include/avro/.
# Build C
WORKDIR $HOME/external-packages/avro-src-${AVRO_RELEASE}/lang/c
RUN ./build.sh test && ./cmake_avrolib.sh || true
RUN cp build/avrolib/lib64/lib* $LSST_SAL_PREFIX/lib/. && \
  cp -r build/avrolib/include/* $LSST_SAL_PREFIX/include/.

# Install Kafka
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
RUN curl -O https://repo1.maven.org/maven2/com/fasterxml/jackson/dataformat/jackson-dataformat-avro/${JACKSON_RELEASE}/jackson-dataformat-avro-${JACKSON_RELEASE}.jar && \
  mv jackson-dataformat-avro-${JACKSON_RELEASE}.jar ${LSST_SAL_PREFIX}/lib/.

# Download and build librdkafka
WORKDIR $HOME/external-packages
RUN git clone https://github.com/confluentinc/librdkafka
RUN cd librdkafka && git checkout v${LIBRDKAFKA_RELEASE} && ./configure --prefix=$LSST_SAL_PREFIX && \
  make && make install

# Download and build libschemaregistry
WORKDIR $HOME/external-packages
RUN git clone --depth 1 --branch $LIBSCHEMAREG_RELEASE https://github.com/confluentinc/libschemaregistry.git
RUN cd libschemaregistry && git apply $HOME/libschemaregistry-vcpkg-avro-only.patch && \
  cmake -S . -B build -DCMAKE_BUILD_TYPE=Release \
    -G Ninja \
    -DCMAKE_MAKE_PROGRAM=/usr/bin/ninja \
    -DCMAKE_C_COMPILER=gcc \
    -DCMAKE_CXX_COMPILER=g++ \
    -DCMAKE_TOOLCHAIN_FILE="${VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake" \
    -DCMAKE_INSTALL_PREFIX="$LSST_SAL_PREFIX" \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DSCHEMAREGISTRY_WITH_AVRO=ON \
    -DSCHEMAREGISTRY_WITH_PROTOBUF=OFF \
    -DSCHEMAREGISTRY_WITH_JSON=OFF \
    -DSCHEMAREGISTRY_WITH_RULES=OFF \
    -DSCHEMAREGISTRY_BUILD_TESTS=OFF \
    -DSCHEMAREGISTRY_BUILD_EXAMPLES=OFF && \
  cmake --build build -j"$(nproc)" && cmake --install build
WORKDIR $HOME/external-packages/libschemaregistry/build/vcpkg_installed/x64-linux
RUN cp lib/libabsl_*.a  ${LSST_SAL_PREFIX}/lib/. && \
  cp lib/libcpr.a ${LSST_SAL_PREFIX}/lib/. && \
  cp lib/libcurl.a ${LSST_SAL_PREFIX}/lib/. && \
  cp lib/libz.a ${LSST_SAL_PREFIX}/lib/. && \
  cp lib/libbz2.a ${LSST_SAL_PREFIX}/lib/. && \
  cp lib/liblzma.a ${LSST_SAL_PREFIX}/lib/. && \
  cp lib/libzstd.a ${LSST_SAL_PREFIX}/lib/. && \
  cp -r include/absl ${LSST_SAL_PREFIX}/include/. && \
  cp -r include/cpr ${LSST_SAL_PREFIX}/include/. && \
  cp -r include/curl ${LSST_SAL_PREFIX}/include/. && \
  cp -r include/nlohmann ${LSST_SAL_PREFIX}/include/.

# Setup startup environment
USER ${USER}
WORKDIR ${HOME}
RUN rm ${HOME}/libschemaregistry-vcpkg-avro-only.patch
RUN echo "" >> ${HOME}/.bash_profile && \
  echo 'source $LSST_SDK_INSTALL/setupKafka.env' >> ${HOME}/.bash_profile
