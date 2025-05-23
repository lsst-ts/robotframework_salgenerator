*** Settings ***
Documentation    This suite builds the various interfaces for the MTPtg.
Force Tags    salgen    mtptg
Suite Setup    Log Many    ${Host}    ${subSystem}    ${timeout}
Library    OperatingSystem
Library    Process
Resource    ../Global_Vars.resource

*** Variables ***
${subSystem}    MTPtg
${timeout}    1200s

*** Test Cases ***
Verify MTPtg XML Defintions exist
    [Tags]    validate
    Comment    Verify the CSC XML definition files exist.
    ${output}    Run Process    ls    ${SALWorkDir}/${subSystem}_*xml    shell=True
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Be Empty    ${output.stdout}
    File Should Exist    ${SALWorkDir}/MTPtg_Commands.xml
    File Should Exist    ${SALWorkDir}/MTPtg_Events.xml
    File Should Exist    ${SALWorkDir}/MTPtg_Telemetry.xml

Salgen MTPtg Validate
    [Documentation]    Validate the MTPtg XML definitions.
    [Tags]    validate
    ${output}=    Run Process    ${SALHome}/bin/salgeneratorKafka    ${subSystem}    validate    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    XMLVERSION = ${XMLVersion}
    Should Contain    ${output.stdout}    Processing ${subSystem}
    Should Contain    ${output.stdout}    Completed ${subSystem} validation
    Directory Should Exist    ${SALWorkDir}/avro-templates
    @{files}=    List Directory    ${SALWorkDir}/avro-templates
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}_metadata.tcl
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}_revCodes.tcl
    Directory Should Exist    ${SALWorkDir}/avro-templates/${subSystem}
    @{files}=    List Directory    ${SALWorkDir}/avro-templates/${subSystem}
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_Generics.xml
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_Commands.xml
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}_cmddef.tcl
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_Events.xml
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}_evtdef.tcl
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_Telemetry.xml
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}_tlmdef.tcl
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_ackcmd.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_global_enums.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_disable.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_enable.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_exitControl.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_setLogLevel.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_standby.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_start.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_pointCloseFile.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_poriginAbsorb.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_guideClear.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_collOffset.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_rotOffset.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_clearCollOffset.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_poriginXY.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_iersUpdate.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_offsetRADec.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_pointAddData.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_guideControl.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_offsetAbsorb.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_ephemTarget.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_wavelength.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_pointLoadModel.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_azCurrentWrap.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_debugLevel.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_raDecTarget.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_offsetPA.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_rotCurrentWrap.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_poriginOffset.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_offsetClear.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_offsetAzEl.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_azElTarget.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_planetTarget.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_pointNewFile.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_poriginClear.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_focusName.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_amLimitSet.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_stopTracking.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_startTracking.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_heartbeat.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_logLevel.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_logMessage.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_softwareVersions.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_errorCode.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_simulationMode.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_summaryState.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focusNameSelected.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_sunProximityWarning.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_detailedState.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_azWrapWarning.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_wavelength.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_objectSetWarning.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pointingModel.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_airmassWarning.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_weatherDataInvalid.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focusNameInconsistentWarning.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_currentTarget.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_iersOutOfDate.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_weatherDataApplied.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_currentDebugLevel.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_mountDataWarning.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_rotWrapWarning.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_iers.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_moonProximityWarning.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_trackPosting.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_ptgAzCurrentWrap.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_ptgRotCurrentWrap.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_elLimitWarning.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pointingFile.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_timesOfLimits.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_validatedTarget.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_offsetSummary.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pointData.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_observatoryLocation.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_currentTargetStatus.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_guiding.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_timeAndDate.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_mountStatus.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_skyEnvironment.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_namedAzEl.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_mountPosition.json/

