*** Settings ***
Documentation    This suite builds the various interfaces for the MTPtg.
Force Tags    salgen    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${timeout}
Library    OperatingSystem
Library    Process
Resource    ../Global_Vars.resource

*** Variables ***
${subSystem}    MTPtg
${timeout}    1200s

*** Test Cases ***
Verify MTPtg XML Defintions exist
    [Tags]
    Comment    Verify the CSC XML definition files exist.
    ${output}    Run Process    ls     ${SALWorkDir}/MTPtg_*.xml    shell=True
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stderr}    No such file or directory    msg="MTPtg has no XML defintions"    values=False
    Should Not Be Empty    ${output.stdout}
    File Should Exist    ${SALWorkDir}/MTPtg_Commands.xml
    File Should Exist    ${SALWorkDir}/MTPtg_Events.xml
    File Should Exist    ${SALWorkDir}/MTPtg_Telemetry.xml

Salgen MTPtg Validate
    [Documentation]    Validate the MTPtg XML definitions.
    [Tags]    validate
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    validate    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Processing ${subSystem}
    Should Contain    ${output.stdout}    Completed ${subSystem} validation
    Directory Should Exist    ${SALWorkDir}/idl-templates
    Directory Should Exist    ${SALWorkDir}/idl-templates/validated
    @{files}=    List Directory    ${SALWorkDir}/idl-templates    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_prospectiveTargetStatus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_nextTargetStatus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_currentTimesToLimits.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_currentTargetStatus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_guidingAndOffsets.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_prospectiveTimesToLimits.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_timeAndDate.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_mountStatus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_nextTimesToLimits.idl
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
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_setAccessMode.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_azElTarget.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_copyTarget.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_planetTarget.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_pointNewFile.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_poriginClear.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_focusName.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_amLimitSet.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_guideAutoclear.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_stopTracking.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_abort.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_disable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_standby.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_exitControl.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_start.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_enterControl.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_setLogLevel.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_setSimulationMode.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_setValue.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focusNameSelected.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_settingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_sunProximityWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_detailedState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_mountGuideMode.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_azWrapWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_wavelength.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_inPositionEl.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_inBlindSpot.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_blindSpotWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_axesTrackMode.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_objectSetWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_pointingModel.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_airmassWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_weatherDataInvalid.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focusNameInconsistentWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_currentTarget.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_iersOutOfDate.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_weatherDataApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_currentDebugLevel.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_nextTarget.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_mountDataWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_accessMode.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_rotWrapWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_inPosition.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_inPositionRot.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_inPositionAz.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_iers.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_prospectiveTarget.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_moonProximityWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_trackPosting.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ptgAzCurrentWrap.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ptgRotCurrentWrap.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_settingVersions.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_errorCode.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_summaryState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_appliedSettingsMatchStart.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_logLevel.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_logMessage.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_simulationMode.idl

Salgen MTPtg HTML
    [Documentation]    Create web form interfaces.
    [Tags]    html    
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    html    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Generating telemetry stream definition editor html
    Should Contain    ${output.stdout}    Creating sal-generator-${subSystem} form
    Should Contain    ${output.stdout}    Added sal-generator-${subSystem}.prospectiveTargetStatus to form
    Should Contain    ${output.stdout}    Added sal-generator-${subSystem}.nextTargetStatus to form
    Should Contain    ${output.stdout}    Added sal-generator-${subSystem}.currentTimesToLimits to form
    Should Contain    ${output.stdout}    Added sal-generator-${subSystem}.currentTargetStatus to form
    Should Contain    ${output.stdout}    Added sal-generator-${subSystem}.guidingAndOffsets to form
    Should Contain    ${output.stdout}    Added sal-generator-${subSystem}.prospectiveTimesToLimits to form
    Should Contain    ${output.stdout}    Added sal-generator-${subSystem}.timeAndDate to form
    Should Contain    ${output.stdout}    Added sal-generator-${subSystem}.mountStatus to form
    Should Contain    ${output.stdout}    Added sal-generator-${subSystem}.nextTimesToLimits to form
    Directory Should Exist    ${SALWorkDir}/html/salgenerator/${subSystem}
    @{files}=    List Directory    ${SALWorkDir}/html/salgenerator/${subSystem}    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/html/${subSystem}/MTPtg_Commands.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/MTPtg_Events.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/MTPtg_Telemetry.html
    File Should Exist    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl

