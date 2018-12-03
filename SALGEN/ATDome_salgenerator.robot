*** Settings ***
Documentation    This suite builds the various interfaces for the ATDome.
Force Tags    salgen    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${timeout}
...    AND    Create Session    SALGEN
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../Global_Vars.robot
Resource    ../common.robot

*** Variables ***
${subSystem}    ATDome
${timeout}    1200s

*** Test Cases ***
Verify ATDome XML Defintions exist
    [Tags]
    Comment    Verify the CSC XML definition files exist.
    ${stdout}    ${stderr}=    Execute Command    ls ${SALWorkDir}/ATDome_*.xml     return_stderr=True
    Should Not Contain    ${stderr}    No such file or directory    msg="ATDome has no XML defintions"    values=False
    Should Not Be Empty    ${stdout}
    File Should Exist    ${SALWorkDir}/ATDome_Commands.xml
    File Should Exist    ${SALWorkDir}/ATDome_Events.xml
    File Should Exist    ${SALWorkDir}/ATDome_Telemetry.xml

Salgen ATDome Validate
    [Documentation]    Validate the ATDome XML definitions.
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
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_timestamp.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_loopTime.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_position.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_moveAzimuth.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_moveShutterDropoutDoor.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_closeShutter.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_stopMotionAllAxis.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_stopShutter.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_openShutter.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_moveShutterMainDoor.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_stopAzimuth.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_azimuthState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_internalCommand.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_heartbeat.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_loopTimeOutOfRange.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_rejectedCommand.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_allAxisInPosition.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_emergencyStop.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_internalStatus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_scbLink.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_shutterInPosition.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_azimuthInPosition.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_azimuthMovingDirection.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_settingsAppliedDomeController.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_dropoutDoorState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_mainDoorState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_settingsAppliedDomeTcp.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_detailedState.idl

Salgen ATDome HTML
    [Documentation]    Create web form interfaces.
    [Tags]    html    
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} html
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - ${SALVersion}
    Should Contain    ${output}    Generating telemetry stream definition editor html
    Should Contain    ${output}    Creating sal-generator-${subSystem} form
    Should Contain    ${output}    Added sal-generator-${subSystem}.timestamp to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.loopTime to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.position to form
    Directory Should Exist    ${SALWorkDir}/html/salgenerator/${subSystem}
    @{files}=    List Directory    ${SALWorkDir}/html/salgenerator/${subSystem}    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/html/${subSystem}/ATDome_Commands.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/ATDome_Events.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/ATDome_Telemetry.html

Salgen ATDome C++
    [Documentation]    Generate C++ wrapper.
    [Tags]    cpp
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} sal cpp
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Not Contain    ${output}    *** DDS error in file
    Should Not Contain    ${output}    Error 1
    Should Contain    ${output}    SAL generator - ${SALVersion}
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_timestamp.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_loopTime.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_position.idl
    Should Contain X Times    ${output}    cpp : Done Publisher    3
    Should Contain X Times    ${output}    cpp : Done Subscriber    3
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

Verify ATDome Telemetry directories
    [Tags]    cpp
    @{files}=    List Directory    ${SALWorkDir}    pattern=*${subSystem}*
    Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/${subSystem}_timestamp
    Directory Should Exist    ${SALWorkDir}/${subSystem}_loopTime
    Directory Should Exist    ${SALWorkDir}/${subSystem}_position

Verify ATDome C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}_timestamp/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_timestamp/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_loopTime/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_loopTime/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_position/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_position/cpp/standalone/sacpp_${subSystem}_sub

Verify ATDome C++ Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_moveAzimuth_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_moveAzimuth_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_moveShutterDropoutDoor_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_moveShutterDropoutDoor_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_closeShutter_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_closeShutter_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_stopMotionAllAxis_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_stopMotionAllAxis_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_stopShutter_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_stopShutter_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_openShutter_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_openShutter_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_moveShutterMainDoor_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_moveShutterMainDoor_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_stopAzimuth_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_stopAzimuth_controller

Verify ATDome C++ Event Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_internalCommand_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_internalCommand_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_heartbeat_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_heartbeat_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_loopTimeOutOfRange_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_loopTimeOutOfRange_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_rejectedCommand_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_rejectedCommand_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_allAxisInPosition_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_allAxisInPosition_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_emergencyStop_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_emergencyStop_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_internalStatus_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_internalStatus_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_scbLink_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_scbLink_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_shutterInPosition_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_shutterInPosition_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthInPosition_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthInPosition_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthMovingDirection_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthMovingDirection_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_settingsAppliedDomeController_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_settingsAppliedDomeController_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_dropoutDoorState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_dropoutDoorState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_mainDoorState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_mainDoorState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_settingsAppliedDomeTcp_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_settingsAppliedDomeTcp_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_detailedState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_detailedState_log

Salgen ATDome Python
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

Verify ATDome Python Telemetry Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_timestamp_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_timestamp_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_loopTime_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_loopTime_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_position_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_position_Subscriber.py

Verify ATDome Python Command Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_moveAzimuth.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_moveAzimuth.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_moveShutterDropoutDoor.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_moveShutterDropoutDoor.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_closeShutter.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_closeShutter.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_stopMotionAllAxis.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_stopMotionAllAxis.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_stopShutter.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_stopShutter.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_openShutter.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_openShutter.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_moveShutterMainDoor.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_moveShutterMainDoor.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_stopAzimuth.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_stopAzimuth.py

Verify ATDome Python Event Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_azimuthState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_azimuthState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_internalCommand.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_internalCommand.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_heartbeat.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_heartbeat.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_loopTimeOutOfRange.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_loopTimeOutOfRange.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_rejectedCommand.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_rejectedCommand.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_allAxisInPosition.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_allAxisInPosition.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_emergencyStop.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_emergencyStop.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_internalStatus.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_internalStatus.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_scbLink.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_scbLink.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_shutterInPosition.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_shutterInPosition.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_azimuthInPosition.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_azimuthInPosition.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_azimuthMovingDirection.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_azimuthMovingDirection.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_settingsAppliedDomeController.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_settingsAppliedDomeController.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_dropoutDoorState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_dropoutDoorState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_mainDoorState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_mainDoorState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_settingsAppliedDomeTcp.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_settingsAppliedDomeTcp.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_detailedState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_detailedState.py

Salgen ATDome LabVIEW
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

Salgen ATDome Java
    [Documentation]    Generate Java wrapper.
    [Tags]    java
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} sal java
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - ${SALVersion}
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_timestamp.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_loopTime.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_position.idl
    Should Contain X Times    ${output}    javac : Done Publisher    3
    Should Contain X Times    ${output}    javac : Done Subscriber    3
    Should Contain X Times    ${output}    javac : Done Commander/Controller    3
    Should Contain X Times    ${output}    javac : Done Event/Logger    3
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl

Salgen ATDome Lib
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

Salgen ATDome Maven
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

