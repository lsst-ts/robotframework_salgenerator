*** Settings ***
Documentation    This suite builds the various interfaces for the MTM1M3.
Force Tags    salgen    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${timeout}
Library    OperatingSystem
Library    Process
Resource    ../Global_Vars.resource

*** Variables ***
${subSystem}    MTM1M3
${timeout}    1200s

*** Test Cases ***
Verify MTM1M3 XML Defintions exist
    [Tags]
    Comment    Verify the CSC XML definition files exist.
    ${output}    Run Process    ls     ${SALWorkDir}/MTM1M3_*.xml    shell=True
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stderr}    No such file or directory    msg="MTM1M3 has no XML defintions"    values=False
    Should Not Be Empty    ${output.stdout}
    File Should Exist    ${SALWorkDir}/MTM1M3_Commands.xml
    File Should Exist    ${SALWorkDir}/MTM1M3_Events.xml
    File Should Exist    ${SALWorkDir}/MTM1M3_Telemetry.xml

Salgen MTM1M3 Validate
    [Documentation]    Validate the MTM1M3 XML definitions.
    [Tags]    validate
    ${output}=    Run Process    ${SALHome}/bin/salgenerator    ${subSystem}    validate    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    XMLVERSION = ${XMLVersion}
    Should Contain    ${output.stdout}    Processing ${subSystem}
    Should Contain    ${output.stdout}    Completed ${subSystem} validation
    Directory Should Exist    ${SALWorkDir}/idl-templates
    Directory Should Exist    ${SALWorkDir}/idl-templates/validated
    @{files}=    List Directory    ${SALWorkDir}/idl-templates    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_ackcmd.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_forceActuatorData.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_inclinometerData.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_outerLoopData.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_accelerometerData.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_hardpointActuatorData.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_imsData.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_forceActuatorPressure.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_gyroData.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_powerSupplyData.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_pidData.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_hardpointMonitorData.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_abort.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_disable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_standby.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_exitControl.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_start.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_enterControl.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_setLogLevel.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_setValue.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_setAuthList.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_raiseM1M3.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_abortRaiseM1M3.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_lowerM1M3.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_enterEngineering.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_exitEngineering.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_turnAirOn.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_turnAirOff.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_testAir.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_moveHardpointActuators.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_stopHardpointMotion.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_testHardpoint.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_enableHardpointChase.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_disableHardpointChase.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_testForceActuator.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_applyOffsetForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_translateM1M3.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_clearOffsetForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_applyAberrationForcesByBendingModes.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_applyAberrationForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_clearAberrationForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_applyActiveOpticForcesByBendingModes.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_applyActiveOpticForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_clearActiveOpticForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_positionM1M3.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_turnLightsOn.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_turnLightsOff.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_turnPowerOn.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_turnPowerOff.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_enableHardpointCorrections.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_disableHardpointCorrections.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_runMirrorForceProfile.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_abortProfile.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_applyOffsetForcesByMirrorForce.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_updatePID.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_resetPID.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_programILC.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_modbusTransmit.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_forceActuatorBumpTest.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_killForceActuatorBumpTest.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_settingVersions.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_errorCode.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_summaryState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_appliedSettingsMatchStart.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_logLevel.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_logMessage.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_settingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_simulationMode.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_softwareVersions.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_heartbeat.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_authList.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_detailedState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_hardpointActuatorInfo.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_forceActuatorInfo.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ilcWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_interlockWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_airSupplyStatus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_airSupplyWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_interlockStatus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_displacementSensorWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_inclinometerSensorWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_accelerometerWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_forceSetpointWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_forceActuatorState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_hardpointMonitorInfo.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_cellLightStatus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_cellLightWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_powerStatus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_powerWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_forceActuatorForceWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_gyroWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_powerSupplyStatus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_appliedOffsetForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_appliedStaticForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_appliedActiveOpticForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_appliedAberrationForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_appliedAzimuthForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_commandRejectionWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_pidInfo.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_hardpointActuatorWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_hardpointMonitorWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_hardpointActuatorState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_hardpointMonitorState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_forceActuatorWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_preclippedStaticForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_preclippedElevationForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_preclippedAzimuthForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_preclippedThermalForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_preclippedActiveOpticForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_preclippedAberrationForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_preclippedBalanceForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_preclippedVelocityForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_preclippedAccelerationForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_preclippedOffsetForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_preclippedForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_appliedElevationForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_appliedAccelerationForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_appliedThermalForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_appliedVelocityForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_appliedBalanceForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_appliedForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_preclippedCylinderForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_appliedCylinderForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_modbusResponse.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_forceActuatorBumpTestStatus.idl

