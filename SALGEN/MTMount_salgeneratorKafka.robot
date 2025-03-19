*** Settings ***
Documentation    This suite builds the various interfaces for the MTMount.
Force Tags    salgen    mtmount
Suite Setup    Log Many    ${Host}    ${subSystem}    ${timeout}
Library    OperatingSystem
Library    Process
Resource    ../Global_Vars.resource

*** Variables ***
${subSystem}    MTMount
${timeout}    1200s

*** Test Cases ***
Verify MTMount XML Defintions exist
    [Tags]    validate
    Comment    Verify the CSC XML definition files exist.
    ${output}    Run Process    ls    ${SALWorkDir}/${subSystem}_*xml    shell=True
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Be Empty    ${output.stdout}
    File Should Exist    ${SALWorkDir}/MTMount_Commands.xml
    File Should Exist    ${SALWorkDir}/MTMount_Events.xml
    File Should Exist    ${SALWorkDir}/MTMount_Telemetry.xml

Salgen MTMount Validate
    [Documentation]    Validate the MTMount XML definitions.
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
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_closeMirrorCovers.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_openMirrorCovers.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_disableCameraCableWrapFollowing.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_enableCameraCableWrapFollowing.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_homeBothAxes.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_park.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_unpark.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_restoreDefaultSettings.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_applySettingsSet.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_moveToTarget.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_setThermal.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_startTracking.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_trackTarget.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_stopTracking.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_stop.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_clearError.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_lockMotion.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_unlockMotion.json
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
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_availableSettings.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_controllerSettingsName.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_azimuthControllerSettings.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_elevationControllerSettings.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_cameraCableWrapControllerSettings.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_azimuthHomed.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_elevationHomed.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_azimuthSystemState.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_elevationSystemState.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_cameraCableWrapSystemState.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_balanceSystemState.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_mirrorCoversSystemState.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_mirrorCoverLocksSystemState.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_azimuthCableWrapSystemState.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_lockingPinsSystemState.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_deployablePlatformsSystemState.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_oilSupplySystemState.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_azimuthDrivesThermalSystemState.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_elevationDrivesThermalSystemState.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_cabinet0101ThermalSystemState.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_auxiliaryCabinetsThermalSystemState.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_mainCabinetThermalSystemState.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_mainAxesPowerSupplySystemState.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_topEndChillerSystemState.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_elevationInPosition.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_azimuthInPosition.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_cameraCableWrapInPosition.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_elevationMotionState.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_azimuthMotionState.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_cameraCableWrapMotionState.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_elevationLimits.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_azimuthLimits.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_cameraCableWrapLimits.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_azimuthToppleBlock.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_cameraCableWrapFollowing.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_cameraCableWrapTarget.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_commander.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_connected.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_telemetryConnected.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_deployablePlatformsMotionState.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_elevationLockingPinMotionState.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_error.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_mirrorCoverLocksMotionState.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_mirrorCoversMotionState.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_safetyInterlocks.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_target.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_warning.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_motionLockState.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_telemetryClientHeartbeat.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_azimuth.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_safetySystem.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_elevation.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_lockingPins.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_deployablePlatforms.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_cabinet0101Thermal.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_azimuthCableWrap.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_cameraCableWrap.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_balancing.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_azimuthDrives.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_azimuthDrivesThermal.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_elevationDrives.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_elevationDrivesThermal.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_encoder.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_mainCabinetThermal.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_mirrorCoverLocks.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_mirrorCover.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_mainPowerSupply.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_topEndChiller.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_auxiliaryCabinetsThermal.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_oilSupplySystem.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_compressedAir.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_cooling.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_dynaleneCooling.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_generalPurposeGlycolWater.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_capacitorBank.json/

Salgen MTMount C++
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
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain X Times    ${output.stdout}    cpp : Done Publisher    27
    Should Contain X Times    ${output.stdout}    cpp : Done Subscriber    27
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

