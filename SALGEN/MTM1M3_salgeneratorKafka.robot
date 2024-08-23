*** Settings ***
Documentation    This suite builds the various interfaces for the MTM1M3.
Force Tags    salgen    mtm1m3
Suite Setup    Log Many    ${Host}    ${subSystem}    ${timeout}
Library    OperatingSystem
Library    Process
Resource    ../Global_Vars.resource

*** Variables ***
${subSystem}    MTM1M3
${timeout}    1200s

*** Test Cases ***
Verify MTM1M3 XML Defintions exist
    [Tags]    validate
    Comment    Verify the CSC XML definition files exist.
    ${output}    Run Process    ls    ${SALWorkDir}/${subSystem}_*xml    shell=True
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Be Empty    ${output.stdout}
    File Should Exist    ${SALWorkDir}/MTM1M3_Commands.xml
    File Should Exist    ${SALWorkDir}/MTM1M3_Events.xml
    File Should Exist    ${SALWorkDir}/MTM1M3_Telemetry.xml

Salgen MTM1M3 Validate
    [Documentation]    Validate the MTM1M3 XML definitions.
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
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_field_enums.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_global_enums.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_disable.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_enable.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_exitControl.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_setLogLevel.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_standby.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_start.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_panic.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_setSlewFlag.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_clearSlewFlag.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_raiseM1M3.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_abortRaiseM1M3.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_lowerM1M3.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_pauseM1M3RaisingLowering.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_resumeM1M3RaisingLowering.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_enterEngineering.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_exitEngineering.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_turnAirOn.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_turnAirOff.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_boosterValveOpen.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_boosterValveClose.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_moveHardpointActuators.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_stopHardpointMotion.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_testHardpoint.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_killHardpointTest.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_enableHardpointChase.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_disableHardpointChase.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_applyOffsetForces.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_translateM1M3.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_clearOffsetForces.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_applyActiveOpticForces.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_clearActiveOpticForces.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_positionM1M3.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_turnLightsOn.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_turnLightsOff.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_turnPowerOn.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_turnPowerOff.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_enableHardpointCorrections.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_disableHardpointCorrections.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_runMirrorForceProfile.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_abortProfile.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_applyOffsetForcesByMirrorForce.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_updatePID.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_resetPID.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_forceActuatorBumpTest.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_killForceActuatorBumpTest.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_disableForceActuator.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_enableForceActuator.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_enableAllForceActuators.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_enableDisableForceComponent.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_setSlewControllerSettings.json
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
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_hardpointActuatorInfo.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_forceActuatorInfo.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_ilcWarning.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_interlockWarning.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_airSupplyStatus.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_airSupplyWarning.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_interlockStatus.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_displacementSensorWarning.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_inclinometerSensorWarning.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_accelerometerWarning.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_forceSetpointWarning.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_raisingLoweringInfo.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_boosterValveSettings.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_boosterValveStatus.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_forceActuatorState.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_forceControllerState.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_slewControllerSettings.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_hardpointMonitorInfo.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_cellLightStatus.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_cellLightWarning.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_powerStatus.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_powerWarning.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_forceActuatorForceWarning.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_forceActuatorFollowingErrorCounter.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_gyroWarning.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_powerSupplyStatus.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_appliedOffsetForces.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_appliedStaticForces.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_appliedActiveOpticForces.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_commandRejectionWarning.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pidInfo.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_hardpointActuatorWarning.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_hardpointMonitorWarning.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_hardpointActuatorState.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_hardpointMonitorState.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_forceActuatorWarning.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_preclippedStaticForces.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_preclippedElevationForces.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_preclippedAzimuthForces.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_preclippedThermalForces.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_preclippedActiveOpticForces.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_preclippedVelocityForces.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_preclippedAccelerationForces.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_preclippedBalanceForces.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_preclippedOffsetForces.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_preclippedForces.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_preclippedCylinderForces.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_forceActuatorBumpTestStatus.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_hardpointTestStatus.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_enabledForceActuators.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_forceActuatorSettings.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_hardpointActuatorSettings.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_positionControllerSettings.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_displacementSensorSettings.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pidSettings.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_accelerometerSettings.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_gyroSettings.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_inclinometerSettings.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_forceActuatorData.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_inclinometerData.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_outerLoopData.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_accelerometerData.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hardpointActuatorData.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_imsData.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_forceActuatorPressure.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_gyroData.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_powerSupplyData.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_pidData.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hardpointMonitorData.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_appliedAzimuthForces.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_appliedAccelerationForces.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_appliedBalanceForces.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_appliedCylinderForces.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_appliedElevationForces.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_appliedForces.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_appliedThermalForces.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_appliedVelocityForces.json/