Verify MTM1M3 revCodes File
    [Documentation]    Ensure MTM1M3_revCodes.tcl contains 1 revcode per topic.
    [Tags]    doc    
    ${output}=    Log File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_abort\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_enable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_disable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_standby\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_exitControl\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_start\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_enterControl\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_setLogLevel\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_setValue\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_setAuthList\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_raiseM1M3\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_abortRaiseM1M3\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_lowerM1M3\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_enterEngineering\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_exitEngineering\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_turnAirOn\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_turnAirOff\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_testAir\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_moveHardpointActuators\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_stopHardpointMotion\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_testHardpoint\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_enableHardpointChase\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_disableHardpointChase\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_testForceActuator\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_applyOffsetForces\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_translateM1M3\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_clearOffsetForces\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_applyAberrationForcesByBendingModes\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_applyAberrationForces\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_clearAberrationForces\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_applyActiveOpticForcesByBendingModes\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_applyActiveOpticForces\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_clearActiveOpticForces\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_positionM1M3\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_turnLightsOn\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_turnLightsOff\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_turnPowerOn\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_turnPowerOff\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_enableHardpointCorrections\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_disableHardpointCorrections\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_runMirrorForceProfile\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_abortProfile\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_applyOffsetForcesByMirrorForce\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_updatePID\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_resetPID\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_programILC\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_modbusTransmit\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_forceActuatorBumpTest\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_killForceActuatorBumpTest\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_settingVersions\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_errorCode\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_summaryState\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_appliedSettingsMatchStart\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_logLevel\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_logMessage\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_settingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_simulationMode\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_softwareVersions\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_heartbeat\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_authList\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_detailedState\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_hardpointActuatorInfo\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_forceActuatorInfo\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ilcWarning\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_interlockWarning\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_airSupplyStatus\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_airSupplyWarning\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_interlockStatus\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_displacementSensorWarning\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_inclinometerSensorWarning\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_accelerometerWarning\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_forceSetpointWarning\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_forceActuatorState\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_hardpointMonitorInfo\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_cellLightStatus\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_cellLightWarning\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_powerStatus\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_powerWarning\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_forceActuatorForceWarning\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_gyroWarning\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_powerSupplyStatus\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_appliedOffsetForces\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_appliedStaticForces\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_appliedActiveOpticForces\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_appliedAberrationForces\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_appliedAzimuthForces\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_commandRejectionWarning\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_pidInfo\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_hardpointActuatorWarning\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_hardpointMonitorWarning\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_hardpointActuatorState\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_hardpointMonitorState\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_forceActuatorWarning\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_preclippedStaticForces\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_preclippedElevationForces\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_preclippedAzimuthForces\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_preclippedThermalForces\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_preclippedActiveOpticForces\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_preclippedAberrationForces\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_preclippedBalanceForces\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_preclippedVelocityForces\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_preclippedAccelerationForces\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_preclippedOffsetForces\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_preclippedForces\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_appliedElevationForces\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_appliedAccelerationForces\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_appliedThermalForces\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_appliedVelocityForces\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_appliedBalanceForces\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_appliedForces\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_preclippedCylinderForces\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_appliedCylinderForces\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_modbusResponse\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_forceActuatorBumpTestStatus\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_forceActuatorData\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_inclinometerData\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_outerLoopData\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_accelerometerData\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_hardpointActuatorData\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_imsData\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_forceActuatorPressure\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_gyroData\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_powerSupplyData\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_pidData\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_hardpointMonitorData\\) [a-z0-9]{8,}

Salgen MTM1M3 IDL
    [Documentation]    Generate the revCoded IDL for ${subSystem}
    [Tags]    idl
    ${output}=    Run Process    ${SALHome}/bin/salgenerator    ${subSystem}    sal    idl    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    XMLVERSION = ${XMLVersion}
    Should Contain    ${output.stdout}    Completed ${subSystem} validation
    File Should Exist    ${SALWorkDir}/${subSystem}/sal_revCoded_${subSystem}.idl
    @{files}=    List Directory    ${SALWorkDir}/idl-templates/validated/sal    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/idl-templates/validated/sal/sal_${subSystem}.idl
    File Should Exist    ${SALWorkDir}/idl-templates/validated/sal/sal_revCoded_${subSystem}.idl