Salgen MTPtg C++
    [Documentation]    Generate C++ libraries.
    [Tags]    cpp
    ${output}=    Run Process    ${SALHome}/bin/salgeneratorKafka    ${subSystem}    sal    cpp   shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stdout}    ERROR : Failed to generate CPP DDS types
    Should Not Contain    ${output.stdout}    *** DDS error in file
    Should Not Contain    ${output.stdout}    Error 1
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    XMLVERSION = ${XMLVersion}
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain X Times    ${output.stdout}    cpp : Done Publisher    7
    Should Contain X Times    ${output.stdout}    cpp : Done Subscriber    7
    Should Contain X Times    ${output.stdout}    cpp : Done Commander    1
    Should Contain X Times    ${output.stdout}    cpp : Done Event/Logger    1

Verify C++ Directories
    [Documentation]    Ensure expected C++ directories and files are created.
    [Tags]    cpp
    Directory Should Exist    ${SALWorkDir}/${subSystem}/cpp
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/cpp/src    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/SAL_${subSystem}.cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/SAL_${subSystem}C.h
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/SAL_${subSystem}LV.h
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/SAL_${subSystem}_actors.h
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/SAL_${subSystem}_enums.h

Verify MTPtg Telemetry directories
    [Tags]    cpp
    @{files}=    List Directory    ${SALWorkDir}    pattern=*${subSystem}*
    Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/${subSystem}_currentTargetStatus
    Directory Should Exist    ${SALWorkDir}/${subSystem}_guiding
    Directory Should Exist    ${SALWorkDir}/${subSystem}_timeAndDate
    Directory Should Exist    ${SALWorkDir}/${subSystem}_mountStatus
    Directory Should Exist    ${SALWorkDir}/${subSystem}_skyEnvironment
    Directory Should Exist    ${SALWorkDir}/${subSystem}_namedAzEl
    Directory Should Exist    ${SALWorkDir}/${subSystem}_mountPosition

Verify MTPtg C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}_currentTargetStatus/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_currentTargetStatus/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_currentTargetStatus.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_guiding/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_guiding/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_guiding.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_timeAndDate/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_timeAndDate/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_timeAndDate.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_mountStatus/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_mountStatus/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_mountStatus.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_skyEnvironment/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_skyEnvironment/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_skyEnvironment.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_namedAzEl/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_namedAzEl/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_namedAzEl.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_mountPosition/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_mountPosition/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_mountPosition.hh

Verify MTPtg C++ Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_ackcmd.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_disable_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_disable_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_disable.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enable_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enable_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_enable.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_exitControl_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_exitControl_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_exitControl.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setLogLevel_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setLogLevel_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_setLogLevel.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_standby_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_standby_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_standby.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_start_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_start_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_start.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_pointCloseFile_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_pointCloseFile_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_pointCloseFile.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_poriginAbsorb_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_poriginAbsorb_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_poriginAbsorb.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_guideClear_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_guideClear_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_guideClear.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_collOffset_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_collOffset_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_collOffset.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_rotOffset_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_rotOffset_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_rotOffset.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_clearCollOffset_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_clearCollOffset_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_clearCollOffset.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_poriginXY_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_poriginXY_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_poriginXY.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_iersUpdate_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_iersUpdate_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_iersUpdate.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_offsetRADec_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_offsetRADec_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_offsetRADec.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_pointAddData_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_pointAddData_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_pointAddData.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_guideControl_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_guideControl_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_guideControl.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_offsetAbsorb_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_offsetAbsorb_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_offsetAbsorb.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ephemTarget_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ephemTarget_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_ephemTarget.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_wavelength_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_wavelength_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_wavelength.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_pointLoadModel_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_pointLoadModel_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_pointLoadModel.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azCurrentWrap_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azCurrentWrap_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_azCurrentWrap.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_debugLevel_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_debugLevel_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_debugLevel.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_raDecTarget_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_raDecTarget_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_raDecTarget.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_offsetPA_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_offsetPA_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_offsetPA.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_rotCurrentWrap_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_rotCurrentWrap_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_rotCurrentWrap.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_poriginOffset_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_poriginOffset_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_poriginOffset.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_offsetClear_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_offsetClear_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_offsetClear.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_offsetAzEl_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_offsetAzEl_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_offsetAzEl.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azElTarget_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azElTarget_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_azElTarget.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_planetTarget_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_planetTarget_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_planetTarget.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_pointNewFile_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_pointNewFile_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_pointNewFile.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_poriginClear_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_poriginClear_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_poriginClear.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_focusName_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_focusName_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_focusName.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_amLimitSet_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_amLimitSet_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_amLimitSet.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_stopTracking_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_stopTracking_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_stopTracking.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startTracking_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startTracking_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_startTracking.hh