Salgen MTM1M3 C++
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
    Should Contain X Times    ${output.stdout}    cpp : Done Publisher    19
    Should Contain X Times    ${output.stdout}    cpp : Done Subscriber    19
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

Verify MTM1M3 Telemetry directories
    [Tags]    cpp
    @{files}=    List Directory    ${SALWorkDir}    pattern=*${subSystem}*
    Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/${subSystem}_forceActuatorData
    Directory Should Exist    ${SALWorkDir}/${subSystem}_inclinometerData
    Directory Should Exist    ${SALWorkDir}/${subSystem}_outerLoopData
    Directory Should Exist    ${SALWorkDir}/${subSystem}_accelerometerData
    Directory Should Exist    ${SALWorkDir}/${subSystem}_hardpointActuatorData
    Directory Should Exist    ${SALWorkDir}/${subSystem}_imsData
    Directory Should Exist    ${SALWorkDir}/${subSystem}_forceActuatorPressure
    Directory Should Exist    ${SALWorkDir}/${subSystem}_gyroData
    Directory Should Exist    ${SALWorkDir}/${subSystem}_powerSupplyData
    Directory Should Exist    ${SALWorkDir}/${subSystem}_pidData
    Directory Should Exist    ${SALWorkDir}/${subSystem}_hardpointMonitorData
    Directory Should Exist    ${SALWorkDir}/${subSystem}_appliedAzimuthForces
    Directory Should Exist    ${SALWorkDir}/${subSystem}_appliedAccelerationForces
    Directory Should Exist    ${SALWorkDir}/${subSystem}_appliedBalanceForces
    Directory Should Exist    ${SALWorkDir}/${subSystem}_appliedCylinderForces
    Directory Should Exist    ${SALWorkDir}/${subSystem}_appliedElevationForces
    Directory Should Exist    ${SALWorkDir}/${subSystem}_appliedForces
    Directory Should Exist    ${SALWorkDir}/${subSystem}_appliedThermalForces
    Directory Should Exist    ${SALWorkDir}/${subSystem}_appliedVelocityForces

Verify MTM1M3 C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}_forceActuatorData/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_forceActuatorData/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_forceActuatorData.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_inclinometerData/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_inclinometerData/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_inclinometerData.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_outerLoopData/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_outerLoopData/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_outerLoopData.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_accelerometerData/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_accelerometerData/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_accelerometerData.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_hardpointActuatorData/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_hardpointActuatorData/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_hardpointActuatorData.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_imsData/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_imsData/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_imsData.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_forceActuatorPressure/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_forceActuatorPressure/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_forceActuatorPressure.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_gyroData/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_gyroData/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_gyroData.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_powerSupplyData/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_powerSupplyData/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_powerSupplyData.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_pidData/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_pidData/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_pidData.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_hardpointMonitorData/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_hardpointMonitorData/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_hardpointMonitorData.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_appliedAzimuthForces/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_appliedAzimuthForces/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_appliedAzimuthForces.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_appliedAccelerationForces/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_appliedAccelerationForces/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_appliedAccelerationForces.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_appliedBalanceForces/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_appliedBalanceForces/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_appliedBalanceForces.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_appliedCylinderForces/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_appliedCylinderForces/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_appliedCylinderForces.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_appliedElevationForces/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_appliedElevationForces/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_appliedElevationForces.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_appliedForces/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_appliedForces/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_appliedForces.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_appliedThermalForces/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_appliedThermalForces/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_appliedThermalForces.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_appliedVelocityForces/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_appliedVelocityForces/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_appliedVelocityForces.hh

