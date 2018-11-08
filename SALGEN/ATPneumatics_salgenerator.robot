*** Settings ***
Documentation    This suite builds the various interfaces for the ATPneumatics.
Force Tags    salgen    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${timeout}
...    AND    Create Session    SALGEN
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../Global_Vars.robot
Resource    ../common.robot

*** Variables ***
${subSystem}    ATPneumatics
${timeout}    1200s

*** Test Cases ***
Verify ATPneumatics XML Defintions exist
    [Tags]
    Comment    Verify the CSC XML definition files exist.
    File Should Exist    ${SALWorkDir}/ATPneumatics_Commands.xml
    File Should Exist    ${SALWorkDir}/ATPneumatics_Events.xml
    File Should Exist    ${SALWorkDir}/ATPneumatics_Telemetry.xml

Salgen ATPneumatics Validate
    [Documentation]    Validate the ATPneumatics XML definitions.
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
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_m1AirPressure.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_m2AirPressure.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_mainAirSourcePressure.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_loadCell.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_openMasterAirSupply.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_m1SetPressure.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_m2SetPressure.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_openM1CellVents.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_openM1Cover.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_openInstrumentAirValve.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_closeInstrumentAirValve.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_closeMasterAirSupply.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_closeM1Cover.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_m2OpenAirValve.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_m2CloseAirValve.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_m1CloseAirValve.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_m1OpenAirValve.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_closeM1CellVents.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_m1CoverLimitSwitches.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_m1VentsLimitSwitches.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_powerStatus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_eStopTriggered.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_resetEStopTriggered.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_m1CoverState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_m1State.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_m2State.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_instrumentState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_cellVentsState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_mainValveState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_m1CoverPosition.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_m1VentsPosition.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_detailedState.idl

Salgen ATPneumatics HTML
    [Documentation]    Create web form interfaces.
    [Tags]    html    TSS-3079
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} html
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - ${SALVersion}
    Should Contain    ${output}    Generating telemetry stream definition editor html
    Should Contain    ${output}    Creating sal-generator-${subSystem} form
    Should Contain    ${output}    Added sal-generator-${subSystem}.m1AirPressure to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.m2AirPressure to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.mainAirSourcePressure to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.loadCell to form
    Directory Should Exist    ${SALWorkDir}/html/salgenerator/${subSystem}
    @{files}=    List Directory    ${SALWorkDir}/html/salgenerator/${subSystem}    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/html/${subSystem}/ATPneumatics_Commands.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/ATPneumatics_Events.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/ATPneumatics_Telemetry.html

Salgen ATPneumatics C++
    [Documentation]    Generate C++ wrapper.
    [Tags]    cpp
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} sal cpp
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Not Contain    ${output}    *** DDS error in file
    Should Not Contain    ${output}    Error 1
    Should Contain    ${output}    SAL generator - ${SALVersion}
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_m1AirPressure.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_m2AirPressure.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_mainAirSourcePressure.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_loadCell.idl
    Should Contain X Times    ${output}    cpp : Done Publisher    4
    Should Contain X Times    ${output}    cpp : Done Subscriber    4
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

Verify ATPneumatics Telemetry directories
    [Tags]    cpp
    @{files}=    List Directory    ${SALWorkDir}    pattern=*${subSystem}*
    Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/${subSystem}_m1AirPressure
    Directory Should Exist    ${SALWorkDir}/${subSystem}_m2AirPressure
    Directory Should Exist    ${SALWorkDir}/${subSystem}_mainAirSourcePressure
    Directory Should Exist    ${SALWorkDir}/${subSystem}_loadCell

Verify ATPneumatics C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}_m1AirPressure/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_m1AirPressure/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_m2AirPressure/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_m2AirPressure/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_mainAirSourcePressure/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_mainAirSourcePressure/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_loadCell/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_loadCell/cpp/standalone/sacpp_${subSystem}_sub

