#!/bin/bash
#  Shellscript to create test suites to
#  create the various interfaces.
#
#  author: Rob Bovill
#  email:  rbovill@lsst.org

# Source common functions
workDir=$HOME/trunk/robotframework_salgenerator
source $workDir/scripts/_common.sh

#  Define variables to be used in script
arg=${1-all}
declare -a subSystemArray=($(subsystemArray))

#  FUNCTIONS
function createSettings() {
    echo "*** Settings ***" >> $testSuite
    echo "Documentation    This suite builds the various interfaces for the $subSystemUp." >> $testSuite
    echo "Force Tags    salgen    $skipped" >> $testSuite
    echo "Suite Setup    Log Many    \${Host}    \${subSystem}    \${timeout}" >> $testSuite
    echo "Library    OperatingSystem" >> $testSuite
    echo "Library    Process" >> $testSuite
    echo "Resource    ../Global_Vars.resource" >> $testSuite
    echo "" >> $testSuite
}

function createVariables() {
    entity=$(getEntity $1)
    echo "*** Variables ***" >> $testSuite
    echo "\${subSystem}    $entity" >> $testSuite
    echo "\${timeout}    1200s" >> $testSuite
    echo "" >> $testSuite
}

function cleanupOutputs() {
    echo "Cleanup stdout and stderr Files" >> $testSuite
    echo "    [Tags]" >> $testSuite
    echo "    Remove Files    \${EXECDIR}\${/}\${subSystem}_stdout.txt    \${EXECDIR}\${/}\${subSystem}_stderr.txt" >> $testSuite
    echo "" >> $testSuite
}

function verifyXMLDefinitions() {
    echo "Verify $subSystemUp XML Defintions exist" >> $testSuite
    echo "    [Tags]" >> $testSuite
    echo "    Comment    Verify the CSC XML definition files exist." >> $testSuite
    echo "    \${output}    Run Process    ls     \${SALWorkDir}/${subSystemUp}_*.xml    shell=True" >> $testSuite
    echo "    Log Many    \${output.stdout}    \${output.stderr}" >> $testSuite
    echo "    Should Not Contain    \${output.stderr}    No such file or directory    msg=\"${subSystemUp} has no XML defintions\"    values=False" >> $testSuite
    echo "    Should Not Be Empty    \${output.stdout}" >> $testSuite
    for file in "${xmls[@]}"; do
        echo "    File Should Exist    \${SALWorkDir}/$file" >> $testSuite
    done
    echo "" >> $testSuite
}