Verify MTMount Telemetry directories
    [Tags]    cpp
    @{files}=    List Directory    ${SALWorkDir}    pattern=*${subSystem}*
    Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/${subSystem}_telemetryClientHeartbeat
    Directory Should Exist    ${SALWorkDir}/${subSystem}_azimuth
    Directory Should Exist    ${SALWorkDir}/${subSystem}_safetySystem
    Directory Should Exist    ${SALWorkDir}/${subSystem}_elevation
    Directory Should Exist    ${SALWorkDir}/${subSystem}_lockingPins
    Directory Should Exist    ${SALWorkDir}/${subSystem}_deployablePlatforms
    Directory Should Exist    ${SALWorkDir}/${subSystem}_cabinet0101Thermal
    Directory Should Exist    ${SALWorkDir}/${subSystem}_azimuthCableWrap
    Directory Should Exist    ${SALWorkDir}/${subSystem}_cameraCableWrap
    Directory Should Exist    ${SALWorkDir}/${subSystem}_balancing
    Directory Should Exist    ${SALWorkDir}/${subSystem}_azimuthDrives
    Directory Should Exist    ${SALWorkDir}/${subSystem}_azimuthDrivesThermal
    Directory Should Exist    ${SALWorkDir}/${subSystem}_elevationDrives
    Directory Should Exist    ${SALWorkDir}/${subSystem}_elevationDrivesThermal
    Directory Should Exist    ${SALWorkDir}/${subSystem}_encoder
    Directory Should Exist    ${SALWorkDir}/${subSystem}_mainCabinetThermal
    Directory Should Exist    ${SALWorkDir}/${subSystem}_mirrorCoverLocks
    Directory Should Exist    ${SALWorkDir}/${subSystem}_mirrorCover
    Directory Should Exist    ${SALWorkDir}/${subSystem}_mainPowerSupply
    Directory Should Exist    ${SALWorkDir}/${subSystem}_topEndChiller
    Directory Should Exist    ${SALWorkDir}/${subSystem}_auxiliaryCabinetsThermal
    Directory Should Exist    ${SALWorkDir}/${subSystem}_oilSupplySystem
    Directory Should Exist    ${SALWorkDir}/${subSystem}_compressedAir
    Directory Should Exist    ${SALWorkDir}/${subSystem}_cooling
    Directory Should Exist    ${SALWorkDir}/${subSystem}_dynaleneCooling
    Directory Should Exist    ${SALWorkDir}/${subSystem}_generalPurposeGlycolWater
    Directory Should Exist    ${SALWorkDir}/${subSystem}_capacitorBank

Verify MTMount C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}_telemetryClientHeartbeat/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_telemetryClientHeartbeat/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_telemetryClientHeartbeat.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_azimuth/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_azimuth/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_azimuth.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_safetySystem/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_safetySystem/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_safetySystem.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_elevation/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_elevation/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_elevation.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_lockingPins/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_lockingPins/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_lockingPins.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_deployablePlatforms/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_deployablePlatforms/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_deployablePlatforms.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_cabinet0101Thermal/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_cabinet0101Thermal/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_cabinet0101Thermal.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_azimuthCableWrap/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_azimuthCableWrap/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_azimuthCableWrap.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_cameraCableWrap/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_cameraCableWrap/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_cameraCableWrap.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_balancing/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_balancing/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_balancing.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_azimuthDrives/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_azimuthDrives/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_azimuthDrives.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_azimuthDrivesThermal/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_azimuthDrivesThermal/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_azimuthDrivesThermal.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_elevationDrives/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_elevationDrives/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_elevationDrives.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_elevationDrivesThermal/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_elevationDrivesThermal/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_elevationDrivesThermal.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_encoder/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_encoder/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_encoder.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_mainCabinetThermal/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_mainCabinetThermal/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_mainCabinetThermal.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_mirrorCoverLocks/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_mirrorCoverLocks/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_mirrorCoverLocks.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_mirrorCover/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_mirrorCover/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_mirrorCover.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_mainPowerSupply/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_mainPowerSupply/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_mainPowerSupply.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_topEndChiller/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_topEndChiller/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_topEndChiller.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_auxiliaryCabinetsThermal/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_auxiliaryCabinetsThermal/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_auxiliaryCabinetsThermal.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_oilSupplySystem/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_oilSupplySystem/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_oilSupplySystem.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_compressedAir/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_compressedAir/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_compressedAir.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_cooling/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_cooling/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_cooling.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_dynaleneCooling/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_dynaleneCooling/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_dynaleneCooling.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_generalPurposeGlycolWater/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_generalPurposeGlycolWater/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_generalPurposeGlycolWater.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_capacitorBank/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_capacitorBank/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_capacitorBank.hh