Verify MTPtg revCodes File
    [Documentation]    Ensure MTPtg_revCodes.tcl contains 1 revcode per topic.
    [Tags]    html    
    ${output}=    Log File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl
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
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_setAccessMode\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_azElTarget\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_copyTarget\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_planetTarget\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_pointNewFile\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_poriginClear\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_focusName\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_amLimitSet\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_guideAutoclear\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_stopTracking\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_abort\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_enable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_disable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_standby\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_exitControl\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_start\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_enterControl\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_setLogLevel\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_setSimulationMode\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_setValue\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focusNameSelected\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_settingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_sunProximityWarning\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_detailedState\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_mountGuideMode\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_azWrapWarning\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_wavelength\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_inPositionEl\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_inBlindSpot\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_blindSpotWarning\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_axesTrackMode\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_objectSetWarning\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_pointingModel\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_airmassWarning\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_weatherDataInvalid\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focusNameInconsistentWarning\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_currentTarget\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_iersOutOfDate\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_weatherDataApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_currentDebugLevel\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_nextTarget\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_mountDataWarning\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_accessMode\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_rotWrapWarning\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_inPosition\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_inPositionRot\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_inPositionAz\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_iers\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_prospectiveTarget\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_moonProximityWarning\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_trackPosting\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ptgAzCurrentWrap\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ptgRotCurrentWrap\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_settingVersions\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_errorCode\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_summaryState\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_appliedSettingsMatchStart\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_logLevel\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_logMessage\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_simulationMode\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_prospectiveTargetStatus\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_nextTargetStatus\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_currentTimesToLimits\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_currentTargetStatus\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_guidingAndOffsets\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_prospectiveTimesToLimits\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_timeAndDate\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_mountStatus\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_nextTimesToLimits\\) [a-z0-9]{8,}

Salgen MTPtg C++
    [Documentation]    Generate C++ wrapper.
    [Tags]    cpp
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    sal    cpp   shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stdout}    *** DDS error in file
    Should Not Contain    ${output.stdout}    Error 1
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_prospectiveTargetStatus.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_nextTargetStatus.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_currentTimesToLimits.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_currentTargetStatus.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_guidingAndOffsets.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_prospectiveTimesToLimits.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_timeAndDate.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_mountStatus.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_nextTimesToLimits.idl
    Should Contain X Times    ${output.stdout}    cpp : Done Publisher    9
    Should Contain X Times    ${output.stdout}    cpp : Done Subscriber    9
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

Verify MTPtg Telemetry directories
    [Tags]    cpp
    @{files}=    List Directory    ${SALWorkDir}    pattern=*${subSystem}*
    Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/${subSystem}_prospectiveTargetStatus
    Directory Should Exist    ${SALWorkDir}/${subSystem}_nextTargetStatus
    Directory Should Exist    ${SALWorkDir}/${subSystem}_currentTimesToLimits
    Directory Should Exist    ${SALWorkDir}/${subSystem}_currentTargetStatus
    Directory Should Exist    ${SALWorkDir}/${subSystem}_guidingAndOffsets
    Directory Should Exist    ${SALWorkDir}/${subSystem}_prospectiveTimesToLimits
    Directory Should Exist    ${SALWorkDir}/${subSystem}_timeAndDate
    Directory Should Exist    ${SALWorkDir}/${subSystem}_mountStatus
    Directory Should Exist    ${SALWorkDir}/${subSystem}_nextTimesToLimits

Verify MTPtg C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}_prospectiveTargetStatus/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_prospectiveTargetStatus/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_nextTargetStatus/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_nextTargetStatus/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_currentTimesToLimits/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_currentTimesToLimits/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_currentTargetStatus/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_currentTargetStatus/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_guidingAndOffsets/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_guidingAndOffsets/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_prospectiveTimesToLimits/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_prospectiveTimesToLimits/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_timeAndDate/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_timeAndDate/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_mountStatus/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_mountStatus/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_nextTimesToLimits/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_nextTimesToLimits/cpp/standalone/sacpp_${subSystem}_sub

Verify MTPtg C++ Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
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
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setAccessMode_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setAccessMode_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azElTarget_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azElTarget_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_copyTarget_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_copyTarget_controller
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
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_guideAutoclear_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_guideAutoclear_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_stopTracking_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_stopTracking_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_abort_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_abort_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enable_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enable_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_disable_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_disable_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_standby_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_standby_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_exitControl_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_exitControl_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_start_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_start_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enterControl_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enterControl_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setLogLevel_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setLogLevel_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setSimulationMode_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setSimulationMode_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setValue_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setValue_controller

