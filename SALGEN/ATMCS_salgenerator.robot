*** Settings ***
Documentation    This suite builds the various interfaces for the ATMCS.
Force Tags    salgen    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${timeout}
...    AND    Create Session    SALGEN
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../Global_Vars.robot
Resource    ../common.robot

*** Variables ***
${subSystem}    ATMCS
${timeout}    1200s

*** Test Cases ***
Verify ATMCS XML Defintions exist
    [Tags]
    Comment    Verify the CSC XML definition files exist.
    File Should Exist    ${SALWorkDir}/ATMCS_Commands.xml
    File Should Exist    ${SALWorkDir}/ATMCS_Events.xml
    File Should Exist    ${SALWorkDir}/ATMCS_Telemetry.xml

Salgen ATMCS Validate
    [Documentation]    Validate the ATMCS XML definitions.
    [Tags]
    ${input}=    Write    cd ${SALWorkDir}
    ${output}=    Read Until Prompt
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} validate
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Processing ${subSystem}
    Should Contain    ${output}    Completed ${subSystem} validation
    Directory Should Exist    ${SALWorkDir}/idl-templates
    Directory Should Exist    ${SALWorkDir}/idl-templates/validated
    @{files}=    List Directory    ${SALWorkDir}/idl-templates    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_mountEncoders.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_torqueDemand.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_measuredTorque.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_measuredMotorVelocity.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_mountMotorEncoders.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_startTracking.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_trackTarget.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_setInstrumentPort.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_stopTracking.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_m3State.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_elevationInPosition.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_azimuthInPosition.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_allAxesInPosition.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_nasmyth1RotatorInPosition.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_azimuthLimitSwitchCCW.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_elevationLimitSwitchUpper.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_nasmyth1LimitSwitchCW.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_nasmyth2LimitSwitchCCW.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_azimuthBrake1.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_elevationBrake.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_nasmyth1Brake.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_nasmyth2Brake.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_azimuthToppleBlockCCW.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_azimuthBrake2.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_nasmyth1LimitSwitchCCW.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_azimuthToppleBlockCW.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_nasmyth2LimitSwitchCW.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_azimuthLimitSwitchCW.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_azimuthDrive1Status.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_azimuthDrive2Status.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_elevationDriveStatus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_nasmyth1DriveStatus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_nasmyth2DriveStatus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_m3DriveStatus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_nasmyth2RotatorInPosition.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_elevationLimitSwitchLower.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_atMountState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_m3RotatorLimitSwitchCW.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_m3RotatorLimitSwitchCCW.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_m3RotatorDetentLimitSwitch.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_m3InPosition.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_m3PortSelected.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_detailedState.idl

Salgen ATMCS HTML
    [Documentation]    Create web form interfaces.
    [Tags]    html    TSS-3079
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} html
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating telemetry stream definition editor html
    Should Contain    ${output}    Creating sal-generator-${subSystem} form
    Should Contain    ${output}    Added sal-generator-${subSystem}.mountEncoders to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.torqueDemand to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.measuredTorque to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.measuredMotorVelocity to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.mountMotorEncoders to form
    Directory Should Exist    ${SALWorkDir}/html/salgenerator/${subSystem}
    @{files}=    List Directory    ${SALWorkDir}/html/salgenerator/${subSystem}    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/html/${subSystem}/ATMCS_Commands.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/ATMCS_Events.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/ATMCS_Telemetry.html

Salgen ATMCS C++
    [Documentation]    Generate C++ wrapper.
    [Tags]    cpp
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} sal cpp
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Not Contain    ${output}    *** DDS error in file
    Should Not Contain    ${output}    Error 1
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_mountEncoders.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_torqueDemand.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_measuredTorque.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_measuredMotorVelocity.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_mountMotorEncoders.idl
    Should Contain X Times    ${output}    cpp : Done Publisher    5
    Should Contain X Times    ${output}    cpp : Done Subscriber    5
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

