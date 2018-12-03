*** Settings ***
Documentation    This suite builds the various interfaces for the DomeAPS.
Force Tags    salgen    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${timeout}
...    AND    Create Session    SALGEN
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../Global_Vars.robot
Resource    ../common.robot

*** Variables ***
${subSystem}    DomeAPS
${timeout}    1200s

*** Test Cases ***
Verify DomeAPS XML Defintions exist
    [Tags]
    Comment    Verify the CSC XML definition files exist.
    ${stdout}    ${stderr}=    Execute Command    ls ${SALWorkDir}/DomeAPS_*.xml     return_stderr=True
    Should Not Contain    ${stderr}    No such file or directory    msg="DomeAPS has no XML defintions"    values=False
    Should Not Be Empty    ${stdout}
    File Should Exist    ${SALWorkDir}/DomeAPS_Commands.xml
    File Should Exist    ${SALWorkDir}/DomeAPS_Events.xml
    File Should Exist    ${SALWorkDir}/DomeAPS_Telemetry.xml

Salgen DomeAPS Validate
    [Documentation]    Validate the DomeAPS XML definitions.
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
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_status.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_close.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_open.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_echo.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_stateChanged.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_driveEnabled.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_driveDisabled.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_driveReady.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_driveFault.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_movementEnabled.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_movementPrevented.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_lockingPinEngaged.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_lockingPinDisengaged.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_lockingPinFloating.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_centralLockingPinEngaged.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_lockingPinHomed.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_centralLockingPinDisengaged.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_centralLockingPinHomed.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_centralLockingPinFloating.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_brakeEngaged.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_brakeDisengaged.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_echoResponse.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_apsSubsystemError.idl

Salgen DomeAPS HTML
    [Documentation]    Create web form interfaces.
    [Tags]    html    
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} html
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - ${SALVersion}
    Should Contain    ${output}    Generating telemetry stream definition editor html
    Should Contain    ${output}    Creating sal-generator-${subSystem} form
    Should Contain    ${output}    Added sal-generator-${subSystem}.status to form
    Directory Should Exist    ${SALWorkDir}/html/salgenerator/${subSystem}
    @{files}=    List Directory    ${SALWorkDir}/html/salgenerator/${subSystem}    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/html/${subSystem}/DomeAPS_Commands.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/DomeAPS_Events.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/DomeAPS_Telemetry.html

Salgen DomeAPS C++
    [Documentation]    Generate C++ wrapper.
    [Tags]    cpp
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} sal cpp
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Not Contain    ${output}    *** DDS error in file
    Should Not Contain    ${output}    Error 1
    Should Contain    ${output}    SAL generator - ${SALVersion}
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_status.idl
    Should Contain X Times    ${output}    cpp : Done Publisher    1
    Should Contain X Times    ${output}    cpp : Done Subscriber    1
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

Verify DomeAPS Telemetry directories
    [Tags]    cpp
    @{files}=    List Directory    ${SALWorkDir}    pattern=*${subSystem}*
    Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/${subSystem}_status

Verify DomeAPS C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}_status/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_status/cpp/standalone/sacpp_${subSystem}_sub

Verify DomeAPS C++ Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_close_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_close_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_open_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_open_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_echo_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_echo_controller

Verify DomeAPS C++ Event Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_stateChanged_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_stateChanged_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_driveEnabled_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_driveEnabled_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_driveDisabled_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_driveDisabled_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_driveReady_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_driveReady_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_driveFault_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_driveFault_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_movementEnabled_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_movementEnabled_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_movementPrevented_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_movementPrevented_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_lockingPinEngaged_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_lockingPinEngaged_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_lockingPinDisengaged_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_lockingPinDisengaged_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_lockingPinFloating_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_lockingPinFloating_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_centralLockingPinEngaged_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_centralLockingPinEngaged_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_lockingPinHomed_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_lockingPinHomed_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_centralLockingPinDisengaged_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_centralLockingPinDisengaged_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_centralLockingPinHomed_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_centralLockingPinHomed_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_centralLockingPinFloating_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_centralLockingPinFloating_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_brakeEngaged_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_brakeEngaged_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_brakeDisengaged_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_brakeDisengaged_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_echoResponse_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_echoResponse_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_apsSubsystemError_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_apsSubsystemError_log

Salgen DomeAPS Python
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

Verify DomeAPS Python Telemetry Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_status_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_status_Subscriber.py

Verify DomeAPS Python Command Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_close.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_close.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_open.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_open.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_echo.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_echo.py

Verify DomeAPS Python Event Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_stateChanged.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_stateChanged.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_driveEnabled.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_driveEnabled.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_driveDisabled.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_driveDisabled.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_driveReady.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_driveReady.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_driveFault.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_driveFault.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_movementEnabled.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_movementEnabled.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_movementPrevented.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_movementPrevented.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_lockingPinEngaged.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_lockingPinEngaged.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_lockingPinDisengaged.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_lockingPinDisengaged.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_lockingPinFloating.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_lockingPinFloating.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_centralLockingPinEngaged.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_centralLockingPinEngaged.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_lockingPinHomed.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_lockingPinHomed.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_centralLockingPinDisengaged.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_centralLockingPinDisengaged.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_centralLockingPinHomed.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_centralLockingPinHomed.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_centralLockingPinFloating.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_centralLockingPinFloating.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_brakeEngaged.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_brakeEngaged.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_brakeDisengaged.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_brakeDisengaged.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_echoResponse.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_echoResponse.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_apsSubsystemError.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_apsSubsystemError.py

Salgen DomeAPS LabVIEW
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

Salgen DomeAPS Java
    [Documentation]    Generate Java wrapper.
    [Tags]    java
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} sal java
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - ${SALVersion}
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_status.idl
    Should Contain X Times    ${output}    javac : Done Publisher    1
    Should Contain X Times    ${output}    javac : Done Subscriber    1
    Should Contain X Times    ${output}    javac : Done Commander/Controller    1
    Should Contain X Times    ${output}    javac : Done Event/Logger    1
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl

Salgen DomeAPS Lib
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

Salgen DomeAPS Maven
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

