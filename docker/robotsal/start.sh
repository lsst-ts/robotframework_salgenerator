#!/bin/bash

# Setup Avro/Kafka files
if [ -d $LSST_SDK_INSTALL ]; then
    echo "Clearing out old build artifacts."
    find $LSST_SDK_INSTALL/test/* -type d -exec rm -rf {} +
    find $LSST_SDK_INSTALL/test/* -type f -name "*xml" -exec rm -f {} +
    echo "Copying the Kafka/Avro libraries into $LSST_SDK_INSTALL"
    cp -R $LSST_SAL_PREFIX/* $LSST_SDK_INSTALL
else
    echo "ERROR: Not found $LSST_SDK_INSTALL"
fi

# Setup XML files
if [ -d $TS_XML_DIR ]; then
    echo "Copying the XML filesinto $LSST_SDK_INSTALL/test"
    cp $TS_XML_DIR/python/lsst/ts/xml/data/sal_interfaces/*/*.xml $LSST_SDK_INSTALL/test
    cp $TS_XML_DIR/python/lsst/ts/xml/data/sal_interfaces/SALSubsystems.xml $LSST_SDK_INSTALL/test
    cp $TS_XML_DIR/python/lsst/ts/xml/data/sal_interfaces/SALGenerics.xml $LSST_SDK_INSTALL/test
else
    echo "ERROR: Not found $TS_XML_DIR"
fi

# Return home
cd $HOME