Verify ATMCS Telemetry directories
    [Tags]    cpp
    @{files}=    List Directory    ${SALWorkDir}    pattern=*${subSystem}*
    Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/${subSystem}_mountEncoders
    Directory Should Exist    ${SALWorkDir}/${subSystem}_torqueDemand
    Directory Should Exist    ${SALWorkDir}/${subSystem}_measuredTorque
    Directory Should Exist    ${SALWorkDir}/${subSystem}_measuredMotorVelocity
    Directory Should Exist    ${SALWorkDir}/${subSystem}_mountMotorEncoders

Verify ATMCS C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}_mountEncoders/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_mountEncoders/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_torqueDemand/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_torqueDemand/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_measuredTorque/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_measuredTorque/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_measuredMotorVelocity/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_measuredMotorVelocity/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_mountMotorEncoders/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_mountMotorEncoders/cpp/standalone/sacpp_${subSystem}_sub

Verify ATMCS C++ Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startTracking_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startTracking_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_trackTarget_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_trackTarget_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setInstrumentPort_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setInstrumentPort_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_stopTracking_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_stopTracking_controller

Verify ATMCS C++ Event Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m3State_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m3State_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_elevationInPosition_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_elevationInPosition_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthInPosition_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthInPosition_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_allAxesInPosition_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_allAxesInPosition_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth1RotatorInPosition_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth1RotatorInPosition_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthLimitSwitchCCW_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthLimitSwitchCCW_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_elevationLimitSwitchUpper_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_elevationLimitSwitchUpper_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth1LimitSwitchCW_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth1LimitSwitchCW_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth2LimitSwitchCCW_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth2LimitSwitchCCW_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthBrake1_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthBrake1_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_elevationBrake_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_elevationBrake_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth1Brake_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth1Brake_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth2Brake_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth2Brake_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthToppleBlockCCW_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthToppleBlockCCW_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthBrake2_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthBrake2_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth1LimitSwitchCCW_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth1LimitSwitchCCW_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthToppleBlockCW_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthToppleBlockCW_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth2LimitSwitchCW_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth2LimitSwitchCW_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthLimitSwitchCW_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthLimitSwitchCW_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthDrive1Status_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthDrive1Status_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthDrive2Status_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthDrive2Status_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_elevationDriveStatus_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_elevationDriveStatus_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth1DriveStatus_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth1DriveStatus_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth2DriveStatus_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth2DriveStatus_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m3DriveStatus_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m3DriveStatus_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth2RotatorInPosition_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth2RotatorInPosition_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_elevationLimitSwitchLower_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_elevationLimitSwitchLower_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_atMountState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_atMountState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m3RotatorLimitSwitchCW_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m3RotatorLimitSwitchCW_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m3RotatorLimitSwitchCCW_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m3RotatorLimitSwitchCCW_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m3RotatorDetentLimitSwitch_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m3RotatorDetentLimitSwitch_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m3InPosition_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m3InPosition_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m3PortSelected_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m3PortSelected_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_detailedState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_detailedState_log

Salgen ATMCS Python
    [Documentation]    Generate Python wrapper.
    [Tags]    python
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} sal python
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating Python SAL support for ${subSystem}
    Should Contain    ${output}    Generating Python bindings
    Should Contain    ${output}    python : Done SALPY_${subSystem}.so
    Directory Should Exist    ${SALWorkDir}/${subSystem}/python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/SALPY_${subSystem}.so

Verify ATMCS Python Telemetry Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_mountEncoders_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_mountEncoders_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_torqueDemand_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_torqueDemand_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_measuredTorque_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_measuredTorque_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_measuredMotorVelocity_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_measuredMotorVelocity_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_mountMotorEncoders_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_mountMotorEncoders_Subscriber.py

Verify ATMCS Python Command Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_startTracking.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_startTracking.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_trackTarget.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_trackTarget.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_setInstrumentPort.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_setInstrumentPort.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_stopTracking.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_stopTracking.py

