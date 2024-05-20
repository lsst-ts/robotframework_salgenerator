*** Settings ***
Documentation    This suite builds the various interfaces for the Test.
Force Tags    salgen    test
Suite Setup    Log Many    ${Host}    ${subSystem}    ${timeout}
Library    OperatingSystem
Library    Process
Resource    ../Global_Vars.resource

*** Variables ***
${subSystem}    Test
${timeout}    1200s

*** Test Cases ***
Verify Test XML Defintions exist
    [Tags]    validate
    Comment    Verify the CSC XML definition files exist.
    ${output}    Run Process    ls     ${SALWorkDir}/${subSystem}_*xml    shell=True
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Be Empty    ${output.stdout}
    File Should Exist    ${SALWorkDir}/Test_Commands.xml
    File Should Exist    ${SALWorkDir}/Test_Events.xml
    File Should Exist    ${SALWorkDir}/Test_Telemetry.xml

Salgen Test Validate
    [Documentation]    Validate the Test XML definitions.
    [Tags]    validate
    ${output}=    Run Process    ${SALHome}/bin/salgeneratorKafka    ${subSystem}    validate    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    XMLVERSION = ${XMLVersion}
    Should Contain    ${output.stdout}    Processing ${subSystem}
    Should Contain    ${output.stdout}    Completed ${subSystem} validation
    Directory Should Exist    ${SALWorkDir}/avro-templates
    @{files}=    List Directory    ${SALWorkDir}/avro-templates
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}_metadata.tcl
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}_revCodes.tcl
    Directory Should Exist    ${SALWorkDir}/avro-templates/${subSystem}
    @{files}=    List Directory    ${SALWorkDir}/avro-templates/${subSystem}
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_Generics.xml
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_Commands.xml
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}_cmddef.tcl
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_Events.xml
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}_evtdef.tcl
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_Telemetry.xml
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}_tlmdef.tcl
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_heartbeat.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_logLevel.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_logMessage.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_softwareVersions.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_errorCode.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_simulationMode.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_summaryState.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_configurationApplied.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_configurationsAvailable.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_scalars.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_arrays.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_scalars.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_arrays.json/

Salgen Test C++
    [Documentation]    Generate C++ libraries.
    [Tags]    cpp
    ${output}=    Run Process    ${SALHome}/bin/salgeneratorKafka    ${subSystem}    sal    cpp   shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stdout}    ERROR : Failed to generate CPP DDS types
    Should Not Contain    ${output.stdout}    *** DDS error in file
    Should Not Contain    ${output.stdout}    Error 1
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    XMLVERSION = ${XMLVersion}
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain X Times    ${output.stdout}    cpp : Done Publisher    2
    Should Contain X Times    ${output.stdout}    cpp : Done Subscriber    2
    Should Contain X Times    ${output.stdout}    cpp : Done Commander    1
    Should Contain X Times    ${output.stdout}    cpp : Done Event/Logger    1

Verify C++ Directories
    [Documentation]    Ensure expected C++ directories and files are created.
    [Tags]    cpp
    Directory Should Exist    ${SALWorkDir}/${subSystem}/cpp
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/cpp/src    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/SAL_${subSystem}.cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/SAL_${subSystem}C.h
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/SAL_${subSystem}LV.h
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/SAL_${subSystem}_actors.h
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/SAL_${subSystem}_enums.h

Verify Test Telemetry directories
    [Tags]    cpp
    @{files}=    List Directory    ${SALWorkDir}    pattern=*${subSystem}*
    Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/${subSystem}_scalars
    Directory Should Exist    ${SALWorkDir}/${subSystem}_arrays

Verify Test C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}_scalars/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_scalars/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_scalars.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_arrays/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_arrays/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_arrays.hh

