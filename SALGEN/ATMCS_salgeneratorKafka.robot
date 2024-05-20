*** Settings ***
Documentation    This suite builds the various interfaces for the ATMCS.
Force Tags    salgen    atmcs
Suite Setup    Log Many    ${Host}    ${subSystem}    ${timeout}
Library    OperatingSystem
Library    Process
Resource    ../Global_Vars.resource

*** Variables ***
${subSystem}    ATMCS
${timeout}    1200s

*** Test Cases ***
Verify ATMCS XML Defintions exist
    [Tags]    validate
    Comment    Verify the CSC XML definition files exist.
    ${output}    Run Process    ls     ${SALWorkDir}/${subSystem}_*xml    shell=True
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Be Empty    ${output.stdout}
    File Should Exist    ${SALWorkDir}/ATMCS_Commands.xml
    File Should Exist    ${SALWorkDir}/ATMCS_Events.xml
    File Should Exist    ${SALWorkDir}/ATMCS_Telemetry.xml

Salgen ATMCS Validate
    [Documentation]    Validate the ATMCS XML definitions.
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
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_detailedState.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_atMountState.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_m3State.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_m3PortSelected.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_positionLimits.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_target.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_elevationInPosition.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_azimuthInPosition.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_nasmyth1RotatorInPosition.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_nasmyth2RotatorInPosition.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_m3InPosition.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_allAxesInPosition.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_azimuthToppleBlockCCW.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_azimuthToppleBlockCW.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_m3RotatorDetentSwitches.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_elevationLimitSwitchLower.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_elevationLimitSwitchUpper.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_azimuthLimitSwitchCCW.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_azimuthLimitSwitchCW.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_nasmyth1LimitSwitchCCW.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_nasmyth1LimitSwitchCW.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_nasmyth2LimitSwitchCCW.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_nasmyth2LimitSwitchCW.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_m3RotatorLimitSwitchCCW.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_m3RotatorLimitSwitchCW.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_elevationDriveStatus.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_azimuthDrive1Status.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_azimuthDrive2Status.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_nasmyth1DriveStatus.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_nasmyth2DriveStatus.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_m3DriveStatus.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_elevationBrake.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_azimuthBrake1.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_azimuthBrake2.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_nasmyth1Brake.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_nasmyth2Brake.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_trajectory.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_mount_AzEl_Encoders.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_mount_Nasmyth_Encoders.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_torqueDemand.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_measuredTorque.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_measuredMotorVelocity.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_nasmyth_m3_mountMotorEncoders.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_azEl_mountMotorEncoders.json/

Salgen ATMCS C++
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
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain X Times    ${output.stdout}    cpp : Done Publisher    8
    Should Contain X Times    ${output.stdout}    cpp : Done Subscriber    8
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

Verify ATMCS Telemetry directories
    [Tags]    cpp
    @{files}=    List Directory    ${SALWorkDir}    pattern=*${subSystem}*
    Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/${subSystem}_trajectory
    Directory Should Exist    ${SALWorkDir}/${subSystem}_mount_AzEl_Encoders
    Directory Should Exist    ${SALWorkDir}/${subSystem}_mount_Nasmyth_Encoders
    Directory Should Exist    ${SALWorkDir}/${subSystem}_torqueDemand
    Directory Should Exist    ${SALWorkDir}/${subSystem}_measuredTorque
    Directory Should Exist    ${SALWorkDir}/${subSystem}_measuredMotorVelocity
    Directory Should Exist    ${SALWorkDir}/${subSystem}_nasmyth_m3_mountMotorEncoders
    Directory Should Exist    ${SALWorkDir}/${subSystem}_azEl_mountMotorEncoders

Verify ATMCS C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}_trajectory/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_trajectory/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_trajectory.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_mount_AzEl_Encoders/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_mount_AzEl_Encoders/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_mount_AzEl_Encoders.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_mount_Nasmyth_Encoders/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_mount_Nasmyth_Encoders/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_mount_Nasmyth_Encoders.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_torqueDemand/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_torqueDemand/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_torqueDemand.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_measuredTorque/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_measuredTorque/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_measuredTorque.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_measuredMotorVelocity/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_measuredMotorVelocity/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_measuredMotorVelocity.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_nasmyth_m3_mountMotorEncoders/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_nasmyth_m3_mountMotorEncoders/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_nasmyth_m3_mountMotorEncoders.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_azEl_mountMotorEncoders/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_azEl_mountMotorEncoders/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_azEl_mountMotorEncoders.hh

