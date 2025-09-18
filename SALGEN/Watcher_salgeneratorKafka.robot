*** Settings ***
Documentation    This suite builds the various interfaces for the Watcher.
Force Tags    salgen    watcher
Suite Setup    Log Many    ${Host}    ${subSystem}    ${timeout}
Library    OperatingSystem
Library    Process
Resource    ../Global_Vars.resource

*** Variables ***
${subSystem}    Watcher
${timeout}    1200s

*** Test Cases ***
Verify Watcher XML Defintions exist
    [Tags]    validate
    Comment    Verify the CSC XML definition files exist.
    ${output}    Run Process    ls    ${SALWorkDir}/${subSystem}_*xml    shell=True
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Be Empty    ${output.stdout}
    File Should Exist    ${SALWorkDir}/Watcher_Commands.xml
    File Should Exist    ${SALWorkDir}/Watcher_Events.xml

Salgen Watcher Validate
    [Documentation]    Validate the Watcher XML definitions.
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
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_ackcmd.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_global_enums.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_disable.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_enable.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_exitControl.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_setLogLevel.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_standby.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_start.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_acknowledge.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_makeLogEntry.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_mute.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_showAlarms.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_unacknowledge.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_unmute.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_heartbeat.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_logLevel.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_logMessage.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_softwareVersions.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_errorCode.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_simulationMode.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_summaryState.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_configurationApplied.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_configurationsAvailable.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_alarm.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_notification.json

Salgen Watcher Java
    [Documentation]    Generate Java libraries.
    [Tags]    java
    ${output}=    Run Process    ${SALHome}/bin/salgeneratorKafka    ${subSystem}    sal    java    version\=${MavenVersion}    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stdout}    ERROR : Failed to generate*saj_*_types.jar 
    Should Not Contain    ${output.stdout}    error: package org.apache.avro* does not exist
    Should Not Contain    ${output.stdout}    error: package org.apache.kafka* does not exist
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    XMLVERSION = ${XMLVersion}
    Should Contain    ${output.stdout}    WARNING : No Telemetry definitions found for ${subSystem}
    Should Contain    ${output.stdout}    calling salavrogen ${subSystem} cpp
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_heartbeat.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_heartbeat.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_logLevel.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_logLevel.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_logMessage.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_logMessage.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_softwareVersions.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_softwareVersions.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_errorCode.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_errorCode.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_simulationMode.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_simulationMode.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_summaryState.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_summaryState.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_configurationApplied.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_configurationApplied.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_configurationsAvailable.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_configurationsAvailable.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_alarm.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_alarm.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_notification.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_notification.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_disable.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_disable.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_enable.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_enable.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_exitControl.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_exitControl.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_setLogLevel.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_setLogLevel.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_standby.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_standby.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_start.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_start.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_acknowledge.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_acknowledge.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_makeLogEntry.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_makeLogEntry.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_mute.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_mute.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_showAlarms.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_showAlarms.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_unacknowledge.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_unacknowledge.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_unmute.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_unmute.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Configuring ${subSystem}/java/src/org/lsst/sal/SAL_${subSystem}.java
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/saj_${subSystem}_types.jar
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/org/lsst/sal/SAL_${subSystem}.java
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/org/lsst/sal/salActor.java
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/org/lsst/sal/salUtils.java
    File Should Exist    ${SALWorkDir}/salUtils/libsalUtils.so
    File Should Exist    ${SALWorkDir}/lib/org/lsst/sal/salUtils.class 

Salgen Watcher Maven
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
    File Should Exist    ${SALWorkDir}/maven/${subSystem}-${XMLVersionBase}_${SALVersionBase}${MavenVersion}/target/sal_${subSystem}-${XMLVersionBase}_${SALVersionBase}${MavenVersion}.jar

Salgen Watcher Lib
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
    File Should Exist    ${SALWorkDir}/lib/libsalUtils.so
    File Should Exist    ${SALWorkDir}/lib/org/lsst/sal/salUtils.class 
    File Should Exist    ${SALWorkDir}/lib/saj_${subSystem}_types.jar

Cleanup stdout and stderr Files
    [Tags]
    Remove Files    ${EXECDIR}${/}${subSystem}_stdout.txt    ${EXECDIR}${/}${subSystem}_stderr.txt

