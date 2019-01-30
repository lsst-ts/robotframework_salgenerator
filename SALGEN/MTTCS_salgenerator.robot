*** Settings ***
Documentation    This suite builds the various interfaces for the MTTCS.
Force Tags    salgen    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${timeout}
Library    OperatingSystem
Resource    ../Global_Vars.resource

*** Variables ***
${subSystem}    MTTCS
${timeout}    1200s

*** Test Cases ***
Verify MTTCS XML Defintions exist
    [Tags]
    Comment    Verify the CSC XML definition files exist.
    ${stdout}    Run    ls ${SALWorkDir}/MTTCS_*.xml 2>&1
    Should Not Contain    ${stdout}    No such file or directory    msg="MTTCS has no XML defintions"    values=False
    Should Not Be Empty    ${stdout}
    File Should Exist    ${SALWorkDir}/MTTCS_Commands.xml
    File Should Exist    ${SALWorkDir}/MTTCS_Events.xml
    File Should Exist    ${SALWorkDir}/MTTCS_Telemetry.xml

Salgen MTTCS Validate
    [Documentation]    Validate the MTTCS XML definitions.
    [Tags]
    ${output}=    Run    cd ${SALWorkDir}
    ${output}=    Run    ${SALHome}/scripts/salgenerator ${subSystem} validate
    Log    ${output}
    Should Contain    ${output}    SAL generator - ${SALVersion}
    Should Contain    ${output}    Processing ${subSystem}
    Should Contain    ${output}    Completed ${subSystem} validation
    Directory Should Exist    ${SALWorkDir}/idl-templates
    Directory Should Exist    ${SALWorkDir}/idl-templates/validated
    @{files}=    List Directory    ${SALWorkDir}/idl-templates    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_kernelPointingModel.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_aOCS.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_kernelTimeKeeper.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_kernelSite.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_kernelTarget.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_kernelPointingControl.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_kernelTrackRefSys.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_zEMAX.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_kernelPointingLog.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_kernelDawdleFilter.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_kernelOpticsVt.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_wEP.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_kernelTrackingTarget.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_kernelFK5Target.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_loopTime.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_timestamp.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_wfpCalculate.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_wfpSimulate.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_filterChangeRequest.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_stopMotion.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_target.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_wfpDataReady.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_zemaxError.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_internalCommand.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_detailedState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_heartbeat.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_loopTimeOutOfRange.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_rejectedCommand.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_heartbeatIn.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_filterChangeInPosition.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_targetInPosition.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_settingsApplied.idl

Salgen MTTCS HTML
    [Documentation]    Create web form interfaces.
    [Tags]    html    
    ${output}=    Run    ${SALHome}/scripts/salgenerator ${subSystem} html
    Log    ${output}
    Should Contain    ${output}    SAL generator - ${SALVersion}
    Should Contain    ${output}    Generating telemetry stream definition editor html
    Should Contain    ${output}    Creating sal-generator-${subSystem} form
    Should Contain    ${output}    Added sal-generator-${subSystem}.kernelPointingModel to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.aOCS to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.kernelTimeKeeper to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.kernelSite to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.kernelTarget to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.kernelPointingControl to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.kernelTrackRefSys to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.zEMAX to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.kernelPointingLog to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.kernelDawdleFilter to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.kernelOpticsVt to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.wEP to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.kernelTrackingTarget to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.kernelFK5Target to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.loopTime to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.timestamp to form
    Directory Should Exist    ${SALWorkDir}/html/salgenerator/${subSystem}
    @{files}=    List Directory    ${SALWorkDir}/html/salgenerator/${subSystem}    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/html/${subSystem}/MTTCS_Commands.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/MTTCS_Events.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/MTTCS_Telemetry.html

Salgen MTTCS C++
    [Documentation]    Generate C++ wrapper.
    [Tags]    cpp
    ${output}=    Run    ${SALHome}/scripts/salgenerator ${subSystem} sal cpp
    Log    ${output}
    Should Not Contain    ${output}    *** DDS error in file
    Should Not Contain    ${output}    Error 1
    Should Contain    ${output}    SAL generator - ${SALVersion}
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_kernelPointingModel.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_aOCS.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_kernelTimeKeeper.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_kernelSite.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_kernelTarget.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_kernelPointingControl.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_kernelTrackRefSys.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_zEMAX.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_kernelPointingLog.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_kernelDawdleFilter.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_kernelOpticsVt.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_wEP.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_kernelTrackingTarget.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_kernelFK5Target.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_loopTime.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_timestamp.idl
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

