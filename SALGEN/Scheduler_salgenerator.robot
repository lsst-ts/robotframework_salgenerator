*** Settings ***
Documentation    This suite builds the various interfaces for the Scheduler.
Force Tags    salgen    TSS-1789
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${timeout}
...    AND    Create Session    SALGEN
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../Global_Vars.robot
Resource    ../common.robot

*** Variables ***
${subSystem}    scheduler
${timeout}    1200s

*** Test Cases ***
Verify Scheduler XML Defintions exist
    [Tags]
    File Should Exist    ${SALWorkDir}/scheduler_Commands.xml
    File Should Exist    ${SALWorkDir}/scheduler_Events.xml
    File Should Exist    ${SALWorkDir}/scheduler_Telemetry.xml

Salgen Scheduler Validate
    [Documentation]    Validate the Scheduler XML definitions.
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
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_timestamp.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_loopTimeMs.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_nightSummary.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_predictedSchedule.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_surveyTopology.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_schedulerConfig.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_driverConfig.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_obsSiteConfig.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_telescopeConfig.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_rotatorConfig.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_domeConfig.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_cameraConfig.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_slewConfig.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_opticsLoopCorrConfig.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_parkConfig.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_generalPropConfig.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_sequencePropConfig.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_observatoryState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_observation.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_interestedProposal.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_timeHandler.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_bulkCloud.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_cloudMap.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_seeing.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_wind.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_temperature.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_skyBrightness.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_photometricQuality.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_avoidanceRegions.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_downtime.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_disable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_standby.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_start.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_disable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_exitControl.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_standby.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_start.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_enterControl.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_appliedSettingsMatchStart.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_errorCode.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_settingVersions.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_summaryState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_detailedState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_internalCommand.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_heartbeat.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_loopTimeOutOfRange.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_rejectedCommand.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_settingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_validSettings.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_target.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_invalidateTarget.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_needFilterSwap.idl

Salgen Scheduler HTML
    [Documentation]    Create web form interfaces.
    [Tags]
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} html
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating telemetry stream definition editor html
    Should Contain    ${output}    Creating sal-generator-${subSystem} form
    Should Contain    ${output}    Added sal-generator-${subSystem}.logevent to form
    Directory Should Exist    ${SALWorkDir}/html/salgenerator/${subSystem}
    @{files}=    List Directory    ${SALWorkDir}/html/salgenerator/${subSystem}    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/html/${subSystem}/scheduler_Commands.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/scheduler_Events.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/scheduler_Telemetry.html

Salgen Scheduler C++
    [Documentation]    Generate C++ wrapper.
    [Tags]    cpp
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} sal cpp
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Not Contain    ${output}    *** DDS error in file
    Should Not Contain    ${output}    Error 1
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_timestamp.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_loopTimeMs.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_nightSummary.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_predictedSchedule.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_surveyTopology.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_schedulerConfig.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_driverConfig.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_obsSiteConfig.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_telescopeConfig.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_rotatorConfig.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_domeConfig.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_cameraConfig.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_slewConfig.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_opticsLoopCorrConfig.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_parkConfig.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_generalPropConfig.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_sequencePropConfig.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_observatoryState.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_observation.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_interestedProposal.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_timeHandler.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_bulkCloud.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_cloudMap.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_seeing.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_wind.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_temperature.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_skyBrightness.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_photometricQuality.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_avoidanceRegions.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_downtime.idl
    Should Contain X Times    ${output}    cpp : Done Publisher    30
    Should Contain X Times    ${output}    cpp : Done Subscriber    30
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