Verify MTMount C++ Command Interfaces
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
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_closeMirrorCovers_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_closeMirrorCovers_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_closeMirrorCovers.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_openMirrorCovers_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_openMirrorCovers_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_openMirrorCovers.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_disableCameraCableWrapFollowing_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_disableCameraCableWrapFollowing_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_disableCameraCableWrapFollowing.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enableCameraCableWrapFollowing_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enableCameraCableWrapFollowing_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_enableCameraCableWrapFollowing.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_homeBothAxes_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_homeBothAxes_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_homeBothAxes.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_park_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_park_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_park.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_unpark_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_unpark_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_unpark.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_restoreDefaultSettings_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_restoreDefaultSettings_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_restoreDefaultSettings.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_applySettingsSet_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_applySettingsSet_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_applySettingsSet.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_moveToTarget_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_moveToTarget_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_moveToTarget.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setThermal_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setThermal_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_setThermal.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startTracking_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startTracking_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_startTracking.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_trackTarget_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_trackTarget_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_trackTarget.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_stopTracking_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_stopTracking_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_stopTracking.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_stop_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_stop_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_stop.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_clearError_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_clearError_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_clearError.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_lockMotion_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_lockMotion_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_lockMotion.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_unlockMotion_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_unlockMotion_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_unlockMotion.hh

