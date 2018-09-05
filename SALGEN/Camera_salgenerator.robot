*** Settings ***
Documentation    This suite builds the various interfaces for the Camera.
Force Tags    salgen    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${timeout}
...    AND    Create Session    SALGEN
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../Global_Vars.robot
Resource    ../common.robot

*** Variables ***
${subSystem}    camera
${timeout}    1200s

*** Test Cases ***
Verify Camera XML Defintions exist
    [Tags]
    File Should Exist    ${SALWorkDir}/camera_Commands.xml
    File Should Exist    ${SALWorkDir}/camera_Events.xml
    File Should Exist    ${SALWorkDir}/camera_Telemetry.xml

Salgen Camera Validate
    [Documentation]    Validate the Camera XML definitions.
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
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_shutter.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_prot.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_filter.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_heartbeat.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_was.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_ccs.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_clusterEncoder.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_cyro.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_purge.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_wds.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_gds.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_sds.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_gas.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_pcms.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_sas.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_cold.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_discardRows.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_setValue.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_startImage.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_disableCalibration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_initGuiders.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_standby.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_enableCalibration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_initImage.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_enterControl.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_endImage.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_setFilter.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_disable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_abort.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_clear.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_exitControl.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_takeImages.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_start.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_stop.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_offlineDetailedState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_endReadout.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_endTakeImage.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_imageReadinessDetailedState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_settingVersions.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_startSetFilter.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_startUnloadFilter.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_notReadyToTakeImage.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_startShutterClose.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_appliedSettingsMatchStart.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_errorCode.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_endInitializeGuider.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_endShutterClose.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_endOfImageTelemetry.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_endUnloadFilter.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_calibrationDetailedState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_endRotateCarousel.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_startLoadFilter.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_filterChangerDetailedState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_shutterDetailedState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_readyToTakeImage.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ccsCommandState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_prepareToTakeImage.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ccsConfigured.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_endLoadFilter.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_endShutterOpen.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_startIntegration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_summaryState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_endInitializeImage.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_settingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_endSetFilter.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_startShutterOpen.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_raftsDetailedState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_availableFilters.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_startReadout.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_startRotateCarousel.idl

Salgen Camera HTML
    [Documentation]    Create web form interfaces.
    [Tags]
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} html
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating telemetry stream definition editor html
    Should Contain    ${output}    Creating sal-generator-${subSystem} form
    Should Contain    ${output}    Added sal-generator-${subSystem}.shutter to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.prot to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.filter to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.heartbeat to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.was to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.ccs to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.clusterEncoder to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.cyro to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.purge to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.wds to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.gds to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.sds to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.gas to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.pcms to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.sas to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.cold to form
    Directory Should Exist    ${SALWorkDir}/html/salgenerator/${subSystem}
    @{files}=    List Directory    ${SALWorkDir}/html/salgenerator/${subSystem}    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/html/${subSystem}/camera_Commands.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/camera_Events.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/camera_Telemetry.html

Salgen Camera C++
    [Documentation]    Generate C++ wrapper.
    [Tags]    cpp
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} sal cpp
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Not Contain    ${output}    *** DDS error in file
    Should Not Contain    ${output}    Error 1
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_shutter.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_prot.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_filter.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_heartbeat.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_was.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_ccs.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_clusterEncoder.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_cyro.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_purge.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_wds.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_gds.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_sds.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_gas.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_pcms.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_sas.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_cold.idl
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

Verify Camera Telemetry directories
    [Tags]    cpp
    @{files}=    List Directory    ${SALWorkDir}    pattern=*${subSystem}*
    Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/${subSystem}_shutter
    Directory Should Exist    ${SALWorkDir}/${subSystem}_prot
    Directory Should Exist    ${SALWorkDir}/${subSystem}_filter
    Directory Should Exist    ${SALWorkDir}/${subSystem}_heartbeat
    Directory Should Exist    ${SALWorkDir}/${subSystem}_was
    Directory Should Exist    ${SALWorkDir}/${subSystem}_ccs
    Directory Should Exist    ${SALWorkDir}/${subSystem}_clusterEncoder
    Directory Should Exist    ${SALWorkDir}/${subSystem}_cyro
    Directory Should Exist    ${SALWorkDir}/${subSystem}_purge
    Directory Should Exist    ${SALWorkDir}/${subSystem}_wds
    Directory Should Exist    ${SALWorkDir}/${subSystem}_gds
    Directory Should Exist    ${SALWorkDir}/${subSystem}_sds
    Directory Should Exist    ${SALWorkDir}/${subSystem}_gas
    Directory Should Exist    ${SALWorkDir}/${subSystem}_pcms
    Directory Should Exist    ${SALWorkDir}/${subSystem}_sas
    Directory Should Exist    ${SALWorkDir}/${subSystem}_cold

Verify Camera C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}_shutter/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_shutter/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_prot/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_prot/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_filter/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_filter/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_heartbeat/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_heartbeat/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_was/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_was/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_ccs/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_ccs/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_clusterEncoder/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_clusterEncoder/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_cyro/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_cyro/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_purge/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_purge/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_wds/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_wds/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_gds/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_gds/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_sds/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_sds/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_gas/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_gas/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_pcms/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_pcms/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_sas/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_sas/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_cold/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_cold/cpp/standalone/sacpp_${subSystem}_sub

Verify Camera C++ Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_discardRows_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_discardRows_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enable_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enable_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setValue_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setValue_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startImage_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startImage_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_disableCalibration_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_disableCalibration_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_initGuiders_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_initGuiders_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_standby_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_standby_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enableCalibration_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enableCalibration_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_initImage_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_initImage_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enterControl_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enterControl_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endImage_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endImage_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setFilter_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setFilter_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_disable_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_disable_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_abort_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_abort_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_clear_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_clear_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_exitControl_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_exitControl_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_takeImages_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_takeImages_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_start_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_start_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_stop_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_stop_controller