Verify MTPtg C++ Event Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_focusNameSelected_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_focusNameSelected_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_settingsApplied_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_settingsApplied_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_sunProximityWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_sunProximityWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_detailedState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_detailedState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_mountGuideMode_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_mountGuideMode_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azWrapWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azWrapWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_wavelength_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_wavelength_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_inPositionEl_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_inPositionEl_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_inBlindSpot_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_inBlindSpot_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_blindSpotWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_blindSpotWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_axesTrackMode_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_axesTrackMode_log
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
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nextTarget_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nextTarget_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_mountDataWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_mountDataWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_accessMode_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_accessMode_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_rotWrapWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_rotWrapWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_inPosition_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_inPosition_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_inPositionRot_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_inPositionRot_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_inPositionAz_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_inPositionAz_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_iers_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_iers_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_prospectiveTarget_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_prospectiveTarget_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_moonProximityWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_moonProximityWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_trackPosting_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_trackPosting_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ptgAzCurrentWrap_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ptgAzCurrentWrap_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ptgRotCurrentWrap_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_ptgRotCurrentWrap_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_settingVersions_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_settingVersions_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_errorCode_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_errorCode_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_summaryState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_summaryState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedSettingsMatchStart_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedSettingsMatchStart_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_logLevel_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_logLevel_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_logMessage_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_logMessage_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_simulationMode_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_simulationMode_log

Salgen MTPtg Python
    [Documentation]    Generate Python wrapper.
    [Tags]    python
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    sal    python    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Generating Python SAL support for ${subSystem}
    Should Contain    ${output.stdout}    Generating Python bindings
    Should Contain    ${output.stdout}    python : Done SALPY_${subSystem}.so
    Directory Should Exist    ${SALWorkDir}/${subSystem}/python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/SALPY_${subSystem}.so

Verify MTPtg Python Telemetry Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_prospectiveTargetStatus_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_prospectiveTargetStatus_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_nextTargetStatus_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_nextTargetStatus_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_currentTimesToLimits_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_currentTimesToLimits_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_currentTargetStatus_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_currentTargetStatus_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_guidingAndOffsets_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_guidingAndOffsets_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_prospectiveTimesToLimits_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_prospectiveTimesToLimits_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_timeAndDate_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_timeAndDate_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_mountStatus_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_mountStatus_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_nextTimesToLimits_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_nextTimesToLimits_Subscriber.py

Verify MTPtg Python Command Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_pointCloseFile.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_pointCloseFile.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_poriginAbsorb.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_poriginAbsorb.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_guideClear.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_guideClear.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_collOffset.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_collOffset.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_rotOffset.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_rotOffset.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_clearCollOffset.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_clearCollOffset.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_poriginXY.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_poriginXY.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_iersUpdate.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_iersUpdate.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_offsetRADec.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_offsetRADec.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_pointAddData.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_pointAddData.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_guideControl.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_guideControl.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_offsetAbsorb.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_offsetAbsorb.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_ephemTarget.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_ephemTarget.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_wavelength.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_wavelength.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_pointLoadModel.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_pointLoadModel.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_azCurrentWrap.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_azCurrentWrap.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_debugLevel.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_debugLevel.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_raDecTarget.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_raDecTarget.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_offsetPA.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_offsetPA.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_rotCurrentWrap.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_rotCurrentWrap.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_poriginOffset.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_poriginOffset.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_offsetClear.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_offsetClear.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_offsetAzEl.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_offsetAzEl.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_setAccessMode.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_setAccessMode.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_azElTarget.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_azElTarget.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_copyTarget.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_copyTarget.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_planetTarget.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_planetTarget.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_pointNewFile.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_pointNewFile.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_poriginClear.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_poriginClear.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_focusName.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_focusName.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_amLimitSet.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_amLimitSet.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_guideAutoclear.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_guideAutoclear.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_stopTracking.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_stopTracking.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_abort.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_abort.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_enable.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_enable.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_disable.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_disable.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_standby.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_standby.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_exitControl.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_exitControl.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_start.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_start.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_enterControl.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_enterControl.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_setLogLevel.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_setLogLevel.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_setSimulationMode.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_setSimulationMode.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_setValue.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_setValue.py