Salgen MTM1M3 C++
    [Documentation]    Generate C++ libraries.
    [Tags]    cpp
    ${output}=    Run Process    ${SALHome}/bin/salgenerator    ${subSystem}    sal    cpp   shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stdout}    ERROR : Failed to generate CPP DDS types
    Should Not Contain    ${output.stdout}    *** DDS error in file
    Should Not Contain    ${output.stdout}    Error 1
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    XMLVERSION = ${XMLVersion}
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_forceActuatorData.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_inclinometerData.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_outerLoopData.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_accelerometerData.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_hardpointActuatorData.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_imsData.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_forceActuatorPressure.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_gyroData.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_powerSupplyData.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_pidData.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_hardpointMonitorData.idl
    Should Contain X Times    ${output.stdout}    cpp : Done Publisher    11
    Should Contain X Times    ${output.stdout}    cpp : Done Subscriber    11
    Should Contain X Times    ${output.stdout}    cpp : Done Commander    1
    Should Contain X Times    ${output.stdout}    cpp : Done Event/Logger    1

Verify C++ Directories
    [Documentation]    Ensure expected C++ directories and files are created.
    [Tags]    cpp
    Directory Should Exist    ${SALWorkDir}/${subSystem}/cpp
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/cpp    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/libsacpp_${subSystem}_types.so
    Directory Should Exist    ${SALWorkDir}/idl-templates/validated/sal
    @{files}=    List Directory    ${SALWorkDir}/idl-templates/validated/sal    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/idl-templates/validated/sal/sal_${subSystem}.idl

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

Verify MTM1M3 C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}_forceActuatorData/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_forceActuatorData/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_inclinometerData/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_inclinometerData/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_outerLoopData/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_outerLoopData/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_accelerometerData/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_accelerometerData/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_hardpointActuatorData/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_hardpointActuatorData/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_imsData/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_imsData/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_forceActuatorPressure/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_forceActuatorPressure/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_gyroData/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_gyroData/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_powerSupplyData/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_powerSupplyData/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_pidData/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_pidData/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_hardpointMonitorData/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_hardpointMonitorData/cpp/standalone/sacpp_${subSystem}_sub

Verify MTM1M3 C++ Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_abort_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_abort_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enable_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enable_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_disable_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_disable_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_standby_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_standby_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_exitControl_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_exitControl_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_start_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_start_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enterControl_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enterControl_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setLogLevel_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setLogLevel_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setValue_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setValue_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setAuthList_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setAuthList_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_raiseM1M3_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_raiseM1M3_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_abortRaiseM1M3_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_abortRaiseM1M3_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_lowerM1M3_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_lowerM1M3_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enterEngineering_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enterEngineering_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_exitEngineering_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_exitEngineering_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_turnAirOn_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_turnAirOn_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_turnAirOff_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_turnAirOff_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_testAir_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_testAir_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_moveHardpointActuators_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_moveHardpointActuators_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_stopHardpointMotion_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_stopHardpointMotion_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_testHardpoint_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_testHardpoint_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enableHardpointChase_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enableHardpointChase_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_disableHardpointChase_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_disableHardpointChase_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_testForceActuator_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_testForceActuator_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_applyOffsetForces_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_applyOffsetForces_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_translateM1M3_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_translateM1M3_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_clearOffsetForces_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_clearOffsetForces_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_applyAberrationForcesByBendingModes_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_applyAberrationForcesByBendingModes_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_applyAberrationForces_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_applyAberrationForces_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_clearAberrationForces_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_clearAberrationForces_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_applyActiveOpticForcesByBendingModes_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_applyActiveOpticForcesByBendingModes_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_applyActiveOpticForces_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_applyActiveOpticForces_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_clearActiveOpticForces_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_clearActiveOpticForces_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_positionM1M3_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_positionM1M3_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_turnLightsOn_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_turnLightsOn_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_turnLightsOff_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_turnLightsOff_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_turnPowerOn_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_turnPowerOn_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_turnPowerOff_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_turnPowerOff_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enableHardpointCorrections_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enableHardpointCorrections_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_disableHardpointCorrections_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_disableHardpointCorrections_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_runMirrorForceProfile_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_runMirrorForceProfile_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_abortProfile_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_abortProfile_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_applyOffsetForcesByMirrorForce_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_applyOffsetForcesByMirrorForce_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_updatePID_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_updatePID_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_resetPID_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_resetPID_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_programILC_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_programILC_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_modbusTransmit_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_modbusTransmit_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_forceActuatorBumpTest_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_forceActuatorBumpTest_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_killForceActuatorBumpTest_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_killForceActuatorBumpTest_controller

