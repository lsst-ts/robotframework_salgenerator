*** Settings ***
Documentation    This suite builds the various interfaces for the MTRotator.
Force Tags    salgen    mtrotator
Suite Setup    Log Many    ${Host}    ${subSystem}    ${timeout}
Library    OperatingSystem
Library    Process
Resource    ../Global_Vars.resource

*** Variables ***
${subSystem}    MTRotator
${timeout}    1200s

*** Test Cases ***
Verify MTRotator XML Defintions exist
    [Tags]    validate
    Comment    Verify the CSC XML definition files exist.
    ${output}    Run Process    ls    ${SALWorkDir}/${subSystem}_*xml    shell=True
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Be Empty    ${output.stdout}
    File Should Exist    ${SALWorkDir}/MTRotator_Commands.xml
    File Should Exist    ${SALWorkDir}/MTRotator_Events.xml
    File Should Exist    ${SALWorkDir}/MTRotator_Telemetry.xml

Salgen MTRotator Validate
    [Documentation]    Validate the MTRotator XML definitions.
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
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_configureAcceleration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_configureVelocity.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_configureJerk.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_configureEmergencyAcceleration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_configureEmergencyJerk.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_fault.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_move.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_track.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_trackStart.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_stop.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_heartbeat.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_logLevel.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_logMessage.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_softwareVersions.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_errorCode.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_simulationMode.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_summaryState.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_configurationApplied.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_configurationsAvailable.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_clockOffset.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_controllerState.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_connected.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_interlock.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_target.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_tracking.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_inPosition.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_configuration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_commandableByDDS.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_lowFrequencyVibration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_ccwFollowingError.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_rotation.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_electrical.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_motors.json/

Salgen MTRotator C++
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
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain X Times    ${output.stdout}    cpp : Done Publisher    4
    Should Contain X Times    ${output.stdout}    cpp : Done Subscriber    4
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

Verify MTRotator Telemetry directories
    [Tags]    cpp
    @{files}=    List Directory    ${SALWorkDir}    pattern=*${subSystem}*
    Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/${subSystem}_ccwFollowingError
    Directory Should Exist    ${SALWorkDir}/${subSystem}_rotation
    Directory Should Exist    ${SALWorkDir}/${subSystem}_electrical
    Directory Should Exist    ${SALWorkDir}/${subSystem}_motors

Verify MTRotator C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}_ccwFollowingError/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_ccwFollowingError/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_ccwFollowingError.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_rotation/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_rotation/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_rotation.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_electrical/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_electrical/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_electrical.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_motors/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_motors/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_motors.hh

Verify MTRotator C++ Command Interfaces
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
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_configureAcceleration_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_configureAcceleration_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_configureAcceleration.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_configureVelocity_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_configureVelocity_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_configureVelocity.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_configureJerk_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_configureJerk_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_configureJerk.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_configureEmergencyAcceleration_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_configureEmergencyAcceleration_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_configureEmergencyAcceleration.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_configureEmergencyJerk_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_configureEmergencyJerk_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_configureEmergencyJerk.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_fault_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_fault_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_fault.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_move_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_move_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_move.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_track_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_track_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_track.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_trackStart_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_trackStart_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_trackStart.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_stop_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_stop_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_stop.hh

Verify MTRotator C++ Event Interfaces
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
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_clockOffset_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_clockOffset_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_clockOffset.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_controllerState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_controllerState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_controllerState.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_connected_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_connected_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_connected.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_interlock_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_interlock_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_interlock.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_target_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_target_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_target.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_tracking_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_tracking_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_tracking.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_inPosition_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_inPosition_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_inPosition.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_configuration_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_configuration_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_configuration.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_commandableByDDS_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_commandableByDDS_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_commandableByDDS.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_lowFrequencyVibration_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_lowFrequencyVibration_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_lowFrequencyVibration.hh

