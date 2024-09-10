*** Settings ***
Documentation    This suite builds the various interfaces for the ATPtg.
Force Tags    salgen    atptg
Suite Setup    Log Many    ${Host}    ${subSystem}    ${timeout}
Library    OperatingSystem
Library    Process
Resource    ../Global_Vars.resource

*** Variables ***
${subSystem}    ATPtg
${timeout}    1200s

*** Test Cases ***
Verify ATPtg XML Defintions exist
    [Tags]
    Comment    Verify the CSC XML definition files exist.
    ${output}    Run Process    ls     ${SALWorkDir}/${subSystem}_*xml    shell=True
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Be Empty    ${output.stdout}
    File Should Exist    ${SALWorkDir}/ATPtg_Commands.xml
    File Should Exist    ${SALWorkDir}/ATPtg_Events.xml
    File Should Exist    ${SALWorkDir}/ATPtg_Telemetry.xml

Salgen ATPtg Validate
    [Documentation]    Validate the ATPtg XML definitions.
    [Tags]    validate
    ${output}=    Run Process    ${SALHome}/bin/salgenerator    ${subSystem}    validate    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    XMLVERSION = ${XMLVersion}
    Should Contain    ${output.stdout}    Processing ${subSystem}
    Should Contain    ${output.stdout}    Completed ${subSystem} validation
    Directory Should Exist    ${SALWorkDir}/idl-templates
    Directory Should Exist    ${SALWorkDir}/idl-templates/validated
    @{files}=    List Directory    ${SALWorkDir}/idl-templates    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_ackcmd.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_currentTargetStatus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_guiding.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_timeAndDate.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_mountStatus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_skyEnvironment.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_namedAzEl.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_mountPositions.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_disable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_exitControl.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_setLogLevel.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_standby.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_start.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_pointCloseFile.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_poriginAbsorb.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_guideClear.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_collOffset.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_rotOffset.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_clearCollOffset.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_poriginXY.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_iersUpdate.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_offsetRADec.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_pointAddData.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_guideControl.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_offsetAbsorb.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_ephemTarget.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_wavelength.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_pointLoadModel.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_azCurrentWrap.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_debugLevel.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_raDecTarget.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_offsetPA.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_rotCurrentWrap.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_poriginOffset.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_offsetClear.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_offsetAzEl.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_azElTarget.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_planetTarget.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_pointNewFile.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_poriginClear.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_focusName.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_amLimitSet.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_stopTracking.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_startTracking.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_heartbeat.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_logLevel.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_logMessage.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_softwareVersions.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_errorCode.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_simulationMode.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_summaryState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focusNameSelected.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_sunProximityWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_detailedState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_azWrapWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_wavelength.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_objectSetWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_pointingModel.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_airmassWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_weatherDataInvalid.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focusNameInconsistentWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_currentTarget.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_iersOutOfDate.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_weatherDataApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_currentDebugLevel.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_mountDataWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_rotWrapWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_iers.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_moonProximityWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_trackPosting.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ptgAzCurrentWrap.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ptgRotCurrentWrap.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_elLimitWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_pointingFile.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_timesOfLimits.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_validatedTarget.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_offsetSummary.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_pointData.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_observatoryLocation.idl