Verify MTM1M3 C++ Command Interfaces
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
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_panic_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_panic_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_panic.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setSlewFlag_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setSlewFlag_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_setSlewFlag.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_clearSlewFlag_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_clearSlewFlag_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_clearSlewFlag.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_raiseM1M3_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_raiseM1M3_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_raiseM1M3.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_abortRaiseM1M3_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_abortRaiseM1M3_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_abortRaiseM1M3.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_lowerM1M3_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_lowerM1M3_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_lowerM1M3.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_pauseM1M3RaisingLowering_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_pauseM1M3RaisingLowering_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_pauseM1M3RaisingLowering.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_resumeM1M3RaisingLowering_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_resumeM1M3RaisingLowering_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_resumeM1M3RaisingLowering.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enterEngineering_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enterEngineering_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_enterEngineering.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_exitEngineering_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_exitEngineering_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_exitEngineering.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_turnAirOn_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_turnAirOn_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_turnAirOn.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_turnAirOff_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_turnAirOff_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_turnAirOff.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_boosterValveOpen_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_boosterValveOpen_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_boosterValveOpen.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_boosterValveClose_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_boosterValveClose_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_boosterValveClose.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_moveHardpointActuators_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_moveHardpointActuators_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_moveHardpointActuators.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_stopHardpointMotion_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_stopHardpointMotion_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_stopHardpointMotion.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_testHardpoint_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_testHardpoint_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_testHardpoint.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_killHardpointTest_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_killHardpointTest_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_killHardpointTest.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enableHardpointChase_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enableHardpointChase_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_enableHardpointChase.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_disableHardpointChase_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_disableHardpointChase_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_disableHardpointChase.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_applyOffsetForces_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_applyOffsetForces_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_applyOffsetForces.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_translateM1M3_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_translateM1M3_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_translateM1M3.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_clearOffsetForces_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_clearOffsetForces_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_clearOffsetForces.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_applyActiveOpticForces_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_applyActiveOpticForces_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_applyActiveOpticForces.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_clearActiveOpticForces_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_clearActiveOpticForces_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_clearActiveOpticForces.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_positionM1M3_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_positionM1M3_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_positionM1M3.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_turnLightsOn_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_turnLightsOn_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_turnLightsOn.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_turnLightsOff_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_turnLightsOff_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_turnLightsOff.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_turnPowerOn_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_turnPowerOn_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_turnPowerOn.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_turnPowerOff_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_turnPowerOff_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_turnPowerOff.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enableHardpointCorrections_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enableHardpointCorrections_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_enableHardpointCorrections.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_disableHardpointCorrections_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_disableHardpointCorrections_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_disableHardpointCorrections.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_runMirrorForceProfile_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_runMirrorForceProfile_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_runMirrorForceProfile.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_abortProfile_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_abortProfile_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_abortProfile.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_applyOffsetForcesByMirrorForce_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_applyOffsetForcesByMirrorForce_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_applyOffsetForcesByMirrorForce.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_updatePID_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_updatePID_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_updatePID.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_resetPID_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_resetPID_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_resetPID.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_forceActuatorBumpTest_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_forceActuatorBumpTest_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_forceActuatorBumpTest.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_killForceActuatorBumpTest_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_killForceActuatorBumpTest_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_killForceActuatorBumpTest.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_disableForceActuator_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_disableForceActuator_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_disableForceActuator.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enableForceActuator_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enableForceActuator_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_enableForceActuator.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enableAllForceActuators_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enableAllForceActuators_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_enableAllForceActuators.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enableDisableForceComponent_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enableDisableForceComponent_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_enableDisableForceComponent.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setSlewControllerSettings_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setSlewControllerSettings_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_setSlewControllerSettings.hh