Verify Scheduler Telemetry directories
    [Tags]    cpp
    @{files}=    List Directory    ${SALWorkDir}    pattern=*${subSystem}*
    Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/${subSystem}_timestamp
    Directory Should Exist    ${SALWorkDir}/${subSystem}_loopTimeMs
    Directory Should Exist    ${SALWorkDir}/${subSystem}_nightSummary
    Directory Should Exist    ${SALWorkDir}/${subSystem}_predictedSchedule
    Directory Should Exist    ${SALWorkDir}/${subSystem}_surveyTopology
    Directory Should Exist    ${SALWorkDir}/${subSystem}_schedulerConfig
    Directory Should Exist    ${SALWorkDir}/${subSystem}_driverConfig
    Directory Should Exist    ${SALWorkDir}/${subSystem}_obsSiteConfig
    Directory Should Exist    ${SALWorkDir}/${subSystem}_telescopeConfig
    Directory Should Exist    ${SALWorkDir}/${subSystem}_rotatorConfig
    Directory Should Exist    ${SALWorkDir}/${subSystem}_domeConfig
    Directory Should Exist    ${SALWorkDir}/${subSystem}_cameraConfig
    Directory Should Exist    ${SALWorkDir}/${subSystem}_slewConfig
    Directory Should Exist    ${SALWorkDir}/${subSystem}_opticsLoopCorrConfig
    Directory Should Exist    ${SALWorkDir}/${subSystem}_parkConfig
    Directory Should Exist    ${SALWorkDir}/${subSystem}_generalPropConfig
    Directory Should Exist    ${SALWorkDir}/${subSystem}_sequencePropConfig
    Directory Should Exist    ${SALWorkDir}/${subSystem}_observatoryState
    Directory Should Exist    ${SALWorkDir}/${subSystem}_observation
    Directory Should Exist    ${SALWorkDir}/${subSystem}_interestedProposal
    Directory Should Exist    ${SALWorkDir}/${subSystem}_timeHandler
    Directory Should Exist    ${SALWorkDir}/${subSystem}_bulkCloud
    Directory Should Exist    ${SALWorkDir}/${subSystem}_cloudMap
    Directory Should Exist    ${SALWorkDir}/${subSystem}_seeing
    Directory Should Exist    ${SALWorkDir}/${subSystem}_wind
    Directory Should Exist    ${SALWorkDir}/${subSystem}_temperature
    Directory Should Exist    ${SALWorkDir}/${subSystem}_skyBrightness
    Directory Should Exist    ${SALWorkDir}/${subSystem}_photometricQuality
    Directory Should Exist    ${SALWorkDir}/${subSystem}_avoidanceRegions
    Directory Should Exist    ${SALWorkDir}/${subSystem}_downtime

Verify Scheduler C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}_timestamp/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_timestamp/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_loopTimeMs/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_loopTimeMs/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_nightSummary/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_nightSummary/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_predictedSchedule/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_predictedSchedule/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_surveyTopology/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_surveyTopology/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_schedulerConfig/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_schedulerConfig/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_driverConfig/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_driverConfig/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_obsSiteConfig/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_obsSiteConfig/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_telescopeConfig/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_telescopeConfig/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_rotatorConfig/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_rotatorConfig/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_domeConfig/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_domeConfig/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_cameraConfig/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_cameraConfig/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_slewConfig/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_slewConfig/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_opticsLoopCorrConfig/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_opticsLoopCorrConfig/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_parkConfig/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_parkConfig/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_generalPropConfig/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_generalPropConfig/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_sequencePropConfig/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_sequencePropConfig/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_observatoryState/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_observatoryState/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_observation/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_observation/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_interestedProposal/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_interestedProposal/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_timeHandler/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_timeHandler/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_bulkCloud/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_bulkCloud/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_cloudMap/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_cloudMap/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_seeing/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_seeing/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_wind/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_wind/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_temperature/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_temperature/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_skyBrightness/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_skyBrightness/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_photometricQuality/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_photometricQuality/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_avoidanceRegions/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_avoidanceRegions/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_downtime/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_downtime/cpp/standalone/sacpp_${subSystem}_sub

Verify Scheduler C++ State Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enable_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enable_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_disable_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_disable_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_standby_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_standby_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_start_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_start_controller

Verify Scheduler C++ Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_disable_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_disable_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enable_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enable_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_exitControl_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_exitControl_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_standby_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_standby_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_start_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_start_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enterControl_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enterControl_controller

Verify Scheduler C++ Event Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedSettingsMatchStart_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedSettingsMatchStart_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_errorCode_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_errorCode_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_settingVersions_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_settingVersions_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_summaryState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_summaryState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_detailedState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_detailedState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_internalCommand_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_internalCommand_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_heartbeat_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_heartbeat_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_loopTimeOutOfRange_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_loopTimeOutOfRange_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_rejectedCommand_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_rejectedCommand_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_settingsApplied_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_settingsApplied_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_validSettings_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_validSettings_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_target_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_target_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_invalidateTarget_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_invalidateTarget_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_needFilterSwap_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_needFilterSwap_log