Verify MTPtg C++ Event Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_heartbeat_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_heartbeat_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_heartbeat.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_logLevel_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_logLevel_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_logLevel.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_logMessage_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_logMessage_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_logMessage.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_softwareVersions_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_softwareVersions_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_softwareVersions.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_errorCode_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_errorCode_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_errorCode.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_simulationMode_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_simulationMode_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_simulationMode.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_summaryState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_summaryState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_summaryState.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_focusNameSelected_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_focusNameSelected_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_focusNameSelected.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_sunProximityWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_sunProximityWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_sunProximityWarning.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_detailedState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_detailedState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_detailedState.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azWrapWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azWrapWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_azWrapWarning.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_wavelength_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_wavelength_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_wavelength.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_objectSetWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_objectSetWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_objectSetWarning.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_pointingModel_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_pointingModel_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_pointingModel.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_airmassWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_airmassWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_airmassWarning.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_weatherDataInvalid_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_weatherDataInvalid_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_weatherDataInvalid.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_focusNameInconsistentWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_focusNameInconsistentWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_focusNameInconsistentWarning.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_currentTarget_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_currentTarget_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_currentTarget.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_iersOutOfDate_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_iersOutOfDate_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_iersOutOfDate.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_weatherDataApplied_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_weatherDataApplied_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_weatherDataApplied.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_currentDebugLevel_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_currentDebugLevel_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_currentDebugLevel.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_mountDataWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_mountDataWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_mountDataWarning.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_rotWrapWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_rotWrapWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_rotWrapWarning.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_iers_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_iers_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_iers.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_moonProximityWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_moonProximityWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_moonProximityWarning.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_trackPosting_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_trackPosting_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_trackPosting.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ptgAzCurrentWrap_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ptgAzCurrentWrap_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_ptgAzCurrentWrap.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ptgRotCurrentWrap_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ptgRotCurrentWrap_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_ptgRotCurrentWrap.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_elLimitWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_elLimitWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_elLimitWarning.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_pointingFile_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_pointingFile_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_pointingFile.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_timesOfLimits_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_timesOfLimits_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_timesOfLimits.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_validatedTarget_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_validatedTarget_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_validatedTarget.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_offsetSummary_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_offsetSummary_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_offsetSummary.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_pointData_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_pointData_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_pointData.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_observatoryLocation_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_observatoryLocation_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_observatoryLocation.hh

Salgen MTPtg Lib
    [Documentation]    Generate the SAL shared library for ${subSystem}
    [Tags]    lib
    ${output}=    Run Process    ${SALHome}/bin/salgeneratorKafka    ${subSystem}    lib    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    XMLVERSION = ${XMLVersion}
    Should Contain    ${output.stdout}    Building shared library for ${subSystem} subsystem
    Directory Should Exist    ${SALWorkDir}/lib
    @{files}=    List Directory    ${SALWorkDir}/lib    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/lib/libSAL_${subSystem}.a
    File Should Exist    ${SALWorkDir}/lib/libSAL_${subSystem}.so