Verify MTM1M3 C++ Event Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_settingVersions_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_settingVersions_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_errorCode_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_errorCode_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_summaryState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_summaryState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedSettingsMatchStart_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedSettingsMatchStart_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_logLevel_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_logLevel_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_logMessage_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_logMessage_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_settingsApplied_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_settingsApplied_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_simulationMode_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_simulationMode_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_softwareVersions_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_softwareVersions_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_heartbeat_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_heartbeat_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_authList_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_authList_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_detailedState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_detailedState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_hardpointActuatorInfo_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_hardpointActuatorInfo_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_forceActuatorInfo_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_forceActuatorInfo_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ilcWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ilcWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_interlockWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_interlockWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_airSupplyStatus_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_airSupplyStatus_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_airSupplyWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_airSupplyWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_interlockStatus_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_interlockStatus_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_displacementSensorWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_displacementSensorWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_inclinometerSensorWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_inclinometerSensorWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_accelerometerWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_accelerometerWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_forceSetpointWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_forceSetpointWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_forceActuatorState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_forceActuatorState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_hardpointMonitorInfo_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_hardpointMonitorInfo_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_cellLightStatus_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_cellLightStatus_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_cellLightWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_cellLightWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_powerStatus_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_powerStatus_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_powerWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_powerWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_forceActuatorForceWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_forceActuatorForceWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_gyroWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_gyroWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_powerSupplyStatus_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_powerSupplyStatus_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedOffsetForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedOffsetForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedStaticForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedStaticForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedActiveOpticForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedActiveOpticForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedAberrationForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedAberrationForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedAzimuthForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedAzimuthForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_commandRejectionWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_commandRejectionWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_pidInfo_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_pidInfo_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_hardpointActuatorWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_hardpointActuatorWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_hardpointMonitorWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_hardpointMonitorWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_hardpointActuatorState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_hardpointActuatorState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_hardpointMonitorState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_hardpointMonitorState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_forceActuatorWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_forceActuatorWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_preclippedStaticForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_preclippedStaticForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_preclippedElevationForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_preclippedElevationForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_preclippedAzimuthForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_preclippedAzimuthForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_preclippedThermalForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_preclippedThermalForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_preclippedActiveOpticForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_preclippedActiveOpticForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_preclippedAberrationForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_preclippedAberrationForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_preclippedBalanceForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_preclippedBalanceForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_preclippedVelocityForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_preclippedVelocityForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_preclippedAccelerationForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_preclippedAccelerationForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_preclippedOffsetForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_preclippedOffsetForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_preclippedForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_preclippedForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedElevationForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedElevationForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedAccelerationForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedAccelerationForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedThermalForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedThermalForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedVelocityForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedVelocityForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedBalanceForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedBalanceForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_preclippedCylinderForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_preclippedCylinderForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedCylinderForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedCylinderForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_modbusResponse_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_modbusResponse_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_forceActuatorBumpTestStatus_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_forceActuatorBumpTestStatus_log

Salgen MTM1M3 Lib
    [Documentation]    Generate the SAL shared library for ${subSystem}
    [Tags]    lib
    ${output}=    Run Process    ${SALHome}/bin/salgenerator    ${subSystem}    lib    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    XMLVERSION = ${XMLVersion}
    Should Contain    ${output.stdout}    Building shared library for ${subSystem} subsystem
    Directory Should Exist    ${SALWorkDir}/lib
    @{files}=    List Directory    ${SALWorkDir}/lib    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/lib/libSAL_${subSystem}.so
    File Should Exist    ${SALWorkDir}/lib/libsacpp_${subSystem}_types.so

Salgen MTM1M3 Doc
    [Documentation]    Create the CSC documentation.
    [Tags]    doc
    ${output}=    Run Process    ${SALHome}/bin/salgenerator    ${subSystem}    apidoc    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    XMLVERSION = ${XMLVersion}
    Should Contain    ${output.stdout}    checking ${subSystem}
    Should Contain    ${output.stdout}    checking apidoc
    Should Contain    ${output.stdout}    Building API documentation for ${subSystem} subsystem
    Directory Should Exist    ${SALHome}/doc/_build/html/apiDocumentation/SAL_${subSystem}
    @{files}=    List Directory    ${SALHome}/doc/_build/html/apiDocumentation/SAL_${subSystem}
    Log Many    @{files}
    File Should Exist    ${SALHome}/doc/_build/html/apiDocumentation/SAL_${subSystem}/index.html