Verify ATPtg revCodes File
    [Documentation]    Ensure ATPtg_revCodes.tcl contains 1 revcode per topic.
    [Tags]    doc    
    ${output}=    Log File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_disable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_enable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_exitControl\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_setLogLevel\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_standby\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_start\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_pointCloseFile\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_poriginAbsorb\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_guideClear\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_collOffset\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_rotOffset\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_clearCollOffset\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_poriginXY\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_iersUpdate\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_offsetRADec\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_pointAddData\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_guideControl\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_offsetAbsorb\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_ephemTarget\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_wavelength\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_pointLoadModel\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_azCurrentWrap\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_debugLevel\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_raDecTarget\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_offsetPA\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_rotCurrentWrap\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_poriginOffset\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_offsetClear\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_offsetAzEl\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_azElTarget\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_planetTarget\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_pointNewFile\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_poriginClear\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_focusName\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_amLimitSet\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_stopTracking\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_startTracking\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_heartbeat\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_logLevel\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_logMessage\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_softwareVersions\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_errorCode\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_simulationMode\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_summaryState\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focusNameSelected\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_sunProximityWarning\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_detailedState\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_azWrapWarning\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_wavelength\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_objectSetWarning\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_pointingModel\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_airmassWarning\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_weatherDataInvalid\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focusNameInconsistentWarning\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_currentTarget\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_iersOutOfDate\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_weatherDataApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_currentDebugLevel\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_mountDataWarning\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_rotWrapWarning\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_iers\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_moonProximityWarning\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_trackPosting\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ptgAzCurrentWrap\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ptgRotCurrentWrap\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_elLimitWarning\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_pointingFile\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_timesOfLimits\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_validatedTarget\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_offsetSummary\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_pointData\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_observatoryLocation\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_currentTargetStatus\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_guiding\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_timeAndDate\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_mountStatus\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_skyEnvironment\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_namedAzEl\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_mountPositions\\) [a-z0-9]{8,}

Salgen ATPtg IDL
    [Documentation]    Generate the revCoded IDL for ${subSystem}
    [Tags]    idl
    ${output}=    Run Process    ${SALHome}/bin/salgenerator    ${subSystem}    sal    idl    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    XMLVERSION = ${XMLVersion}
    Should Contain    ${output.stdout}    Completed ${subSystem} validation
    File Should Exist    ${SALWorkDir}/${subSystem}/sal_revCoded_${subSystem}.idl
    @{files}=    List Directory    ${SALWorkDir}/idl-templates/validated/sal    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/idl-templates/validated/sal/sal_${subSystem}.idl
    File Should Exist    ${SALWorkDir}/idl-templates/validated/sal/sal_revCoded_${subSystem}.idl

Salgen ATPtg C++
    [Documentation]    Generate C++ libraries.
    [Tags]    cpp
    ${output}=    Run Process    ${SALHome}/bin/salgenerator    ${subSystem}    sal    cpp   shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stdout}    ERROR : Failed to generate CPP DDS types
    Should Not Contain    ${output.stdout}    *** DDS error in file
    Should Not Contain    ${output.stdout}    Error 1
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    XMLVERSION = ${XMLVersion}
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_currentTargetStatus.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_guiding.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_timeAndDate.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_mountStatus.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_skyEnvironment.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_namedAzEl.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_mountPositions.idl
    Should Contain X Times    ${output.stdout}    cpp : Done Publisher    7
    Should Contain X Times    ${output.stdout}    cpp : Done Subscriber    7
    Should Contain X Times    ${output.stdout}    cpp : Done Commander    1
    Should Contain X Times    ${output.stdout}    cpp : Done Event/Logger    1

Verify C++ Directories
    [Documentation]    Ensure expected C++ directories and files are created.
    [Tags]    cpp
    Directory Should Exist    ${SALWorkDir}/${subSystem}/cpp
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/cpp    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/libsacpp_${subSystem}_types.so
    Directory Should Exist    ${SALWorkDir}/idl-templates/validated/sal
    @{files}=    List Directory    ${SALWorkDir}/idl-templates/validated/sal    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/idl-templates/validated/sal/sal_${subSystem}.idl

Verify ATPtg Telemetry directories
    [Tags]    cpp
    @{files}=    List Directory    ${SALWorkDir}    pattern=*${subSystem}*
    Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/${subSystem}_currentTargetStatus
    Directory Should Exist    ${SALWorkDir}/${subSystem}_guiding
    Directory Should Exist    ${SALWorkDir}/${subSystem}_timeAndDate
    Directory Should Exist    ${SALWorkDir}/${subSystem}_mountStatus
    Directory Should Exist    ${SALWorkDir}/${subSystem}_skyEnvironment
    Directory Should Exist    ${SALWorkDir}/${subSystem}_namedAzEl
    Directory Should Exist    ${SALWorkDir}/${subSystem}_mountPositions

