*** Settings ***
Documentation    This suite builds the various interfaces for the MTM2.
Force Tags    salgen    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${timeout}
...    AND    Create Session    SALGEN
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../Global_Vars.robot
Resource    ../common.robot

*** Variables ***
${subSystem}    MTM2
${timeout}    1200s

*** Test Cases ***
Verify MTM2 XML Defintions exist
    [Tags]
    Comment    Verify the CSC XML definition files exist.
    File Should Exist    ${SALWorkDir}/MTM2_Commands.xml
    File Should Exist    ${SALWorkDir}/MTM2_Events.xml
    File Should Exist    ${SALWorkDir}/MTM2_Telemetry.xml

Salgen MTM2 Validate
    [Documentation]    Validate the MTM2 XML definitions.
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
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_mirrorPositionMeasured.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_axialForcesMeasured.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_tangentForcesMeasured.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_zenithAngleMeasured.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_axialActuatorAbsolutePositionSteps.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_tangentActuatorAbsolutePositionSteps.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_axialActuatorPositionAbsoluteEncoderPositionMeasured.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_tangentActuatorPositionAbsoluteEncoderPositionMeasured.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_powerStatus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_temperaturesMeasured.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_rawDisplacement.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_stepVectorUpdate.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_targetForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_systemStatus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_rawTelemetry.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_actuatorLimitSwitches.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_applyBendingMode.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_applyForce.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_setCorrectionMode.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_positionMirror.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_moveAxialActuator.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_m2FaultState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_m2AssemblyInPosition.idl

Salgen MTM2 HTML
    [Documentation]    Create web form interfaces.
    [Tags]    html    TSS-3079
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} html
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating telemetry stream definition editor html
    Should Contain    ${output}    Creating sal-generator-${subSystem} form
    Should Contain    ${output}    Added sal-generator-${subSystem}.mirrorPositionMeasured to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.axialForcesMeasured to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.tangentForcesMeasured to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.zenithAngleMeasured to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.axialActuatorAbsolutePositionSteps to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.tangentActuatorAbsolutePositionSteps to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.axialActuatorPositionAbsoluteEncoderPositionMeasured to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.tangentActuatorPositionAbsoluteEncoderPositionMeasured to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.powerStatus to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.temperaturesMeasured to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.rawDisplacement to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.stepVectorUpdate to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.targetForces to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.systemStatus to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.rawTelemetry to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.actuatorLimitSwitches to form
    Directory Should Exist    ${SALWorkDir}/html/salgenerator/${subSystem}
    @{files}=    List Directory    ${SALWorkDir}/html/salgenerator/${subSystem}    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/html/${subSystem}/MTM2_Commands.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/MTM2_Events.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/MTM2_Telemetry.html

Salgen MTM2 C++
    [Documentation]    Generate C++ wrapper.
    [Tags]    cpp
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} sal cpp
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Not Contain    ${output}    *** DDS error in file
    Should Not Contain    ${output}    Error 1
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_mirrorPositionMeasured.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_axialForcesMeasured.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_tangentForcesMeasured.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_zenithAngleMeasured.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_axialActuatorAbsolutePositionSteps.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_tangentActuatorAbsolutePositionSteps.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_axialActuatorPositionAbsoluteEncoderPositionMeasured.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_tangentActuatorPositionAbsoluteEncoderPositionMeasured.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_powerStatus.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_temperaturesMeasured.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_rawDisplacement.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_stepVectorUpdate.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_targetForces.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_systemStatus.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_rawTelemetry.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_actuatorLimitSwitches.idl
    Should Contain X Times    ${output}    cpp : Done Publisher    16
    Should Contain X Times    ${output}    cpp : Done Subscriber    16
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

Verify MTM2 Telemetry directories
    [Tags]    cpp
    @{files}=    List Directory    ${SALWorkDir}    pattern=*${subSystem}*
    Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/${subSystem}_mirrorPositionMeasured
    Directory Should Exist    ${SALWorkDir}/${subSystem}_axialForcesMeasured
    Directory Should Exist    ${SALWorkDir}/${subSystem}_tangentForcesMeasured
    Directory Should Exist    ${SALWorkDir}/${subSystem}_zenithAngleMeasured
    Directory Should Exist    ${SALWorkDir}/${subSystem}_axialActuatorAbsolutePositionSteps
    Directory Should Exist    ${SALWorkDir}/${subSystem}_tangentActuatorAbsolutePositionSteps
    Directory Should Exist    ${SALWorkDir}/${subSystem}_axialActuatorPositionAbsoluteEncoderPositionMeasured
    Directory Should Exist    ${SALWorkDir}/${subSystem}_tangentActuatorPositionAbsoluteEncoderPositionMeasured
    Directory Should Exist    ${SALWorkDir}/${subSystem}_powerStatus
    Directory Should Exist    ${SALWorkDir}/${subSystem}_temperaturesMeasured
    Directory Should Exist    ${SALWorkDir}/${subSystem}_rawDisplacement
    Directory Should Exist    ${SALWorkDir}/${subSystem}_stepVectorUpdate
    Directory Should Exist    ${SALWorkDir}/${subSystem}_targetForces
    Directory Should Exist    ${SALWorkDir}/${subSystem}_systemStatus
    Directory Should Exist    ${SALWorkDir}/${subSystem}_rawTelemetry
    Directory Should Exist    ${SALWorkDir}/${subSystem}_actuatorLimitSwitches