Verify Camera C++ Event Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_offlineDetailedState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_offlineDetailedState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endReadout_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endReadout_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endTakeImage_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endTakeImage_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_imageReadinessDetailedState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_imageReadinessDetailedState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_settingVersions_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_settingVersions_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startSetFilter_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startSetFilter_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startUnloadFilter_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startUnloadFilter_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_notReadyToTakeImage_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_notReadyToTakeImage_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startShutterClose_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startShutterClose_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedSettingsMatchStart_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedSettingsMatchStart_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_errorCode_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_errorCode_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endInitializeGuider_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endInitializeGuider_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endShutterClose_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endShutterClose_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endOfImageTelemetry_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endOfImageTelemetry_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endUnloadFilter_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endUnloadFilter_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_calibrationDetailedState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_calibrationDetailedState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endRotateCarousel_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endRotateCarousel_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startLoadFilter_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startLoadFilter_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_filterChangerDetailedState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_filterChangerDetailedState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_shutterDetailedState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_shutterDetailedState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_readyToTakeImage_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_readyToTakeImage_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ccsCommandState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ccsCommandState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_prepareToTakeImage_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_prepareToTakeImage_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ccsConfigured_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ccsConfigured_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endLoadFilter_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endLoadFilter_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endShutterOpen_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endShutterOpen_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startIntegration_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startIntegration_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_summaryState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_summaryState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endInitializeImage_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endInitializeImage_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_settingsApplied_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_settingsApplied_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endSetFilter_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endSetFilter_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startShutterOpen_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startShutterOpen_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_raftsDetailedState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_raftsDetailedState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_availableFilters_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_availableFilters_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startReadout_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startReadout_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startRotateCarousel_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startRotateCarousel_log

Salgen Camera Python
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

Verify Camera Python Telemetry Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_shutter_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_shutter_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_prot_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_prot_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_filter_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_filter_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_heartbeat_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_heartbeat_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_was_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_was_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_ccs_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_ccs_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_clusterEncoder_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_clusterEncoder_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_cyro_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_cyro_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_purge_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_purge_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_wds_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_wds_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_gds_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_gds_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_sds_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_sds_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_gas_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_gas_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_pcms_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_pcms_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_sas_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_sas_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_cold_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_cold_Subscriber.py

Verify Camera Python Command Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_discardRows.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_discardRows.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_enable.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_enable.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_setValue.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_setValue.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_startImage.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_startImage.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_disableCalibration.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_disableCalibration.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_initGuiders.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_initGuiders.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_standby.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_standby.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_enableCalibration.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_enableCalibration.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_initImage.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_initImage.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_enterControl.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_enterControl.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_endImage.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_endImage.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_setFilter.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_setFilter.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_disable.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_disable.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_abort.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_abort.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_clear.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_clear.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_exitControl.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_exitControl.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_takeImages.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_takeImages.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_start.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_start.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_stop.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_stop.py

Verify Camera Python Event Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_offlineDetailedState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_offlineDetailedState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_endReadout.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_endReadout.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_endTakeImage.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_endTakeImage.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_imageReadinessDetailedState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_imageReadinessDetailedState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_settingVersions.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_settingVersions.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_startSetFilter.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_startSetFilter.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_startUnloadFilter.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_startUnloadFilter.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_notReadyToTakeImage.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_notReadyToTakeImage.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_startShutterClose.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_startShutterClose.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_appliedSettingsMatchStart.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_appliedSettingsMatchStart.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_errorCode.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_errorCode.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_endInitializeGuider.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_endInitializeGuider.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_endShutterClose.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_endShutterClose.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_endOfImageTelemetry.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_endOfImageTelemetry.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_endUnloadFilter.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_endUnloadFilter.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_calibrationDetailedState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_calibrationDetailedState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_endRotateCarousel.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_endRotateCarousel.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_startLoadFilter.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_startLoadFilter.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_filterChangerDetailedState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_filterChangerDetailedState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_shutterDetailedState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_shutterDetailedState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_readyToTakeImage.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_readyToTakeImage.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_ccsCommandState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_ccsCommandState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_prepareToTakeImage.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_prepareToTakeImage.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_ccsConfigured.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_ccsConfigured.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_endLoadFilter.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_endLoadFilter.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_endShutterOpen.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_endShutterOpen.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_startIntegration.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_startIntegration.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_summaryState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_summaryState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_endInitializeImage.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_endInitializeImage.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_settingsApplied.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_settingsApplied.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_endSetFilter.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_endSetFilter.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_startShutterOpen.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_startShutterOpen.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_raftsDetailedState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_raftsDetailedState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_availableFilters.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_availableFilters.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_startReadout.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_startReadout.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_startRotateCarousel.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_startRotateCarousel.py

Salgen Camera LabVIEW
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

Salgen Camera Java
    [Documentation]    Generate Java wrapper.
    [Tags]    java
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} sal java
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - V${SALVersion}
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_shutter.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_prot.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_filter.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_heartbeat.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_was.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_ccs.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_clusterEncoder.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_cyro.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_purge.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_wds.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_gds.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_sds.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_gas.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_pcms.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_sas.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_cold.idl
    Should Contain X Times    ${output}    javac : Done Publisher    16
    Should Contain X Times    ${output}    javac : Done Subscriber    16
    Should Contain X Times    ${output}    javac : Done Commander/Controller    16
    Should Contain X Times    ${output}    javac : Done Event/Logger    16
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl

Salgen Camera Lib
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

Salgen Camera Maven
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