Verify MTM1M3 C++ Event Interfaces
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
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_hardpointActuatorInfo_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_hardpointActuatorInfo_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_hardpointActuatorInfo.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_forceActuatorInfo_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_forceActuatorInfo_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_forceActuatorInfo.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ilcWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ilcWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_ilcWarning.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_interlockWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_interlockWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_interlockWarning.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_airSupplyStatus_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_airSupplyStatus_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_airSupplyStatus.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_airSupplyWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_airSupplyWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_airSupplyWarning.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_interlockStatus_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_interlockStatus_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_interlockStatus.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_displacementSensorWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_displacementSensorWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_displacementSensorWarning.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_inclinometerSensorWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_inclinometerSensorWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_inclinometerSensorWarning.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_accelerometerWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_accelerometerWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_accelerometerWarning.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_forceSetpointWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_forceSetpointWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_forceSetpointWarning.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_raisingLoweringInfo_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_raisingLoweringInfo_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_raisingLoweringInfo.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_boosterValveSettings_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_boosterValveSettings_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_boosterValveSettings.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_boosterValveStatus_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_boosterValveStatus_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_boosterValveStatus.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_forceActuatorState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_forceActuatorState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_forceActuatorState.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_forceControllerState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_forceControllerState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_forceControllerState.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_slewControllerSettings_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_slewControllerSettings_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_slewControllerSettings.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_hardpointMonitorInfo_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_hardpointMonitorInfo_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_hardpointMonitorInfo.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_cellLightStatus_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_cellLightStatus_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_cellLightStatus.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_cellLightWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_cellLightWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_cellLightWarning.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_powerStatus_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_powerStatus_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_powerStatus.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_powerWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_powerWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_powerWarning.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_forceActuatorForceWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_forceActuatorForceWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_forceActuatorForceWarning.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_forceActuatorFollowingErrorCounter_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_forceActuatorFollowingErrorCounter_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_forceActuatorFollowingErrorCounter.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_gyroWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_gyroWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_gyroWarning.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_powerSupplyStatus_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_powerSupplyStatus_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_powerSupplyStatus.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedOffsetForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedOffsetForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_appliedOffsetForces.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedStaticForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedStaticForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_appliedStaticForces.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedActiveOpticForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedActiveOpticForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_appliedActiveOpticForces.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_commandRejectionWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_commandRejectionWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_commandRejectionWarning.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_pidInfo_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_pidInfo_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_pidInfo.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_hardpointActuatorWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_hardpointActuatorWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_hardpointActuatorWarning.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_hardpointMonitorWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_hardpointMonitorWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_hardpointMonitorWarning.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_hardpointActuatorState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_hardpointActuatorState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_hardpointActuatorState.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_hardpointMonitorState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_hardpointMonitorState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_hardpointMonitorState.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_forceActuatorWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_forceActuatorWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_forceActuatorWarning.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_preclippedStaticForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_preclippedStaticForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_preclippedStaticForces.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_preclippedElevationForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_preclippedElevationForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_preclippedElevationForces.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_preclippedAzimuthForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_preclippedAzimuthForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_preclippedAzimuthForces.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_preclippedThermalForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_preclippedThermalForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_preclippedThermalForces.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_preclippedActiveOpticForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_preclippedActiveOpticForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_preclippedActiveOpticForces.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_preclippedVelocityForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_preclippedVelocityForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_preclippedVelocityForces.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_preclippedAccelerationForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_preclippedAccelerationForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_preclippedAccelerationForces.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_preclippedBalanceForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_preclippedBalanceForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_preclippedBalanceForces.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_preclippedOffsetForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_preclippedOffsetForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_preclippedOffsetForces.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_preclippedForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_preclippedForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_preclippedForces.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_preclippedCylinderForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_preclippedCylinderForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_preclippedCylinderForces.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_forceActuatorBumpTestStatus_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_forceActuatorBumpTestStatus_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_forceActuatorBumpTestStatus.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_hardpointTestStatus_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_hardpointTestStatus_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_hardpointTestStatus.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enabledForceActuators_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enabledForceActuators_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_enabledForceActuators.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_forceActuatorSettings_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_forceActuatorSettings_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_forceActuatorSettings.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_hardpointActuatorSettings_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_hardpointActuatorSettings_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_hardpointActuatorSettings.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_positionControllerSettings_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_positionControllerSettings_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_positionControllerSettings.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_displacementSensorSettings_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_displacementSensorSettings_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_displacementSensorSettings.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_pidSettings_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_pidSettings_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_pidSettings.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_accelerometerSettings_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_accelerometerSettings_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_accelerometerSettings.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_gyroSettings_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_gyroSettings_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_gyroSettings.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_inclinometerSettings_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_inclinometerSettings_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_inclinometerSettings.hh