Verify MTTCS Telemetry directories
    [Tags]    cpp
    @{files}=    List Directory    ${SALWorkDir}    pattern=*${subSystem}*
    Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/${subSystem}_kernelPointingModel
    Directory Should Exist    ${SALWorkDir}/${subSystem}_aOCS
    Directory Should Exist    ${SALWorkDir}/${subSystem}_kernelTimeKeeper
    Directory Should Exist    ${SALWorkDir}/${subSystem}_kernelSite
    Directory Should Exist    ${SALWorkDir}/${subSystem}_kernelTarget
    Directory Should Exist    ${SALWorkDir}/${subSystem}_kernelPointingControl
    Directory Should Exist    ${SALWorkDir}/${subSystem}_kernelTrackRefSys
    Directory Should Exist    ${SALWorkDir}/${subSystem}_zEMAX
    Directory Should Exist    ${SALWorkDir}/${subSystem}_kernelPointingLog
    Directory Should Exist    ${SALWorkDir}/${subSystem}_kernelDawdleFilter
    Directory Should Exist    ${SALWorkDir}/${subSystem}_kernelOpticsVt
    Directory Should Exist    ${SALWorkDir}/${subSystem}_wEP
    Directory Should Exist    ${SALWorkDir}/${subSystem}_kernelTrackingTarget
    Directory Should Exist    ${SALWorkDir}/${subSystem}_kernelFK5Target
    Directory Should Exist    ${SALWorkDir}/${subSystem}_loopTime
    Directory Should Exist    ${SALWorkDir}/${subSystem}_timestamp

Verify MTTCS C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}_kernelPointingModel/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_kernelPointingModel/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_aOCS/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_aOCS/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_kernelTimeKeeper/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_kernelTimeKeeper/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_kernelSite/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_kernelSite/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_kernelTarget/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_kernelTarget/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_kernelPointingControl/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_kernelPointingControl/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_kernelTrackRefSys/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_kernelTrackRefSys/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_zEMAX/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_zEMAX/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_kernelPointingLog/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_kernelPointingLog/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_kernelDawdleFilter/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_kernelDawdleFilter/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_kernelOpticsVt/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_kernelOpticsVt/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_wEP/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_wEP/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_kernelTrackingTarget/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_kernelTrackingTarget/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_kernelFK5Target/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_kernelFK5Target/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_loopTime/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_loopTime/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_timestamp/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_timestamp/cpp/standalone/sacpp_${subSystem}_sub

Verify MTTCS C++ Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_wfpCalculate_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_wfpCalculate_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_wfpSimulate_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_wfpSimulate_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_filterChangeRequest_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_filterChangeRequest_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_stopMotion_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_stopMotion_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_target_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_target_controller

Verify MTTCS C++ Event Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_wfpDataReady_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_wfpDataReady_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_zemaxError_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_zemaxError_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_internalCommand_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_internalCommand_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_detailedState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_detailedState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_heartbeat_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_heartbeat_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_loopTimeOutOfRange_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_loopTimeOutOfRange_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_rejectedCommand_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_rejectedCommand_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_heartbeatIn_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_heartbeatIn_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_filterChangeInPosition_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_filterChangeInPosition_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_targetInPosition_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_targetInPosition_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_settingsApplied_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_settingsApplied_log

Salgen MTTCS Python
    [Documentation]    Generate Python wrapper.
    [Tags]    python
    ${output}=    Run    ${SALHome}/scripts/salgenerator ${subSystem} sal python
    Log    ${output}
    Should Contain    ${output}    SAL generator - ${SALVersion}
    Should Contain    ${output}    Generating Python SAL support for ${subSystem}
    Should Contain    ${output}    Generating Python bindings
    Should Contain    ${output}    python : Done SALPY_${subSystem}.so
    Directory Should Exist    ${SALWorkDir}/${subSystem}/python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/SALPY_${subSystem}.so

