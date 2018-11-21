*** Settings ***
Documentation    This suite builds the various interfaces for the ScriptQueue.
Force Tags    salgen    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${timeout}
...    AND    Create Session    SALGEN
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../Global_Vars.robot
Resource    ../common.robot

*** Variables ***
${subSystem}    ScriptQueue
${timeout}    1200s

*** Test Cases ***
Verify ScriptQueue XML Defintions exist
    [Tags]
    Comment    Verify the CSC XML definition files exist.
    File Should Exist    ${SALWorkDir}/ScriptQueue_Commands.xml
    File Should Exist    ${SALWorkDir}/ScriptQueue_Events.xml

Salgen ScriptQueue Validate
    [Documentation]    Validate the ScriptQueue XML definitions.
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
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_showAvailableScripts.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_showQueue.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_showScript.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_pause.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_resume.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_add.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_move.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_requeue.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_stopScripts.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_heartbeat.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_availableScripts.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_script.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_queue.idl

Salgen ScriptQueue HTML
    [Documentation]    Create web form interfaces.
    [Tags]    html    
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} html
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - ${SALVersion}
    Should Contain    ${output}    Generating telemetry stream definition editor html
    Should Contain    ${output}    Creating sal-generator-${subSystem} form
    Directory Should Exist    ${SALWorkDir}/html/salgenerator/${subSystem}
    @{files}=    List Directory    ${SALWorkDir}/html/salgenerator/${subSystem}    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/html/${subSystem}/ScriptQueue_Commands.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/ScriptQueue_Events.html

Salgen ScriptQueue C++
    [Documentation]    Generate C++ wrapper.
    [Tags]    cpp
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} sal cpp
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Not Contain    ${output}    *** DDS error in file
    Should Not Contain    ${output}    Error 1
    Should Contain    ${output}    SAL generator - ${SALVersion}
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

Verify ScriptQueue C++ Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_showAvailableScripts_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_showAvailableScripts_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_showQueue_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_showQueue_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_showScript_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_showScript_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_pause_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_pause_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_resume_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_resume_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_add_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_add_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_move_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_move_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_requeue_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_requeue_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_stopScripts_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_stopScripts_controller

Verify ScriptQueue C++ Event Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_heartbeat_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_heartbeat_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_availableScripts_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_availableScripts_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_script_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_script_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_queue_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_queue_log

Salgen ScriptQueue Python
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

Verify ScriptQueue Python Command Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_showAvailableScripts.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_showAvailableScripts.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_showQueue.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_showQueue.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_showScript.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_showScript.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_pause.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_pause.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_resume.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_resume.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_add.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_add.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_move.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_move.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_requeue.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_requeue.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_stopScripts.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_stopScripts.py

Verify ScriptQueue Python Event Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_heartbeat.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_heartbeat.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_availableScripts.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_availableScripts.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_script.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_script.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_queue.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_queue.py

Salgen ScriptQueue LabVIEW
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

Salgen ScriptQueue Java
    [Documentation]    Generate Java wrapper.
    [Tags]    java
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} sal java
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - ${SALVersion}
    Should Contain X Times    ${output}    javac : Done Publisher    1
    Should Contain X Times    ${output}    javac : Done Subscriber    1
    Should Contain X Times    ${output}    javac : Done Commander/Controller    1
    Should Contain X Times    ${output}    javac : Done Event/Logger    1
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl

Salgen ScriptQueue Lib
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

Salgen ScriptQueue Maven
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