Verify MTMount C++ Event Interfaces
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
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_availableSettings_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_availableSettings_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_availableSettings.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_controllerSettingsName_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_controllerSettingsName_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_controllerSettingsName.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthControllerSettings_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthControllerSettings_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_azimuthControllerSettings.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_elevationControllerSettings_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_elevationControllerSettings_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_elevationControllerSettings.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_cameraCableWrapControllerSettings_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_cameraCableWrapControllerSettings_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_cameraCableWrapControllerSettings.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthHomed_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthHomed_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_azimuthHomed.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_elevationHomed_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_elevationHomed_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_elevationHomed.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthSystemState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthSystemState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_azimuthSystemState.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_elevationSystemState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_elevationSystemState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_elevationSystemState.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_cameraCableWrapSystemState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_cameraCableWrapSystemState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_cameraCableWrapSystemState.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_balanceSystemState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_balanceSystemState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_balanceSystemState.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_mirrorCoversSystemState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_mirrorCoversSystemState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_mirrorCoversSystemState.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_mirrorCoverLocksSystemState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_mirrorCoverLocksSystemState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_mirrorCoverLocksSystemState.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthCableWrapSystemState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthCableWrapSystemState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_azimuthCableWrapSystemState.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_lockingPinsSystemState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_lockingPinsSystemState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_lockingPinsSystemState.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_deployablePlatformsSystemState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_deployablePlatformsSystemState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_deployablePlatformsSystemState.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_oilSupplySystemState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_oilSupplySystemState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_oilSupplySystemState.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthDrivesThermalSystemState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthDrivesThermalSystemState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_azimuthDrivesThermalSystemState.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_elevationDrivesThermalSystemState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_elevationDrivesThermalSystemState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_elevationDrivesThermalSystemState.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_cabinet0101ThermalSystemState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_cabinet0101ThermalSystemState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_cabinet0101ThermalSystemState.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_auxiliaryCabinetsThermalSystemState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_auxiliaryCabinetsThermalSystemState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_auxiliaryCabinetsThermalSystemState.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_mainCabinetThermalSystemState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_mainCabinetThermalSystemState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_mainCabinetThermalSystemState.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_mainAxesPowerSupplySystemState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_mainAxesPowerSupplySystemState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_mainAxesPowerSupplySystemState.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_topEndChillerSystemState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_topEndChillerSystemState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_topEndChillerSystemState.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_elevationInPosition_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_elevationInPosition_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_elevationInPosition.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthInPosition_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthInPosition_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_azimuthInPosition.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_cameraCableWrapInPosition_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_cameraCableWrapInPosition_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_cameraCableWrapInPosition.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_elevationMotionState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_elevationMotionState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_elevationMotionState.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthMotionState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthMotionState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_azimuthMotionState.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_cameraCableWrapMotionState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_cameraCableWrapMotionState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_cameraCableWrapMotionState.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_elevationLimits_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_elevationLimits_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_elevationLimits.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthLimits_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthLimits_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_azimuthLimits.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_cameraCableWrapLimits_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_cameraCableWrapLimits_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_cameraCableWrapLimits.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthToppleBlock_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthToppleBlock_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_azimuthToppleBlock.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_cameraCableWrapFollowing_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_cameraCableWrapFollowing_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_cameraCableWrapFollowing.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_cameraCableWrapTarget_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_cameraCableWrapTarget_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_cameraCableWrapTarget.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_commander_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_commander_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_commander.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_connected_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_connected_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_connected.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_telemetryConnected_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_telemetryConnected_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_telemetryConnected.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_deployablePlatformsMotionState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_deployablePlatformsMotionState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_deployablePlatformsMotionState.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_elevationLockingPinMotionState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_elevationLockingPinMotionState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_elevationLockingPinMotionState.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_error_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_error_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_error.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_mirrorCoverLocksMotionState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_mirrorCoverLocksMotionState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_mirrorCoverLocksMotionState.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_mirrorCoversMotionState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_mirrorCoversMotionState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_mirrorCoversMotionState.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_safetyInterlocks_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_safetyInterlocks_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_safetyInterlocks.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_target_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_target_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_target.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_warning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_warning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_warning.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_motionLockState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_motionLockState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_motionLockState.hh