Verify Test C++ Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_ackcmd.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_disable_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_disable_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_disable.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enable_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enable_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_enable.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_exitControl_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_exitControl_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_exitControl.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setLogLevel_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setLogLevel_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_setLogLevel.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_standby_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_standby_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_standby.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_start_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_start_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_start.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setScalars_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setScalars_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_setScalars.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setArrays_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setArrays_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_setArrays.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_fault_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_fault_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_fault.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_wait_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_wait_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_wait.hh

Verify Test C++ Event Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_heartbeat_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_heartbeat_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_heartbeat.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_logLevel_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_logLevel_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_logLevel.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_logMessage_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_logMessage_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_logMessage.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_softwareVersions_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_softwareVersions_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_softwareVersions.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_errorCode_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_errorCode_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_errorCode.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_simulationMode_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_simulationMode_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_simulationMode.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_summaryState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_summaryState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_summaryState.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_configurationApplied_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_configurationApplied_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_configurationApplied.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_configurationsAvailable_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_configurationsAvailable_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_configurationsAvailable.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_scalars_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_scalars_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_scalars.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_arrays_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_arrays_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_arrays.hh

Salgen Test LabVIEW
    [Documentation]    Generate ${subSystem} low-level LabView interfaces.
    [Tags]    labview
    ${output}=    Run Process    ${SALHome}/bin/salgeneratorKafka    ${subSystem}    labview    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    XMLVERSION = ${XMLVersion}
    Directory Should Exist    ${SALWorkDir}/${subSystem}/labview
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/labview
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/labview/SAL_${subSystem}_salShmMonitor.cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/labview/SAL_${subSystem}_shmem.h
    File Should Exist    ${SALWorkDir}/${subSystem}/labview/SALLV_${subSystem}.so
    File Should Exist    ${SALWorkDir}/${subSystem}/labview/SALLV_${subSystem}_Monitor

Salgen Test Java
    [Documentation]    Generate Java libraries.
    [Tags]    java
    Comment    The Test CSC is not a true Java artifact and is never published as such. Remove the MavenVersion string to accommodate RPM packaging.
    Set Suite Variable    ${MavenVersion}    ${EMPTY}
    ${output}=    Run Process    ${SALHome}/bin/salgeneratorKafka    ${subSystem}    sal    java    version\=${MavenVersion}    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stdout}    ERROR : Failed to generate*saj_*_types.jar 
    Should Not Contain    ${output.stdout}    error: package org.apache.avro* does not exist
    Should Not Contain    ${output.stdout}    error: package org.apache.kafka* does not exist
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    XMLVERSION = ${XMLVersion}
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_scalars.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_scalars java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_scalars/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_arrays.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_arrays java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_arrays/java/src/org/lsst/sal/salUtils.class
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/saj_${subSystem}_types.jar
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/org/lsst/sal/SAL_${subSystem}.java
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/org/lsst/sal/salActor.java
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/org/lsst/sal/salUtils.java
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/classes/org/lsst/sal//salUtils.class
    File Should Exist    ${SALWorkDir}/salUtils/libsalUtils.so
    File Should Exist    ${SALWorkDir}/lib/org/lsst/sal/salUtils.class 

Salgen Test Maven
    [Documentation]    Generate the Maven repository.
    [Tags]    java
    ${output}=    Run Process    ${SALHome}/bin/salgeneratorKafka    ${subSystem}    maven    version\=${MavenVersion}    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    argv = ${subSystem} maven version=${MavenVersion}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    XMLVERSION = ${XMLVersion}
    Should Contain    ${output.stdout}    Running maven install
    Should Contain    ${output.stdout}    [INFO] Building sal_${subSystem} ${XMLVersionBase}_${SALVersionBase}${MavenVersion}
    Should Contain X Times    ${output.stdout}    [INFO] BUILD SUCCESS    1
    Should Contain X Times    ${output.stdout}    [INFO] Finished at:    1
    @{files}=    List Directory    ${SALWorkDir}/maven
    File Should Exist    ${SALWorkDir}/maven/${subSystem}-${XMLVersionBase}_${SALVersionBase}${MavenVersion}/pom.xml