Verify MTM2 C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}_mirrorPositionMeasured/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_mirrorPositionMeasured/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_axialForcesMeasured/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_axialForcesMeasured/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_tangentForcesMeasured/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_tangentForcesMeasured/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_zenithAngleMeasured/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_zenithAngleMeasured/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_axialActuatorAbsolutePositionSteps/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_axialActuatorAbsolutePositionSteps/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_tangentActuatorAbsolutePositionSteps/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_tangentActuatorAbsolutePositionSteps/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_axialActuatorPositionAbsoluteEncoderPositionMeasured/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_axialActuatorPositionAbsoluteEncoderPositionMeasured/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_tangentActuatorPositionAbsoluteEncoderPositionMeasured/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_tangentActuatorPositionAbsoluteEncoderPositionMeasured/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_powerStatus/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_powerStatus/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_temperaturesMeasured/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_temperaturesMeasured/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_rawDisplacement/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_rawDisplacement/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_stepVectorUpdate/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_stepVectorUpdate/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_targetForces/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_targetForces/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_systemStatus/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_systemStatus/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_rawTelemetry/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_rawTelemetry/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_actuatorLimitSwitches/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_actuatorLimitSwitches/cpp/standalone/sacpp_${subSystem}_sub

Verify MTM2 C++ Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_applyBendingMode_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_applyBendingMode_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_applyForce_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_applyForce_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setCorrectionMode_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setCorrectionMode_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_positionMirror_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_positionMirror_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_moveAxialActuator_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_moveAxialActuator_controller

Verify MTM2 C++ Event Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m2FaultState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m2FaultState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m2AssemblyInPosition_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m2AssemblyInPosition_log

Salgen MTM2 Python
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

Verify MTM2 Python Telemetry Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_mirrorPositionMeasured_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_mirrorPositionMeasured_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_axialForcesMeasured_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_axialForcesMeasured_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_tangentForcesMeasured_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_tangentForcesMeasured_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_zenithAngleMeasured_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_zenithAngleMeasured_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_axialActuatorAbsolutePositionSteps_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_axialActuatorAbsolutePositionSteps_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_tangentActuatorAbsolutePositionSteps_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_tangentActuatorAbsolutePositionSteps_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_axialActuatorPositionAbsoluteEncoderPositionMeasured_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_axialActuatorPositionAbsoluteEncoderPositionMeasured_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_tangentActuatorPositionAbsoluteEncoderPositionMeasured_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_tangentActuatorPositionAbsoluteEncoderPositionMeasured_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_powerStatus_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_powerStatus_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_temperaturesMeasured_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_temperaturesMeasured_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_rawDisplacement_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_rawDisplacement_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_stepVectorUpdate_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_stepVectorUpdate_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_targetForces_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_targetForces_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_systemStatus_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_systemStatus_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_rawTelemetry_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_rawTelemetry_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_actuatorLimitSwitches_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_actuatorLimitSwitches_Subscriber.py

Verify MTM2 Python Command Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_applyBendingMode.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_applyBendingMode.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_applyForce.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_applyForce.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_setCorrectionMode.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_setCorrectionMode.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_positionMirror.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_positionMirror.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_moveAxialActuator.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_moveAxialActuator.py

Verify MTM2 Python Event Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_m2FaultState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_m2FaultState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_m2AssemblyInPosition.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_m2AssemblyInPosition.py

Salgen MTM2 LabVIEW
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

Salgen MTM2 Java
    [Documentation]    Generate Java wrapper.
    [Tags]    java
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} sal java
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_mirrorPositionMeasured.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_axialForcesMeasured.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_tangentForcesMeasured.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_zenithAngleMeasured.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_axialActuatorAbsolutePositionSteps.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_tangentActuatorAbsolutePositionSteps.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_axialActuatorPositionAbsoluteEncoderPositionMeasured.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_tangentActuatorPositionAbsoluteEncoderPositionMeasured.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_powerStatus.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_temperaturesMeasured.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_rawDisplacement.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_stepVectorUpdate.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_targetForces.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_systemStatus.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_rawTelemetry.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_actuatorLimitSwitches.idl
    Should Contain X Times    ${output}    javac : Done Publisher    16
    Should Contain X Times    ${output}    javac : Done Subscriber    16
    Should Contain X Times    ${output}    javac : Done Commander/Controller    16
    Should Contain X Times    ${output}    javac : Done Event/Logger    16
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl

Salgen MTM2 Lib
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

Salgen MTM2 Maven
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