Salgen MTMount Java
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
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_telemetryClientHeartbeat.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_telemetryClientHeartbeat.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_azimuth.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_azimuth.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_safetySystem.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_safetySystem.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_elevation.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_elevation.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_lockingPins.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_lockingPins.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_deployablePlatforms.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_deployablePlatforms.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_cabinet0101Thermal.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_cabinet0101Thermal.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_azimuthCableWrap.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_azimuthCableWrap.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_cameraCableWrap.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_cameraCableWrap.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_balancing.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_balancing.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_azimuthDrives.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_azimuthDrives.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_azimuthDrivesThermal.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_azimuthDrivesThermal.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_elevationDrives.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_elevationDrives.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_elevationDrivesThermal.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_elevationDrivesThermal.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_encoder.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_encoder.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_mainCabinetThermal.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_mainCabinetThermal.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_mirrorCoverLocks.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_mirrorCoverLocks.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_mirrorCover.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_mirrorCover.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_mainPowerSupply.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_mainPowerSupply.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_topEndChiller.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_topEndChiller.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_auxiliaryCabinetsThermal.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_auxiliaryCabinetsThermal.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_oilSupplySystem.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_oilSupplySystem.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_compressedAir.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_compressedAir.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_cooling.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_cooling.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_dynaleneCooling.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_dynaleneCooling.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_generalPurposeGlycolWater.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_generalPurposeGlycolWater.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_capacitorBank.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_capacitorBank.hh to sal_${subSystem} code fragments
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
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_clockOffset.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_clockOffset.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_availableSettings.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_availableSettings.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_controllerSettingsName.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_controllerSettingsName.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_azimuthControllerSettings.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_azimuthControllerSettings.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_elevationControllerSettings.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_elevationControllerSettings.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_cameraCableWrapControllerSettings.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_cameraCableWrapControllerSettings.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_azimuthHomed.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_azimuthHomed.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_elevationHomed.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_elevationHomed.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_azimuthSystemState.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_azimuthSystemState.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_elevationSystemState.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_elevationSystemState.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_cameraCableWrapSystemState.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_cameraCableWrapSystemState.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_balanceSystemState.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_balanceSystemState.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_mirrorCoversSystemState.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_mirrorCoversSystemState.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_mirrorCoverLocksSystemState.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_mirrorCoverLocksSystemState.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_azimuthCableWrapSystemState.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_azimuthCableWrapSystemState.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_lockingPinsSystemState.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_lockingPinsSystemState.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_deployablePlatformsSystemState.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_deployablePlatformsSystemState.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_oilSupplySystemState.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_oilSupplySystemState.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_azimuthDrivesThermalSystemState.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_azimuthDrivesThermalSystemState.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_elevationDrivesThermalSystemState.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_elevationDrivesThermalSystemState.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_cabinet0101ThermalSystemState.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_cabinet0101ThermalSystemState.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_auxiliaryCabinetsThermalSystemState.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_auxiliaryCabinetsThermalSystemState.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_mainCabinetThermalSystemState.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_mainCabinetThermalSystemState.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_mainAxesPowerSupplySystemState.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_mainAxesPowerSupplySystemState.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_topEndChillerSystemState.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_topEndChillerSystemState.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_elevationInPosition.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_elevationInPosition.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_azimuthInPosition.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_azimuthInPosition.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_cameraCableWrapInPosition.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_cameraCableWrapInPosition.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_elevationMotionState.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_elevationMotionState.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_azimuthMotionState.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_azimuthMotionState.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_cameraCableWrapMotionState.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_cameraCableWrapMotionState.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_elevationLimits.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_elevationLimits.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_azimuthLimits.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_azimuthLimits.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_cameraCableWrapLimits.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_cameraCableWrapLimits.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_azimuthToppleBlock.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_azimuthToppleBlock.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_cameraCableWrapFollowing.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_cameraCableWrapFollowing.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_cameraCableWrapTarget.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_cameraCableWrapTarget.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_commander.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_commander.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_connected.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_connected.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_telemetryConnected.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_telemetryConnected.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_deployablePlatformsMotionState.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_deployablePlatformsMotionState.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_elevationLockingPinMotionState.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_elevationLockingPinMotionState.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_error.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_error.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_mirrorCoverLocksMotionState.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_mirrorCoverLocksMotionState.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_mirrorCoversMotionState.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_mirrorCoversMotionState.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_safetyInterlocks.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_safetyInterlocks.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_target.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_target.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_warning.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_warning.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_motionLockState.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_motionLockState.hh to sal_${subSystem} code fragments
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
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_closeMirrorCovers.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_closeMirrorCovers.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_openMirrorCovers.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_openMirrorCovers.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_disableCameraCableWrapFollowing.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_disableCameraCableWrapFollowing.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_enableCameraCableWrapFollowing.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_enableCameraCableWrapFollowing.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_homeBothAxes.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_homeBothAxes.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_park.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_park.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_unpark.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_unpark.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_restoreDefaultSettings.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_restoreDefaultSettings.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_applySettingsSet.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_applySettingsSet.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_moveToTarget.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_moveToTarget.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_setThermal.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_setThermal.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_startTracking.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_startTracking.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_trackTarget.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_trackTarget.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_stopTracking.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_stopTracking.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_stop.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_stop.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_clearError.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_clearError.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_lockMotion.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_lockMotion.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_unlockMotion.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_unlockMotion.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Configuring ${subSystem}/java/src/org/lsst/sal/SAL_${subSystem}.java
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/saj_${subSystem}_types.jar
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/org/lsst/sal/SAL_${subSystem}.java
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/org/lsst/sal/salActor.java
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/org/lsst/sal/salUtils.java
    File Should Exist    ${SALWorkDir}/salUtils/libsalUtils.so
    File Should Exist    ${SALWorkDir}/lib/org/lsst/sal/salUtils.class 