Verify ATMCS C++ Command Interfaces
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
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startTracking_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startTracking_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_startTracking.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_trackTarget_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_trackTarget_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_trackTarget.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setInstrumentPort_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setInstrumentPort_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_setInstrumentPort.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_stopTracking_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_stopTracking_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_stopTracking.hh

Verify ATMCS C++ Event Interfaces
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
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_detailedState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_detailedState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_detailedState.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_atMountState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_atMountState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_atMountState.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m3State_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m3State_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_m3State.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m3PortSelected_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m3PortSelected_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_m3PortSelected.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_positionLimits_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_positionLimits_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_positionLimits.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_target_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_target_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_target.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_elevationInPosition_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_elevationInPosition_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_elevationInPosition.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthInPosition_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthInPosition_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_azimuthInPosition.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth1RotatorInPosition_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth1RotatorInPosition_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_nasmyth1RotatorInPosition.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth2RotatorInPosition_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth2RotatorInPosition_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_nasmyth2RotatorInPosition.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m3InPosition_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m3InPosition_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_m3InPosition.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_allAxesInPosition_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_allAxesInPosition_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_allAxesInPosition.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthToppleBlockCCW_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthToppleBlockCCW_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_azimuthToppleBlockCCW.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthToppleBlockCW_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthToppleBlockCW_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_azimuthToppleBlockCW.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m3RotatorDetentSwitches_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m3RotatorDetentSwitches_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_m3RotatorDetentSwitches.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_elevationLimitSwitchLower_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_elevationLimitSwitchLower_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_elevationLimitSwitchLower.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_elevationLimitSwitchUpper_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_elevationLimitSwitchUpper_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_elevationLimitSwitchUpper.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthLimitSwitchCCW_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthLimitSwitchCCW_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_azimuthLimitSwitchCCW.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthLimitSwitchCW_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthLimitSwitchCW_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_azimuthLimitSwitchCW.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth1LimitSwitchCCW_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth1LimitSwitchCCW_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_nasmyth1LimitSwitchCCW.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth1LimitSwitchCW_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth1LimitSwitchCW_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_nasmyth1LimitSwitchCW.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth2LimitSwitchCCW_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth2LimitSwitchCCW_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_nasmyth2LimitSwitchCCW.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth2LimitSwitchCW_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth2LimitSwitchCW_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_nasmyth2LimitSwitchCW.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m3RotatorLimitSwitchCCW_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m3RotatorLimitSwitchCCW_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_m3RotatorLimitSwitchCCW.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m3RotatorLimitSwitchCW_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m3RotatorLimitSwitchCW_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_m3RotatorLimitSwitchCW.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_elevationDriveStatus_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_elevationDriveStatus_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_elevationDriveStatus.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthDrive1Status_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthDrive1Status_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_azimuthDrive1Status.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthDrive2Status_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthDrive2Status_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_azimuthDrive2Status.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth1DriveStatus_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth1DriveStatus_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_nasmyth1DriveStatus.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth2DriveStatus_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth2DriveStatus_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_nasmyth2DriveStatus.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m3DriveStatus_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m3DriveStatus_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_m3DriveStatus.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_elevationBrake_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_elevationBrake_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_elevationBrake.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthBrake1_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthBrake1_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_azimuthBrake1.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthBrake2_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthBrake2_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_azimuthBrake2.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth1Brake_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth1Brake_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_nasmyth1Brake.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth2Brake_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth2Brake_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_nasmyth2Brake.hh

Salgen ATMCS LabVIEW
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

Salgen ATMCS Lib
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

Salgen ATMCS RPM
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