Verify ATMCS Python Event Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_m3State.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_m3State.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_elevationInPosition.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_elevationInPosition.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_azimuthInPosition.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_azimuthInPosition.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_allAxesInPosition.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_allAxesInPosition.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_nasmyth1RotatorInPosition.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_nasmyth1RotatorInPosition.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_azimuthLimitSwitchCCW.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_azimuthLimitSwitchCCW.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_elevationLimitSwitchUpper.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_elevationLimitSwitchUpper.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_nasmyth1LimitSwitchCW.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_nasmyth1LimitSwitchCW.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_nasmyth2LimitSwitchCCW.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_nasmyth2LimitSwitchCCW.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_azimuthBrake1.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_azimuthBrake1.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_elevationBrake.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_elevationBrake.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_nasmyth1Brake.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_nasmyth1Brake.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_nasmyth2Brake.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_nasmyth2Brake.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_azimuthToppleBlockCCW.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_azimuthToppleBlockCCW.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_azimuthBrake2.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_azimuthBrake2.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_nasmyth1LimitSwitchCCW.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_nasmyth1LimitSwitchCCW.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_azimuthToppleBlockCW.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_azimuthToppleBlockCW.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_nasmyth2LimitSwitchCW.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_nasmyth2LimitSwitchCW.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_azimuthLimitSwitchCW.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_azimuthLimitSwitchCW.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_azimuthDrive1Status.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_azimuthDrive1Status.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_azimuthDrive2Status.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_azimuthDrive2Status.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_elevationDriveStatus.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_elevationDriveStatus.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_nasmyth1DriveStatus.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_nasmyth1DriveStatus.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_nasmyth2DriveStatus.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_nasmyth2DriveStatus.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_m3DriveStatus.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_m3DriveStatus.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_nasmyth2RotatorInPosition.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_nasmyth2RotatorInPosition.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_elevationLimitSwitchLower.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_elevationLimitSwitchLower.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_atMountState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_atMountState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_m3RotatorLimitSwitchCW.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_m3RotatorLimitSwitchCW.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_m3RotatorLimitSwitchCCW.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_m3RotatorLimitSwitchCCW.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_m3RotatorDetentLimitSwitch.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_m3RotatorDetentLimitSwitch.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_m3InPosition.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_m3InPosition.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_m3PortSelected.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_m3PortSelected.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_detailedState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_detailedState.py

Salgen ATMCS LabVIEW
    [Documentation]    Generate ${subSystem} low-level LabView interfaces.
    [Tags]    labview
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} labview
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Directory Should Exist    ${SALWorkDir}/${subSystem}/labview
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/labview
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/labview/SAL_${subSystem}_salShmMonitor.cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/labview/SAL_${subSystem}_shmem.h
    File Should Exist    ${SALWorkDir}/${subSystem}/labview/SALLV_${subSystem}.so
    File Should Exist    ${SALWorkDir}/${subSystem}/labview/SALLV_${subSystem}_Monitor

Salgen ATMCS Java
    [Documentation]    Generate Java wrapper.
    [Tags]    java
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} sal java
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_mountEncoders.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_torqueDemand.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_measuredTorque.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_measuredMotorVelocity.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_mountMotorEncoders.idl
    Should Contain X Times    ${output}    javac : Done Publisher    5
    Should Contain X Times    ${output}    javac : Done Subscriber    5
    Should Contain X Times    ${output}    javac : Done Commander/Controller    5
    Should Contain X Times    ${output}    javac : Done Event/Logger    5
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl

Salgen ATMCS Lib
    [Documentation]    Generate the SAL shared library for ${subSystem}
    [Tags]    
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} lib
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Building shared library for ${subSystem} subsystem
    Directory Should Exist    ${SALWorkDir}/lib
    @{files}=    List Directory    ${SALWorkDir}/lib
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/lib/libsacpp_${subSystem}_types.so
    File Should Exist    ${SALWorkDir}/lib/libSAL_${subSystem}.so
    File Should Exist    ${SALWorkDir}/lib/SALLV_${subSystem}.so
    File Should Exist    ${SALWorkDir}/lib/SALPY_${subSystem}.so

Salgen ATMCS Maven
    [Documentation]    Generate the Maven repository.
    [Tags]    java
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} maven
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Running maven install
    Should Contain    ${output}    [INFO] Building sal_${subSystem} ${SALVersion}
    Should Contain X Times    ${output}    [INFO] BUILD SUCCESS    1
    Should Contain X Times    ${output}    [INFO] Finished at:    1
    @{files}=    List Directory    ${SALWorkDir}/maven
    File Should Exist    ${SALWorkDir}/maven/${subSystem}_${SALVersion}/pom.xml