Salgen MTRotator Java
    [Documentation]    Generate Java libraries.
    [Tags]    java
    ${output}=    Run Process    ${SALHome}/bin/salgeneratorKafka    ${subSystem}    sal    java    version\=${MavenVersion}    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stdout}    ERROR : Failed to generate*saj_*_types.jar 
    Should Not Contain    ${output.stdout}    error: package org.apache.avro* does not exist
    Should Not Contain    ${output.stdout}    error: package org.apache.kafka* does not exist
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    XMLVERSION = ${XMLVersion}
    Should Contain    ${output.stdout}    calling salavrogen ${subSystem} cpp
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_ccwFollowingError.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_ccwFollowingError.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_rotation.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_rotation.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_electrical.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_electrical.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_motors.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_motors.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_heartbeat.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_heartbeat.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_logLevel.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_logLevel.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_logMessage.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_logMessage.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_softwareVersions.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_softwareVersions.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_errorCode.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_errorCode.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_simulationMode.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_simulationMode.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_summaryState.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_summaryState.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_configurationApplied.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_configurationApplied.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_configurationsAvailable.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_configurationsAvailable.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_clockOffset.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_clockOffset.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_controllerState.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_controllerState.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_connected.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_connected.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_interlock.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_interlock.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_target.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_target.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_tracking.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_tracking.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_inPosition.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_inPosition.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_configuration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_configuration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_commandableByDDS.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_commandableByDDS.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_lowFrequencyVibration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_lowFrequencyVibration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_disable.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_disable.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_enable.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_enable.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_exitControl.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_exitControl.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_setLogLevel.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_setLogLevel.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_standby.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_standby.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_start.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_start.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_configureAcceleration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_configureAcceleration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_configureVelocity.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_configureVelocity.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_configureJerk.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_configureJerk.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_configureEmergencyAcceleration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_configureEmergencyAcceleration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_configureEmergencyJerk.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_configureEmergencyJerk.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_fault.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_fault.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_move.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_move.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_track.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_track.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_trackStart.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_trackStart.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_stop.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_stop.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Configuring ${subSystem}/java/src/org/lsst/sal/SAL_${subSystem}.java
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/saj_${subSystem}_types.jar
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/org/lsst/sal/SAL_${subSystem}.java
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/org/lsst/sal/salActor.java
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/org/lsst/sal/salUtils.java
    File Should Exist    ${SALWorkDir}/salUtils/libsalUtils.so
    File Should Exist    ${SALWorkDir}/lib/org/lsst/sal/salUtils.class 

Salgen MTRotator Maven
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

Salgen MTRotator Lib
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

Salgen MTRotator RPM
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

Verify MTRotator RPM Contents
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
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_configureAcceleration.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_configureVelocity.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_configureJerk.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_configureEmergencyAcceleration.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_configureEmergencyJerk.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_fault.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_move.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_track.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_trackStart.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_stop.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_heartbeat.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_logLevel.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_logMessage.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_softwareVersions.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_errorCode.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_simulationMode.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_summaryState.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_configurationApplied.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_configurationsAvailable.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_clockOffset.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_controllerState.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_connected.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_interlock.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_target.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_tracking.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_inPosition.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_configuration.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_commandableByDDS.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_lowFrequencyVibration.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_ccwFollowingError.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_rotation.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_electrical.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_motors.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/lib/libSAL_${subSystem}.a
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/SAL_${subSystem}.h
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_ackcmd.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_ccwFollowingError.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_rotation.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_electrical.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_motors.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_disable.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_enable.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_exitControl.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_setLogLevel.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_standby.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_start.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_configureAcceleration.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_configureVelocity.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_configureJerk.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_configureEmergencyAcceleration.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_configureEmergencyJerk.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_fault.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_move.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_track.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_trackStart.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_stop.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_heartbeat.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_logLevel.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_logMessage.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_softwareVersions.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_errorCode.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_simulationMode.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_summaryState.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_configurationApplied.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_configurationsAvailable.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_clockOffset.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_controllerState.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_connected.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_interlock.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_target.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_tracking.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_inPosition.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_configuration.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_commandableByDDS.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_lowFrequencyVibration.hh
    Comment    Verify the interface definition files are included.
    Should Contain    ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Generics.xml
    Should Contain    ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Commands.xml
    Should Contain    ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Commands.html
    Should Contain    ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Events.xml
    Should Contain    ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Events.html
    Should Contain    ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Telemetry.xml
    Should Contain    ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Telemetry.html

Verify MTRotator TEST RPM Contents
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
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_configureAcceleration_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_configureAcceleration_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_configureVelocity_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_configureVelocity_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_configureJerk_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_configureJerk_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_configureEmergencyAcceleration_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_configureEmergencyAcceleration_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_configureEmergencyJerk_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_configureEmergencyJerk_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_fault_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_fault_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_move_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_move_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_track_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_track_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_trackStart_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_trackStart_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_stop_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_stop_controller
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
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_clockOffset_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_clockOffset_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_controllerState_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_controllerState_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_connected_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_connected_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_interlock_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_interlock_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_target_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_target_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_tracking_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_tracking_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_inPosition_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_inPosition_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_configuration_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_configuration_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_commandableByDDS_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_commandableByDDS_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_lowFrequencyVibration_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_lowFrequencyVibration_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_ccwFollowingError_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_ccwFollowingError_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_rotation_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_rotation_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_electrical_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_electrical_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_motors_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_motors_subscriber

Cleanup stdout and stderr Files
    [Tags]
    Remove Files    ${EXECDIR}${/}${subSystem}_stdout.txt    ${EXECDIR}${/}${subSystem}_stderr.txt

