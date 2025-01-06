*** Settings ***
Documentation    This suite builds the various interfaces for the MTVMS.
Force Tags    salgen    mtvms
Suite Setup    Log Many    ${Host}    ${subSystem}    ${timeout}
Library    OperatingSystem
Library    Process
Resource    ../Global_Vars.resource

*** Variables ***
${subSystem}    MTVMS
${timeout}    1200s

*** Test Cases ***
Verify MTVMS XML Defintions exist
    [Tags]    validate
    Comment    Verify the CSC XML definition files exist.
    ${output}    Run Process    ls    ${SALWorkDir}/${subSystem}_*xml    shell=True
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Be Empty    ${output.stdout}
    File Should Exist    ${SALWorkDir}/MTVMS_Commands.xml
    File Should Exist    ${SALWorkDir}/MTVMS_Events.xml
    File Should Exist    ${SALWorkDir}/MTVMS_Telemetry.xml

Salgen MTVMS Validate
    [Documentation]    Validate the MTVMS XML definitions.
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
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_Generics.xml
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_Commands.xml
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}_cmddef.tcl
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_Events.xml
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}_evtdef.tcl
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_Telemetry.xml
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}_tlmdef.tcl
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_ackcmd.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_global_enums.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_disable.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_enable.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_exitControl.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_setLogLevel.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_standby.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_start.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_changeSamplePeriod.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_heartbeat.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_logLevel.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_logMessage.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_softwareVersions.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_errorCode.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_simulationMode.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_summaryState.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_configurationApplied.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_configurationsAvailable.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fpgaState.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_timeSynchronization.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_data.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_psd.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_miscellaneous.json/

Salgen MTVMS C++
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
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain X Times    ${output.stdout}    cpp : Done Publisher    3
    Should Contain X Times    ${output.stdout}    cpp : Done Subscriber    3
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

Verify MTVMS Telemetry directories
    [Tags]    cpp
    @{files}=    List Directory    ${SALWorkDir}    pattern=*${subSystem}*
    Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/${subSystem}_data
    Directory Should Exist    ${SALWorkDir}/${subSystem}_psd
    Directory Should Exist    ${SALWorkDir}/${subSystem}_miscellaneous

Verify MTVMS C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}_data/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_data/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_data.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_psd/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_psd/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_psd.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_miscellaneous/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_miscellaneous/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_miscellaneous.hh

Verify MTVMS C++ Command Interfaces
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
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_changeSamplePeriod_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_changeSamplePeriod_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_changeSamplePeriod.hh

Verify MTVMS C++ Event Interfaces
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
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_fpgaState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_fpgaState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_fpgaState.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_timeSynchronization_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_timeSynchronization_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_timeSynchronization.hh

Salgen MTVMS Lib
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

Salgen MTVMS RPM
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
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/ts_sal_utilsKafka-${SALVersionBase}-1.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/${subSystem}-${XMLVersionBase}${sep}${Build_Number}-${SALVersionBase}${DIST}.x86_64.rpm
    File Should Exist    ${SALWorkDir}/lib/org/lsst/sal/salUtils.class
    File Should Exist    ${SALWorkDir}/lib/libsalUtils.so
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/${subSystem}_test-${XMLVersionBase}${sep}${Build_Number}-${SALVersionBase}${DIST}.x86_64.rpm
    Should Not Contain    ${output.stdout}    child process exited abnormally

Verify MTVMS RPM Contents
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
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/scripts/${subSystem}_revCodes.tcl
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_ackcmd.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_global_enums.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_hash_table.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_disable.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_enable.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_exitControl.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_setLogLevel.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_standby.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_start.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_changeSamplePeriod.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_heartbeat.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_logLevel.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_logMessage.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_softwareVersions.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_errorCode.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_simulationMode.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_summaryState.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_configurationApplied.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_configurationsAvailable.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_fpgaState.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_timeSynchronization.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_data.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_psd.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_miscellaneous.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/lib/libSAL_${subSystem}.a
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/SAL_${subSystem}.h
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_ackcmd.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_data.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_psd.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_miscellaneous.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_disable.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_enable.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_exitControl.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_setLogLevel.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_standby.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_start.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_changeSamplePeriod.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_heartbeat.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_logLevel.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_logMessage.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_softwareVersions.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_errorCode.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_simulationMode.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_summaryState.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_configurationApplied.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_configurationsAvailable.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_fpgaState.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_timeSynchronization.hh
    Comment    Verify the interface definition files are included.
    Should Contain    ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Generics.xml
    Should Contain    ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Commands.xml
    Should Contain    ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Commands.html
    Should Contain    ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Events.xml
    Should Contain    ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Events.html
    Should Contain    ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Telemetry.xml
    Should Contain    ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Telemetry.html

Verify MTVMS TEST RPM Contents
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
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_changeSamplePeriod_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_changeSamplePeriod_controller
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
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_fpgaState_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_fpgaState_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_timeSynchronization_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_timeSynchronization_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_data_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_data_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_psd_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_psd_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_miscellaneous_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_miscellaneous_subscriber

Cleanup stdout and stderr Files
    [Tags]
    Remove Files    ${EXECDIR}${/}${subSystem}_stdout.txt    ${EXECDIR}${/}${subSystem}_stderr.txt

