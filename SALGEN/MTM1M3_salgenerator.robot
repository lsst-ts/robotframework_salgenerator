*** Settings ***
Documentation    This suite builds the various interfaces for the MTM1M3.
Force Tags    salgen    TSS-3342    skipped
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${timeout}
...    AND    Create Session    SALGEN
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../Global_Vars.robot
Resource    ../common.robot

*** Variables ***
${subSystem}    MTM1M3
${timeout}    1200s

*** Test Cases ***
Verify MTM1M3 XML Defintions exist
    [Tags]
    Comment    Verify the CSC XML definition files exist.
    ${stdout}    ${stderr}=    Execute Command    ls ${SALWorkDir}/MTM1M3_*.xml     return_stderr=True
    Should Not Contain    ${stderr}    No such file or directory    msg="MTM1M3 has no XML defintions"    values=False
    Should Not Be Empty    ${stdout}
    File Should Exist    ${SALWorkDir}/MTM1M3_Commands.xml
    File Should Exist    ${SALWorkDir}/MTM1M3_Events.xml
    File Should Exist    ${SALWorkDir}/MTM1M3_Telemetry.xml

Salgen MTM1M3 Validate
    [Documentation]    Validate the MTM1M3 XML definitions.
    [Tags]
    ${input}=    Write    cd ${SALWorkDir}
    ${output}=    Read Until Prompt
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} validate
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - ${SALVersion}
    Should Contain    ${output}    Processing ${subSystem}
    Should Contain    ${output}    Completed ${subSystem} validation
    Directory Should Exist    ${SALWorkDir}/idl-templates
    Directory Should Exist    ${SALWorkDir}/idl-templates/validated
    @{files}=    List Directory    ${SALWorkDir}/idl-templates    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_accelerometerData.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_forceActuatorData.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_forceActuatorPressure.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_gyroData.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_hardpointActuatorData.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_hardpointMonitorData.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_imsData.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_inclinometerData.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_outerLoopData.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_pidData.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_powerData.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_abortRaiseM1M3.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_applyAberrationForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_applyAberrationForcesByBendingModes.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_applyActiveOpticForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_applyActiveOpticForcesByBendingModes.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_applyOffsetForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_applyOffsetForcesByMirrorForce.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_clearAberrationForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_clearActiveOpticForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_clearOffsetForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_disableHardpointChase.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_disableHardpointCorrections.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_enableHardpointChase.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_enableHardpointCorrections.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_enterEngineering.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_exitEngineering.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_lowerM1M3.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_modbusTransmit.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_moveHardpointActuators.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_positionM1M3.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_programILC.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_raiseM1M3.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_resetPID.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_shutdown.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_stopHardpointMotion.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_testAir.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_testForceActuator.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_testHardpoint.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_translateM1M3.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_turnAirOff.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_turnAirOn.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_turnLightsOff.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_turnLightsOn.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_turnPowerOff.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_turnPowerOn.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_updatePID.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_accelerometerWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_airSupplyStatus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_airSupplyWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_appliedAberrationForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_appliedAccelerationForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_appliedActiveOpticForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_appliedAzimuthForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_appliedBalanceForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_appliedCylinderForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_appliedElevationForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_appliedForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_appliedHardpointSteps.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_appliedOffsetForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_appliedStaticForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_appliedThermalForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_appliedVelocityForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_cellLightStatus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_cellLightWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_detailedState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_displacementSensorWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_forceActuatorBackupCalibrationInfo.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_forceActuatorILCInfo.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_forceActuatorIdInfo.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_forceActuatorMainCalibrationInfo.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_forceActuatorMezzanineCalibrationInfo.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_forceActuatorPositionInfo.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_forceActuatorState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_forceActuatorWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_gyroWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_hardpointActuatorInfo.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_hardpointActuatorState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_hardpointActuatorWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_hardpointMonitorInfo.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_hardpointMonitorState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_hardpointMonitorWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_inclinometerSensorWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_interlockStatus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_interlockWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_modbusResponse.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_modbusWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_pidInfo.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_powerStatus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_powerWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_rejectedAberrationForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_rejectedAccelerationForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_rejectedActiveOpticForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_rejectedAzimuthForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_rejectedBalanceForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_rejectedCylinderForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_rejectedElevationForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_rejectedForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_rejectedOffsetForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_rejectedStaticForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_rejectedThermalForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_rejectedVelocityForces.idl