Salgen MTMount Maven
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

Salgen MTMount Lib
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
    File Should Exist    ${SALWorkDir}/lib/libSAL_${subSystem}.so
    File Should Exist    ${SALWorkDir}/lib/libsalUtils.so
    File Should Exist    ${SALWorkDir}/lib/org/lsst/sal/salUtils.class 
    File Should Exist    ${SALWorkDir}/lib/saj_${subSystem}_types.jar

Salgen MTMount RPM
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

Verify MTMount RPM Contents
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
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_closeMirrorCovers.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_openMirrorCovers.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_disableCameraCableWrapFollowing.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_enableCameraCableWrapFollowing.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_homeBothAxes.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_park.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_unpark.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_restoreDefaultSettings.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_applySettingsSet.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_moveToTarget.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_setThermal.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_startTracking.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_trackTarget.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_stopTracking.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_stop.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_clearError.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_lockMotion.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_unlockMotion.json
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
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_availableSettings.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_controllerSettingsName.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_azimuthControllerSettings.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_elevationControllerSettings.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_cameraCableWrapControllerSettings.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_azimuthHomed.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_elevationHomed.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_azimuthSystemState.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_elevationSystemState.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_cameraCableWrapSystemState.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_balanceSystemState.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_mirrorCoversSystemState.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_mirrorCoverLocksSystemState.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_azimuthCableWrapSystemState.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_lockingPinsSystemState.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_deployablePlatformsSystemState.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_oilSupplySystemState.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_azimuthDrivesThermalSystemState.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_elevationDrivesThermalSystemState.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_cabinet0101ThermalSystemState.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_auxiliaryCabinetsThermalSystemState.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_mainCabinetThermalSystemState.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_mainAxesPowerSupplySystemState.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_topEndChillerSystemState.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_elevationInPosition.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_azimuthInPosition.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_cameraCableWrapInPosition.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_elevationMotionState.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_azimuthMotionState.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_cameraCableWrapMotionState.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_elevationLimits.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_azimuthLimits.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_cameraCableWrapLimits.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_azimuthToppleBlock.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_cameraCableWrapFollowing.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_cameraCableWrapTarget.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_commander.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_connected.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_telemetryConnected.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_deployablePlatformsMotionState.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_elevationLockingPinMotionState.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_error.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_mirrorCoverLocksMotionState.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_mirrorCoversMotionState.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_safetyInterlocks.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_target.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_warning.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_motionLockState.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_telemetryClientHeartbeat.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_azimuth.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_safetySystem.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_elevation.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_lockingPins.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_deployablePlatforms.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_cabinet0101Thermal.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_azimuthCableWrap.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_cameraCableWrap.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_balancing.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_azimuthDrives.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_azimuthDrivesThermal.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_elevationDrives.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_elevationDrivesThermal.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_encoder.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_mainCabinetThermal.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_mirrorCoverLocks.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_mirrorCover.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_mainPowerSupply.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_topEndChiller.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_auxiliaryCabinetsThermal.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_oilSupplySystem.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_compressedAir.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_cooling.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_dynaleneCooling.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_generalPurposeGlycolWater.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_capacitorBank.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/lib/libSAL_${subSystem}.a
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/lib/libSAL_${subSystem}.so
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/SAL_${subSystem}.h
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_ackcmd.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_telemetryClientHeartbeat.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_azimuth.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_safetySystem.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_elevation.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_lockingPins.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_deployablePlatforms.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_cabinet0101Thermal.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_azimuthCableWrap.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_cameraCableWrap.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_balancing.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_azimuthDrives.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_azimuthDrivesThermal.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_elevationDrives.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_elevationDrivesThermal.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_encoder.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_mainCabinetThermal.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_mirrorCoverLocks.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_mirrorCover.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_mainPowerSupply.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_topEndChiller.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_auxiliaryCabinetsThermal.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_oilSupplySystem.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_compressedAir.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_cooling.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_dynaleneCooling.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_generalPurposeGlycolWater.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_capacitorBank.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_disable.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_enable.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_exitControl.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_setLogLevel.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_standby.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_start.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_closeMirrorCovers.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_openMirrorCovers.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_disableCameraCableWrapFollowing.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_enableCameraCableWrapFollowing.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_homeBothAxes.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_park.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_unpark.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_restoreDefaultSettings.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_applySettingsSet.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_moveToTarget.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_setThermal.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_startTracking.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_trackTarget.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_stopTracking.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_stop.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_clearError.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_lockMotion.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_unlockMotion.hh
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
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_availableSettings.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_controllerSettingsName.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_azimuthControllerSettings.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_elevationControllerSettings.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_cameraCableWrapControllerSettings.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_azimuthHomed.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_elevationHomed.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_azimuthSystemState.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_elevationSystemState.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_cameraCableWrapSystemState.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_balanceSystemState.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_mirrorCoversSystemState.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_mirrorCoverLocksSystemState.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_azimuthCableWrapSystemState.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_lockingPinsSystemState.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_deployablePlatformsSystemState.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_oilSupplySystemState.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_azimuthDrivesThermalSystemState.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_elevationDrivesThermalSystemState.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_cabinet0101ThermalSystemState.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_auxiliaryCabinetsThermalSystemState.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_mainCabinetThermalSystemState.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_mainAxesPowerSupplySystemState.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_topEndChillerSystemState.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_elevationInPosition.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_azimuthInPosition.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_cameraCableWrapInPosition.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_elevationMotionState.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_azimuthMotionState.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_cameraCableWrapMotionState.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_elevationLimits.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_azimuthLimits.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_cameraCableWrapLimits.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_azimuthToppleBlock.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_cameraCableWrapFollowing.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_cameraCableWrapTarget.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_commander.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_connected.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_telemetryConnected.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_deployablePlatformsMotionState.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_elevationLockingPinMotionState.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_error.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_mirrorCoverLocksMotionState.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_mirrorCoversMotionState.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_safetyInterlocks.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_target.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_warning.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_motionLockState.hh
    Comment    Verify the interface definition files are included.
    Should Contain    ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Generics.xml
    Should Contain    ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Commands.xml
    Should Contain    ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Commands.html
    Should Contain    ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Events.xml
    Should Contain    ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Events.html
    Should Contain    ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Telemetry.xml
    Should Contain    ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Telemetry.html