Salgen MTM1M3 RPM
    [Documentation]    Generate the SAL runtime RPM for ${subSystem}
    [Tags]    rpm
    Log Many    ${XMLVersion}    ${SALVersion}    ${Build_Number}    ${DIST}
    ${output}=    Run Process    ${SALHome}/bin/salgenerator    ${subSystem}    rpm    version\=${Build_Number}    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    @{files}=    List Directory    /tmp/
    Should Be Empty    ${output.stderr}
    File Should Exist    /tmp/makerpm_${subSystem}.log
    Log File    /tmp/makerpm_${subSystem}.log
    Should Not Contain    ${output.stdout}    ERROR : Asset required for rpm
    Should Not Contain    ${output.stdout}    child process exited abnormally
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
    Run Keyword If    "${Build_Number}" == ""
    ...    Set Test Variable    ${dot}    ${EMPTY}
    Run Keyword Unless    "${Build_Number}" == ""
    ...    Set Test Variable    ${dot}    .
    File Should Exist    ${SALWorkDir}/rpmbuild/SPECS/ts_sal_${subSystem}.spec
    File Should Exist    ${SALWorkDir}/rpmbuild/SOURCES/${subSystem}-${XMLVersion}.tgz
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/ts_sal_runtime-${XMLVersion}-${SALVersion}${dot}${Build_Number}${DIST}.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/ts_sal_ATruntime-${XMLVersion}-${SALVersion}${dot}${Build_Number}${DIST}.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/${subSystem}-${XMLVersion}-${SALVersion}${dot}${Build_Number}${DIST}.x86_64.rpm
    File Should Exist    /tmp/makerpm_${subSystem}_test.log
    Log File    /tmp/makerpm_${subSystem}_test.log
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/${subSystem}_test-${XMLVersion}-${SALVersion}${dot}${Build_Number}${DIST}.x86_64.rpm

Verify MTM1M3 RPM Contents
    [Documentation]    Verify the ${subSystem} RPM contains all the expected libraries
    [Tags]    rpm
    Comment    Re-run the {dot} process, so this test case can run independently.
    Run Keyword If    "${Build_Number}" == ""
    ...    Set Test Variable    ${dot}    ${EMPTY}
    Run Keyword Unless    "${Build_Number}" == ""
    ...    Set Test Variable    ${dot}    .
    ${output}=    Run Process    rpm    -qpl    ${subSystem}-${XMLVersion}-${SALVersion}${dot}${Build_Number}${DIST}.x86_64.rpm    cwd=${SALWorkDir}/rpmbuild/RPMS/x86_64
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stderr}    error
    Should Not Contain    ${output.stderr}    No such file or directory
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/idl/sal_revCoded_${subSystem}.idl
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/scripts/${subSystem}_revCodes.tcl
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/lib/libSAL_${subSystem}.so
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/lib/libSAL_${subSystem}.a
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/SAL_${subSystem}.h
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/SAL_${subSystem}.h
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/SAL_defines.h
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/ccpp_sal_${subSystem}.h
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/sal_${subSystem}Dcps.h
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/sal_${subSystem}Dcps_impl.h
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/sal_${subSystem}SplDcps.h
    Comment    Verify the interface definition files are included.
    Should Contain     ${output.stdout}    /opt/lsst/ts_xml/sal_interfaces/${subSystem}/${subSystem}_Generics.xml
    Should Contain     ${output.stdout}    /opt/lsst/ts_xml/sal_interfaces/${subSystem}/${subSystem}_Commands.xml
    Should Contain     ${output.stdout}    /opt/lsst/ts_xml/sal_interfaces/${subSystem}/${subSystem}_Commands.html
    Should Contain     ${output.stdout}    /opt/lsst/ts_xml/sal_interfaces/${subSystem}/${subSystem}_Events.xml
    Should Contain     ${output.stdout}    /opt/lsst/ts_xml/sal_interfaces/${subSystem}/${subSystem}_Events.html
    Should Contain     ${output.stdout}    /opt/lsst/ts_xml/sal_interfaces/${subSystem}/${subSystem}_Telemetry.xml
    Should Contain     ${output.stdout}    /opt/lsst/ts_xml/sal_interfaces/${subSystem}/${subSystem}_Telemetry.html