Verify ATMCS RPM Contents
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
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_trajectory.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_mount_AzEl_Encoders.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_mount_Nasmyth_Encoders.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_torqueDemand.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_measuredTorque.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_measuredMotorVelocity.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_nasmyth_m3_mountMotorEncoders.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_azEl_mountMotorEncoders.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_disable.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_enable.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_exitControl.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_setLogLevel.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_standby.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_start.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_startTracking.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_trackTarget.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_setInstrumentPort.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_stopTracking.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_heartbeat.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_logLevel.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_logMessage.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_softwareVersions.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_errorCode.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_simulationMode.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_summaryState.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_configurationApplied.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_configurationsAvailable.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_detailedState.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_atMountState.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_m3State.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_m3PortSelected.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_positionLimits.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_target.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_elevationInPosition.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_azimuthInPosition.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_nasmyth1RotatorInPosition.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_nasmyth2RotatorInPosition.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_m3InPosition.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_allAxesInPosition.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_azimuthToppleBlockCCW.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_azimuthToppleBlockCW.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_m3RotatorDetentSwitches.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_elevationLimitSwitchLower.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_elevationLimitSwitchUpper.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_azimuthLimitSwitchCCW.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_azimuthLimitSwitchCW.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_nasmyth1LimitSwitchCCW.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_nasmyth1LimitSwitchCW.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_nasmyth2LimitSwitchCCW.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_nasmyth2LimitSwitchCW.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_m3RotatorLimitSwitchCCW.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_m3RotatorLimitSwitchCW.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_elevationDriveStatus.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_azimuthDrive1Status.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_azimuthDrive2Status.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_nasmyth1DriveStatus.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_nasmyth2DriveStatus.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_m3DriveStatus.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_elevationBrake.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_azimuthBrake1.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_azimuthBrake2.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_nasmyth1Brake.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_nasmyth2Brake.hh
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

Verify ATMCS TEST RPM Contents
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
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_startTracking_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_startTracking_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_trackTarget_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_trackTarget_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_setInstrumentPort_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_setInstrumentPort_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_stopTracking_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_stopTracking_controller
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
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_detailedState_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_detailedState_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_atMountState_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_atMountState_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_m3State_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_m3State_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_m3PortSelected_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_m3PortSelected_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_positionLimits_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_positionLimits_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_target_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_target_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_elevationInPosition_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_elevationInPosition_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_azimuthInPosition_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_azimuthInPosition_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_nasmyth1RotatorInPosition_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_nasmyth1RotatorInPosition_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_nasmyth2RotatorInPosition_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_nasmyth2RotatorInPosition_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_m3InPosition_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_m3InPosition_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_allAxesInPosition_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_allAxesInPosition_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_azimuthToppleBlockCCW_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_azimuthToppleBlockCCW_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_azimuthToppleBlockCW_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_azimuthToppleBlockCW_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_m3RotatorDetentSwitches_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_m3RotatorDetentSwitches_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_elevationLimitSwitchLower_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_elevationLimitSwitchLower_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_elevationLimitSwitchUpper_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_elevationLimitSwitchUpper_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_azimuthLimitSwitchCCW_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_azimuthLimitSwitchCCW_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_azimuthLimitSwitchCW_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_azimuthLimitSwitchCW_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_nasmyth1LimitSwitchCCW_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_nasmyth1LimitSwitchCCW_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_nasmyth1LimitSwitchCW_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_nasmyth1LimitSwitchCW_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_nasmyth2LimitSwitchCCW_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_nasmyth2LimitSwitchCCW_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_nasmyth2LimitSwitchCW_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_nasmyth2LimitSwitchCW_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_m3RotatorLimitSwitchCCW_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_m3RotatorLimitSwitchCCW_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_m3RotatorLimitSwitchCW_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_m3RotatorLimitSwitchCW_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_elevationDriveStatus_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_elevationDriveStatus_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_azimuthDrive1Status_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_azimuthDrive1Status_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_azimuthDrive2Status_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_azimuthDrive2Status_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_nasmyth1DriveStatus_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_nasmyth1DriveStatus_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_nasmyth2DriveStatus_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_nasmyth2DriveStatus_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_m3DriveStatus_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_m3DriveStatus_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_elevationBrake_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_elevationBrake_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_azimuthBrake1_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_azimuthBrake1_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_azimuthBrake2_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_azimuthBrake2_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_nasmyth1Brake_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_nasmyth1Brake_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_nasmyth2Brake_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_nasmyth2Brake_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_trajectory_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_trajectory_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_mount_AzEl_Encoders_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_mount_AzEl_Encoders_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_mount_Nasmyth_Encoders_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_mount_Nasmyth_Encoders_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_torqueDemand_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_torqueDemand_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_measuredTorque_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_measuredTorque_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_measuredMotorVelocity_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_measuredMotorVelocity_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_nasmyth_m3_mountMotorEncoders_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_nasmyth_m3_mountMotorEncoders_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_azEl_mountMotorEncoders_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_azEl_mountMotorEncoders_subscriber

Cleanup stdout and stderr Files
    [Tags]
    Remove Files    ${EXECDIR}${/}${subSystem}_stdout.txt    ${EXECDIR}${/}${subSystem}_stderr.txt