Salgen MTM1M3 Lib
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

Salgen MTM1M3 RPM
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

Verify MTM1M3 RPM Contents
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
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_field_enums.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_global_enums.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_hash_table.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_disable.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_enable.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_exitControl.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_setLogLevel.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_standby.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_start.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_panic.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_setSlewFlag.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_clearSlewFlag.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_raiseM1M3.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_abortRaiseM1M3.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_lowerM1M3.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_pauseM1M3RaisingLowering.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_resumeM1M3RaisingLowering.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_enterEngineering.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_exitEngineering.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_turnAirOn.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_turnAirOff.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_boosterValveOpen.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_boosterValveClose.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_moveHardpointActuators.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_stopHardpointMotion.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_testHardpoint.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_killHardpointTest.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_enableHardpointChase.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_disableHardpointChase.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_applyOffsetForces.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_translateM1M3.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_clearOffsetForces.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_applyActiveOpticForces.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_clearActiveOpticForces.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_positionM1M3.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_turnLightsOn.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_turnLightsOff.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_turnPowerOn.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_turnPowerOff.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_enableHardpointCorrections.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_disableHardpointCorrections.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_runMirrorForceProfile.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_abortProfile.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_applyOffsetForcesByMirrorForce.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_updatePID.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_resetPID.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_forceActuatorBumpTest.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_killForceActuatorBumpTest.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_disableForceActuator.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_enableForceActuator.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_enableAllForceActuators.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_enableDisableForceComponent.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_setSlewControllerSettings.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_heartbeat.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_logLevel.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_logMessage.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_softwareVersions.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_errorCode.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_simulationMode.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_summaryState.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_configurationApplied.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_configurationsAvailable.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_detailedState.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_hardpointActuatorInfo.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_forceActuatorInfo.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_ilcWarning.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_interlockWarning.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_airSupplyStatus.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_airSupplyWarning.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_interlockStatus.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_displacementSensorWarning.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_inclinometerSensorWarning.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_accelerometerWarning.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_forceSetpointWarning.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_raisingLoweringInfo.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_boosterValveSettings.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_boosterValveStatus.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_forceActuatorState.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_forceControllerState.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_slewControllerSettings.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_hardpointMonitorInfo.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_cellLightStatus.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_cellLightWarning.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_powerStatus.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_powerWarning.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_forceActuatorForceWarning.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_forceActuatorFollowingErrorCounter.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_gyroWarning.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_powerSupplyStatus.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_appliedOffsetForces.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_appliedStaticForces.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_appliedActiveOpticForces.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_commandRejectionWarning.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_pidInfo.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_hardpointActuatorWarning.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_hardpointMonitorWarning.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_hardpointActuatorState.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_hardpointMonitorState.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_forceActuatorWarning.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_preclippedStaticForces.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_preclippedElevationForces.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_preclippedAzimuthForces.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_preclippedThermalForces.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_preclippedActiveOpticForces.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_preclippedVelocityForces.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_preclippedAccelerationForces.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_preclippedBalanceForces.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_preclippedOffsetForces.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_preclippedForces.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_preclippedCylinderForces.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_forceActuatorBumpTestStatus.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_hardpointTestStatus.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_enabledForceActuators.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_forceActuatorSettings.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_hardpointActuatorSettings.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_positionControllerSettings.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_displacementSensorSettings.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_pidSettings.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_accelerometerSettings.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_gyroSettings.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_inclinometerSettings.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_forceActuatorData.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_inclinometerData.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_outerLoopData.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_accelerometerData.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_hardpointActuatorData.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_imsData.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_forceActuatorPressure.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_gyroData.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_powerSupplyData.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_pidData.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_hardpointMonitorData.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_appliedAzimuthForces.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_appliedAccelerationForces.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_appliedBalanceForces.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_appliedCylinderForces.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_appliedElevationForces.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_appliedForces.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_appliedThermalForces.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_appliedVelocityForces.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/lib/libSAL_${subSystem}.a
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/SAL_${subSystem}.h
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_ackcmd.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_forceActuatorData.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_inclinometerData.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_outerLoopData.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_accelerometerData.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_hardpointActuatorData.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_imsData.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_forceActuatorPressure.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_gyroData.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_powerSupplyData.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_pidData.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_hardpointMonitorData.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_appliedAzimuthForces.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_appliedAccelerationForces.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_appliedBalanceForces.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_appliedCylinderForces.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_appliedElevationForces.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_appliedForces.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_appliedThermalForces.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_appliedVelocityForces.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_disable.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_enable.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_exitControl.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_setLogLevel.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_standby.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_start.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_panic.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_setSlewFlag.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_clearSlewFlag.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_raiseM1M3.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_abortRaiseM1M3.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_lowerM1M3.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_pauseM1M3RaisingLowering.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_resumeM1M3RaisingLowering.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_enterEngineering.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_exitEngineering.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_turnAirOn.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_turnAirOff.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_boosterValveOpen.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_boosterValveClose.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_moveHardpointActuators.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_stopHardpointMotion.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_testHardpoint.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_killHardpointTest.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_enableHardpointChase.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_disableHardpointChase.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_applyOffsetForces.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_translateM1M3.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_clearOffsetForces.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_applyActiveOpticForces.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_clearActiveOpticForces.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_positionM1M3.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_turnLightsOn.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_turnLightsOff.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_turnPowerOn.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_turnPowerOff.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_enableHardpointCorrections.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_disableHardpointCorrections.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_runMirrorForceProfile.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_abortProfile.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_applyOffsetForcesByMirrorForce.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_updatePID.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_resetPID.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_forceActuatorBumpTest.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_killForceActuatorBumpTest.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_disableForceActuator.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_enableForceActuator.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_enableAllForceActuators.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_enableDisableForceComponent.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_setSlewControllerSettings.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_heartbeat.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_logLevel.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_logMessage.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_softwareVersions.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_errorCode.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_simulationMode.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_summaryState.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_configurationApplied.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_configurationsAvailable.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_detailedState.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_hardpointActuatorInfo.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_forceActuatorInfo.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_ilcWarning.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_interlockWarning.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_airSupplyStatus.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_airSupplyWarning.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_interlockStatus.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_displacementSensorWarning.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_inclinometerSensorWarning.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_accelerometerWarning.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_forceSetpointWarning.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_raisingLoweringInfo.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_boosterValveSettings.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_boosterValveStatus.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_forceActuatorState.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_forceControllerState.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_slewControllerSettings.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_hardpointMonitorInfo.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_cellLightStatus.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_cellLightWarning.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_powerStatus.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_powerWarning.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_forceActuatorForceWarning.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_forceActuatorFollowingErrorCounter.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_gyroWarning.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_powerSupplyStatus.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_appliedOffsetForces.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_appliedStaticForces.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_appliedActiveOpticForces.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_commandRejectionWarning.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_pidInfo.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_hardpointActuatorWarning.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_hardpointMonitorWarning.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_hardpointActuatorState.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_hardpointMonitorState.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_forceActuatorWarning.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_preclippedStaticForces.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_preclippedElevationForces.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_preclippedAzimuthForces.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_preclippedThermalForces.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_preclippedActiveOpticForces.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_preclippedVelocityForces.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_preclippedAccelerationForces.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_preclippedBalanceForces.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_preclippedOffsetForces.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_preclippedForces.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_preclippedCylinderForces.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_forceActuatorBumpTestStatus.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_hardpointTestStatus.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_enabledForceActuators.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_forceActuatorSettings.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_hardpointActuatorSettings.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_positionControllerSettings.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_displacementSensorSettings.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_pidSettings.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_accelerometerSettings.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_gyroSettings.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_inclinometerSettings.hh
    Comment    Verify the interface definition files are included.
    Should Contain    ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Generics.xml
    Should Contain    ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Commands.xml
    Should Contain    ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Commands.html
    Should Contain    ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Events.xml
    Should Contain    ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Events.html
    Should Contain    ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Telemetry.xml
    Should Contain    ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Telemetry.html