Verify MTTCS Python Telemetry Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_kernelPointingModel_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_kernelPointingModel_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_aOCS_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_aOCS_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_kernelTimeKeeper_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_kernelTimeKeeper_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_kernelSite_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_kernelSite_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_kernelTarget_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_kernelTarget_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_kernelPointingControl_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_kernelPointingControl_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_kernelTrackRefSys_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_kernelTrackRefSys_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_zEMAX_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_zEMAX_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_kernelPointingLog_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_kernelPointingLog_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_kernelDawdleFilter_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_kernelDawdleFilter_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_kernelOpticsVt_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_kernelOpticsVt_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_wEP_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_wEP_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_kernelTrackingTarget_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_kernelTrackingTarget_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_kernelFK5Target_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_kernelFK5Target_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_loopTime_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_loopTime_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_timestamp_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_timestamp_Subscriber.py

Verify MTTCS Python Command Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_wfpCalculate.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_wfpCalculate.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_wfpSimulate.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_wfpSimulate.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_filterChangeRequest.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_filterChangeRequest.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_stopMotion.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_stopMotion.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_target.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_target.py

Verify MTTCS Python Event Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_wfpDataReady.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_wfpDataReady.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_zemaxError.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_zemaxError.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_internalCommand.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_internalCommand.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_detailedState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_detailedState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_heartbeat.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_heartbeat.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_loopTimeOutOfRange.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_loopTimeOutOfRange.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_rejectedCommand.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_rejectedCommand.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_heartbeatIn.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_heartbeatIn.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_filterChangeInPosition.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_filterChangeInPosition.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_targetInPosition.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_targetInPosition.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_settingsApplied.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_settingsApplied.py

Salgen MTTCS LabVIEW
    [Documentation]    Generate ${subSystem} low-level LabView interfaces.
    [Tags]    labview
    ${output}=    Run    ${SALHome}/scripts/salgenerator ${subSystem} labview
    Log    ${output}
    Should Contain    ${output}    SAL generator - ${SALVersion}
    Directory Should Exist    ${SALWorkDir}/${subSystem}/labview
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/labview
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/labview/SAL_${subSystem}_salShmMonitor.cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/labview/SAL_${subSystem}_shmem.h
    File Should Exist    ${SALWorkDir}/${subSystem}/labview/SALLV_${subSystem}.so
    File Should Exist    ${SALWorkDir}/${subSystem}/labview/SALLV_${subSystem}_Monitor

Salgen MTTCS Java
    [Documentation]    Generate Java wrapper.
    [Tags]    java
    ${output}=    Run    ${SALHome}/scripts/salgenerator ${subSystem} sal java
    Log    ${output}
    Should Contain    ${output}    SAL generator - ${SALVersion}
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_kernelPointingModel.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_aOCS.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_kernelTimeKeeper.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_kernelSite.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_kernelTarget.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_kernelPointingControl.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_kernelTrackRefSys.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_zEMAX.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_kernelPointingLog.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_kernelDawdleFilter.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_kernelOpticsVt.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_wEP.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_kernelTrackingTarget.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_kernelFK5Target.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_loopTime.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_timestamp.idl
    Should Contain X Times    ${output}    javac : Done Publisher    16
    Should Contain X Times    ${output}    javac : Done Subscriber    16
    Should Contain X Times    ${output}    javac : Done Commander/Controller    16
    Should Contain X Times    ${output}    javac : Done Event/Logger    16
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl

Salgen MTTCS Lib
    [Documentation]    Generate the SAL shared library for ${subSystem}
    [Tags]    
    ${output}=    Run    ${SALHome}/scripts/salgenerator ${subSystem} lib
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

Salgen MTTCS Maven
    [Documentation]    Generate the Maven repository.
    [Tags]    java
    ${output}=    Run    ${SALHome}/scripts/salgenerator ${subSystem} maven
    Log    ${output}
    Should Contain    ${output}    SAL generator - ${SALVersion}
    Should Contain    ${output}    Running maven install
    Should Contain    ${output}    [INFO] Building sal_${subSystem} ${SALVersion}
    Should Contain X Times    ${output}    [INFO] BUILD SUCCESS    1
    Should Contain X Times    ${output}    [INFO] Finished at:    1
    @{files}=    List Directory    ${SALWorkDir}/maven
    File Should Exist    ${SALWorkDir}/maven/${subSystem}_${SALVersion}/pom.xml