Verify ATPneumatics C++ Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_openMasterAirSupply_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_openMasterAirSupply_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m1SetPressure_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m1SetPressure_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m2SetPressure_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m2SetPressure_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_openM1CellVents_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_openM1CellVents_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_openM1Cover_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_openM1Cover_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_openInstrumentAirValve_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_openInstrumentAirValve_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_closeInstrumentAirValve_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_closeInstrumentAirValve_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_closeMasterAirSupply_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_closeMasterAirSupply_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_closeM1Cover_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_closeM1Cover_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m2OpenAirValve_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m2OpenAirValve_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m2CloseAirValve_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m2CloseAirValve_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m1CloseAirValve_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m1CloseAirValve_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m1OpenAirValve_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m1OpenAirValve_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_closeM1CellVents_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_closeM1CellVents_controller

Verify ATPneumatics C++ Event Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m1CoverLimitSwitches_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m1CoverLimitSwitches_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m1VentsLimitSwitches_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m1VentsLimitSwitches_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_powerStatus_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_powerStatus_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_eStopTriggered_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_eStopTriggered_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_resetEStopTriggered_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_resetEStopTriggered_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m1CoverState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m1CoverState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m1State_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m1State_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m2State_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m2State_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_instrumentState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_instrumentState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_cellVentsState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_cellVentsState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_mainValveState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_mainValveState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m1CoverPosition_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m1CoverPosition_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m1VentsPosition_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m1VentsPosition_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_detailedState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_detailedState_log

Salgen ATPneumatics Python
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

Verify ATPneumatics Python Telemetry Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_m1AirPressure_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_m1AirPressure_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_m2AirPressure_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_m2AirPressure_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_mainAirSourcePressure_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_mainAirSourcePressure_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_loadCell_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_loadCell_Subscriber.py

Verify ATPneumatics Python Command Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_openMasterAirSupply.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_openMasterAirSupply.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_m1SetPressure.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_m1SetPressure.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_m2SetPressure.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_m2SetPressure.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_openM1CellVents.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_openM1CellVents.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_openM1Cover.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_openM1Cover.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_openInstrumentAirValve.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_openInstrumentAirValve.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_closeInstrumentAirValve.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_closeInstrumentAirValve.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_closeMasterAirSupply.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_closeMasterAirSupply.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_closeM1Cover.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_closeM1Cover.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_m2OpenAirValve.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_m2OpenAirValve.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_m2CloseAirValve.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_m2CloseAirValve.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_m1CloseAirValve.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_m1CloseAirValve.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_m1OpenAirValve.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_m1OpenAirValve.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_closeM1CellVents.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_closeM1CellVents.py

Verify ATPneumatics Python Event Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_m1CoverLimitSwitches.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_m1CoverLimitSwitches.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_m1VentsLimitSwitches.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_m1VentsLimitSwitches.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_powerStatus.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_powerStatus.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_eStopTriggered.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_eStopTriggered.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_resetEStopTriggered.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_resetEStopTriggered.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_m1CoverState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_m1CoverState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_m1State.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_m1State.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_m2State.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_m2State.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_instrumentState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_instrumentState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_cellVentsState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_cellVentsState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_mainValveState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_mainValveState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_m1CoverPosition.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_m1CoverPosition.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_m1VentsPosition.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_m1VentsPosition.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_detailedState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_detailedState.py

Salgen ATPneumatics LabVIEW
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

Salgen ATPneumatics Java
    [Documentation]    Generate Java wrapper.
    [Tags]    java
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} sal java
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - ${SALVersion}
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_m1AirPressure.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_m2AirPressure.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_mainAirSourcePressure.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_loadCell.idl
    Should Contain X Times    ${output}    javac : Done Publisher    4
    Should Contain X Times    ${output}    javac : Done Subscriber    4
    Should Contain X Times    ${output}    javac : Done Commander/Controller    4
    Should Contain X Times    ${output}    javac : Done Event/Logger    4
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl

Salgen ATPneumatics Lib
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

Salgen ATPneumatics Maven
    [Documentation]    Generate the Maven repository.
    [Tags]    java
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