Verify MTM1M3 TEST RPM Contents
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
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_panic_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_panic_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_setSlewFlag_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_setSlewFlag_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_clearSlewFlag_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_clearSlewFlag_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_raiseM1M3_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_raiseM1M3_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_abortRaiseM1M3_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_abortRaiseM1M3_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_lowerM1M3_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_lowerM1M3_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_pauseM1M3RaisingLowering_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_pauseM1M3RaisingLowering_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_resumeM1M3RaisingLowering_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_resumeM1M3RaisingLowering_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_enterEngineering_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_enterEngineering_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_exitEngineering_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_exitEngineering_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_turnAirOn_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_turnAirOn_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_turnAirOff_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_turnAirOff_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_boosterValveOpen_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_boosterValveOpen_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_boosterValveClose_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_boosterValveClose_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_moveHardpointActuators_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_moveHardpointActuators_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_stopHardpointMotion_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_stopHardpointMotion_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_testHardpoint_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_testHardpoint_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_killHardpointTest_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_killHardpointTest_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_enableHardpointChase_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_enableHardpointChase_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_disableHardpointChase_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_disableHardpointChase_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_applyOffsetForces_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_applyOffsetForces_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_translateM1M3_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_translateM1M3_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_clearOffsetForces_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_clearOffsetForces_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_applyActiveOpticForces_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_applyActiveOpticForces_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_clearActiveOpticForces_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_clearActiveOpticForces_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_positionM1M3_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_positionM1M3_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_turnLightsOn_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_turnLightsOn_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_turnLightsOff_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_turnLightsOff_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_turnPowerOn_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_turnPowerOn_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_turnPowerOff_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_turnPowerOff_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_enableHardpointCorrections_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_enableHardpointCorrections_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_disableHardpointCorrections_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_disableHardpointCorrections_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_runMirrorForceProfile_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_runMirrorForceProfile_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_abortProfile_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_abortProfile_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_applyOffsetForcesByMirrorForce_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_applyOffsetForcesByMirrorForce_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_updatePID_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_updatePID_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_resetPID_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_resetPID_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_forceActuatorBumpTest_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_forceActuatorBumpTest_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_killForceActuatorBumpTest_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_killForceActuatorBumpTest_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_disableForceActuator_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_disableForceActuator_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_enableForceActuator_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_enableForceActuator_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_enableAllForceActuators_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_enableAllForceActuators_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_enableDisableForceComponent_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_enableDisableForceComponent_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_setSlewControllerSettings_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_setSlewControllerSettings_controller
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
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_hardpointActuatorInfo_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_hardpointActuatorInfo_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_forceActuatorInfo_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_forceActuatorInfo_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_ilcWarning_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_ilcWarning_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_interlockWarning_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_interlockWarning_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_airSupplyStatus_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_airSupplyStatus_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_airSupplyWarning_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_airSupplyWarning_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_interlockStatus_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_interlockStatus_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_displacementSensorWarning_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_displacementSensorWarning_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_inclinometerSensorWarning_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_inclinometerSensorWarning_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_accelerometerWarning_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_accelerometerWarning_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_forceSetpointWarning_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_forceSetpointWarning_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_raisingLoweringInfo_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_raisingLoweringInfo_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_boosterValveSettings_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_boosterValveSettings_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_boosterValveStatus_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_boosterValveStatus_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_forceActuatorState_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_forceActuatorState_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_forceControllerState_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_forceControllerState_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_slewControllerSettings_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_slewControllerSettings_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_hardpointMonitorInfo_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_hardpointMonitorInfo_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_cellLightStatus_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_cellLightStatus_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_cellLightWarning_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_cellLightWarning_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_powerStatus_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_powerStatus_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_powerWarning_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_powerWarning_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_forceActuatorForceWarning_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_forceActuatorForceWarning_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_forceActuatorFollowingErrorCounter_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_forceActuatorFollowingErrorCounter_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_gyroWarning_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_gyroWarning_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_powerSupplyStatus_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_powerSupplyStatus_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_appliedOffsetForces_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_appliedOffsetForces_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_appliedStaticForces_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_appliedStaticForces_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_appliedActiveOpticForces_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_appliedActiveOpticForces_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_commandRejectionWarning_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_commandRejectionWarning_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_pidInfo_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_pidInfo_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_hardpointActuatorWarning_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_hardpointActuatorWarning_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_hardpointMonitorWarning_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_hardpointMonitorWarning_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_hardpointActuatorState_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_hardpointActuatorState_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_hardpointMonitorState_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_hardpointMonitorState_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_forceActuatorWarning_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_forceActuatorWarning_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_preclippedStaticForces_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_preclippedStaticForces_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_preclippedElevationForces_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_preclippedElevationForces_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_preclippedAzimuthForces_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_preclippedAzimuthForces_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_preclippedThermalForces_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_preclippedThermalForces_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_preclippedActiveOpticForces_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_preclippedActiveOpticForces_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_preclippedVelocityForces_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_preclippedVelocityForces_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_preclippedAccelerationForces_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_preclippedAccelerationForces_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_preclippedBalanceForces_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_preclippedBalanceForces_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_preclippedOffsetForces_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_preclippedOffsetForces_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_preclippedForces_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_preclippedForces_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_preclippedCylinderForces_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_preclippedCylinderForces_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_forceActuatorBumpTestStatus_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_forceActuatorBumpTestStatus_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_hardpointTestStatus_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_hardpointTestStatus_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_enabledForceActuators_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_enabledForceActuators_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_forceActuatorSettings_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_forceActuatorSettings_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_hardpointActuatorSettings_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_hardpointActuatorSettings_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_positionControllerSettings_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_positionControllerSettings_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_displacementSensorSettings_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_displacementSensorSettings_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_pidSettings_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_pidSettings_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_accelerometerSettings_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_accelerometerSettings_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_gyroSettings_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_gyroSettings_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_inclinometerSettings_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_inclinometerSettings_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_forceActuatorData_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_forceActuatorData_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_inclinometerData_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_inclinometerData_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_outerLoopData_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_outerLoopData_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_accelerometerData_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_accelerometerData_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_hardpointActuatorData_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_hardpointActuatorData_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_imsData_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_imsData_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_forceActuatorPressure_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_forceActuatorPressure_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_gyroData_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_gyroData_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_powerSupplyData_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_powerSupplyData_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_pidData_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_pidData_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_hardpointMonitorData_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_hardpointMonitorData_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_appliedAzimuthForces_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_appliedAzimuthForces_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_appliedAccelerationForces_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_appliedAccelerationForces_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_appliedBalanceForces_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_appliedBalanceForces_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_appliedCylinderForces_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_appliedCylinderForces_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_appliedElevationForces_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_appliedElevationForces_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_appliedForces_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_appliedForces_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_appliedThermalForces_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_appliedThermalForces_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_appliedVelocityForces_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_appliedVelocityForces_subscriber

Cleanup stdout and stderr Files
    [Tags]
    Remove Files    ${EXECDIR}${/}${subSystem}_stdout.txt    ${EXECDIR}${/}${subSystem}_stderr.txt