Salgen Test Lib
    [Documentation]    Generate the SAL shared library for ${subSystem}
    [Tags]    lib
    ${output}=    Run Process    ${SALHome}/bin/salgeneratorKafka    ${subSystem}    lib    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    XMLVERSION = ${XMLVersion}
    Should Contain    ${output.stdout}    Building shared library for ${subSystem} subsystem
    Directory Should Exist    ${SALWorkDir}/lib
    @{files}=    List Directory    ${SALWorkDir}/lib    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/lib/libSAL_${subSystem}.a
    File Should Exist    ${SALWorkDir}/lib/libsalUtils.so
    File Should Exist    ${SALWorkDir}/lib/org/lsst/sal/salUtils.class 
    File Should Exist    ${SALWorkDir}/lib/saj_${subSystem}_types.jar

Salgen Test RPM
    [Documentation]    Generate the SAL runtime RPM for ${subSystem}
    [Tags]    rpm
    Log Many    ${XMLVersion}    ${SALVersion}    ${Build_Number}    ${DIST}
    ${output}=    Run Process    ${SALHome}/bin/salgeneratorKafka    ${subSystem}    rpm    version\=${Build_Number}    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    @{files}=    List Directory    /tmp/
    Should Be Empty    ${output.stderr}
    File Should Exist    /tmp/makerpm_${subSystem}.log
    File Should Exist    /tmp/makerpm-utils.log
    Log File    /tmp/makerpm_${subSystem}.log
    Log File    /tmp/makerpm-utils.log
    Should Not Contain    ${output.stdout}    ERROR : Asset required for rpm
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    XMLVERSION = ${XMLVersion}
    Should Contain    ${output.stdout}    Building runtime RPM for ${subSystem} subsystem
    Directory Should Exist    ${SALWorkDir}/rpmbuild
    Directory Should Exist    ${SALWorkDir}/rpmbuild/BUILD
    Directory Should Exist    ${SALWorkDir}/rpmbuild/BUILDROOT
    Directory Should Exist    ${SALWorkDir}/rpmbuild/RPMS
    Directory Should Exist    ${SALWorkDir}/rpmbuild/SOURCES
    Directory Should Exist    ${SALWorkDir}/rpmbuild/SPECS
    Directory Should Exist    ${SALWorkDir}/rpmbuild/SRPMS
    Directory Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/
    @{files}=    List Directory    ${SALWorkDir}/rpmbuild/RPMS/x86_64/
    Log Many    @{files}
    IF    "${Build_Number}" == ""
        Set Test Variable    ${sep}    ${EMPTY}
    ELSE IF    any(item in '${Build_Number}' for item in ('pre', 'post', 'rc'))
        Set Test Variable    ${sep}    ~
    ELSE
        Set Test Variable    ${sep}    ${EMPTY}
    END
    File Should Exist    ${SALWorkDir}/rpmbuild/SPECS/ts_sal_${subSystem}.spec
    File Should Exist    ${SALWorkDir}/rpmbuild/SOURCES/${subSystem}-${XMLVersionBase}${sep}${Build_Number}.tgz
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/ts_sal_runtime-${XMLVersionBase}${sep}${Build_Number}-${SALVersionBase}*${DIST}.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/ts_sal_ATruntime-${XMLVersionBase}${sep}${Build_Number}-${SALVersionBase}*${DIST}.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/ts_sal_utils-${SALVersionBase}-1.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/${subSystem}-${XMLVersionBase}${sep}${Build_Number}-${SALVersionBase}${DIST}.x86_64.rpm
    File Should Exist    ${SALWorkDir}/lib/org/lsst/sal/salUtils.class
    File Should Exist    ${SALWorkDir}/lib/libsalUtils.so
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/${subSystem}_test-${XMLVersionBase}${sep}${Build_Number}-${SALVersionBase}${DIST}.x86_64.rpm
    Should Not Contain    ${output.stdout}    child process exited abnormally