Salgen MTM1M3 HTML
    [Documentation]    Create web form interfaces.
    [Tags]    html    
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} html
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - ${SALVersion}
    Should Contain    ${output}    Generating telemetry stream definition editor html
    Should Contain    ${output}    Creating sal-generator-${subSystem} form
    Should Contain    ${output}    Added sal-generator-${subSystem}.accelerometerData to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.forceActuatorData to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.forceActuatorPressure to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.gyroData to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.hardpointActuatorData to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.hardpointMonitorData to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.imsData to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.inclinometerData to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.outerLoopData to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.pidData to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.powerData to form
    Directory Should Exist    ${SALWorkDir}/html/salgenerator/${subSystem}
    @{files}=    List Directory    ${SALWorkDir}/html/salgenerator/${subSystem}    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/html/${subSystem}/MTM1M3_Commands.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/MTM1M3_Events.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/MTM1M3_Telemetry.html

Salgen MTM1M3 C++
    [Documentation]    Generate C++ wrapper.
    [Tags]    cpp
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} sal cpp
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Not Contain    ${output}    *** DDS error in file
    Should Not Contain    ${output}    Error 1
    Should Contain    ${output}    SAL generator - ${SALVersion}
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_accelerometerData.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_forceActuatorData.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_forceActuatorPressure.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_gyroData.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_hardpointActuatorData.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_hardpointMonitorData.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_imsData.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_inclinometerData.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_outerLoopData.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_pidData.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_powerData.idl
    Should Contain X Times    ${output}    cpp : Done Publisher    11
    Should Contain X Times    ${output}    cpp : Done Subscriber    11
    Should Contain X Times    ${output}    cpp : Done Commander    1
    Should Contain X Times    ${output}    cpp : Done Event/Logger    1

Verify C++ Directories
    [Documentation]    Ensure expected C++ directories and files.
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
    Directory Should Exist    ${SALWorkDir}/${subSystem}_accelerometerData
    Directory Should Exist    ${SALWorkDir}/${subSystem}_forceActuatorData
    Directory Should Exist    ${SALWorkDir}/${subSystem}_forceActuatorPressure
    Directory Should Exist    ${SALWorkDir}/${subSystem}_gyroData
    Directory Should Exist    ${SALWorkDir}/${subSystem}_hardpointActuatorData
    Directory Should Exist    ${SALWorkDir}/${subSystem}_hardpointMonitorData
    Directory Should Exist    ${SALWorkDir}/${subSystem}_imsData
    Directory Should Exist    ${SALWorkDir}/${subSystem}_inclinometerData
    Directory Should Exist    ${SALWorkDir}/${subSystem}_outerLoopData
    Directory Should Exist    ${SALWorkDir}/${subSystem}_pidData
    Directory Should Exist    ${SALWorkDir}/${subSystem}_powerData

Verify MTM1M3 C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}_accelerometerData/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_accelerometerData/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_forceActuatorData/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_forceActuatorData/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_forceActuatorPressure/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_forceActuatorPressure/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_gyroData/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_gyroData/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_hardpointActuatorData/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_hardpointActuatorData/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_hardpointMonitorData/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_hardpointMonitorData/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_imsData/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_imsData/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_inclinometerData/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_inclinometerData/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_outerLoopData/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_outerLoopData/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_pidData/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_pidData/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_powerData/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_powerData/cpp/standalone/sacpp_${subSystem}_sub

