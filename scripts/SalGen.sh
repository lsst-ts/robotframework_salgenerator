#!/bin/bash
#  Shell script to create the Robot-Framework (RF) 
#  salgenerator test suites that create and test 
#  the SAL/DDS library generation process.
#
#  author: Rob Bovill
#  email:  rbovill@lsst.org


###  VARIABLES ###
#  Define variables and import the 
#  common functions used in this script.
#
# arg : 'string'
#       The invocation argument. Controls what is built;
#       One of 'all', a single <CSC> or left blank.
#
# workDir : 'string'
#       Defines the working directory.
#
# subSystemArray : 'string' array
#       Array of all the CSCs, as defined in the 
#       _common.sh>subsystemArray() function.
#
arg=${1-all}
workDir=$HOME/trunk/robotframework_salgenerator
source $workDir/scripts/_common.sh
declare -a subSystemArray=($(subsystemArray))


###  FUNCTIONS ###

function createSettings() {
    # Creates the RF Settings section.
    #  This is where the test suites import the libraries,
    #  especially the Global_Vars.resource file.
    #
    local subsystem=$(echo "$1" |tr '[:upper:]' '[:lower:]')
    echo "*** Settings ***" >> $testSuite
    echo "Documentation    This suite builds the various interfaces for the $subSystemUp." >> $testSuite
    echo "Force Tags    salgen    $subsystem" >> $testSuite
    echo "Suite Setup    Log Many    \${Host}    \${subSystem}    \${timeout}" >> $testSuite
    echo "Library    OperatingSystem" >> $testSuite
    echo "Library    Process" >> $testSuite
    echo "Resource    ../Global_Vars.resource" >> $testSuite
    echo "" >> $testSuite
}


function createVariables() {
    # Creates the RF Variables section.
    #   Getting the timeout value correct is very challenging.
    #   It needs to be long enough to allow all test suites to
    #   complete, but short enough to reduce unncessary waiting.
    #
    echo "*** Variables ***" >> $testSuite
    echo "\${subSystem}    $subSystem" >> $testSuite
    echo "\${timeout}    1200s" >> $testSuite
    echo "" >> $testSuite
}


function cleanupOutputs() {
    # Creates the Cleanup test case.
    #  Many of the combined messaging programs overfill 
    #  the stdout buffer. Instead, we use the stdout 
    #  and stderr output files. As such, clean them up
    #  at the end of the test suite.
    #
    echo "Cleanup stdout and stderr Files" >> $testSuite
    echo "    [Tags]" >> $testSuite
    echo "    Remove Files    \${EXECDIR}\${/}\${subSystem}_stdout.txt    \${EXECDIR}\${/}\${subSystem}_stderr.txt" >> $testSuite
    echo "" >> $testSuite
}


function verifyXMLDefinitions() {
    # Creates the test case to verify the XML files exist.
    #  Somewhat perfunctory, but good to check just in case.
    #
    echo "Verify $subSystemUp XML Defintions exist" >> $testSuite
    echo "    [Tags]    validate" >> $testSuite
    echo "    Comment    Verify the CSC XML definition files exist." >> $testSuite
    if [[ "${xmls[0]}" == "README.md" ]]; then
        echo "    \${output}    Get File    \${EXECDIR}/../ts_xml/python/lsst/ts/xml/data/sal_interfaces/$subSystem/README.md" >> $testSuite
        echo "    Log    \${output}" >> $testSuite
        echo "    Should Contain     \${output}    \# \${subSystem}" >> $testSuite
        echo "    Should Contain     \${output}    This SAL Component only uses generic topics." >> $testSuite
        echo "    Should Contain     \${output}    This directory is intentionally left empty." >> $testSuite
    else
        echo "    \${output}    Run Process    ls     \${SALWorkDir}/\${subSystem}_*xml    shell=True" >> $testSuite
        echo "    Log Many    \${output.stdout}    \${output.stderr}" >> $testSuite
        echo "    Should Not Be Empty    \${output.stdout}" >> $testSuite
        for file in "${xmls[@]}"; do
            echo "    File Should Exist    \${SALWorkDir}/$file" >> $testSuite
        done
    fi
    echo "" >> $testSuite
}


