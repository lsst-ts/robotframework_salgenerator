*** Settings ***
Documentation    This suite builds the various interfaces for the EEC.
Force Tags    salgen    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${timeout}
...    AND    Create Session    SALGEN
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../Global_Vars.robot
Resource    ../common.robot

*** Variables ***
${subSystem}    eec
${timeout}    1200s

*** Test Cases ***
Verify EEC XML Defintions exist
    [Tags]
    File Should Exist    ${SALWorkDir}/eec_Commands.xml
    File Should Exist    ${SALWorkDir}/eec_Events.xml
    File Should Exist    ${SALWorkDir}/eec_Telemetry.xml

Salgen EEC Validate
    [Documentation]    Validate the EEC XML definitions.
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
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_hvacTelem.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_timestamp.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_nightSetPoint.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_eecTelem.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_loopTimeMs.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_daySetPoint.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_operatoMode.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_nightTimeMode.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_exitControl.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_setHVAC.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_dayTimeMode.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_setLouvers.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_start.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_engineeringMode.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_standby.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_disable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_appliedSettingsMatchStart.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_nightTimeFail.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_rejectedCommand.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_settingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_detailedState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_dayTimeFail.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_internalCommand.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_loopTimeOutOfRange.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_summaryState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_errorCode.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_heartbeat.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_settingVersions.idl

Salgen EEC HTML
    [Documentation]    Create web form interfaces.
    [Tags]
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} html
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating telemetry stream definition editor html
    Should Contain    ${output}    Creating sal-generator-${subSystem} form
    Should Contain    ${output}    Added sal-generator-${subSystem}.hvacTelem to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.timestamp to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.nightSetPoint to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.eecTelem to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.loopTimeMs to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.daySetPoint to form
    Directory Should Exist    ${SALWorkDir}/html/salgenerator/${subSystem}
    @{files}=    List Directory    ${SALWorkDir}/html/salgenerator/${subSystem}    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/html/${subSystem}/eec_Commands.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/eec_Events.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/eec_Telemetry.html

Salgen EEC C++
    [Documentation]    Generate C++ wrapper.
    [Tags]    cpp
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} sal cpp
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Not Contain    ${output}    *** DDS error in file
    Should Not Contain    ${output}    Error 1
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_hvacTelem.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_timestamp.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_nightSetPoint.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_eecTelem.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_loopTimeMs.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_daySetPoint.idl
    Should Contain X Times    ${output}    cpp : Done Publisher    6
    Should Contain X Times    ${output}    cpp : Done Subscriber    6
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

Verify EEC Telemetry directories
    [Tags]    cpp
    @{files}=    List Directory    ${SALWorkDir}    pattern=*${subSystem}*
    Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/${subSystem}_hvacTelem
    Directory Should Exist    ${SALWorkDir}/${subSystem}_timestamp
    Directory Should Exist    ${SALWorkDir}/${subSystem}_nightSetPoint
    Directory Should Exist    ${SALWorkDir}/${subSystem}_eecTelem
    Directory Should Exist    ${SALWorkDir}/${subSystem}_loopTimeMs
    Directory Should Exist    ${SALWorkDir}/${subSystem}_daySetPoint

Verify EEC C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}_hvacTelem/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_hvacTelem/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_timestamp/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_timestamp/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_nightSetPoint/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_nightSetPoint/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_eecTelem/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_eecTelem/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_loopTimeMs/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_loopTimeMs/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_daySetPoint/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_daySetPoint/cpp/standalone/sacpp_${subSystem}_sub

Verify EEC C++ Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_operatoMode_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_operatoMode_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nightTimeMode_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nightTimeMode_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enable_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enable_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_exitControl_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_exitControl_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setHVAC_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setHVAC_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_dayTimeMode_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_dayTimeMode_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setLouvers_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setLouvers_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_start_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_start_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_engineeringMode_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_engineeringMode_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_standby_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_standby_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_disable_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_disable_controller

Verify EEC C++ Event Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedSettingsMatchStart_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedSettingsMatchStart_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nightTimeFail_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nightTimeFail_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_rejectedCommand_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_rejectedCommand_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_settingsApplied_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_settingsApplied_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_detailedState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_detailedState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_dayTimeFail_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_dayTimeFail_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_internalCommand_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_internalCommand_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_loopTimeOutOfRange_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_loopTimeOutOfRange_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_summaryState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_summaryState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_errorCode_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_errorCode_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_heartbeat_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_heartbeat_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_settingVersions_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_settingVersions_log

Salgen EEC Python
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

Verify EEC Python Telemetry Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_hvacTelem_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_hvacTelem_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_timestamp_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_timestamp_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_nightSetPoint_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_nightSetPoint_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_eecTelem_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_eecTelem_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_loopTimeMs_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_loopTimeMs_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_daySetPoint_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_daySetPoint_Subscriber.py

Verify EEC Python Command Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_operatoMode.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_operatoMode.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_nightTimeMode.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_nightTimeMode.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_enable.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_enable.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_exitControl.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_exitControl.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_setHVAC.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_setHVAC.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_dayTimeMode.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_dayTimeMode.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_setLouvers.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_setLouvers.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_start.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_start.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_engineeringMode.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_engineeringMode.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_standby.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_standby.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_disable.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_disable.py

Verify EEC Python Event Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_appliedSettingsMatchStart.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_appliedSettingsMatchStart.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_nightTimeFail.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_nightTimeFail.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_rejectedCommand.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_rejectedCommand.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_settingsApplied.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_settingsApplied.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_detailedState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_detailedState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_dayTimeFail.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_dayTimeFail.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_internalCommand.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_internalCommand.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_loopTimeOutOfRange.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_loopTimeOutOfRange.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_summaryState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_summaryState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_errorCode.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_errorCode.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_heartbeat.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_heartbeat.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_settingVersions.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_settingVersions.py

Salgen EEC LabVIEW
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

Salgen EEC Java
    [Documentation]    Generate Java wrapper.
    [Tags]    java
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} sal java
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_hvacTelem.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_timestamp.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_nightSetPoint.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_eecTelem.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_loopTimeMs.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_daySetPoint.idl
    Should Contain X Times    ${output}    javac : Done Publisher    6
    Should Contain X Times    ${output}    javac : Done Subscriber    6
    Should Contain X Times    ${output}    javac : Done Commander/Controller    6
    Should Contain X Times    ${output}    javac : Done Event/Logger    6
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl

Salgen EEC Lib
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

Salgen EEC Maven
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