Verify MTM1M3 C++ Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_abortRaiseM1M3_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_abortRaiseM1M3_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_applyAberrationForces_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_applyAberrationForces_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_applyAberrationForcesByBendingModes_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_applyAberrationForcesByBendingModes_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_applyActiveOpticForces_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_applyActiveOpticForces_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_applyActiveOpticForcesByBendingModes_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_applyActiveOpticForcesByBendingModes_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_applyOffsetForces_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_applyOffsetForces_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_applyOffsetForcesByMirrorForce_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_applyOffsetForcesByMirrorForce_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_clearAberrationForces_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_clearAberrationForces_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_clearActiveOpticForces_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_clearActiveOpticForces_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_clearOffsetForces_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_clearOffsetForces_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_disableHardpointChase_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_disableHardpointChase_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_disableHardpointCorrections_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_disableHardpointCorrections_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enableHardpointChase_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enableHardpointChase_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enableHardpointCorrections_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enableHardpointCorrections_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enterEngineering_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enterEngineering_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_exitEngineering_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_exitEngineering_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_lowerM1M3_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_lowerM1M3_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_modbusTransmit_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_modbusTransmit_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_moveHardpointActuators_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_moveHardpointActuators_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_positionM1M3_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_positionM1M3_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_programILC_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_programILC_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_raiseM1M3_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_raiseM1M3_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_resetPID_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_resetPID_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_shutdown_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_shutdown_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_stopHardpointMotion_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_stopHardpointMotion_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_testAir_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_testAir_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_testForceActuator_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_testForceActuator_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_testHardpoint_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_testHardpoint_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_translateM1M3_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_translateM1M3_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_turnAirOff_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_turnAirOff_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_turnAirOn_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_turnAirOn_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_turnLightsOff_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_turnLightsOff_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_turnLightsOn_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_turnLightsOn_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_turnPowerOff_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_turnPowerOff_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_turnPowerOn_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_turnPowerOn_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_updatePID_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_updatePID_controller

Verify MTM1M3 C++ Event Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_accelerometerWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_accelerometerWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_airSupplyStatus_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_airSupplyStatus_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_airSupplyWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_airSupplyWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedAberrationForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedAberrationForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedAccelerationForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedAccelerationForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedActiveOpticForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedActiveOpticForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedAzimuthForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedAzimuthForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedBalanceForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedBalanceForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedCylinderForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedCylinderForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedElevationForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedElevationForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedHardpointSteps_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedHardpointSteps_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedOffsetForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedOffsetForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedStaticForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedStaticForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedThermalForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedThermalForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedVelocityForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedVelocityForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_cellLightStatus_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_cellLightStatus_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_cellLightWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_cellLightWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_detailedState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_detailedState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_displacementSensorWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_displacementSensorWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_forceActuatorBackupCalibrationInfo_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_forceActuatorBackupCalibrationInfo_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_forceActuatorILCInfo_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_forceActuatorILCInfo_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_forceActuatorIdInfo_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_forceActuatorIdInfo_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_forceActuatorMainCalibrationInfo_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_forceActuatorMainCalibrationInfo_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_forceActuatorMezzanineCalibrationInfo_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_forceActuatorMezzanineCalibrationInfo_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_forceActuatorPositionInfo_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_forceActuatorPositionInfo_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_forceActuatorState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_forceActuatorState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_forceActuatorWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_forceActuatorWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_gyroWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_gyroWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_hardpointActuatorInfo_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_hardpointActuatorInfo_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_hardpointActuatorState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_hardpointActuatorState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_hardpointActuatorWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_hardpointActuatorWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_hardpointMonitorInfo_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_hardpointMonitorInfo_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_hardpointMonitorState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_hardpointMonitorState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_hardpointMonitorWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_hardpointMonitorWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_inclinometerSensorWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_inclinometerSensorWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_interlockStatus_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_interlockStatus_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_interlockWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_interlockWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_modbusResponse_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_modbusResponse_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_modbusWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_modbusWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_pidInfo_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_pidInfo_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_powerStatus_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_powerStatus_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_powerWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_powerWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_rejectedAberrationForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_rejectedAberrationForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_rejectedAccelerationForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_rejectedAccelerationForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_rejectedActiveOpticForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_rejectedActiveOpticForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_rejectedAzimuthForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_rejectedAzimuthForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_rejectedBalanceForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_rejectedBalanceForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_rejectedCylinderForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_rejectedCylinderForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_rejectedElevationForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_rejectedElevationForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_rejectedForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_rejectedForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_rejectedOffsetForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_rejectedOffsetForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_rejectedStaticForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_rejectedStaticForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_rejectedThermalForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_rejectedThermalForces_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_rejectedVelocityForces_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_rejectedVelocityForces_log