Verify MTPtg Python Event Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_focusNameSelected.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_focusNameSelected.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_settingsApplied.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_settingsApplied.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_sunProximityWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_sunProximityWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_detailedState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_detailedState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_mountGuideMode.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_mountGuideMode.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_azWrapWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_azWrapWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_wavelength.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_wavelength.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_inPositionEl.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_inPositionEl.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_inBlindSpot.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_inBlindSpot.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_blindSpotWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_blindSpotWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_axesTrackMode.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_axesTrackMode.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_objectSetWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_objectSetWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_pointingModel.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_pointingModel.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_airmassWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_airmassWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_weatherDataInvalid.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_weatherDataInvalid.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_focusNameInconsistentWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_focusNameInconsistentWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_currentTarget.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_currentTarget.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_iersOutOfDate.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_iersOutOfDate.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_weatherDataApplied.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_weatherDataApplied.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_currentDebugLevel.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_currentDebugLevel.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_nextTarget.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_nextTarget.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_mountDataWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_mountDataWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_accessMode.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_accessMode.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_rotWrapWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_rotWrapWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_inPosition.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_inPosition.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_inPositionRot.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_inPositionRot.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_inPositionAz.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_inPositionAz.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_iers.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_iers.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_prospectiveTarget.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_prospectiveTarget.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_moonProximityWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_moonProximityWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_trackPosting.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_trackPosting.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_ptgAzCurrentWrap.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_ptgAzCurrentWrap.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_ptgRotCurrentWrap.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_ptgRotCurrentWrap.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_settingVersions.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_settingVersions.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_errorCode.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_errorCode.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_summaryState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_summaryState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_appliedSettingsMatchStart.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_appliedSettingsMatchStart.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_logLevel.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_logLevel.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_logMessage.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_logMessage.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_simulationMode.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_simulationMode.py

Salgen MTPtg LabVIEW
    [Documentation]    Generate ${subSystem} low-level LabView interfaces.
    [Tags]    labview
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    labview    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Directory Should Exist    ${SALWorkDir}/${subSystem}/labview
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/labview
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/labview/SAL_${subSystem}_salShmMonitor.cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/labview/SAL_${subSystem}_shmem.h
    File Should Exist    ${SALWorkDir}/${subSystem}/labview/SALLV_${subSystem}.so
    File Should Exist    ${SALWorkDir}/${subSystem}/labview/SALLV_${subSystem}_Monitor

Salgen MTPtg Java
    [Documentation]    Generate Java wrapper.
    [Tags]    java
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    sal    java    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_prospectiveTargetStatus.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_nextTargetStatus.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_currentTimesToLimits.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_currentTargetStatus.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_guidingAndOffsets.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_prospectiveTimesToLimits.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_timeAndDate.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_mountStatus.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_nextTimesToLimits.idl
    Should Contain X Times    ${output.stdout}    javac : Done Publisher    9
    Should Contain X Times    ${output.stdout}    javac : Done Subscriber    9
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl
    File Should Exist    ${SALWorkDir}/${subSystem}/java/saj_${subSystem}_types.jar
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl

Salgen MTPtg Lib
    [Documentation]    Generate the SAL shared library for ${subSystem}
    [Tags]    lib
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    lib    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Building shared library for ${subSystem} subsystem
    Directory Should Exist    ${SALWorkDir}/lib
    @{files}=    List Directory    ${SALWorkDir}/lib    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/lib/libsacpp_${subSystem}_types.so
    File Should Exist    ${SALWorkDir}/lib/libSAL_${subSystem}.so
    File Should Exist    ${SALWorkDir}/lib/SALLV_${subSystem}.so
    File Should Exist    ${SALWorkDir}/lib/SALPY_${subSystem}.so
    File Should Exist    ${SALWorkDir}/lib/libsacpp_${subSystem}_types.so
    File Should Exist    ${SALWorkDir}/lib/libSAL_${subSystem}.so
    File Should Exist    ${SALWorkDir}/lib/saj_${subSystem}_types.jar
    File Should Exist    ${SALWorkDir}/lib/SALLV_${subSystem}.so

Salgen MTPtg RPM
    [Documentation]    Generate the SAL library RPM for ${subSystem}
    [Tags]    rpm
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    rpm    version\=${SALVersion}${Build_Number}    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    @{files}=    List Directory    /tmp/
    Log File    /tmp/makerpm.log
    Should Not Contain    ${output.stdout}    ERROR : Asset required for rpm
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}${Build_Number}
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
    File Should Exist    ${SALWorkDir}/rpmbuild/SPECS/ts_sal_${subSystem}.spec
    File Should Exist    ${SALWorkDir}/rpmbuild/SOURCES/${subSystem}-${SALVersion}${Build_Number}.tgz
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/${subSystem}-${SALVersion}${Build_Number}-${XMLVersion}${DIST}.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/${subSystem}_test-${SALVersion}${Build_Number}-${XMLVersion}${DIST}.x86_64.rpm

Salgen MTPtg Maven
    [Documentation]    Generate the Maven repository.
    [Tags]    java
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    maven    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Running maven install
    Should Contain    ${output.stdout}    [INFO] Building sal_${subSystem} ${SALVersion}
    Should Contain X Times    ${output.stdout}    [INFO] BUILD SUCCESS    1
    Should Contain X Times    ${output.stdout}    [INFO] Finished at:    1
    @{files}=    List Directory    ${SALWorkDir}/maven
    File Should Exist    ${SALWorkDir}/maven/${subSystem}_${SALVersion}/pom.xml