Verify ATPtg C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}_currentTargetStatus/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_currentTargetStatus/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_guiding/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_guiding/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_timeAndDate/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_timeAndDate/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_mountStatus/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_mountStatus/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_skyEnvironment/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_skyEnvironment/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_namedAzEl/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_namedAzEl/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_mountPositions/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_mountPositions/cpp/standalone/sacpp_${subSystem}_sub

Verify ATPtg C++ Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_disable_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_disable_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enable_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enable_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_exitControl_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_exitControl_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setLogLevel_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setLogLevel_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_standby_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_standby_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_start_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_start_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_pointCloseFile_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_pointCloseFile_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_poriginAbsorb_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_poriginAbsorb_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_guideClear_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_guideClear_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_collOffset_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_collOffset_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_rotOffset_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_rotOffset_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_clearCollOffset_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_clearCollOffset_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_poriginXY_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_poriginXY_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_iersUpdate_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_iersUpdate_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_offsetRADec_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_offsetRADec_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_pointAddData_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_pointAddData_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_guideControl_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_guideControl_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_offsetAbsorb_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_offsetAbsorb_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ephemTarget_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ephemTarget_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_wavelength_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_wavelength_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_pointLoadModel_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_pointLoadModel_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azCurrentWrap_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azCurrentWrap_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_debugLevel_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_debugLevel_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_raDecTarget_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_raDecTarget_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_offsetPA_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_offsetPA_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_rotCurrentWrap_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_rotCurrentWrap_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_poriginOffset_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_poriginOffset_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_offsetClear_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_offsetClear_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_offsetAzEl_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_offsetAzEl_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azElTarget_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azElTarget_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_planetTarget_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_planetTarget_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_pointNewFile_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_pointNewFile_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_poriginClear_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_poriginClear_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_focusName_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_focusName_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_amLimitSet_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_amLimitSet_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_stopTracking_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_stopTracking_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startTracking_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startTracking_controller

Verify ATPtg C++ Event Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_heartbeat_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_heartbeat_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_logLevel_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_logLevel_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_logMessage_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_logMessage_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_softwareVersions_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_softwareVersions_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_errorCode_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_errorCode_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_simulationMode_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_simulationMode_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_summaryState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_summaryState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_focusNameSelected_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_focusNameSelected_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_sunProximityWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_sunProximityWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_detailedState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_detailedState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azWrapWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azWrapWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_wavelength_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_wavelength_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_objectSetWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_objectSetWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_pointingModel_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_pointingModel_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_airmassWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_airmassWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_weatherDataInvalid_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_weatherDataInvalid_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_focusNameInconsistentWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_focusNameInconsistentWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_currentTarget_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_currentTarget_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_iersOutOfDate_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_iersOutOfDate_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_weatherDataApplied_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_weatherDataApplied_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_currentDebugLevel_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_currentDebugLevel_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_mountDataWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_mountDataWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_rotWrapWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_rotWrapWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_iers_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_iers_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_moonProximityWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_moonProximityWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_trackPosting_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_trackPosting_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ptgAzCurrentWrap_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ptgAzCurrentWrap_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ptgRotCurrentWrap_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ptgRotCurrentWrap_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_elLimitWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_elLimitWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_pointingFile_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_pointingFile_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_timesOfLimits_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_timesOfLimits_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_validatedTarget_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_validatedTarget_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_offsetSummary_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_offsetSummary_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_pointData_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_pointData_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_observatoryLocation_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_observatoryLocation_log