Salgen MTM1M3 Python
    [Documentation]    Generate Python wrapper.
    [Tags]    python
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} sal python
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - ${SALVersion}
    Should Contain    ${output}    Generating Python SAL support for ${subSystem}
    Should Contain    ${output}    Generating Python bindings
    Should Contain    ${output}    python : Done SALPY_${subSystem}.so
    Directory Should Exist    ${SALWorkDir}/${subSystem}/python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/SALPY_${subSystem}.so

Verify MTM1M3 Python Telemetry Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_accelerometerData_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_accelerometerData_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_forceActuatorData_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_forceActuatorData_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_forceActuatorPressure_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_forceActuatorPressure_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_gyroData_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_gyroData_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_hardpointActuatorData_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_hardpointActuatorData_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_hardpointMonitorData_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_hardpointMonitorData_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_imsData_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_imsData_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_inclinometerData_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_inclinometerData_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_outerLoopData_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_outerLoopData_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_pidData_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_pidData_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_powerData_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_powerData_Subscriber.py

Verify MTM1M3 Python Command Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_abortRaiseM1M3.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_abortRaiseM1M3.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_applyAberrationForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_applyAberrationForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_applyAberrationForcesByBendingModes.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_applyAberrationForcesByBendingModes.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_applyActiveOpticForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_applyActiveOpticForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_applyActiveOpticForcesByBendingModes.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_applyActiveOpticForcesByBendingModes.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_applyOffsetForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_applyOffsetForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_applyOffsetForcesByMirrorForce.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_applyOffsetForcesByMirrorForce.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_clearAberrationForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_clearAberrationForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_clearActiveOpticForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_clearActiveOpticForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_clearOffsetForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_clearOffsetForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_disableHardpointChase.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_disableHardpointChase.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_disableHardpointCorrections.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_disableHardpointCorrections.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_enableHardpointChase.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_enableHardpointChase.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_enableHardpointCorrections.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_enableHardpointCorrections.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_enterEngineering.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_enterEngineering.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_exitEngineering.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_exitEngineering.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_lowerM1M3.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_lowerM1M3.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_modbusTransmit.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_modbusTransmit.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_moveHardpointActuators.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_moveHardpointActuators.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_positionM1M3.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_positionM1M3.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_programILC.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_programILC.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_raiseM1M3.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_raiseM1M3.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_resetPID.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_resetPID.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_shutdown.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_shutdown.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_stopHardpointMotion.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_stopHardpointMotion.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_testAir.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_testAir.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_testForceActuator.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_testForceActuator.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_testHardpoint.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_testHardpoint.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_translateM1M3.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_translateM1M3.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_turnAirOff.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_turnAirOff.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_turnAirOn.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_turnAirOn.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_turnLightsOff.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_turnLightsOff.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_turnLightsOn.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_turnLightsOn.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_turnPowerOff.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_turnPowerOff.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_turnPowerOn.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_turnPowerOn.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_updatePID.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_updatePID.py