Salgen Scheduler Python
    [Documentation]    Generate Python wrapper.
    [Tags]    python
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} sal python
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating Python SAL support for ${subSystem}
    Should Contain    ${output}    Generating Boost.Python bindings
    Should Contain    ${output}    python : Done SALPY_${subSystem}.so
    Directory Should Exist    ${SALWorkDir}/${subSystem}/python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/SALPY_${subSystem}.so

Verify Scheduler Python Telemetry Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_timestamp_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_timestamp_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_loopTimeMs_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_loopTimeMs_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_nightSummary_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_nightSummary_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_predictedSchedule_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_predictedSchedule_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_surveyTopology_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_surveyTopology_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_schedulerConfig_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_schedulerConfig_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_driverConfig_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_driverConfig_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_obsSiteConfig_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_obsSiteConfig_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_telescopeConfig_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_telescopeConfig_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_rotatorConfig_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_rotatorConfig_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_domeConfig_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_domeConfig_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_cameraConfig_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_cameraConfig_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_slewConfig_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_slewConfig_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_opticsLoopCorrConfig_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_opticsLoopCorrConfig_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_parkConfig_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_parkConfig_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_generalPropConfig_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_generalPropConfig_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_sequencePropConfig_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_sequencePropConfig_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_observatoryState_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_observatoryState_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_observation_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_observation_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_interestedProposal_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_interestedProposal_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_timeHandler_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_timeHandler_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_bulkCloud_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_bulkCloud_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_cloudMap_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_cloudMap_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_seeing_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_seeing_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_wind_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_wind_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_temperature_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_temperature_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_skyBrightness_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_skyBrightness_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_photometricQuality_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_photometricQuality_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_avoidanceRegions_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_avoidanceRegions_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_downtime_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_downtime_Subscriber.py

Verify Scheduler Python State Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    python
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_enable.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_enable.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_disable.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_disable.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_standby.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_standby.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_start.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_start.py

Verify Scheduler Python Command Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_disable.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_disable.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_enable.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_enable.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_exitControl.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_exitControl.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_standby.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_standby.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_start.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_start.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_enterControl.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_enterControl.py

Verify Scheduler Python Event Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_appliedSettingsMatchStart.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_appliedSettingsMatchStart.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_errorCode.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_errorCode.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_settingVersions.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_settingVersions.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_summaryState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_summaryState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_detailedState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_detailedState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_internalCommand.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_internalCommand.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_heartbeat.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_heartbeat.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_loopTimeOutOfRange.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_loopTimeOutOfRange.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_rejectedCommand.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_rejectedCommand.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_settingsApplied.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_settingsApplied.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_validSettings.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_validSettings.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_target.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_target.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_invalidateTarget.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_invalidateTarget.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_needFilterSwap.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_needFilterSwap.py

Salgen Scheduler Java
    [Documentation]    Generate Java wrapper.
    [Tags]    java
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} sal java
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_timestamp.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_loopTimeMs.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_nightSummary.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_predictedSchedule.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_surveyTopology.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_schedulerConfig.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_driverConfig.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_obsSiteConfig.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_telescopeConfig.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_rotatorConfig.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_domeConfig.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_cameraConfig.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_slewConfig.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_opticsLoopCorrConfig.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_parkConfig.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_generalPropConfig.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_sequencePropConfig.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_observatoryState.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_observation.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_interestedProposal.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_timeHandler.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_bulkCloud.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_cloudMap.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_seeing.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_wind.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_temperature.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_skyBrightness.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_photometricQuality.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_avoidanceRegions.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_downtime.idl
    Should Contain X Times    ${output}    javac : Done Publisher    30
    Should Contain X Times    ${output}    javac : Done Subscriber    30
    Should Contain X Times    ${output}    javac : Done Commander/Controller    30
    Should Contain X Times    ${output}    javac : Done Event/Logger    30
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl

Salgen Scheduler Lib
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
    File Should Exist    ${SALWorkDir}/lib/SALPY_${subSystem}.so

Salgen Scheduler Maven
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