Verify MTMount TEST RPM Contents
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
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_closeMirrorCovers_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_closeMirrorCovers_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_openMirrorCovers_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_openMirrorCovers_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_disableCameraCableWrapFollowing_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_disableCameraCableWrapFollowing_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_enableCameraCableWrapFollowing_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_enableCameraCableWrapFollowing_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_homeBothAxes_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_homeBothAxes_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_park_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_park_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_unpark_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_unpark_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_restoreDefaultSettings_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_restoreDefaultSettings_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_applySettingsSet_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_applySettingsSet_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_moveToTarget_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_moveToTarget_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_setThermal_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_setThermal_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_startTracking_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_startTracking_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_trackTarget_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_trackTarget_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_stopTracking_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_stopTracking_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_stop_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_stop_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_clearError_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_clearError_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_lockMotion_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_lockMotion_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_unlockMotion_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_unlockMotion_controller
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
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_availableSettings_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_availableSettings_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_controllerSettingsName_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_controllerSettingsName_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_azimuthControllerSettings_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_azimuthControllerSettings_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_elevationControllerSettings_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_elevationControllerSettings_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_cameraCableWrapControllerSettings_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_cameraCableWrapControllerSettings_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_azimuthHomed_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_azimuthHomed_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_elevationHomed_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_elevationHomed_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_azimuthSystemState_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_azimuthSystemState_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_elevationSystemState_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_elevationSystemState_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_cameraCableWrapSystemState_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_cameraCableWrapSystemState_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_balanceSystemState_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_balanceSystemState_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_mirrorCoversSystemState_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_mirrorCoversSystemState_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_mirrorCoverLocksSystemState_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_mirrorCoverLocksSystemState_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_azimuthCableWrapSystemState_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_azimuthCableWrapSystemState_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_lockingPinsSystemState_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_lockingPinsSystemState_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_deployablePlatformsSystemState_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_deployablePlatformsSystemState_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_oilSupplySystemState_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_oilSupplySystemState_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_azimuthDrivesThermalSystemState_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_azimuthDrivesThermalSystemState_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_elevationDrivesThermalSystemState_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_elevationDrivesThermalSystemState_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_cabinet0101ThermalSystemState_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_cabinet0101ThermalSystemState_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_auxiliaryCabinetsThermalSystemState_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_auxiliaryCabinetsThermalSystemState_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_mainCabinetThermalSystemState_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_mainCabinetThermalSystemState_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_mainAxesPowerSupplySystemState_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_mainAxesPowerSupplySystemState_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_topEndChillerSystemState_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_topEndChillerSystemState_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_elevationInPosition_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_elevationInPosition_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_azimuthInPosition_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_azimuthInPosition_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_cameraCableWrapInPosition_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_cameraCableWrapInPosition_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_elevationMotionState_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_elevationMotionState_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_azimuthMotionState_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_azimuthMotionState_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_cameraCableWrapMotionState_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_cameraCableWrapMotionState_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_elevationLimits_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_elevationLimits_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_azimuthLimits_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_azimuthLimits_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_cameraCableWrapLimits_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_cameraCableWrapLimits_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_azimuthToppleBlock_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_azimuthToppleBlock_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_cameraCableWrapFollowing_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_cameraCableWrapFollowing_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_cameraCableWrapTarget_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_cameraCableWrapTarget_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_commander_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_commander_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_connected_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_connected_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_telemetryConnected_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_telemetryConnected_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_deployablePlatformsMotionState_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_deployablePlatformsMotionState_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_elevationLockingPinMotionState_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_elevationLockingPinMotionState_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_error_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_error_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_mirrorCoverLocksMotionState_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_mirrorCoverLocksMotionState_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_mirrorCoversMotionState_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_mirrorCoversMotionState_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_safetyInterlocks_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_safetyInterlocks_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_target_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_target_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_warning_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_warning_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_motionLockState_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_motionLockState_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_telemetryClientHeartbeat_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_telemetryClientHeartbeat_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_azimuth_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_azimuth_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_safetySystem_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_safetySystem_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_elevation_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_elevation_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_lockingPins_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_lockingPins_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_deployablePlatforms_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_deployablePlatforms_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_cabinet0101Thermal_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_cabinet0101Thermal_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_azimuthCableWrap_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_azimuthCableWrap_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_cameraCableWrap_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_cameraCableWrap_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_balancing_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_balancing_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_azimuthDrives_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_azimuthDrives_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_azimuthDrivesThermal_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_azimuthDrivesThermal_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_elevationDrives_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_elevationDrives_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_elevationDrivesThermal_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_elevationDrivesThermal_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_encoder_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_encoder_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_mainCabinetThermal_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_mainCabinetThermal_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_mirrorCoverLocks_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_mirrorCoverLocks_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_mirrorCover_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_mirrorCover_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_mainPowerSupply_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_mainPowerSupply_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_topEndChiller_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_topEndChiller_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_auxiliaryCabinetsThermal_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_auxiliaryCabinetsThermal_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_oilSupplySystem_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_oilSupplySystem_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_compressedAir_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_compressedAir_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_cooling_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_cooling_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_dynaleneCooling_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_dynaleneCooling_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_generalPurposeGlycolWater_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_generalPurposeGlycolWater_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_capacitorBank_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_capacitorBank_subscriber

Cleanup stdout and stderr Files
    [Tags]
    Remove Files    ${EXECDIR}${/}${subSystem}_stdout.txt    ${EXECDIR}${/}${subSystem}_stderr.txt