function salgenValidate() {
    skipped=$(checkIfSkipped "validate")
    echo "Salgen $subSystemUp Validate" >> $testSuite
    echo "    [Documentation]    Validate the $subSystemUp XML definitions." >> $testSuite
    echo "    [Tags]    validate$skipped" >> $testSuite
    echo "    \${output}=    Run Process    \${SALHome}/bin/salgenerator    \${subSystem}    validate    \
shell=True    cwd=\${SALWorkDir}    stdout=\${EXECDIR}\${/}\${subSystem}_stdout.txt    stderr=\${EXECDIR}\${/}\${subSystem}_stderr.txt" >> $testSuite
    echo "    Log Many    \${output.stdout}    \${output.stderr}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    SAL generator - \${SALVersion}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    XMLVERSION = \${XMLVersion}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    Processing \${subSystem}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    Completed \${subSystem} validation" >> $testSuite
    echo "    Directory Should Exist    \${SALWorkDir}/idl-templates" >> $testSuite
    echo "    Directory Should Exist    \${SALWorkDir}/idl-templates/validated" >> $testSuite
    echo "    @{files}=    List Directory    \${SALWorkDir}/idl-templates    pattern=*\${subSystem}*" >> $testSuite
    echo "    Log Many    @{files}" >> $testSuite
    if [ ${#commandArray[@]} != 0 ]; then
        echo "    File Should Exist    \${SALWorkDir}/idl-templates/\${subSystem}_ackcmd.idl" >> $testSuite
    fi
    for topic in "${telemetryArray[@]}"; do
        echo "    File Should Exist    \${SALWorkDir}/idl-templates/\${subSystem}_${topic}.idl" >> $testSuite
    done
    for topic in "${commandArray[@]}"; do
        echo "    File Should Exist    \${SALWorkDir}/idl-templates/\${subSystem}_command_${topic}.idl" >> $testSuite
    done
    for topic in "${eventArray[@]}"; do
        echo "    File Should Exist    \${SALWorkDir}/idl-templates/\${subSystem}_logevent_${topic}.idl" >> $testSuite
    done
    echo "" >> $testSuite
}

function salgenDOC() {
    skipped=$(checkIfSkipped "doc")
    echo "Salgen $subSystemUp Doc" >> $testSuite
    echo "    [Documentation]    Create the CSC documentation." >> $testSuite
    echo "    [Tags]    doc    $skipped" >> $testSuite
    echo "    \${output}=    Run Process    \${SALHome}/bin/salgenerator    \${subSystem}    apidoc    \
shell=True    cwd=\${SALWorkDir}    stdout=\${EXECDIR}\${/}\${subSystem}_stdout.txt    stderr=\${EXECDIR}\${/}\${subSystem}_stderr.txt" >> $testSuite
    echo "    Log Many    \${output.stdout}    \${output.stderr}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    SAL generator - \${SALVersion}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    XMLVERSION = \${XMLVersion}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    checking \${subSystem}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    checking apidoc" >> $testSuite
    echo "    Should Contain    \${output.stdout}    Building API documentation for \${subSystem} subsystem" >> $testSuite
    echo "    @{files}=    List Directory    \${SALHome}/doc/_build/html/apiDocumentation/SAL_\${subSystem}" >> $testSuite
    echo "    Log Many    @{files}" >> $testSuite
    echo "    File Should Exist    \${SALHome}/doc/_build/html/apiDocumentation/SAL_Test/index.html" >> $testSuite
    echo "    File Should Exist    \${SALHome}/doc/_build/html/apiDocumentation/SAL_Test/SALPY_Test.html" >> $testSuite
    echo "" >> $testSuite
}

function revCodeDefinition() {
    skipped=$(checkIfSkipped "doc")
    echo "Verify $subSystemUp revCodes File" >> $testSuite
    echo "    [Documentation]    Ensure ${subSystemUp}_revCodes.tcl contains 1 revcode per topic." >> $testSuite
    echo "    [Tags]    doc    $skipped" >> $testSuite
    echo "    \${output}=    Log File    \${SALWorkDir}/idl-templates/validated/\${subSystem}_revCodes.tcl" >> $testSuite
    for topic in "${commandArray[@]}"; do
        echo "    Should Match Regexp    \${output}    set REVCODE\\\(\${subSystem}_command_$topic\\\) [a-z0-9]{8,}" >> $testSuite
    done
    for topic in "${eventArray[@]}"; do
        echo "    Should Match Regexp    \${output}    set REVCODE\\\(\${subSystem}_logevent_$topic\\\) [a-z0-9]{8,}" >> $testSuite
    done
    for topic in "${telemetryArray[@]}"; do
        echo "    Should Match Regexp    \${output}    set REVCODE\\\(\${subSystem}_$topic\\\) [a-z0-9]{8,}" >> $testSuite
    done
    echo "" >> $testSuite
}

function salgenCPP {
    echo "Salgen $subSystemUp C++" >> $testSuite
    echo "    [Documentation]    Generate C++ libraries." >> $testSuite
    echo "    [Tags]    cpp" >> $testSuite
    echo "    \${output}=    Run Process    \${SALHome}/bin/salgenerator    \${subSystem}    sal    cpp   \
shell=True    cwd=\${SALWorkDir}    stdout=\${EXECDIR}\${/}\${subSystem}_stdout.txt    stderr=\${EXECDIR}\${/}\${subSystem}_stderr.txt" >> $testSuite
    echo "    Log Many    \${output.stdout}    \${output.stderr}" >> $testSuite
    echo "    Should Not Contain    \${output.stdout}    ERROR : Failed to generate CPP DDS types" >> $testSuite
    echo "    Should Not Contain    \${output.stdout}    *** DDS error in file" >> $testSuite
    echo "    Should Not Contain    \${output.stdout}    Error 1" >> $testSuite
    echo "    Should Contain    \${output.stdout}    SAL generator - \${SALVersion}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    XMLVERSION = \${XMLVersion}" >> $testSuite
    for topic in "${telemetryArray[@]}"; do
        echo "    Should Contain    \${output.stdout}    Generating SAL CPP code for \${subSystem}_${topic}.idl" >> $testSuite
    done
    if [ ${#telemetryArray[@]} -eq 0 ]; then
        echo "    Should Contain    \${output.stdout}    WARNING : No Telemetry definitions found for \${subSystem}" >> $testSuite
    else
        echo "    Should Contain X Times    \${output.stdout}    cpp : Done Publisher    ${#telemetryArray[@]}" >> $testSuite
        echo "    Should Contain X Times    \${output.stdout}    cpp : Done Subscriber    ${#telemetryArray[@]}" >> $testSuite
    fi
    echo "    Should Contain X Times    \${output.stdout}    cpp : Done Commander    1" >> $testSuite
    echo "    Should Contain X Times    \${output.stdout}    cpp : Done Event/Logger    1" >> $testSuite
    echo "" >> $testSuite
}

function verifyCppDirectories() {
    echo "Verify C++ Directories" >> $testSuite
    echo "    [Documentation]    Ensure expected C++ directories and files are created." >> $testSuite
    echo "    [Tags]    cpp" >> $testSuite
    echo "    Directory Should Exist    \${SALWorkDir}/\${subSystem}/cpp" >> $testSuite
    echo "    @{files}=    List Directory    \${SALWorkDir}/\${subSystem}/cpp    pattern=*\${subSystem}*" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/cpp/libsacpp_\${subSystem}_types.so" >> $testSuite
    echo "    Directory Should Exist    \${SALWorkDir}/idl-templates/validated/sal" >> $testSuite
    echo "    @{files}=    List Directory    \${SALWorkDir}/idl-templates/validated/sal    pattern=*\${subSystem}*" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/idl-templates/validated/sal/sal_\${subSystem}.idl" >> $testSuite
    echo "" >> $testSuite
}

function verifyTelemetryDirectories() {
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
    echo "Verify $subSystemUp C++ Telemetry Interfaces" >> $testSuite
    echo "    [Documentation]    Verify the C++ interfaces were properly created." >> $testSuite
    echo "    [Tags]    cpp" >> $testSuite
    for topic in "${telemetryArray[@]}"; do
        echo "    File Should Exist    \${SALWorkDir}/\${subSystem}_${topic}/cpp/standalone/sacpp_\${subSystem}_pub" >> $testSuite
        echo "    File Should Exist    \${SALWorkDir}/\${subSystem}_${topic}/cpp/standalone/sacpp_\${subSystem}_sub" >> $testSuite
    done
    echo "" >> $testSuite
}

function verifyCppCommandInterfaces() {
    echo "Verify $subSystemUp C++ Command Interfaces" >> $testSuite
    echo "    [Documentation]    Verify the C++ interfaces were properly created." >> $testSuite
    echo "    [Tags]    cpp" >> $testSuite
    for topic in "${commandArray[@]}"; do
        echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/cpp/src/sacpp_\${subSystem}_${topic}_commander" >> $testSuite
        echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/cpp/src/sacpp_\${subSystem}_${topic}_controller" >> $testSuite
    done
    echo "" >> $testSuite
}

function verifyCppEventInterfaces() {
    echo "Verify $subSystemUp C++ Event Interfaces" >> $testSuite
    echo "    [Documentation]    Verify the C++ interfaces were properly created." >> $testSuite
    echo "    [Tags]    cpp" >> $testSuite
    for topic in "${eventArray[@]}"; do
        echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/cpp/src/sacpp_\${subSystem}_${topic}_send" >> $testSuite
        echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/cpp/src/sacpp_\${subSystem}_${topic}_log" >> $testSuite
    done
    echo "" >> $testSuite
}

function salgenJava() {
    skipped=$(checkIfSkipped $subSystem "java")
    echo "Salgen $subSystemUp Java" >> $testSuite
    echo "    [Documentation]    Generate Java libraries." >> $testSuite
    echo "    [Tags]    java$skipped" >> $testSuite
    echo "    \${output}=    Run Process    \${SALHome}/bin/salgenerator    \${subSystem}    sal    java    \
shell=True    cwd=\${SALWorkDir}    stdout=\${EXECDIR}\${/}\${subSystem}_stdout.txt    stderr=\${EXECDIR}\${/}\${subSystem}_stderr.txt" >> $testSuite
    echo "    Log Many    \${output.stdout}    \${output.stderr}" >> $testSuite
    echo "    Should Not Contain    \${output.stdout}    ERROR : Failed to generate Java DDS types" >> $testSuite
    echo "    Should Contain    \${output.stdout}    SAL generator - \${SALVersion}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    XMLVERSION = \${XMLVersion}" >> $testSuite
    for topic in "${telemetryArray[@]}"; do
        echo "    Should Contain    \${output.stdout}    Generating SAL Java code for \${subSystem}_${topic}.idl" >> $testSuite
    done
    if [ ${#telemetryArray[@]} -eq 0 ]; then
        echo "    Should Contain    \${output.stdout}    WARNING : No Telemetry definitions found for \${subSystem}" >> $testSuite
    else
        echo "    Should Contain X Times    \${output.stdout}    javac : Done Publisher    ${#telemetryArray[@]}" >> $testSuite
        echo "    Should Contain X Times    \${output.stdout}    javac : Done Subscriber    ${#telemetryArray[@]}" >> $testSuite
    fi
    echo "    Directory Should Exist    \${SALWorkDir}/\${subSystem}/java" >> $testSuite
    echo "    @{files}=    List Directory    \${SALWorkDir}/\${subSystem}/java    pattern=*\${subSystem}*" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/java/sal_\${subSystem}.idl" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/java/saj_\${subSystem}_types.jar" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/java/sal_\${subSystem}.idl" >> $testSuite
    echo "" >> $testSuite
}

function salgenMaven() {
    skipped=$(checkIfSkipped $subSystem "java")
    echo "Salgen $subSystemUp Maven" >> $testSuite
    echo "    [Documentation]    Generate the Maven repository." >> $testSuite
    echo "    [Tags]    java$skipped" >> $testSuite
    echo "    \${output}=    Run Process    \${SALHome}/bin/salgenerator    \${subSystem}    maven    version\\=\${Build_Number}\${MavenVersion}    \
shell=True    cwd=\${SALWorkDir}    stdout=\${EXECDIR}\${/}\${subSystem}_stdout.txt    stderr=\${EXECDIR}\${/}\${subSystem}_stderr.txt" >> $testSuite
    echo "    Log Many    \${output.stdout}    \${output.stderr}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    argv = \${subSystem} maven version=\${Build_Number}\${MavenVersion}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    SAL generator - \${SALVersion}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    XMLVERSION = \${XMLVersion}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    Running maven install" >> $testSuite
    echo "    Should Contain    \${output.stdout}    [INFO] Building sal_\${subSystem} \${XMLVersion}_\${SALVersion}\${Build_Number}\${MavenVersion}" >> $testSuite
    echo "    Should Contain X Times    \${output.stdout}    [INFO] BUILD SUCCESS    1" >> $testSuite
    echo "    Should Contain X Times    \${output.stdout}    [INFO] Finished at:    1" >> $testSuite
    echo "    @{files}=    List Directory    \${SALWorkDir}/maven" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/maven/\${subSystem}-\${XMLVersion}_\${SALVersion}\${Build_Number}\${MavenVersion}/pom.xml" >> $testSuite
    echo "" >> $testSuite
}

function salgenPython() {
    skipped=$(checkIfSkipped $subSystem "python")
    echo "Salgen $subSystemUp Python" >> $testSuite
    echo "    [Documentation]    Generate Python libraries." >> $testSuite
    echo "    [Tags]    python$skipped" >> $testSuite
    echo "    \${output}=    Run Process    \${SALHome}/bin/salgenerator    \${subSystem}    sal    python    \
shell=True    cwd=\${SALWorkDir}    stdout=\${EXECDIR}\${/}\${subSystem}_stdout.txt    stderr=\${EXECDIR}\${/}\${subSystem}_stderr.txt" >> $testSuite
    echo "    Log Many    \${output.stdout}    \${output.stderr}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    SAL generator - \${SALVersion}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    XMLVERSION = \${XMLVersion}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    Generating Python SAL support for \${subSystem}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    Generating Python bindings" >> $testSuite
    echo "    Should Contain    \${output.stdout}    python : Done SALPY_\${subSystem}.so" >> $testSuite
    echo "    Directory Should Exist    \${SALWorkDir}/\${subSystem}/python" >> $testSuite
    echo "    @{files}=    List Directory    \${SALWorkDir}/\${subSystem}/python    pattern=*\${subSystem}*" >> $testSuite
    echo "    Log Many    @{files}" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/cpp/src/SALPY_\${subSystem}.so" >> $testSuite
    echo "" >> $testSuite
}

function verifyPythonTelemetryInterfaces() {
    echo "Verify $subSystemUp Python Telemetry Interfaces" >> $testSuite
    echo "    [Documentation]    Verify the Python interfaces were properly created." >> $testSuite
    echo "    [Tags]    python" >> $testSuite
    echo "    @{files}=    List Directory    \${SALWorkDir}/\${subSystem}/python    pattern=*\${subSystem}*" >> $testSuite
    echo "    Log Many    @{files}" >> $testSuite
    for topic in "${telemetryArray[@]}"; do
        echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/python/\${subSystem}_${topic}_Publisher.py" >> $testSuite
        echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/python/\${subSystem}_${topic}_Subscriber.py" >> $testSuite
    done
    echo "" >> $testSuite
}

function verifyPythonCommandInterfaces() {
    echo "Verify $subSystemUp Python Command Interfaces" >> $testSuite
    echo "    [Documentation]    Verify the Python interfaces were properly created." >> $testSuite
    echo "    [Tags]    python" >> $testSuite
    echo "    @{files}=    List Directory    \${SALWorkDir}/\${subSystem}/python    pattern=*\${subSystem}*" >> $testSuite
    echo "    Log Many    @{files}" >> $testSuite
    for topic in "${commandArray[@]}"; do
        echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/python/\${subSystem}_Commander_${topic}.py" >> $testSuite
        echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/python/\${subSystem}_Controller_${topic}.py" >> $testSuite
    done
    echo "" >> $testSuite
}

function verifyPythonEventInterfaces() {
    echo "Verify $subSystemUp Python Event Interfaces" >> $testSuite
    echo "    [Documentation]    Verify the Python interfaces were properly created." >> $testSuite
    echo "    [Tags]    python" >> $testSuite
    echo "    @{files}=    List Directory    \${SALWorkDir}/\${subSystem}/python    pattern=*\${subSystem}*" >> $testSuite
    echo "    Log Many    @{files}" >> $testSuite
    for topic in "${eventArray[@]}"; do
        echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/python/\${subSystem}_Event_${topic}.py" >> $testSuite
        echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/python/\${subSystem}_EventLogger_${topic}.py" >> $testSuite
    done
    echo "" >> $testSuite
}

function salgenLabview() {
    skipped=$(checkIfSkipped $subSystem "labview")
    echo "Salgen $subSystemUp LabVIEW" >> $testSuite
    echo "    [Documentation]    Generate \${subSystem} low-level LabView interfaces." >> $testSuite
    echo "    [Tags]    labview$skipped" >> $testSuite
    echo "    \${output}=    Run Process    \${SALHome}/bin/salgenerator    \${subSystem}    labview    \
shell=True    cwd=\${SALWorkDir}    stdout=\${EXECDIR}\${/}\${subSystem}_stdout.txt    stderr=\${EXECDIR}\${/}\${subSystem}_stderr.txt" >> $testSuite
    echo "    Log Many    \${output.stdout}    \${output.stderr}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    SAL generator - \${SALVersion}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    XMLVERSION = \${XMLVersion}" >> $testSuite
    echo "    Directory Should Exist    \${SALWorkDir}/\${subSystem}/labview" >> $testSuite
    echo "    @{files}=    List Directory    \${SALWorkDir}/\${subSystem}/labview" >> $testSuite
    echo "    Log Many    @{files}" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/labview/SAL_\${subSystem}_salShmMonitor.cpp" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/labview/SAL_\${subSystem}_shmem.h" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/labview/SALLV_\${subSystem}.so" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/labview/SALLV_\${subSystem}_Monitor" >> $testSuite
    echo "" >> $testSuite
}

function salgenLib() {
    langs=("$@")
    skipped=$(checkIfSkipped $subSystem "lib")
    echo "Salgen $subSystemUp Lib" >> $testSuite
    echo "    [Documentation]    Generate the SAL shared library for \${subSystem}" >> $testSuite
    echo "    [Tags]    lib$skipped" >> $testSuite
    echo "    \${output}=    Run Process    \${SALHome}/bin/salgenerator    \${subSystem}    lib    \
shell=True    cwd=\${SALWorkDir}    stdout=\${EXECDIR}\${/}\${subSystem}_stdout.txt    stderr=\${EXECDIR}\${/}\${subSystem}_stderr.txt" >> $testSuite
    echo "    Log Many    \${output.stdout}    \${output.stderr}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    SAL generator - \${SALVersion}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    XMLVERSION = \${XMLVersion}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    Building shared library for \${subSystem} subsystem" >> $testSuite
    echo "    Directory Should Exist    \${SALWorkDir}/lib" >> $testSuite
    echo "    @{files}=    List Directory    \${SALWorkDir}/lib    pattern=*\${subSystem}*" >> $testSuite
    echo "    Log Many    @{files}" >> $testSuite
    if [[ ${langs[@]} =~ "CPP" ]]; then
        echo "    File Should Exist    \${SALWorkDir}/lib/libSAL_\${subSystem}.so" >> $testSuite
        echo "    File Should Exist    \${SALWorkDir}/lib/libsacpp_\${subSystem}_types.so" >> $testSuite
    fi
    if [[ ${langs[@]} =~ "SALPY" ]]; then
        echo "    File Should Exist    \${SALWorkDir}/lib/SALPY_\${subSystem}.so" >> $testSuite
    fi
    if [[ ${langs[@]} =~ "LabVIEW" ]]; then
        echo "    File Should Exist    \${SALWorkDir}/lib/SALLV_\${subSystem}.so" >> $testSuite
    fi
    if [[ ${langs[@]} =~ "Java" ]]; then
        echo "    File Should Exist    \${SALWorkDir}/lib/saj_\${subSystem}_types.jar" >> $testSuite
    fi
    echo "" >> $testSuite
}

function salgenRPM() {
    skipped=$(checkIfSkipped $subSystem "rpm")
    echo "Salgen $subSystemUp RPM" >> $testSuite
    echo "    [Documentation]    Generate the SAL runtime RPM for \${subSystem}" >> $testSuite
    echo "    [Tags]    rpm$skipped" >> $testSuite
    echo "    Log Many    \${XMLVersion}    \${SALVersion}    \${Build_Number}    \${DIST}" >> $testSuite
    echo "    \${output}=    Run Process    \${SALHome}/bin/salgenerator    \${subSystem}    rpm    version\\=\${Build_Number}    \
shell=True    cwd=\${SALWorkDir}    stdout=\${EXECDIR}\${/}\${subSystem}_stdout.txt    stderr=\${EXECDIR}\${/}\${subSystem}_stderr.txt" >> $testSuite
    echo "    Log Many    \${output.stdout}    \${output.stderr}" >> $testSuite
    echo "    @{files}=    List Directory    /tmp/" >> $testSuite
    echo "    Should Be Empty    \${output.stderr}" >> $testSuite
    echo "    File Should Exist    /tmp/makerpm_\${subSystem}.log" >> $testSuite
    echo "    File Should Exist    /tmp/makerpm_\${subSystem}_test.log" >> $testSuite
    echo "    File Should Exist    /tmp/makerpm-utils.log" >> $testSuite
    echo "    Log File    /tmp/makerpm_\${subSystem}.log" >> $testSuite
    echo "    Log File    /tmp/makerpm_\${subSystem}_test.log" >> $testSuite
    echo "    Log File    /tmp/makerpm-utils.log" >> $testSuite
    echo "    Should Not Contain    \${output.stdout}    ERROR : Asset required for rpm" >> $testSuite
    echo "    Should Not Contain    \${output.stdout}    child process exited abnormally" >> $testSuite
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
    echo "    Run Keyword If    \"\${Build_Number}\" == \"\"" >> $testSuite
    echo "    ...    Set Test Variable    \${dot}    \${EMPTY}" >> $testSuite
    echo "    Run Keyword Unless    \"\${Build_Number}\" == \"\"" >> $testSuite
    echo "    ...    Set Test Variable    \${dot}    ." >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/rpmbuild/SPECS/ts_sal_\${subSystem}.spec" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/rpmbuild/SOURCES/\${subSystem}-\${XMLVersion}.tgz" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/rpmbuild/RPMS/x86_64/ts_sal_runtime-\${XMLVersion}-\${SALVersion}\${dot}\${Build_Number}\${DIST}.x86_64.rpm" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/rpmbuild/RPMS/x86_64/ts_sal_ATruntime-\${XMLVersion}-\${SALVersion}\${dot}\${Build_Number}\${DIST}.x86_64.rpm" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/rpmbuild/RPMS/x86_64/ts_sal_utils-\${SALVersion}-1.x86_64.rpm" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/rpmbuild/RPMS/x86_64/\${subSystem}-\${XMLVersion}-\${SALVersion}\${dot}\${Build_Number}\${DIST}.x86_64.rpm" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/rpmbuild/RPMS/x86_64/\${subSystem}_test-\${XMLVersion}-\${SALVersion}\${dot}\${Build_Number}\${DIST}.x86_64.rpm" >> $testSuite
    echo "" >> $testSuite
}

function verifyRPM() {
    commandsArray="$1"
    eventsArray="$2"
    telemetryArray="$3"
    shift 3
    skipped=$(checkIfSkipped $subSystem "rpm")
    echo "Verify $subSystemUp RPM Contents" >> $testSuite
    echo "    [Documentation]    Verify the \${subSystem} contains all the expected libraries" >> $testSuite
    echo "    [Tags]    rpm$skipped" >> $testSuite
    echo "    Comment    Re-run the {dot} process, so this test case can run independently." >> $testSuite
    echo "    Run Keyword If    \"\${Build_Number}\" == \"\"" >> $testSuite
    echo "    ...    Set Test Variable    \${dot}    \${EMPTY}" >> $testSuite
    echo "    Run Keyword Unless    \"\${Build_Number}\" == \"\"" >> $testSuite
    echo "    ...    Set Test Variable    \${dot}    ." >> $testSuite
    echo "    \${output}=    Run Process    rpm    -qpl    \${subSystem}-\${XMLVersion}-\${SALVersion}\${dot}\${Build_Number}\${DIST}.x86_64.rpm    cwd=\${SALWorkDir}/rpmbuild/RPMS/x86_64" >> $testSuite
    echo "    Log Many    \${output.stdout}    \${output.stderr}" >> $testSuite
    echo "    Should Not Contain    \${output.stderr}    error" >> $testSuite
    echo "    Should Not Contain    \${output.stderr}    No such file or directory" >> $testSuite
    echo "    Should Contain     \${output.stdout}    /opt/lsst/ts_sal/idl/sal_revCoded_\${subSystem}.idl" >> $testSuite
    echo "    Should Contain     \${output.stdout}    /opt/lsst/ts_sal/scripts/\${subSystem}_revCodes.tcl" >> $testSuite
    if [[ "$@" =~ "CPP" ]]; then
        echo "    Should Contain     \${output.stdout}    /opt/lsst/ts_sal/lib/libSAL_\${subSystem}.so" >> $testSuite
        echo "    Should Contain     \${output.stdout}    /opt/lsst/ts_sal/lib/libSAL_\${subSystem}.a" >> $testSuite
        echo "    Should Contain     \${output.stdout}    /opt/lsst/ts_sal/include/SAL_\${subSystem}.h" >> $testSuite
        echo "    Should Contain     \${output.stdout}    /opt/lsst/ts_sal/include/SAL_\${subSystem}.h" >> $testSuite
        echo "    Should Contain     \${output.stdout}    /opt/lsst/ts_sal/include/SAL_defines.h" >> $testSuite
        echo "    Should Contain     \${output.stdout}    /opt/lsst/ts_sal/include/ccpp_sal_\${subSystem}.h" >> $testSuite
        echo "    Should Contain     \${output.stdout}    /opt/lsst/ts_sal/include/sal_\${subSystem}Dcps.h" >> $testSuite
        echo "    Should Contain     \${output.stdout}    /opt/lsst/ts_sal/include/sal_\${subSystem}Dcps_impl.h" >> $testSuite
        echo "    Should Contain     \${output.stdout}    /opt/lsst/ts_sal/include/sal_\${subSystem}SplDcps.h" >> $testSuite
    fi
    if [[ "$@" =~ "SALPY" ]]; then
        echo "    Should Contain     \${output.stdout}    /opt/lsst/ts_sal/lib/SALPY_\${subSystem}.so" >> $testSuite
    fi
    if [[ "$@" =~ "LabVIEW" ]]; then
        echo "    Should Contain     \${output.stdout}    /opt/lsst/ts_sal/bin/SALLV_\${subSystem}_Monitor" >> $testSuite
        echo "    Should Contain     \${output.stdout}    /opt/lsst/ts_sal/labview/lib/SALLV_\${subSystem}.so" >> $testSuite
        echo "    Should Contain     \${output.stdout}    /opt/lsst/ts_sal/labview/sal_\${subSystem}.idl" >> $testSuite
        echo "    Should Contain     \${output.stdout}    /opt/lsst/ts_sal/include/SAL_\${subSystem}.h" >> $testSuite
        echo "    Should Contain     \${output.stdout}    /opt/lsst/ts_sal/include/SAL_\${subSystem}C.h" >> $testSuite
        echo "    Should Contain     \${output.stdout}    /opt/lsst/ts_sal/include/SAL_\${subSystem}LV.h" >> $testSuite
        echo "    Should Contain     \${output.stdout}    /opt/lsst/ts_sal/include/SAL_\${subSystem}_shmem.h" >> $testSuite
    fi
    echo "    Comment    Verify the interface definition files are included." >> $testSuite
    echo "    Should Contain     \${output.stdout}    /opt/lsst/ts_xml/sal_interfaces/\${subSystem}/\${subSystem}_Generics.xml" >> $testSuite
    if test -f $HOME/trunk/ts_xml/sal_interfaces/${subSystem}/${subSystem}_Commands.xml; then
        echo "    Should Contain     \${output.stdout}    /opt/lsst/ts_xml/sal_interfaces/\${subSystem}/\${subSystem}_Commands.xml" >> $testSuite
    fi
    if [[ $commandsArray -ne 0 ]]; then
        echo "    Should Contain     \${output.stdout}    /opt/lsst/ts_xml/sal_interfaces/\${subSystem}/\${subSystem}_Commands.html" >> $testSuite
    fi
    if test -f $HOME/trunk/ts_xml/sal_interfaces/${subSystem}/${subSystem}_Events.xml; then
        echo "    Should Contain     \${output.stdout}    /opt/lsst/ts_xml/sal_interfaces/\${subSystem}/\${subSystem}_Events.xml" >> $testSuite
    fi
    if [[ $eventsArray -ne 0 ]]; then
        echo "    Should Contain     \${output.stdout}    /opt/lsst/ts_xml/sal_interfaces/\${subSystem}/\${subSystem}_Events.html" >> $testSuite
    fi
    if test -f $HOME/trunk/ts_xml/sal_interfaces/${subSystem}/${subSystem}_Telemetry.xml; then
        echo "    Should Contain     \${output.stdout}    /opt/lsst/ts_xml/sal_interfaces/\${subSystem}/\${subSystem}_Telemetry.xml" >> $testSuite
    fi
    if [[ $telemetryArray -ne 0 ]]; then
        echo "    Should Contain     \${output.stdout}    /opt/lsst/ts_xml/sal_interfaces/\${subSystem}/\${subSystem}_Telemetry.html" >> $testSuite
    fi
    echo "" >> $testSuite
}

function salgenIDL() {
    skipped=$(checkIfSkipped $subSystem "idl")
    echo "Salgen $subSystemUp IDL" >> $testSuite
    echo "    [Documentation]    Generate the revCoded IDL for \${subSystem}" >> $testSuite
    echo "    [Tags]    idl$skipped" >> $testSuite
    echo "    \${output}=    Run Process    \${SALHome}/bin/salgenerator    \${subSystem}    sal    idl    \
shell=True    cwd=\${SALWorkDir}    stdout=\${EXECDIR}\${/}\${subSystem}_stdout.txt    stderr=\${EXECDIR}\${/}\${subSystem}_stderr.txt" >> $testSuite
    echo "    Log Many    \${output.stdout}    \${output.stderr}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    SAL generator - \${SALVersion}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    XMLVERSION = \${XMLVersion}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    Completed \${subSystem} validation" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/sal_revCoded_\${subSystem}.idl" >> $testSuite
    echo "    @{files}=    List Directory    \${SALWorkDir}/idl-templates/validated/sal    pattern=*\${subSystem}*" >> $testSuite
    echo "    Log Many    @{files}" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/idl-templates/validated/sal/sal_\${subSystem}.idl" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/idl-templates/validated/sal/sal_revCoded_\${subSystem}.idl" >> $testSuite
    echo "" >> $testSuite
}

function createTestSuite() {
    subSystem=$1

    #  Define test suite name
    subSystemUp=$(capitializeSubsystem $subSystem)
    testSuite=$workDir/SALGEN/${subSystemUp}_salgenerator.robot
        
    #  Check to see if the TestSuite exists then, if it does, delete it.
    clearTestSuites $subSystem "SALGEN" 
        
    # Get XML topic definitions.  Not all subsystems have all types of topics.
    declare -a xmls=($(ls $HOME/trunk/ts_xml/sal_interfaces/$subSystem))
    # Declare topic arrays
    declare -a telemetryArray=($(getTelemetryTopics $subSystem))
    #echo ${telemetryArray[@]}
    declare -a commandArray=($(getCommandTopics $subSystem))
    #echo ${commandArray[@]}
    declare -a eventArray=($(getEventTopics $subSystem))
    #echo ${eventArray[@]}

    #  Check if test suite should be skipped.
    skipped=$(checkIfSkipped $subSystem $topic)

    #  Get list of languages to build
    temp=$(getRuntimeLanguages $subSystem)
    IFS=', ' read -r -a rtlang <<< "${temp[0]}"
    if ! [[ ${rtlang[@]} =~ "CPP" ]]; then
        if [[ ${rtlang[@]} =~ "SALPY" || ${rtlang[@]} =~ "LabVIEW" ]]; then
            rtlang+=('CPP')
        fi
    fi
    echo "Runtime languages to build: ${rtlang[@]}"

    #  Create test suite.
    echo Creating $testSuite
    createSettings
    createVariables $subSystem
    echo "*** Test Cases ***" >> $testSuite
    verifyXMLDefinitions
    salgenValidate
    revCodeDefinition
    # Create and verfiy the RevCoded IDL files.
    salgenIDL
    # Create and verify C++ interfaces.
    if [[ ${rtlang[@]} =~ "CPP" || ${rtlang[@]} =~ "SALPY" || ${rtlang[@]} =~ "LabVIEW" ]]; then
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
    # Create and verify Python interfaces.
    if [[ ${rtlang[@]} =~ "SALPY" ]]; then
        salgenPython
        if [[ ${#telemetryArray[@]} -ne 0 ]]; then
            verifyPythonTelemetryInterfaces
        fi
        if [[ ${#commandArray[@]} -ne 0 ]]; then
            verifyPythonCommandInterfaces
        fi
        if [[ ${#eventArray[@]} -ne 0 ]]; then
            verifyPythonEventInterfaces
        fi
    fi
    # Create LabVIEW interfaces.  NOTE: There are NO such Scheduler or EFD interfaces.
    if [[ ${rtlang[@]} =~ "LabVIEW" ]]; then
        if [ "$subSystem" == "scheduler" ]; then
            echo "Skipping LabVIEW step for the Scheduler."
        else
            salgenLabview
        fi
    fi
    # Create and verify Java interfaces.
    if [[ ${rtlang[@]} =~ "Java" ]]; then
        salgenJava
    fi
    # Move/Generate the SAL libraries.
    salgenLib "${rtlang[@]}"
    # Generate the CSC documentation
    salgenDOC
    # Generate the as-built SAL libraries RPM.
    salgenRPM "${rtlang[@]}"
    verifyRPM ${#commandArray[@]} ${#eventArray[@]} ${#telemetryArray[@]} "${rtlang[@]}"
    # Run the Maven tests.
    if [[ ${rtlang[@]} =~ "Java" ]]; then
        salgenMaven
    fi
    # Indicate completion of the test suite.
    cleanupOutputs
    echo Done with test suite.
    echo ""
}


#  MAIN
subSystem=$(getEntity $arg)
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
    echo USAGE - Argument must be one of: ${subSystemArray[*]} OR all.
fi