Salgen ATPtg Lib
    [Documentation]    Generate the SAL shared library for ${subSystem}
    [Tags]    lib
    ${output}=    Run Process    ${SALHome}/bin/salgenerator    ${subSystem}    lib    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    XMLVERSION = ${XMLVersion}
    Should Contain    ${output.stdout}    Building shared library for ${subSystem} subsystem
    Directory Should Exist    ${SALWorkDir}/lib
    @{files}=    List Directory    ${SALWorkDir}/lib    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/lib/libSAL_${subSystem}.so
    File Should Exist    ${SALWorkDir}/lib/libSAL_${subSystem}.a
    File Should Exist    ${SALWorkDir}/lib/libsacpp_${subSystem}_types.so

Salgen ATPtg RPM
    [Documentation]    Generate the SAL runtime RPM for ${subSystem}
    [Tags]    rpm
    Log Many    ${XMLVersion}    ${SALVersion}    ${Build_Number}    ${DIST}
    ${output}=    Run Process    ${SALHome}/bin/salgenerator    ${subSystem}    rpm    version\=${Build_Number}    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
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
    File Should Exist    ${SALWorkDir}/rpmbuild/SPECS/ts_sal_${subSystem}_dds.spec
    File Should Exist    ${SALWorkDir}/rpmbuild/SOURCES/${subSystem}_dds-${XMLVersionBase}${sep}${Build_Number}.tgz
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/ts_sal_runtime_dds-${XMLVersionBase}${sep}${Build_Number}-${SALVersionBase}*${DIST}.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/ts_sal_ATruntime_dds-${XMLVersionBase}${sep}${Build_Number}-${SALVersionBase}*${DIST}.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/ts_sal_utils_dds-${SALVersionBase}-1.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/${subSystem}_dds-${XMLVersionBase}${sep}${Build_Number}-${SALVersionBase}${DIST}.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/${subSystem}_dds_test-${XMLVersionBase}${sep}${Build_Number}-${SALVersionBase}${DIST}.x86_64.rpm
    Should Not Contain    ${output.stdout}    child process exited abnormally

Verify ATPtg RPM Contents
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
    ${output}=    Run Process    rpm    -qpl    ${subSystem}_dds-${XMLVersionBase}${sep}${Build_Number}-${SALVersionBase}${DIST}.x86_64.rpm    cwd=${SALWorkDir}/rpmbuild/RPMS/x86_64
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stderr}    error
    Should Not Contain    ${output.stderr}    No such file or directory
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/idl/sal_revCoded_${subSystem}.idl
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/scripts/${subSystem}_revCodes.tcl
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/lib/libSAL_${subSystem}.so
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/lib/libSAL_${subSystem}.a
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/lib/libsacpp_${subSystem}_types.so
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/SAL_${subSystem}.h
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/SAL_${subSystem}.h
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/SAL_defines.h
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/ccpp_sal_${subSystem}.h
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/sal_${subSystem}Dcps.h
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/sal_${subSystem}Dcps_impl.h
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/sal_${subSystem}SplDcps.h
    Comment    Verify the interface definition files are included.
    Should Contain     ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Generics.xml
    Should Contain     ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Commands.xml
    Should Contain     ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Commands.html
    Should Contain     ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Events.xml
    Should Contain     ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Events.html
    Should Contain     ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Telemetry.xml
    Should Contain     ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Telemetry.html

Verify ATPtg TEST RPM Contents
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
    ${output}=    Run Process    rpm    -qpl    ${subSystem}_dds_test-${XMLVersionBase}${sep}${Build_Number}-${SALVersionBase}${DIST}.x86_64.rpm    shell=True    cwd=${SALWorkDir}/rpmbuild/RPMS/x86_64    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stderr}    error
    Should Not Contain    ${output.stderr}    No such file or directory
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/lib/libSAL_${subSystem}.so
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/lib/libSAL_${subSystem}.a
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
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_mountPositions_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_mountPositions_subscriber

Cleanup stdout and stderr Files
    [Tags]
    Remove Files    ${EXECDIR}${/}${subSystem}_stdout.txt    ${EXECDIR}${/}${subSystem}_stderr.txt