function salgenValidate() {
    # Creates the salgenerator validate test case.
    #  Since not all CSCs have all XML topic types,
    #  use conditionals to control the tests.
    #
    skipped=$(checkIfSkipped "validate")
    echo "Salgen $subSystemUp Validate" >> $testSuite
    echo "    [Documentation]    Validate the $subSystemUp XML definitions." >> $testSuite
    echo "    [Tags]    validate$skipped" >> $testSuite
    echo "    \${output}=    Run Process    \${SALHome}/bin/salgeneratorKafka    \${subSystem}    validate    \
shell=True    cwd=\${SALWorkDir}    stdout=\${EXECDIR}\${/}\${subSystem}_stdout.txt    stderr=\${EXECDIR}\${/}\${subSystem}_stderr.txt" >> $testSuite
    echo "    Log Many    \${output.stdout}    \${output.stderr}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    SAL generator - \${SALVersion}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    XMLVERSION = \${XMLVersion}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    Processing \${subSystem}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    Completed \${subSystem} validation" >> $testSuite
    echo "    Directory Should Exist    \${SALWorkDir}/avro-templates" >> $testSuite
    echo "    @{files}=    List Directory    \${SALWorkDir}/avro-templates" >> $testSuite
    echo "    Log Many    @{files}" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/avro-templates/\${subSystem}_metadata.tcl" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/avro-templates/\${subSystem}_revCodes.tcl" >> $testSuite
    echo "    Directory Should Exist    \${SALWorkDir}/avro-templates/\${subSystem}" >> $testSuite
    echo "    @{files}=    List Directory    \${SALWorkDir}/avro-templates/\${subSystem}" >> $testSuite
    echo "    Log Many    @{files}" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/avro-templates/\${subSystem}/\${subSystem}_hash_table.json" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/avro-templates/\${subSystem}/\${subSystem}_Generics.xml" >> $testSuite
    if test -f $HOME/trunk/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Commands.xml; then
        echo "    File Should Exist    \${SALWorkDir}/avro-templates/\${subSystem}/\${subSystem}_Commands.xml" >> $testSuite
        echo "    File Should Exist    \${SALWorkDir}/avro-templates/\${subSystem}_cmddef.tcl" >> $testSuite
    fi
    if test -f $HOME/trunk/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Events.xml; then
        echo "    File Should Exist    \${SALWorkDir}/avro-templates/\${subSystem}/\${subSystem}_Events.xml" >> $testSuite
        echo "    File Should Exist    \${SALWorkDir}/avro-templates/\${subSystem}_evtdef.tcl" >> $testSuite
    fi
    if test -f $HOME/trunk/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Telemetry.xml; then
        echo "    File Should Exist    \${SALWorkDir}/avro-templates/\${subSystem}/\${subSystem}_Telemetry.xml" >> $testSuite
        echo "    File Should Exist    \${SALWorkDir}/avro-templates/\${subSystem}_tlmdef.tcl" >> $testSuite
    fi
    for topic in "${commandsArray[@]}"; do
        echo "    File Should Exist    \${SALWorkDir}/avro-templates/\${subSystem}/\${subSystem}_command_${topic}.json" >> $testSuite
    done
    for topic in "${eventArray[@]}"; do
        echo "    File Should Exist    \${SALWorkDir}/avro-templates/\${subSystem}/\${subSystem}_logevent_${topic}.json" >> $testSuite
    done
    for topic in "${telemetryArray[@]}"; do
        echo "    File Should Exist    \${SALWorkDir}/avro-templates/\${subSystem}/\${subSystem}_${topic}.json/" >> $testSuite
    done
    echo "" >> $testSuite
}


function salgenDOC() {
    skipped=$(checkIfSkipped "doc")
    echo "Salgen $subSystemUp Doc" >> $testSuite
    echo "    [Documentation]    Create the CSC documentation." >> $testSuite
    echo "    [Tags]    doc$skipped" >> $testSuite
    echo "    \${output}=    Run Process    \${SALHome}/bin/salgeneratorKafka    \${subSystem}    apidoc    \
shell=True    cwd=\${SALWorkDir}    stdout=\${EXECDIR}\${/}\${subSystem}_stdout.txt    stderr=\${EXECDIR}\${/}\${subSystem}_stderr.txt" >> $testSuite
    echo "    Log Many    \${output.stdout}    \${output.stderr}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    SAL generator - \${SALVersion}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    XMLVERSION = \${XMLVersion}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    checking \${subSystem}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    checking apidoc" >> $testSuite
    echo "    Should Contain    \${output.stdout}    Building API documentation for \${subSystem} subsystem" >> $testSuite
    echo "    Directory Should Exist    \${SALHome}/doc/_build/html/apiDocumentation/SAL_\${subSystem}" >> $testSuite
    echo "    @{files}=    List Directory    \${SALHome}/doc/_build/html/apiDocumentation/SAL_\${subSystem}" >> $testSuite
    echo "    Log Many    @{files}" >> $testSuite
    echo "    File Should Exist    \${SALHome}/doc/_build/html/apiDocumentation/SAL_\${subSystem}/index.html" >> $testSuite
    echo "" >> $testSuite
}