Verify MTM1M3 Python Event Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_accelerometerWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_accelerometerWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_airSupplyStatus.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_airSupplyStatus.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_airSupplyWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_airSupplyWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_appliedAberrationForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_appliedAberrationForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_appliedAccelerationForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_appliedAccelerationForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_appliedActiveOpticForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_appliedActiveOpticForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_appliedAzimuthForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_appliedAzimuthForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_appliedBalanceForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_appliedBalanceForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_appliedCylinderForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_appliedCylinderForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_appliedElevationForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_appliedElevationForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_appliedForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_appliedForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_appliedHardpointSteps.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_appliedHardpointSteps.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_appliedOffsetForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_appliedOffsetForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_appliedStaticForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_appliedStaticForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_appliedThermalForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_appliedThermalForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_appliedVelocityForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_appliedVelocityForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_cellLightStatus.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_cellLightStatus.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_cellLightWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_cellLightWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_detailedState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_detailedState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_displacementSensorWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_displacementSensorWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_forceActuatorBackupCalibrationInfo.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_forceActuatorBackupCalibrationInfo.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_forceActuatorILCInfo.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_forceActuatorILCInfo.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_forceActuatorIdInfo.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_forceActuatorIdInfo.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_forceActuatorMainCalibrationInfo.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_forceActuatorMainCalibrationInfo.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_forceActuatorMezzanineCalibrationInfo.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_forceActuatorMezzanineCalibrationInfo.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_forceActuatorPositionInfo.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_forceActuatorPositionInfo.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_forceActuatorState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_forceActuatorState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_forceActuatorWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_forceActuatorWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_gyroWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_gyroWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_hardpointActuatorInfo.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_hardpointActuatorInfo.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_hardpointActuatorState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_hardpointActuatorState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_hardpointActuatorWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_hardpointActuatorWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_hardpointMonitorInfo.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_hardpointMonitorInfo.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_hardpointMonitorState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_hardpointMonitorState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_hardpointMonitorWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_hardpointMonitorWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_inclinometerSensorWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_inclinometerSensorWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_interlockStatus.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_interlockStatus.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_interlockWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_interlockWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_modbusResponse.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_modbusResponse.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_modbusWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_modbusWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_pidInfo.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_pidInfo.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_powerStatus.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_powerStatus.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_powerWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_powerWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_rejectedAberrationForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_rejectedAberrationForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_rejectedAccelerationForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_rejectedAccelerationForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_rejectedActiveOpticForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_rejectedActiveOpticForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_rejectedAzimuthForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_rejectedAzimuthForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_rejectedBalanceForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_rejectedBalanceForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_rejectedCylinderForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_rejectedCylinderForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_rejectedElevationForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_rejectedElevationForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_rejectedForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_rejectedForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_rejectedOffsetForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_rejectedOffsetForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_rejectedStaticForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_rejectedStaticForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_rejectedThermalForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_rejectedThermalForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_rejectedVelocityForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_rejectedVelocityForces.py

Salgen MTM1M3 LabVIEW
    [Documentation]    Generate ${subSystem} low-level LabView interfaces.
    [Tags]    labview
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} labview
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - ${SALVersion}
    Directory Should Exist    ${SALWorkDir}/${subSystem}/labview
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/labview
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/labview/SAL_${subSystem}_salShmMonitor.cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/labview/SAL_${subSystem}_shmem.h
    File Should Exist    ${SALWorkDir}/${subSystem}/labview/SALLV_${subSystem}.so
    File Should Exist    ${SALWorkDir}/${subSystem}/labview/SALLV_${subSystem}_Monitor

Salgen MTM1M3 Java
    [Documentation]    Generate Java wrapper.
    [Tags]    javaTSS-3342    skipped
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} sal java
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - ${SALVersion}
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_accelerometerData.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_forceActuatorData.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_forceActuatorPressure.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_gyroData.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_hardpointActuatorData.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_hardpointMonitorData.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_imsData.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_inclinometerData.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_outerLoopData.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_pidData.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_powerData.idl
    Should Contain X Times    ${output}    javac : Done Publisher    11
    Should Contain X Times    ${output}    javac : Done Subscriber    11
    Should Contain X Times    ${output}    javac : Done Commander/Controller    11
    Should Contain X Times    ${output}    javac : Done Event/Logger    11
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl

Salgen MTM1M3 Lib
    [Documentation]    Generate the SAL shared library for ${subSystem}
    [Tags]    
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} lib
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - ${SALVersion}
    Should Contain    ${output}    Building shared library for ${subSystem} subsystem
    Directory Should Exist    ${SALWorkDir}/lib
    @{files}=    List Directory    ${SALWorkDir}/lib
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/lib/libsacpp_${subSystem}_types.so
    File Should Exist    ${SALWorkDir}/lib/libSAL_${subSystem}.so
    File Should Exist    ${SALWorkDir}/lib/SALLV_${subSystem}.so
    File Should Exist    ${SALWorkDir}/lib/SALPY_${subSystem}.so

Salgen MTM1M3 Maven
    [Documentation]    Generate the Maven repository.
    [Tags]    javaTSS-3342    skipped
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} maven
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - ${SALVersion}
    Should Contain    ${output}    Running maven install
    Should Contain    ${output}    [INFO] Building sal_${subSystem} ${SALVersion}
    Should Contain X Times    ${output}    [INFO] BUILD SUCCESS    1
    Should Contain X Times    ${output}    [INFO] Finished at:    1
    @{files}=    List Directory    ${SALWorkDir}/maven
    File Should Exist    ${SALWorkDir}/maven/${subSystem}_${SALVersion}/pom.xml