Verify Test RPM Contents
    [Documentation]    Verify the ${subSystem} RPM contains all the expected libraries
    [Tags]    rpm
    Comment    Re-run the {sep} process, so this test case can run independently.
    IF    "${Build_Number}" == ""
        Set Test Variable    ${sep}    ${EMPTY}
    ELSE IF    any(item in '${Build_Number}' for item in ('pre', 'post', 'rc'))
        Set Test Variable    ${sep}    ~
    ELSE
        Set Test Variable    ${sep}    ${EMPTY}
    END
    ${output}=    Run Process    rpm    -qpl    ${subSystem}-${XMLVersionBase}${sep}${Build_Number}-${SALVersionBase}${DIST}.x86_64.rpm    cwd=${SALWorkDir}/rpmbuild/RPMS/x86_64
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stderr}    error
    Should Not Contain    ${output.stderr}    No such file or directory
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/scripts/${subSystem}_revCodes.tcl
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/lib/libSAL_${subSystem}.a
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/SAL_${subSystem}.h
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_ackcmd.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_scalars.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_arrays.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_disable.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_enable.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_exitControl.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_setLogLevel.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_standby.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_start.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_setScalars.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_setArrays.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_fault.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_wait.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_heartbeat.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_logLevel.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_logMessage.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_softwareVersions.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_errorCode.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_simulationMode.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_summaryState.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_configurationApplied.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_configurationsAvailable.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_scalars.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_arrays.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/SAL_${subSystem}C.h
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/SAL_${subSystem}LV.h
    Comment    Verify the interface definition files are included.
    Should Contain     ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Generics.xml
    Should Contain     ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Commands.xml
    Should Contain     ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Commands.html
    Should Contain     ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Events.xml
    Should Contain     ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Events.html
    Should Contain     ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Telemetry.xml
    Should Contain     ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Telemetry.html

Verify Test TEST RPM Contents
    [Documentation]    Verify the ${subSystem} TEST RPM contains all the expected libraries
    [Tags]    rpm
    Comment    Re-run the {sep} process, so this test case can run independently.
    IF    "${Build_Number}" == ""
        Set Test Variable    ${sep}    ${EMPTY}
    ELSE IF    any(item in '${Build_Number}' for item in ('pre', 'post', 'rc'))
        Set Test Variable    ${sep}    ~
    ELSE
        Set Test Variable    ${sep}    ${EMPTY}
    END
    ${output}=    Run Process    rpm    -qpl    ${subSystem}_test-${XMLVersionBase}${sep}${Build_Number}-${SALVersionBase}${DIST}.x86_64.rpm    shell=True    cwd=${SALWorkDir}/rpmbuild/RPMS/x86_64    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stderr}    error
    Should Not Contain    ${output.stderr}    No such file or directory
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/lib/libSAL_${subSystem}.a
    Comment    Verify the TEST RPM contains the test programs.
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_all_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_all_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_all_sender
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_all_logger
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_all_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_all_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_disable_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_disable_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_enable_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_enable_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_exitControl_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_exitControl_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_setLogLevel_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_setLogLevel_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_standby_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_standby_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_start_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_start_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_setScalars_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_setScalars_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_setArrays_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_setArrays_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_fault_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_fault_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_wait_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_wait_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_heartbeat_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_heartbeat_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_logLevel_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_logLevel_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_logMessage_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_logMessage_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_softwareVersions_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_softwareVersions_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_errorCode_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_errorCode_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_simulationMode_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_simulationMode_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_summaryState_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_summaryState_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_configurationApplied_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_configurationApplied_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_configurationsAvailable_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_configurationsAvailable_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_scalars_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_scalars_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_arrays_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_arrays_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_scalars_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_scalars_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_arrays_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_arrays_subscriber

Cleanup stdout and stderr Files
    [Tags]
    Remove Files    ${EXECDIR}${/}${subSystem}_stdout.txt    ${EXECDIR}${/}${subSystem}_stderr.txt