function salgenCPP {
    # Creates the salgenerator C++ test case.
    #  Some CSCs have NO telemetry.
    #  All CSCs get one Command and Event entry.
    #
    echo "Salgen $subSystemUp C++" >> $testSuite
    echo "    [Documentation]    Generate C++ libraries." >> $testSuite
    echo "    [Tags]    cpp" >> $testSuite
    echo "    \${output}=    Run Process    \${SALHome}/bin/salgeneratorKafka    \${subSystem}    sal    cpp   \
shell=True    cwd=\${SALWorkDir}    stdout=\${EXECDIR}\${/}\${subSystem}_stdout.txt    stderr=\${EXECDIR}\${/}\${subSystem}_stderr.txt" >> $testSuite
    echo "    Log Many    \${output.stdout}    \${output.stderr}" >> $testSuite
    echo "    Should Not Contain    \${output.stdout}    ERROR : Failed to generate CPP DDS types" >> $testSuite
    echo "    Should Not Contain    \${output.stdout}    *** DDS error in file" >> $testSuite
    echo "    Should Not Contain    \${output.stdout}    Error 1" >> $testSuite
    echo "    Should Contain    \${output.stdout}    SAL generator - \${SALVersion}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    XMLVERSION = \${XMLVersion}" >> $testSuite
    if [ ${#telemetryArray[@]} -eq 0 ]; then
        echo "    Should Contain    \${output.stdout}    WARNING : No Telemetry definitions found for \${subSystem}" >> $testSuite
    else
        for topic in "${telemetryArray[@]}"; do
            echo "    Should Contain    \${output.stdout}    Generating cpp type support for \${subSystem}" >> $testSuite
        done
        echo "    Should Contain X Times    \${output.stdout}    cpp : Done Publisher    ${#telemetryArray[@]}" >> $testSuite
        echo "    Should Contain X Times    \${output.stdout}    cpp : Done Subscriber    ${#telemetryArray[@]}" >> $testSuite
    fi
    echo "    Should Contain X Times    \${output.stdout}    cpp : Done Commander    1" >> $testSuite
    echo "    Should Contain X Times    \${output.stdout}    cpp : Done Event/Logger    1" >> $testSuite
    echo "" >> $testSuite
}


function verifyCppDirectories() {
    # Creates the test case to verify the expected
    # C++ SAL/DDS libraries were created.
    #
    echo "Verify C++ Directories" >> $testSuite
    echo "    [Documentation]    Ensure expected C++ directories and files are created." >> $testSuite
    echo "    [Tags]    cpp" >> $testSuite
    echo "    Directory Should Exist    \${SALWorkDir}/\${subSystem}/cpp" >> $testSuite
    echo "    @{files}=    List Directory    \${SALWorkDir}/\${subSystem}/cpp/src    pattern=*\${subSystem}*" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/cpp/src/SAL_\${subSystem}.cpp" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/cpp/src/SAL_\${subSystem}C.h" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/cpp/src/SAL_\${subSystem}LV.h" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/cpp/src/SAL_\${subSystem}_actors.h" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/cpp/src/SAL_\${subSystem}_enums.h" >> $testSuite
    echo "" >> $testSuite
}


function verifyTelemetryDirectories() {
    # Creates the test case to verify the expected
    # C++ Telemetry folders were created.
    #
    echo "Verify $subSystemUp Telemetry directories" >> $testSuite
    echo "    [Tags]    cpp" >> $testSuite
    echo "    @{files}=    List Directory    \${SALWorkDir}    pattern=*\${subSystem}*" >> $testSuite
    echo "    Log Many    @{files}" >> $testSuite
    for topic in "${telemetryArray[@]}"; do
        echo "    Directory Should Exist    \${SALWorkDir}/\${subSystem}_${topic}" >> $testSuite
    done
    echo "" >> $testSuite
}


function verifyCppTelemetryInterfaces() {
    # Creates the test case to verify the expected
    # C++ Telemetry files were created.
    #
    echo "Verify $subSystemUp C++ Telemetry Interfaces" >> $testSuite
    echo "    [Documentation]    Verify the C++ interfaces were properly created." >> $testSuite
    echo "    [Tags]    cpp" >> $testSuite
    for topic in "${telemetryArray[@]}"; do
        echo "    File Should Exist    \${SALWorkDir}/\${subSystem}_${topic}/cpp/standalone/sacpp_\${subSystem}_pub" >> $testSuite
        echo "    File Should Exist    \${SALWorkDir}/\${subSystem}_${topic}/cpp/standalone/sacpp_\${subSystem}_sub" >> $testSuite
        echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/cpp/src/\${subSystem}_${topic}.hh" >> $testSuite
    done
    echo "" >> $testSuite
}


function verifyCppCommandInterfaces() {
    # Creates the test case to verify the expected
    # C++ Command files were created.
    #
    echo "Verify $subSystemUp C++ Command Interfaces" >> $testSuite
    echo "    [Documentation]    Verify the C++ interfaces were properly created." >> $testSuite
    echo "    [Tags]    cpp" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/cpp/src/\${subSystem}_ackcmd.hh" >> $testSuite
    for topic in "${commandArray[@]}"; do
        echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/cpp/src/sacpp_\${subSystem}_${topic}_commander" >> $testSuite
        echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/cpp/src/sacpp_\${subSystem}_${topic}_controller" >> $testSuite
        echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/cpp/src/\${subSystem}_command_${topic}.hh" >> $testSuite
    done
    echo "" >> $testSuite
}


function verifyCppEventInterfaces() {
    # Creates the test case to verify the expected
    # C++ Event files were created.
    #
    echo "Verify $subSystemUp C++ Event Interfaces" >> $testSuite
    echo "    [Documentation]    Verify the C++ interfaces were properly created." >> $testSuite
    echo "    [Tags]    cpp" >> $testSuite
    for topic in "${eventArray[@]}"; do
        echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/cpp/src/sacpp_\${subSystem}_${topic}_send" >> $testSuite
        echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/cpp/src/sacpp_\${subSystem}_${topic}_log" >> $testSuite
        echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/cpp/src/\${subSystem}_logevent_${topic}.hh" >> $testSuite
    done
    echo "" >> $testSuite
}


function salgenJava() {
    # Creates the salgenerator Java test case.
    #  Some CSCs have NO telemetry.
    #  All CSCs get one Command and Event entry.
    #
    skipped=$(checkIfSkipped $subSystem "java")
    echo "Salgen $subSystemUp Java" >> $testSuite
    echo "    [Documentation]    Generate Java libraries." >> $testSuite
    echo "    [Tags]    java$skipped" >> $testSuite
    if [[ $subSystemUp == "Test" ]]; then
        echo "    Comment    The Test CSC is not a true Java artifact and is never published as such. Remove the MavenVersion string to accommodate RPM packaging." >> $testSuite
        echo "    Set Suite Variable    \${MavenVersion}    \${EMPTY}" >> $testSuite
    fi
    echo "    \${output}=    Run Process    \${SALHome}/bin/salgeneratorKafka    \${subSystem}    sal    java    version\\=\${MavenVersion}    \
shell=True    cwd=\${SALWorkDir}    stdout=\${EXECDIR}\${/}\${subSystem}_stdout.txt    stderr=\${EXECDIR}\${/}\${subSystem}_stderr.txt" >> $testSuite
    echo "    Log Many    \${output.stdout}    \${output.stderr}" >> $testSuite
    echo "    Should Not Contain    \${output.stdout}    ERROR : Failed to generate*saj_*_types.jar " >> $testSuite
    echo "    Should Not Contain    \${output.stdout}    error: package org.apache.avro* does not exist" >> $testSuite
    echo "    Should Not Contain    \${output.stdout}    error: package org.apache.kafka* does not exist" >> $testSuite
    echo "    Should Contain    \${output.stdout}    SAL generator - \${SALVersion}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    XMLVERSION = \${XMLVersion}" >> $testSuite
    if [ ${#telemetryArray[@]} -eq 0 ]; then
        echo "    Should Contain    \${output.stdout}    WARNING : No Telemetry definitions found for \${subSystem}" >> $testSuite
    else
        for topic in "${telemetryArray[@]}"; do
            echo "    Should Contain    \${output.stdout}    Generating SAL Java code for \${subSystem}_${topic}.json" >> $testSuite
            echo "    Should Contain    \${output.stdout}    done addSALKAFKAtypes \${subSystem}_${topic} java \${subSystem}" >> $testSuite
            echo "    File Should Exist    \${SALWorkDir}/\${subSystem}_${topic}/java/src/org/lsst/sal/salUtils.class" >> $testSuite
        done
        #echo "    Should Contain X Times    \${output.stdout}    javac : Done Publisher    ${#telemetryArray[@]}" >> $testSuite
        #echo "    Should Contain X Times    \${output.stdout}    javac : Done Subscriber    ${#telemetryArray[@]}" >> $testSuite
    fi
    echo "    Directory Should Exist    \${SALWorkDir}/\${subSystem}/java" >> $testSuite
    echo "    @{files}=    List Directory    \${SALWorkDir}/\${subSystem}/java    pattern=*\${subSystem}*" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/java/src/saj_\${subSystem}_types.jar" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/java/src/org/lsst/sal/SAL_\${subSystem}.java" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/java/src/org/lsst/sal/salActor.java" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/java/src/org/lsst/sal/salUtils.java" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/java/src/classes/org/lsst/sal//salUtils.class" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/salUtils/libsalUtils.so" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/lib/org/lsst/sal/salUtils.class " >> $testSuite
    echo "" >> $testSuite
}


function salgenMaven() {
    # Creates the salgenerator Maven test case.
    #
    skipped=$(checkIfSkipped $subSystem "java")
    echo "Salgen $subSystemUp Maven" >> $testSuite
    echo "    [Documentation]    Generate the Maven repository." >> $testSuite
    echo "    [Tags]    java$skipped" >> $testSuite
    echo "    \${output}=    Run Process    \${SALHome}/bin/salgeneratorKafka    \${subSystem}    maven    version\\=\${MavenVersion}    \
shell=True    cwd=\${SALWorkDir}    stdout=\${EXECDIR}\${/}\${subSystem}_stdout.txt    stderr=\${EXECDIR}\${/}\${subSystem}_stderr.txt" >> $testSuite
    echo "    Log Many    \${output.stdout}    \${output.stderr}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    argv = \${subSystem} maven version=\${MavenVersion}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    SAL generator - \${SALVersion}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    XMLVERSION = \${XMLVersion}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    Running maven install" >> $testSuite
    echo "    Should Contain    \${output.stdout}    [INFO] Building sal_\${subSystem} \${XMLVersionBase}_\${SALVersionBase}\${MavenVersion}" >> $testSuite
    echo "    Should Contain X Times    \${output.stdout}    [INFO] BUILD SUCCESS    1" >> $testSuite
    echo "    Should Contain X Times    \${output.stdout}    [INFO] Finished at:    1" >> $testSuite
    echo "    @{files}=    List Directory    \${SALWorkDir}/maven" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/maven/\${subSystem}-\${XMLVersionBase}_\${SALVersionBase}\${MavenVersion}/pom.xml" >> $testSuite
    echo "" >> $testSuite
}


function salgenLib() {
    # Creates the salgenerator Lib test case.
    #  Verifies all the expected SAL/DDS
    #  libraries are created and moved to the
    #  ts_sal/test/lib directory.
    #
    langs=("$@")
    skipped=$(checkIfSkipped $subSystem "lib")
    echo "Salgen $subSystemUp Lib" >> $testSuite
    echo "    [Documentation]    Generate the SAL shared library for \${subSystem}" >> $testSuite
    echo "    [Tags]    lib$skipped" >> $testSuite
    echo "    \${output}=    Run Process    \${SALHome}/bin/salgeneratorKafka    \${subSystem}    lib    \
shell=True    cwd=\${SALWorkDir}    stdout=\${EXECDIR}\${/}\${subSystem}_stdout.txt    stderr=\${EXECDIR}\${/}\${subSystem}_stderr.txt" >> $testSuite
    echo "    Log Many    \${output.stdout}    \${output.stderr}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    SAL generator - \${SALVersion}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    XMLVERSION = \${XMLVersion}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    Building shared library for \${subSystem} subsystem" >> $testSuite
    echo "    Directory Should Exist    \${SALWorkDir}/lib" >> $testSuite
    echo "    @{files}=    List Directory    \${SALWorkDir}/lib    pattern=*\${subSystem}*" >> $testSuite
    echo "    Log Many    @{files}" >> $testSuite
    if [[ ${langs[@]} =~ "CPP" ]]; then
        echo "    File Should Exist    \${SALWorkDir}/lib/libSAL_\${subSystem}.a" >> $testSuite
    fi
    if [[ ${langs[@]} =~ "Java" ]]; then
        echo "    File Should Exist    \${SALWorkDir}/lib/libsalUtils.so" >> $testSuite
        echo "    File Should Exist    \${SALWorkDir}/lib/org/lsst/sal/salUtils.class " >> $testSuite
        echo "    File Should Exist    \${SALWorkDir}/lib/saj_\${subSystem}_types.jar" >> $testSuite
    fi
    echo "" >> $testSuite
}


function salgenRPM() {
    # Creates the salgenerator RPM test case.
    #  Verifies the RPM infrastructure is correct 
    #  and all expected files were created.
    #
    skipped=$(checkIfSkipped $subSystem "rpm")
    echo "Salgen $subSystemUp RPM" >> $testSuite
    echo "    [Documentation]    Generate the SAL runtime RPM for \${subSystem}" >> $testSuite
    echo "    [Tags]    rpm$skipped" >> $testSuite
    echo "    Log Many    \${XMLVersion}    \${SALVersion}    \${Build_Number}    \${DIST}" >> $testSuite
    echo "    \${output}=    Run Process    \${SALHome}/bin/salgeneratorKafka    \${subSystem}    rpm    version\\=\${Build_Number}    \
shell=True    cwd=\${SALWorkDir}    stdout=\${EXECDIR}\${/}\${subSystem}_stdout.txt    stderr=\${EXECDIR}\${/}\${subSystem}_stderr.txt" >> $testSuite
    echo "    Log Many    \${output.stdout}    \${output.stderr}" >> $testSuite
    echo "    @{files}=    List Directory    /tmp/" >> $testSuite
    echo "    Should Be Empty    \${output.stderr}" >> $testSuite
    echo "    File Should Exist    /tmp/makerpm_\${subSystem}.log" >> $testSuite
    echo "    File Should Exist    /tmp/makerpm-utils.log" >> $testSuite
    echo "    Log File    /tmp/makerpm_\${subSystem}.log" >> $testSuite
    echo "    Log File    /tmp/makerpm-utils.log" >> $testSuite
    echo "    Should Not Contain    \${output.stdout}    ERROR : Asset required for rpm" >> $testSuite
    echo "    Should Contain    \${output.stdout}    SAL generator - \${SALVersion}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    XMLVERSION = \${XMLVersion}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    Building runtime RPM for \${subSystem} subsystem" >> $testSuite
    echo "    Directory Should Exist    \${SALWorkDir}/rpmbuild" >> $testSuite
    echo "    Directory Should Exist    \${SALWorkDir}/rpmbuild/BUILD" >> $testSuite
    echo "    Directory Should Exist    \${SALWorkDir}/rpmbuild/BUILDROOT" >> $testSuite
    echo "    Directory Should Exist    \${SALWorkDir}/rpmbuild/RPMS" >> $testSuite
    echo "    Directory Should Exist    \${SALWorkDir}/rpmbuild/SOURCES" >> $testSuite
    echo "    Directory Should Exist    \${SALWorkDir}/rpmbuild/SPECS" >> $testSuite
    echo "    Directory Should Exist    \${SALWorkDir}/rpmbuild/SRPMS" >> $testSuite
    echo "    Directory Should Exist    \${SALWorkDir}/rpmbuild/RPMS/x86_64/" >> $testSuite
    echo "    @{files}=    List Directory    \${SALWorkDir}/rpmbuild/RPMS/x86_64/" >> $testSuite
    echo "    Log Many    @{files}" >> $testSuite
    echo "    IF    \"\${Build_Number}\" == \"\"" >> $testSuite
    echo "        Set Test Variable    \${sep}    \${EMPTY}" >> $testSuite
    echo "    ELSE IF    any(item in '\${Build_Number}' for item in ('pre', 'post', 'rc'))" >> $testSuite
    echo "        Set Test Variable    \${sep}    ~" >> $testSuite
    echo "    ELSE" >> $testSuite
    echo "        Set Test Variable    \${sep}    \${EMPTY}" >> $testSuite
    echo "    END" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/rpmbuild/SPECS/ts_sal_\${subSystem}.spec" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/rpmbuild/SOURCES/\${subSystem}-\${XMLVersionBase}\${sep}\${Build_Number}.tgz" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/rpmbuild/RPMS/x86_64/ts_sal_runtime-\${XMLVersionBase}\${sep}\${Build_Number}-\${SALVersionBase}*\${DIST}.x86_64.rpm" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/rpmbuild/RPMS/x86_64/ts_sal_ATruntime-\${XMLVersionBase}\${sep}\${Build_Number}-\${SALVersionBase}*\${DIST}.x86_64.rpm" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/rpmbuild/RPMS/x86_64/ts_sal_utils-\${SALVersionBase}-1.x86_64.rpm" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/rpmbuild/RPMS/x86_64/\${subSystem}-\${XMLVersionBase}\${sep}\${Build_Number}-\${SALVersionBase}\${DIST}.x86_64.rpm" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/lib/org/lsst/sal/salUtils.class" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/lib/libsalUtils.so" >> $testSuite
    if [[ "$@" =~ "CPP" ]]; then
        echo "    File Should Exist    \${SALWorkDir}/rpmbuild/RPMS/x86_64/\${subSystem}_test-\${XMLVersionBase}\${sep}\${Build_Number}-\${SALVersionBase}\${DIST}.x86_64.rpm" >> $testSuite
    fi
    echo "    Should Not Contain    \${output.stdout}    child process exited abnormally" >> $testSuite
    echo "" >> $testSuite
}


function verifyRPM() {
    # Create the test case to verify the RPM contents.
    #  On occaision, the SAL incorrectly packages an RPM.
    #  This test case is aimed at catching that problem 
    #  before the RPM is released.
    #
    commandsLen="$1"
    eventsLen="$2"
    telemetryLen="$3"
    shift 3
    skipped=$(checkIfSkipped $subSystem "rpm")
    echo "Verify $subSystemUp RPM Contents" >> $testSuite
    echo "    [Documentation]    Verify the \${subSystem} RPM contains all the expected libraries" >> $testSuite
    echo "    [Tags]    rpm$skipped" >> $testSuite
    echo "    Comment    Re-run the {sep} process, so this test case can run independently." >> $testSuite
    echo "    IF    \"\${Build_Number}\" == \"\"" >> $testSuite
    echo "        Set Test Variable    \${sep}    \${EMPTY}" >> $testSuite
    echo "    ELSE IF    any(item in '\${Build_Number}' for item in ('pre', 'post', 'rc'))" >> $testSuite
    echo "        Set Test Variable    \${sep}    ~" >> $testSuite
    echo "    ELSE" >> $testSuite
    echo "        Set Test Variable    \${sep}    \${EMPTY}" >> $testSuite
    echo "    END" >> $testSuite
    echo "    \${output}=    Run Process    rpm    -qpl    \${subSystem}-\${XMLVersionBase}\${sep}\${Build_Number}-\${SALVersionBase}\${DIST}.x86_64.rpm    cwd=\${SALWorkDir}/rpmbuild/RPMS/x86_64" >> $testSuite
    echo "    Log Many    \${output.stdout}    \${output.stderr}" >> $testSuite
    echo "    Should Not Contain    \${output.stderr}    error" >> $testSuite
    echo "    Should Not Contain    \${output.stderr}    No such file or directory" >> $testSuite
    echo "    Should Contain     \${output.stdout}    /opt/lsst/ts_sal/scripts/\${subSystem}_revCodes.tcl" >> $testSuite
    if [[ "$@" =~ "CPP" ]]; then
        echo "    Should Contain     \${output.stdout}    /opt/lsst/ts_sal/lib/libSAL_\${subSystem}.a" >> $testSuite
        echo "    Should Contain     \${output.stdout}    /opt/lsst/ts_sal/include/SAL_\${subSystem}.h" >> $testSuite
        echo "    Should Contain     \${output.stdout}    /opt/lsst/ts_sal/include/\${subSystem}_ackcmd.hh" >> $testSuite
        for topic in "${telemetryArray[@]}"; do
            echo "    Should Contain     \${output.stdout}    /opt/lsst/ts_sal/include/\${subSystem}_${topic}.hh" >> $testSuite
        done
        for topic in "${commandArray[@]}"; do
            echo "    Should Contain     \${output.stdout}    /opt/lsst/ts_sal/include/\${subSystem}_command_${topic}.hh" >> $testSuite
        done
        for topic in "${eventArray[@]}"; do
            echo "    Should Contain     \${output.stdout}    /opt/lsst/ts_sal/include/\${subSystem}_logevent_${topic}.hh" >> $testSuite
        done
    fi
    if [[ "$@" =~ "LabVIEW" ]]; then
        echo "    Should Contain     \${output.stdout}    /opt/lsst/ts_sal/include/SAL_\${subSystem}C.h" >> $testSuite
        echo "    Should Contain     \${output.stdout}    /opt/lsst/ts_sal/include/SAL_\${subSystem}LV.h" >> $testSuite
    fi
    echo "    Comment    Verify the interface definition files are included." >> $testSuite
    echo "    Should Contain     \${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/\${subSystem}/\${subSystem}_Generics.xml" >> $testSuite
    if test -f $HOME/trunk/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Commands.xml; then
        echo "    Should Contain     \${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/\${subSystem}/\${subSystem}_Commands.xml" >> $testSuite
    fi
    if [[ $commandsLen -ne 0 ]]; then
        echo "    Should Contain     \${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/\${subSystem}/\${subSystem}_Commands.html" >> $testSuite
    fi
    if test -f $HOME/trunk/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Events.xml; then
        echo "    Should Contain     \${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/\${subSystem}/\${subSystem}_Events.xml" >> $testSuite
    fi
    if [[ $eventsLen -ne 0 ]]; then
        echo "    Should Contain     \${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/\${subSystem}/\${subSystem}_Events.html" >> $testSuite
    fi
    if test -f $HOME/trunk/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Telemetry.xml; then
        echo "    Should Contain     \${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/\${subSystem}/\${subSystem}_Telemetry.xml" >> $testSuite
    fi
    if [[ $telemetryLen -ne 0 ]]; then
        echo "    Should Contain     \${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/\${subSystem}/\${subSystem}_Telemetry.html" >> $testSuite
    fi
    echo "" >> $testSuite
}


function verifyTestRPM() {
    # Create the test case to verify the Test RPM contents.
    #  The Test RPM is similar to the regular RPM,
    #  but contains the test programs, in addition.
    #
    #  On occaision, the SAL incorrectly packages an RPM.
    #  This test case is aimed at catching that problem 
    #  before the RPM is released.
    #
    commandsLen="$1"
    eventsLen="$2"
    telemetryLen="$3"
    skipped=$(checkIfSkipped $subSystem "rpm")
    echo "Verify $subSystemUp TEST RPM Contents" >> $testSuite
    echo "    [Documentation]    Verify the \${subSystem} TEST RPM contains all the expected libraries" >> $testSuite
    echo "    [Tags]    rpm$skipped" >> $testSuite
    echo "    Comment    Re-run the {sep} process, so this test case can run independently." >> $testSuite
    echo "    IF    \"\${Build_Number}\" == \"\"" >> $testSuite
    echo "        Set Test Variable    \${sep}    \${EMPTY}" >> $testSuite
    echo "    ELSE IF    any(item in '\${Build_Number}' for item in ('pre', 'post', 'rc'))" >> $testSuite
    echo "        Set Test Variable    \${sep}    ~" >> $testSuite
    echo "    ELSE" >> $testSuite
    echo "        Set Test Variable    \${sep}    \${EMPTY}" >> $testSuite
    echo "    END" >> $testSuite
    echo "    \${output}=    Run Process    rpm    -qpl    \${subSystem}_test-\${XMLVersionBase}\${sep}\${Build_Number}-\${SALVersionBase}\${DIST}.x86_64.rpm    \
shell=True    cwd=\${SALWorkDir}/rpmbuild/RPMS/x86_64    stdout=\${EXECDIR}\${/}\${subSystem}_stdout.txt    stderr=\${EXECDIR}\${/}\${subSystem}_stderr.txt" >> $testSuite
    echo "    Log Many    \${output.stdout}    \${output.stderr}" >> $testSuite
    echo "    Should Not Contain    \${output.stderr}    error" >> $testSuite
    echo "    Should Not Contain    \${output.stderr}    No such file or directory" >> $testSuite
    echo "    Should Contain     \${output.stdout}    /opt/lsst/ts_sal/lib/libSAL_\${subSystem}.a" >> $testSuite
    echo "    Comment    Verify the TEST RPM contains the test programs." >> $testSuite
    if [[ $commandsLen -ne 0 ]]; then
        echo "    Should Contain    \${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_\${subSystem}_all_commander" >> $testSuite
        echo "    Should Contain    \${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_\${subSystem}_all_controller" >> $testSuite
    fi
    if [[ $eventsLen -ne 0 ]]; then
        echo "    Should Contain    \${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_\${subSystem}_all_sender" >> $testSuite
        echo "    Should Contain    \${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_\${subSystem}_all_logger" >> $testSuite
    fi
    if [[ $telemetryLen -ne 0 ]]; then
        echo "    Should Contain    \${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_\${subSystem}_all_publisher" >> $testSuite
        echo "    Should Contain    \${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_\${subSystem}_all_subscriber" >> $testSuite
    fi
    for topic in "${commandArray[@]}"; do
        echo "    Should Contain    \${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_\${subSystem}_${topic}_commander" >> $testSuite
        echo "    Should Contain    \${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_\${subSystem}_${topic}_controller" >> $testSuite
    done
    for topic in "${eventArray[@]}"; do
        echo "    Should Contain    \${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_\${subSystem}_${topic}_send" >> $testSuite
        echo "    Should Contain    \${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_\${subSystem}_${topic}_log" >> $testSuite
    done
    for topic in "${telemetryArray[@]}"; do
        echo "    Should Contain    \${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_\${subSystem}_${topic}_publisher" >> $testSuite
        echo "    Should Contain    \${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_\${subSystem}_${topic}_subscriber" >> $testSuite
    done
    echo "" >> $testSuite
}


function createTestSuite() {
    # This function creates the entire salgenerator
    # test suite for the given CSC. It coordinates
    # all the individual functions, controls the structure
    # of the test suite, and manages much of the logic
    # that determines what gets tested and what is
    # skipped because it is not relevant.
    #
    subSystem=$1

    #  Define test suite name. Get the CSC into the 
    #  desired capitalization format.
    #
    subSystemUp=$(capitializeSubsystem $subSystem)
    testSuite=$workDir/SALGEN/${subSystemUp}_salgeneratorKafka.robot
        
    # Check to see if the TestSuite exists then, if it does, delete it.
    clearTestSuites $subSystem "SALGEN" 
        
    # Get XML topic definitions.  Not all subsystems have all types of topics.
    declare -a xmls=($(ls $HOME/trunk/ts_xml/python/lsst/ts/xml/data/sal_interfaces/$subSystem))
    # Declare topic arrays.
    declare -a telemetryArray=($(getTelemetryTopics $subSystem))
    #echo ${telemetryArray[@]}
    declare -a commandArray=($(getCommandTopics $subSystem))
    #echo ${commandArray[@]}
    declare -a eventArray=($(getEventTopics $subSystem))
    #echo ${eventArray[@]}

    #  Check if test suite should be skipped.
    skipped=$(checkIfSkipped $subSystem $topic)

    # Get list of languages to build. Each CSC lists
    # which language-specific libraries it is 
    # required to build. This is defined in the 
    # ts_xml/python/lsst/ts/xml/data/sal_interfaces/SALSubsystems.xml file.
    #
    # Requiring the LabVIEW libraries inherently 
    # requires the C++ library. The 'if' statement 
    # ensures the C++ process is run in the case 
    # LabVIEW is defined but CPP is not explicitly
    # defined.
    #
    temp=$(getRuntimeLanguages $subSystem)
    IFS=', ' read -r -a rtlang <<< "${temp[0]}"
    if ! [[ ${rtlang[@]} =~ "CPP" ]]; then
        if [[ ${rtlang[@]} =~ "LabVIEW" ]]; then
            rtlang+=('CPP')
        fi
    fi
    echo "Runtime languages to build: ${rtlang[@]}"

    # Create test suite.
    # Execution ORDER of these functions is CRITICAL.
    #
    echo Creating $testSuite
    createSettings $subSystem
    createVariables $subSystem
    echo "*** Test Cases ***" >> $testSuite
    verifyXMLDefinitions
    salgenValidate
    # Create and verfiy the RevCoded IDL files.
    # Create and verify C++ interfaces.
    if [[ ${rtlang[@]} =~ "CPP" || ${rtlang[@]} =~ "LabVIEW" ]]; then
        salgenCPP
        verifyCppDirectories
        if [[ ${#telemetryArray[@]} -ne 0 ]]; then
            verifyTelemetryDirectories
            verifyCppTelemetryInterfaces
        fi
        if [[ ${#commandArray[@]} -ne 0 ]]; then
            verifyCppCommandInterfaces
        fi
        if [[ ${#eventArray[@]} -ne 0 ]]; then
            verifyCppEventInterfaces
        fi
    fi
    # Create and verify Java interfaces.
    if [[ ${rtlang[@]} =~ "Java" ]]; then
        salgenJava
        salgenMaven
    fi
    # Move/Generate the SAL libraries.
    salgenLib "${rtlang[@]}"
    # Generate the CSC documentation
    #salgenDOC
    # Generate the as-built SAL libraries RPM.
    if [[ ${rtlang[@]} =~ "CPP" ]]; then
        salgenRPM "${rtlang[@]}"
        verifyRPM ${#commandArray[@]} ${#eventArray[@]} ${#telemetryArray[@]} "${rtlang[@]}"
        verifyTestRPM ${#commandArray[@]} ${#eventArray[@]} ${#telemetryArray[@]} 
    fi
    # Indicate completion of the test suite.
    cleanupOutputs
    echo Done with test suite.
    echo ""
}


###  MAIN ###
# This acts as the light-weight main function.
#  It determines with "path" the script should
#  follow, whether for a single CSC or All of them.
#
subSystem=$arg
#echo $subSystem
if [ "$arg" == "all" ]; then
    for subSystem in "${subSystemArray[@]}"; do
        createTestSuite $subSystem
    done
    echo COMPLETED ALL test suites for ALL subsystems.
elif [[ ${subSystemArray[*]} =~ $subSystem ]]; then
    createTestSuite $subSystem
    echo COMPLETED all test suites for the $subSystem.
else
    echo USAGE - Argument must be one of: [${subSystemArray[*]}] OR [all]. All is the default.
fi