Verify MTM1M3 TEST RPM Contents
    [Documentation]    Verify the ${subSystem} TEST RPM contains all the expected libraries
    [Tags]    rpm
    Comment    Re-run the {dot} process, so this test case can run independently.
    Run Keyword If    "${Build_Number}" == ""
    ...    Set Test Variable    ${dot}    ${EMPTY}
    Run Keyword Unless    "${Build_Number}" == ""
    ...    Set Test Variable    ${dot}    .
    ${output}=    Run Process    rpm    -qpl    ${subSystem}_test-${XMLVersion}-${SALVersion}${dot}${Build_Number}${DIST}.x86_64.rpm    cwd=${SALWorkDir}/rpmbuild/RPMS/x86_64
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stderr}    error
    Should Not Contain    ${output.stderr}    No such file or directory
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/lib/libSAL_${subSystem}.so
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/lib/libSAL_${subSystem}.a
    Comment    Verify the TEST RPM contains the test programs.
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_all_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_all_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_all_sender
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_all_logger
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_all_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_all_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_abort_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_abort_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_enable_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_enable_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_disable_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_disable_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_standby_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_standby_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_exitControl_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_exitControl_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_start_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_start_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_enterControl_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_enterControl_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_setLogLevel_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_setLogLevel_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_setValue_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_setValue_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_setAuthList_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_setAuthList_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_raiseM1M3_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_raiseM1M3_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_abortRaiseM1M3_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_abortRaiseM1M3_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_lowerM1M3_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_lowerM1M3_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_enterEngineering_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_enterEngineering_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_exitEngineering_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_exitEngineering_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_turnAirOn_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_turnAirOn_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_turnAirOff_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_turnAirOff_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_testAir_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_testAir_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_moveHardpointActuators_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_moveHardpointActuators_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_stopHardpointMotion_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_stopHardpointMotion_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_testHardpoint_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_testHardpoint_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_enableHardpointChase_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_enableHardpointChase_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_disableHardpointChase_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_disableHardpointChase_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_testForceActuator_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_testForceActuator_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_applyOffsetForces_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_applyOffsetForces_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_translateM1M3_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_translateM1M3_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_clearOffsetForces_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_clearOffsetForces_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_applyAberrationForcesByBendingModes_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_applyAberrationForcesByBendingModes_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_applyAberrationForces_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_applyAberrationForces_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_clearAberrationForces_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_clearAberrationForces_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_applyActiveOpticForcesByBendingModes_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_applyActiveOpticForcesByBendingModes_controller
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
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_programILC_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_programILC_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_modbusTransmit_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_modbusTransmit_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_forceActuatorBumpTest_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_forceActuatorBumpTest_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_killForceActuatorBumpTest_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_killForceActuatorBumpTest_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_settingVersions_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_settingVersions_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_errorCode_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_errorCode_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_summaryState_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_summaryState_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_appliedSettingsMatchStart_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_appliedSettingsMatchStart_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_logLevel_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_logLevel_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_logMessage_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_logMessage_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_settingsApplied_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_settingsApplied_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_simulationMode_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_simulationMode_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_softwareVersions_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_softwareVersions_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_heartbeat_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_heartbeat_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_authList_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_authList_log
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
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_forceActuatorState_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_forceActuatorState_log
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
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_appliedAberrationForces_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_appliedAberrationForces_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_appliedAzimuthForces_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_appliedAzimuthForces_log
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
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_preclippedAberrationForces_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_preclippedAberrationForces_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_preclippedBalanceForces_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_preclippedBalanceForces_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_preclippedVelocityForces_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_preclippedVelocityForces_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_preclippedAccelerationForces_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_preclippedAccelerationForces_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_preclippedOffsetForces_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_preclippedOffsetForces_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_preclippedForces_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_preclippedForces_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_appliedElevationForces_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_appliedElevationForces_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_appliedAccelerationForces_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_appliedAccelerationForces_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_appliedThermalForces_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_appliedThermalForces_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_appliedVelocityForces_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_appliedVelocityForces_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_appliedBalanceForces_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_appliedBalanceForces_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_appliedForces_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_appliedForces_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_preclippedCylinderForces_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_preclippedCylinderForces_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_appliedCylinderForces_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_appliedCylinderForces_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_modbusResponse_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_modbusResponse_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_forceActuatorBumpTestStatus_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_forceActuatorBumpTestStatus_log
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

Cleanup stdout and stderr Files
    [Tags]
    Remove Files    ${EXECDIR}${/}${subSystem}_stdout.txt    ${EXECDIR}${/}${subSystem}_stderr.txt