Salgen MTPtg RPM
    [Documentation]    Generate the SAL runtime RPM for ${subSystem}
    [Tags]    rpm
    Log Many    ${XMLVersion}    ${SALVersion}    ${Build_Number}    ${DIST}
    ${output}=    Run Process    ${SALHome}/bin/salgeneratorKafka    ${subSystem}    rpm    version\=${Build_Number}    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    @{files}=    List Directory    /tmp/
    Should Be Empty    ${output.stderr}
    File Should Exist    /tmp/makerpm_${subSystem}.log
    File Should Exist    /tmp/makerpm-utils.log
    Log File    /tmp/makerpm_${subSystem}.log
    Log File    /tmp/makerpm-utils.log
    Should Not Contain    ${output.stdout}    ERROR : Asset required for rpm
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    XMLVERSION = ${XMLVersion}
    Should Contain    ${output.stdout}    Building runtime RPM for ${subSystem} subsystem
    Directory Should Exist    ${SALWorkDir}/rpmbuild
    Directory Should Exist    ${SALWorkDir}/rpmbuild/BUILD
    Directory Should Exist    ${SALWorkDir}/rpmbuild/BUILDROOT
    Directory Should Exist    ${SALWorkDir}/rpmbuild/RPMS
    Directory Should Exist    ${SALWorkDir}/rpmbuild/SOURCES
    Directory Should Exist    ${SALWorkDir}/rpmbuild/SPECS
    Directory Should Exist    ${SALWorkDir}/rpmbuild/SRPMS
    Directory Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/
    @{files}=    List Directory    ${SALWorkDir}/rpmbuild/RPMS/x86_64/
    Log Many    @{files}
    IF    "${Build_Number}" == ""
        Set Test Variable    ${sep}    ${EMPTY}
    ELSE IF    any(item in '${Build_Number}' for item in ('pre', 'post', 'rc'))
        Set Test Variable    ${sep}    ~
    ELSE
        Set Test Variable    ${sep}    ${EMPTY}
    END
    File Should Exist    ${SALWorkDir}/rpmbuild/SPECS/ts_sal_${subSystem}.spec
    File Should Exist    ${SALWorkDir}/rpmbuild/SOURCES/${subSystem}-${XMLVersionBase}${sep}${Build_Number}.tgz
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/ts_sal_runtime-${XMLVersionBase}${sep}${Build_Number}-${SALVersionBase}*${DIST}.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/ts_sal_ATruntime-${XMLVersionBase}${sep}${Build_Number}-${SALVersionBase}*${DIST}.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/ts_sal_utilsKafka-${SALVersionBase}-1.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/${subSystem}-${XMLVersionBase}${sep}${Build_Number}-${SALVersionBase}${DIST}.x86_64.rpm
    File Should Exist    ${SALWorkDir}/lib/org/lsst/sal/salUtils.class
    File Should Exist    ${SALWorkDir}/lib/libsalUtils.so
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/${subSystem}_test-${XMLVersionBase}${sep}${Build_Number}-${SALVersionBase}${DIST}.x86_64.rpm
    Should Not Contain    ${output.stdout}    child process exited abnormally

