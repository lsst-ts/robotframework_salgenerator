#!/bin/bash

# Setup Avro/Kafka files
AVRO_RELEASE=1.11.1
mkdir -p $LSST_SAL_PREFIX/include/avro
mkdir -p $LSST_SAL_PREFIX/lib
cd $HOME/external-packages/avro-src-${AVRO_RELEASE}/lang/c++
cp ./build/lib* $LSST_SAL_PREFIX/lib/.
cp ./build/avrogencpp $LSST_SAL_PREFIX/bin/.
cp -r ./api/* $LSST_SAL_PREFIX/include/avro/.
cp -r ./impl $LSST_SAL_PREFIX/include/.
cd $HOME/external-packages/avro-src-${AVRO_RELEASE}/lang/c
cp ./build/avrolib/lib64/lib* $LSST_SAL_PREFIX/lib/.
cp -r ./build/avrolib/include/* $LSST_SAL_PREFIX/include/.
cd $HOME/external-packages/avro-src-${AVRO_RELEASE}/lang/java
cp ./avro/target/avro-1.11.1.jar $LSST_SAL_PREFIX/lib/.
cp ./compiler/target/avro-compiler-1.11.1.jar $LSST_SAL_PREFIX/lib/.
cp ./tools/target/avro-tools-1.11.1.jar $LSST_SAL_PREFIX/lib/.

# Setup XML files
cp $HOME/trunk/ts_xml/python/lsst/ts/xml/data/sal_interfaces/*/*.xml $HOME/trunk/ts_sal/test
cp $HOME/trunk/ts_xml/python/lsst/ts/xml/data/sal_interfaces/SALSubsystems.xml $HOME/trunk/ts_sal/test
cp $HOME/trunk/ts_xml/python/lsst/ts/xml/data/sal_interfaces/SALGenerics.xml $HOME/trunk/ts_sal/test

# Return home
cd $HOME