Verify MTPtg RPM Contents
    [Documentation]    Verify the ${subSystem} RPM contains all the expected libraries
    [Tags]    rpm
    Comment    Re-run the {sep} process, so this test case can run independently.
    IF    "${Build_Number}" == ""
        Set Test Variable    ${sep}    ${EMPTY}
    ELSE IF    any(item in '${Build_Number}' for item in ('pre', 'post', 'rc'))
        Set Test Variable    ${sep}    ~
    ELSE
        Set Test Variable    ${sep}    ${EMPTY}
    END
    ${output}=    Run Process    rpm    -qpl    ${subSystem}-${XMLVersionBase}${sep}${Build_Number}-${SALVersionBase}${DIST}.x86_64.rpm    cwd=${SALWorkDir}/rpmbuild/RPMS/x86_64
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stderr}    error
    Should Not Contain    ${output.stderr}    No such file or directory
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/scripts/${subSystem}_revCodes.tcl
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_ackcmd.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_global_enums.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_hash_table.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_disable.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_enable.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_exitControl.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_setLogLevel.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_standby.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_start.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_pointCloseFile.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_poriginAbsorb.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_guideClear.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_collOffset.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_rotOffset.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_clearCollOffset.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_poriginXY.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_iersUpdate.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_offsetRADec.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_pointAddData.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_guideControl.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_offsetAbsorb.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_ephemTarget.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_wavelength.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_pointLoadModel.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_azCurrentWrap.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_debugLevel.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_raDecTarget.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_offsetPA.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_rotCurrentWrap.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_poriginOffset.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_offsetClear.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_offsetAzEl.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_azElTarget.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_planetTarget.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_pointNewFile.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_poriginClear.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_focusName.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_amLimitSet.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_stopTracking.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_command_startTracking.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_heartbeat.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_logLevel.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_logMessage.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_softwareVersions.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_errorCode.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_simulationMode.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_summaryState.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_focusNameSelected.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_sunProximityWarning.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_detailedState.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_azWrapWarning.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_wavelength.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_objectSetWarning.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_pointingModel.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_airmassWarning.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_weatherDataInvalid.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_focusNameInconsistentWarning.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_currentTarget.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_iersOutOfDate.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_weatherDataApplied.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_currentDebugLevel.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_mountDataWarning.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_rotWrapWarning.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_iers.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_moonProximityWarning.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_trackPosting.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_ptgAzCurrentWrap.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_ptgRotCurrentWrap.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_elLimitWarning.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_pointingFile.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_timesOfLimits.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_validatedTarget.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_offsetSummary.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_pointData.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_logevent_observatoryLocation.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_currentTargetStatus.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_guiding.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_timeAndDate.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_mountStatus.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_skyEnvironment.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_namedAzEl.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/avro-templates/${subSystem}/${subSystem}_mountPosition.json
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/lib/libSAL_${subSystem}.a
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/lib/libSAL_${subSystem}.so
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/SAL_${subSystem}.h
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_ackcmd.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_currentTargetStatus.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_guiding.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_timeAndDate.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_mountStatus.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_skyEnvironment.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_namedAzEl.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_mountPosition.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_disable.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_enable.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_exitControl.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_setLogLevel.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_standby.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_start.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_pointCloseFile.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_poriginAbsorb.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_guideClear.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_collOffset.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_rotOffset.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_clearCollOffset.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_poriginXY.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_iersUpdate.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_offsetRADec.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_pointAddData.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_guideControl.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_offsetAbsorb.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_ephemTarget.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_wavelength.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_pointLoadModel.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_azCurrentWrap.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_debugLevel.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_raDecTarget.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_offsetPA.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_rotCurrentWrap.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_poriginOffset.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_offsetClear.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_offsetAzEl.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_azElTarget.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_planetTarget.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_pointNewFile.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_poriginClear.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_focusName.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_amLimitSet.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_stopTracking.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_startTracking.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_heartbeat.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_logLevel.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_logMessage.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_softwareVersions.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_errorCode.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_simulationMode.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_summaryState.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_focusNameSelected.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_sunProximityWarning.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_detailedState.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_azWrapWarning.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_wavelength.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_objectSetWarning.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_pointingModel.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_airmassWarning.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_weatherDataInvalid.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_focusNameInconsistentWarning.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_currentTarget.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_iersOutOfDate.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_weatherDataApplied.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_currentDebugLevel.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_mountDataWarning.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_rotWrapWarning.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_iers.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_moonProximityWarning.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_trackPosting.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_ptgAzCurrentWrap.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_ptgRotCurrentWrap.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_elLimitWarning.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_pointingFile.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_timesOfLimits.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_validatedTarget.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_offsetSummary.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_pointData.hh
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_observatoryLocation.hh
    Comment    Verify the interface definition files are included.
    Should Contain    ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Generics.xml
    Should Contain    ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Commands.xml
    Should Contain    ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Commands.html
    Should Contain    ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Events.xml
    Should Contain    ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Events.html
    Should Contain    ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Telemetry.xml
    Should Contain    ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Telemetry.html

Verify MTPtg TEST RPM Contents
    [Documentation]    Verify the ${subSystem} TEST RPM contains all the expected libraries
    [Tags]    rpm
    Comment    Re-run the {sep} process, so this test case can run independently.
    IF    "${Build_Number}" == ""
        Set Test Variable    ${sep}    ${EMPTY}
    ELSE IF    any(item in '${Build_Number}' for item in ('pre', 'post', 'rc'))
        Set Test Variable    ${sep}    ~
    ELSE
        Set Test Variable    ${sep}    ${EMPTY}
    END
    ${output}=    Run Process    rpm    -qpl    ${subSystem}_test-${XMLVersionBase}${sep}${Build_Number}-${SALVersionBase}${DIST}.x86_64.rpm    shell=True    cwd=${SALWorkDir}/rpmbuild/RPMS/x86_64    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stderr}    error
    Should Not Contain    ${output.stderr}    No such file or directory
    Comment    Verify the TEST RPM contains the test programs.
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_all_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_all_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_all_sender
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_all_logger
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_all_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_all_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_disable_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_disable_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_enable_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_enable_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_exitControl_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_exitControl_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_setLogLevel_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_setLogLevel_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_standby_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_standby_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_start_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_start_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_pointCloseFile_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_pointCloseFile_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_poriginAbsorb_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_poriginAbsorb_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_guideClear_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_guideClear_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_collOffset_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_collOffset_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_rotOffset_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_rotOffset_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_clearCollOffset_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_clearCollOffset_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_poriginXY_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_poriginXY_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_iersUpdate_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_iersUpdate_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_offsetRADec_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_offsetRADec_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_pointAddData_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_pointAddData_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_guideControl_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_guideControl_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_offsetAbsorb_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_offsetAbsorb_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_ephemTarget_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_ephemTarget_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_wavelength_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_wavelength_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_pointLoadModel_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_pointLoadModel_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_azCurrentWrap_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_azCurrentWrap_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_debugLevel_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_debugLevel_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_raDecTarget_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_raDecTarget_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_offsetPA_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_offsetPA_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_rotCurrentWrap_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_rotCurrentWrap_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_poriginOffset_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_poriginOffset_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_offsetClear_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_offsetClear_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_offsetAzEl_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_offsetAzEl_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_azElTarget_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_azElTarget_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_planetTarget_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_planetTarget_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_pointNewFile_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_pointNewFile_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_poriginClear_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_poriginClear_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_focusName_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_focusName_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_amLimitSet_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_amLimitSet_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_stopTracking_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_stopTracking_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_startTracking_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_startTracking_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_heartbeat_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_heartbeat_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_logLevel_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_logLevel_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_logMessage_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_logMessage_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_softwareVersions_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_softwareVersions_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_errorCode_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_errorCode_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_simulationMode_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_simulationMode_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_summaryState_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_summaryState_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_focusNameSelected_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_focusNameSelected_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_sunProximityWarning_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_sunProximityWarning_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_detailedState_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_detailedState_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_azWrapWarning_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_azWrapWarning_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_wavelength_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_wavelength_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_objectSetWarning_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_objectSetWarning_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_pointingModel_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_pointingModel_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_airmassWarning_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_airmassWarning_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_weatherDataInvalid_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_weatherDataInvalid_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_focusNameInconsistentWarning_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_focusNameInconsistentWarning_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_currentTarget_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_currentTarget_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_iersOutOfDate_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_iersOutOfDate_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_weatherDataApplied_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_weatherDataApplied_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_currentDebugLevel_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_currentDebugLevel_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_mountDataWarning_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_mountDataWarning_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_rotWrapWarning_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_rotWrapWarning_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_iers_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_iers_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_moonProximityWarning_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_moonProximityWarning_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_trackPosting_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_trackPosting_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_ptgAzCurrentWrap_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_ptgAzCurrentWrap_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_ptgRotCurrentWrap_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_ptgRotCurrentWrap_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_elLimitWarning_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_elLimitWarning_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_pointingFile_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_pointingFile_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_timesOfLimits_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_timesOfLimits_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_validatedTarget_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_validatedTarget_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_offsetSummary_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_offsetSummary_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_pointData_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_pointData_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_observatoryLocation_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_observatoryLocation_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_currentTargetStatus_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_currentTargetStatus_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_guiding_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_guiding_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_timeAndDate_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_timeAndDate_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_mountStatus_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_mountStatus_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_skyEnvironment_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_skyEnvironment_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_namedAzEl_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_namedAzEl_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_mountPosition_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_mountPosition_subscriber

Cleanup stdout and stderr Files
    [Tags]
    Remove Files    ${EXECDIR}${/}${subSystem}_stdout.txt    ${EXECDIR}${/}${subSystem}_stderr.txt

