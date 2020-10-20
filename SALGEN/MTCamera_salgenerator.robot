*** Settings ***
Documentation    This suite builds the various interfaces for the MTCamera.
Force Tags    salgen    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${timeout}
Library    OperatingSystem
Library    Process
Resource    ../Global_Vars.resource

*** Variables ***
${subSystem}    MTCamera
${timeout}    1200s

*** Test Cases ***
Verify MTCamera XML Defintions exist
    [Tags]
    Comment    Verify the CSC XML definition files exist.
    ${output}    Run Process    ls     ${SALWorkDir}/MTCamera_*.xml    shell=True
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stderr}    No such file or directory    msg="MTCamera has no XML defintions"    values=False
    Should Not Be Empty    ${output.stdout}
    File Should Exist    ${SALWorkDir}/MTCamera_Commands.xml
    File Should Exist    ${SALWorkDir}/MTCamera_Events.xml
    File Should Exist    ${SALWorkDir}/MTCamera_Telemetry.xml

Salgen MTCamera Validate
    [Documentation]    Validate the MTCamera XML definitions.
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
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_quadbox_BFR.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_quadbox_PDU_5V.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_quadbox_PDU_24VC.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_quadbox_PDU_24VD.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_quadbox_PDU_48V.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_quadbox_REB_Bulk_PS.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_rebpower_Rebps.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_rebpower_Reb.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_hex_Cold1.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_hex_Cold2.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_hex_Cryo5.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_hex_Cryo6.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_hex_Cryo4.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_hex_Cryo3.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_hex_Cryo2.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_hex_Cryo1.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_refrig_Cold1.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_refrig_Cold2.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_refrig_Cryo5.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_refrig_Cryo6.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_refrig_Cryo4.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_refrig_Cryo3.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_refrig_Cryo2.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_refrig_Cryo1.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vacuum_IonPumps.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vacuum_TurboPump.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vacuum_CryoVacGauge.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vacuum_TurboVacGauge.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vacuum_ForelineVacGauge.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vacuum_Hex1VacGauge.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vacuum_Hex2VacGauge.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_daq_monitor_Store.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_focal_plane_Reb.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_focal_plane_Ccd.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_focal_plane_Segment.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_focal_plane_RebTotalPower.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_abort.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_disable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_standby.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_exitControl.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_start.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_enterControl.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_setLogLevel.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_setValue.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_setAuthList.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_discardRows.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_startImage.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_disableCalibration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_initGuiders.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_enableCalibration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_initImage.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_endImage.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_setFilter.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_clear.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_takeImages.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_stop.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_settingVersions.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_errorCode.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_summaryState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_appliedSettingsMatchStart.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_logLevel.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_logMessage.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_settingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_simulationMode.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_softwareVersions.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_heartbeat.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_authList.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_offlineDetailedState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_endReadout.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_endTakeImage.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_imageReadinessDetailedState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_startSetFilter.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_startUnloadFilter.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_notReadyToTakeImage.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_startShutterClose.idl
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
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_endInitializeImage.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_endSetFilter.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_startShutterOpen.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_raftsDetailedState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_availableFilters.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_startReadout.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_startRotateCarousel.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_imageReadoutParameters.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focalPlaneSummaryInfo.idl

Verify MTCamera revCodes File
    [Documentation]    Ensure MTCamera_revCodes.tcl contains 1 revcode per topic.
    [Tags]    html    
    ${output}=    Log File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_abort\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_enable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_disable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_standby\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_exitControl\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_start\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_enterControl\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_setLogLevel\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_setValue\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_setAuthList\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_discardRows\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_startImage\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_disableCalibration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_initGuiders\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_enableCalibration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_initImage\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_endImage\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_setFilter\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_clear\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_takeImages\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_stop\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_settingVersions\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_errorCode\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_summaryState\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_appliedSettingsMatchStart\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_logLevel\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_logMessage\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_settingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_simulationMode\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_softwareVersions\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_heartbeat\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_authList\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_offlineDetailedState\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_endReadout\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_endTakeImage\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_imageReadinessDetailedState\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_startSetFilter\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_startUnloadFilter\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_notReadyToTakeImage\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_startShutterClose\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_endInitializeGuider\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_endShutterClose\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_endOfImageTelemetry\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_endUnloadFilter\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_calibrationDetailedState\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_endRotateCarousel\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_startLoadFilter\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_filterChangerDetailedState\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_shutterDetailedState\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_readyToTakeImage\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ccsCommandState\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_prepareToTakeImage\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ccsConfigured\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_endLoadFilter\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_endShutterOpen\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_startIntegration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_endInitializeImage\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_endSetFilter\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_startShutterOpen\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_raftsDetailedState\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_availableFilters\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_startReadout\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_startRotateCarousel\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_imageReadoutParameters\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focalPlaneSummaryInfo\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_quadbox_BFR\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_quadbox_PDU_5V\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_quadbox_PDU_24VC\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_quadbox_PDU_24VD\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_quadbox_PDU_48V\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_quadbox_REB_Bulk_PS\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_rebpower_Rebps\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_rebpower_Reb\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_hex_Cold1\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_hex_Cold2\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_hex_Cryo5\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_hex_Cryo6\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_hex_Cryo4\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_hex_Cryo3\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_hex_Cryo2\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_hex_Cryo1\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_refrig_Cold1\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_refrig_Cold2\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_refrig_Cryo5\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_refrig_Cryo6\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_refrig_Cryo4\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_refrig_Cryo3\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_refrig_Cryo2\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_refrig_Cryo1\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vacuum_IonPumps\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vacuum_TurboPump\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vacuum_CryoVacGauge\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vacuum_TurboVacGauge\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vacuum_ForelineVacGauge\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vacuum_Hex1VacGauge\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vacuum_Hex2VacGauge\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_daq_monitor_Store\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_focal_plane_Reb\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_focal_plane_Ccd\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_focal_plane_Segment\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_focal_plane_RebTotalPower\\) [a-z0-9]{8,}

Salgen MTCamera IDL
    [Documentation]    Generate the revCoded IDL for ${subSystem}
    [Tags]    idl
    ${output}=    Run Process    ${SALHome}/bin/salgenerator    ${subSystem}    sal    idl    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    XMLVERSION = ${XMLVersion}
    Should Contain    ${output.stdout}    Completed ${subSystem} validation
    File Should Exist    ${SALWorkDir}/${subSystem}/sal_revCoded_${subSystem}.idl
    @{files}=    List Directory    ${SALWorkDir}/idl-templates/validated/
    Log Many    @{files}

Salgen MTCamera C++
    [Documentation]    Generate C++ libraries.
    [Tags]    cpp
    ${output}=    Run Process    ${SALHome}/bin/salgenerator    ${subSystem}    sal    cpp   shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stdout}    *** DDS error in file
    Should Not Contain    ${output.stdout}    Error 1
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    XMLVERSION = ${XMLVersion}
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_quadbox_BFR.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_quadbox_PDU_5V.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_quadbox_PDU_24VC.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_quadbox_PDU_24VD.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_quadbox_PDU_48V.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_quadbox_REB_Bulk_PS.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_rebpower_Rebps.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_rebpower_Reb.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_hex_Cold1.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_hex_Cold2.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_hex_Cryo5.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_hex_Cryo6.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_hex_Cryo4.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_hex_Cryo3.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_hex_Cryo2.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_hex_Cryo1.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_refrig_Cold1.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_refrig_Cold2.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_refrig_Cryo5.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_refrig_Cryo6.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_refrig_Cryo4.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_refrig_Cryo3.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_refrig_Cryo2.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_refrig_Cryo1.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_vacuum_IonPumps.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_vacuum_TurboPump.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_vacuum_CryoVacGauge.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_vacuum_TurboVacGauge.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_vacuum_ForelineVacGauge.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_vacuum_Hex1VacGauge.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_vacuum_Hex2VacGauge.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_daq_monitor_Store.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_focal_plane_Reb.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_focal_plane_Ccd.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_focal_plane_Segment.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_focal_plane_RebTotalPower.idl
    Should Contain X Times    ${output.stdout}    cpp : Done Publisher    36
    Should Contain X Times    ${output.stdout}    cpp : Done Subscriber    36
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

Verify MTCamera Telemetry directories
    [Tags]    cpp
    @{files}=    List Directory    ${SALWorkDir}    pattern=*${subSystem}*
    Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/${subSystem}_quadbox_BFR
    Directory Should Exist    ${SALWorkDir}/${subSystem}_quadbox_PDU_5V
    Directory Should Exist    ${SALWorkDir}/${subSystem}_quadbox_PDU_24VC
    Directory Should Exist    ${SALWorkDir}/${subSystem}_quadbox_PDU_24VD
    Directory Should Exist    ${SALWorkDir}/${subSystem}_quadbox_PDU_48V
    Directory Should Exist    ${SALWorkDir}/${subSystem}_quadbox_REB_Bulk_PS
    Directory Should Exist    ${SALWorkDir}/${subSystem}_rebpower_Rebps
    Directory Should Exist    ${SALWorkDir}/${subSystem}_rebpower_Reb
    Directory Should Exist    ${SALWorkDir}/${subSystem}_hex_Cold1
    Directory Should Exist    ${SALWorkDir}/${subSystem}_hex_Cold2
    Directory Should Exist    ${SALWorkDir}/${subSystem}_hex_Cryo5
    Directory Should Exist    ${SALWorkDir}/${subSystem}_hex_Cryo6
    Directory Should Exist    ${SALWorkDir}/${subSystem}_hex_Cryo4
    Directory Should Exist    ${SALWorkDir}/${subSystem}_hex_Cryo3
    Directory Should Exist    ${SALWorkDir}/${subSystem}_hex_Cryo2
    Directory Should Exist    ${SALWorkDir}/${subSystem}_hex_Cryo1
    Directory Should Exist    ${SALWorkDir}/${subSystem}_refrig_Cold1
    Directory Should Exist    ${SALWorkDir}/${subSystem}_refrig_Cold2
    Directory Should Exist    ${SALWorkDir}/${subSystem}_refrig_Cryo5
    Directory Should Exist    ${SALWorkDir}/${subSystem}_refrig_Cryo6
    Directory Should Exist    ${SALWorkDir}/${subSystem}_refrig_Cryo4
    Directory Should Exist    ${SALWorkDir}/${subSystem}_refrig_Cryo3
    Directory Should Exist    ${SALWorkDir}/${subSystem}_refrig_Cryo2
    Directory Should Exist    ${SALWorkDir}/${subSystem}_refrig_Cryo1
    Directory Should Exist    ${SALWorkDir}/${subSystem}_vacuum_IonPumps
    Directory Should Exist    ${SALWorkDir}/${subSystem}_vacuum_TurboPump
    Directory Should Exist    ${SALWorkDir}/${subSystem}_vacuum_CryoVacGauge
    Directory Should Exist    ${SALWorkDir}/${subSystem}_vacuum_TurboVacGauge
    Directory Should Exist    ${SALWorkDir}/${subSystem}_vacuum_ForelineVacGauge
    Directory Should Exist    ${SALWorkDir}/${subSystem}_vacuum_Hex1VacGauge
    Directory Should Exist    ${SALWorkDir}/${subSystem}_vacuum_Hex2VacGauge
    Directory Should Exist    ${SALWorkDir}/${subSystem}_daq_monitor_Store
    Directory Should Exist    ${SALWorkDir}/${subSystem}_focal_plane_Reb
    Directory Should Exist    ${SALWorkDir}/${subSystem}_focal_plane_Ccd
    Directory Should Exist    ${SALWorkDir}/${subSystem}_focal_plane_Segment
    Directory Should Exist    ${SALWorkDir}/${subSystem}_focal_plane_RebTotalPower

Verify MTCamera C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}_quadbox_BFR/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_quadbox_BFR/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_quadbox_PDU_5V/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_quadbox_PDU_5V/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_quadbox_PDU_24VC/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_quadbox_PDU_24VC/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_quadbox_PDU_24VD/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_quadbox_PDU_24VD/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_quadbox_PDU_48V/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_quadbox_PDU_48V/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_quadbox_REB_Bulk_PS/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_quadbox_REB_Bulk_PS/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_rebpower_Rebps/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_rebpower_Rebps/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_rebpower_Reb/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_rebpower_Reb/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_hex_Cold1/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_hex_Cold1/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_hex_Cold2/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_hex_Cold2/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_hex_Cryo5/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_hex_Cryo5/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_hex_Cryo6/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_hex_Cryo6/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_hex_Cryo4/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_hex_Cryo4/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_hex_Cryo3/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_hex_Cryo3/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_hex_Cryo2/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_hex_Cryo2/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_hex_Cryo1/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_hex_Cryo1/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_refrig_Cold1/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_refrig_Cold1/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_refrig_Cold2/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_refrig_Cold2/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_refrig_Cryo5/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_refrig_Cryo5/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_refrig_Cryo6/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_refrig_Cryo6/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_refrig_Cryo4/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_refrig_Cryo4/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_refrig_Cryo3/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_refrig_Cryo3/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_refrig_Cryo2/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_refrig_Cryo2/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_refrig_Cryo1/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_refrig_Cryo1/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_vacuum_IonPumps/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_vacuum_IonPumps/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_vacuum_TurboPump/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_vacuum_TurboPump/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_vacuum_CryoVacGauge/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_vacuum_CryoVacGauge/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_vacuum_TurboVacGauge/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_vacuum_TurboVacGauge/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_vacuum_ForelineVacGauge/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_vacuum_ForelineVacGauge/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_vacuum_Hex1VacGauge/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_vacuum_Hex1VacGauge/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_vacuum_Hex2VacGauge/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_vacuum_Hex2VacGauge/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_daq_monitor_Store/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_daq_monitor_Store/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_focal_plane_Reb/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_focal_plane_Reb/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_focal_plane_Ccd/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_focal_plane_Ccd/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_focal_plane_Segment/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_focal_plane_Segment/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_focal_plane_RebTotalPower/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_focal_plane_RebTotalPower/cpp/standalone/sacpp_${subSystem}_sub

Verify MTCamera C++ Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
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
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setValue_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setValue_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setAuthList_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setAuthList_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_discardRows_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_discardRows_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startImage_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startImage_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_disableCalibration_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_disableCalibration_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_initGuiders_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_initGuiders_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enableCalibration_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enableCalibration_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_initImage_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_initImage_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endImage_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endImage_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setFilter_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setFilter_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_clear_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_clear_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_takeImages_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_takeImages_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_stop_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_stop_controller

Verify MTCamera C++ Event Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
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
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_settingsApplied_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_settingsApplied_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_simulationMode_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_simulationMode_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_softwareVersions_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_softwareVersions_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_heartbeat_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_heartbeat_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_authList_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_authList_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_offlineDetailedState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_offlineDetailedState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endReadout_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endReadout_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endTakeImage_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endTakeImage_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_imageReadinessDetailedState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_imageReadinessDetailedState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startSetFilter_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startSetFilter_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startUnloadFilter_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startUnloadFilter_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_notReadyToTakeImage_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_notReadyToTakeImage_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startShutterClose_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startShutterClose_log
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
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endInitializeImage_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endInitializeImage_log
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
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_imageReadoutParameters_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_imageReadoutParameters_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_focalPlaneSummaryInfo_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_focalPlaneSummaryInfo_log

Salgen MTCamera Python
    [Documentation]    Generate Python libraries.
    [Tags]    python
    ${output}=    Run Process    ${SALHome}/bin/salgenerator    ${subSystem}    sal    python    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    XMLVERSION = ${XMLVersion}
    Should Contain    ${output.stdout}    Generating Python SAL support for ${subSystem}
    Should Contain    ${output.stdout}    Generating Python bindings
    Should Contain    ${output.stdout}    python : Done SALPY_${subSystem}.so
    Directory Should Exist    ${SALWorkDir}/${subSystem}/python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/SALPY_${subSystem}.so

Verify MTCamera Python Telemetry Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_quadbox_BFR_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_quadbox_BFR_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_quadbox_PDU_5V_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_quadbox_PDU_5V_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_quadbox_PDU_24VC_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_quadbox_PDU_24VC_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_quadbox_PDU_24VD_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_quadbox_PDU_24VD_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_quadbox_PDU_48V_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_quadbox_PDU_48V_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_quadbox_REB_Bulk_PS_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_quadbox_REB_Bulk_PS_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_rebpower_Rebps_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_rebpower_Rebps_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_rebpower_Reb_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_rebpower_Reb_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_hex_Cold1_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_hex_Cold1_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_hex_Cold2_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_hex_Cold2_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_hex_Cryo5_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_hex_Cryo5_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_hex_Cryo6_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_hex_Cryo6_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_hex_Cryo4_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_hex_Cryo4_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_hex_Cryo3_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_hex_Cryo3_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_hex_Cryo2_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_hex_Cryo2_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_hex_Cryo1_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_hex_Cryo1_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_refrig_Cold1_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_refrig_Cold1_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_refrig_Cold2_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_refrig_Cold2_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_refrig_Cryo5_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_refrig_Cryo5_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_refrig_Cryo6_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_refrig_Cryo6_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_refrig_Cryo4_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_refrig_Cryo4_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_refrig_Cryo3_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_refrig_Cryo3_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_refrig_Cryo2_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_refrig_Cryo2_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_refrig_Cryo1_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_refrig_Cryo1_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_vacuum_IonPumps_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_vacuum_IonPumps_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_vacuum_TurboPump_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_vacuum_TurboPump_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_vacuum_CryoVacGauge_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_vacuum_CryoVacGauge_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_vacuum_TurboVacGauge_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_vacuum_TurboVacGauge_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_vacuum_ForelineVacGauge_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_vacuum_ForelineVacGauge_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_vacuum_Hex1VacGauge_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_vacuum_Hex1VacGauge_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_vacuum_Hex2VacGauge_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_vacuum_Hex2VacGauge_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_daq_monitor_Store_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_daq_monitor_Store_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_focal_plane_Reb_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_focal_plane_Reb_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_focal_plane_Ccd_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_focal_plane_Ccd_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_focal_plane_Segment_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_focal_plane_Segment_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_focal_plane_RebTotalPower_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_focal_plane_RebTotalPower_Subscriber.py

Verify MTCamera Python Command Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
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
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_setValue.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_setValue.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_setAuthList.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_setAuthList.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_discardRows.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_discardRows.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_startImage.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_startImage.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_disableCalibration.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_disableCalibration.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_initGuiders.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_initGuiders.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_enableCalibration.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_enableCalibration.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_initImage.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_initImage.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_endImage.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_endImage.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_setFilter.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_setFilter.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_clear.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_clear.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_takeImages.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_takeImages.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_stop.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_stop.py

Verify MTCamera Python Event Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
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
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_settingsApplied.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_settingsApplied.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_simulationMode.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_simulationMode.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_softwareVersions.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_softwareVersions.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_heartbeat.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_heartbeat.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_authList.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_authList.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_offlineDetailedState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_offlineDetailedState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_endReadout.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_endReadout.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_endTakeImage.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_endTakeImage.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_imageReadinessDetailedState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_imageReadinessDetailedState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_startSetFilter.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_startSetFilter.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_startUnloadFilter.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_startUnloadFilter.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_notReadyToTakeImage.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_notReadyToTakeImage.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_startShutterClose.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_startShutterClose.py
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
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_endInitializeImage.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_endInitializeImage.py
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
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_imageReadoutParameters.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_imageReadoutParameters.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_focalPlaneSummaryInfo.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_focalPlaneSummaryInfo.py

Salgen MTCamera LabVIEW
    [Documentation]    Generate ${subSystem} low-level LabView interfaces.
    [Tags]    labview
    ${output}=    Run Process    ${SALHome}/bin/salgenerator    ${subSystem}    labview    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    XMLVERSION = ${XMLVersion}
    Directory Should Exist    ${SALWorkDir}/${subSystem}/labview
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/labview
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/labview/SAL_${subSystem}_salShmMonitor.cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/labview/SAL_${subSystem}_shmem.h
    File Should Exist    ${SALWorkDir}/${subSystem}/labview/SALLV_${subSystem}.so
    File Should Exist    ${SALWorkDir}/${subSystem}/labview/SALLV_${subSystem}_Monitor

Salgen MTCamera Java
    [Documentation]    Generate Java libraries.
    [Tags]    java
    ${output}=    Run Process    ${SALHome}/bin/salgenerator    ${subSystem}    sal    java    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    XMLVERSION = ${XMLVersion}
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_quadbox_BFR.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_quadbox_PDU_5V.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_quadbox_PDU_24VC.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_quadbox_PDU_24VD.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_quadbox_PDU_48V.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_quadbox_REB_Bulk_PS.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_rebpower_Rebps.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_rebpower_Reb.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_hex_Cold1.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_hex_Cold2.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_hex_Cryo5.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_hex_Cryo6.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_hex_Cryo4.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_hex_Cryo3.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_hex_Cryo2.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_hex_Cryo1.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_refrig_Cold1.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_refrig_Cold2.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_refrig_Cryo5.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_refrig_Cryo6.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_refrig_Cryo4.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_refrig_Cryo3.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_refrig_Cryo2.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_refrig_Cryo1.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vacuum_IonPumps.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vacuum_TurboPump.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vacuum_CryoVacGauge.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vacuum_TurboVacGauge.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vacuum_ForelineVacGauge.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vacuum_Hex1VacGauge.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vacuum_Hex2VacGauge.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_daq_monitor_Store.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_focal_plane_Reb.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_focal_plane_Ccd.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_focal_plane_Segment.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_focal_plane_RebTotalPower.idl
    Should Contain X Times    ${output.stdout}    javac : Done Publisher    36
    Should Contain X Times    ${output.stdout}    javac : Done Subscriber    36
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl
    File Should Exist    ${SALWorkDir}/${subSystem}/java/saj_${subSystem}_types.jar
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl

Salgen MTCamera Lib
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
    File Should Exist    ${SALWorkDir}/lib/libsacpp_${subSystem}_types.so
    File Should Exist    ${SALWorkDir}/lib/libSAL_${subSystem}.so
    File Should Exist    ${SALWorkDir}/lib/SALLV_${subSystem}.so
    File Should Exist    ${SALWorkDir}/lib/SALPY_${subSystem}.so
    File Should Exist    ${SALWorkDir}/lib/libsacpp_${subSystem}_types.so
    File Should Exist    ${SALWorkDir}/lib/libSAL_${subSystem}.so
    File Should Exist    ${SALWorkDir}/lib/saj_${subSystem}_types.jar

Salgen MTCamera RPM
    [Documentation]    Generate the SAL library RPM for ${subSystem}
    [Tags]    rpm
    Log Many    ${XMLVersion}    ${SALVersion}    ${Build_Number}    ${DIST}
    ${output}=    Run Process    ${SALHome}/bin/salgenerator    ${subSystem}    rpm    version\=${Build_Number}    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    @{files}=    List Directory    /tmp/
    Should Be Empty    ${output.stderr}
    File Should Exist    /tmp/makerpm_${subSystem}.log
    File Should Exist    /tmp/makerpm_${subSystem}_test.log
    File Should Exist    /tmp/makerpm-utils.log
    Log File    /tmp/makerpm_${subSystem}.log
    Log File    /tmp/makerpm_${subSystem}_test.log
    Log File    /tmp/makerpm-utils.log
    Should Not Contain    ${output.stdout}    ERROR : Asset required for rpm
    Should Not Contain    ${output.stdout}    child process exited abnormally
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
    Run Keyword If    "${Build_Number}" == ""
    ...    Set Test Variable    ${dot}    ${EMPTY}
    Run Keyword Unless    "${Build_Number}" == ""
    ...    Set Test Variable    ${dot}    .
    File Should Exist    ${SALWorkDir}/rpmbuild/SPECS/ts_sal_${subSystem}.spec
    File Should Exist    ${SALWorkDir}/rpmbuild/SOURCES/${subSystem}-${XMLVersion}.tgz
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/ts_sal_runtime-${XMLVersion}-${SALVersion}${dot}${Build_Number}${DIST}.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/ts_sal_ATruntime-${XMLVersion}-${SALVersion}${dot}${Build_Number}${DIST}.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/ts_sal_utils-${SALVersion}-1.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/${subSystem}-${XMLVersion}-${SALVersion}${dot}${Build_Number}${DIST}.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/${subSystem}_test-${XMLVersion}-${SALVersion}${dot}${Build_Number}${DIST}.x86_64.rpm

Salgen MTCamera Maven
    [Documentation]    Generate the Maven repository.
    [Tags]    java
    ${output}=    Run Process    ${SALHome}/bin/salgenerator    ${subSystem}    maven    version\=${Build_Number}${MavenVersion}    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    argv = ${subSystem} maven version=${Build_Number}${MavenVersion}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    XMLVERSION = ${XMLVersion}
    Should Contain    ${output.stdout}    Running maven install
    Should Contain    ${output.stdout}    [INFO] Building sal_${subSystem} ${XMLVersion}_${SALVersion}${Build_Number}${MavenVersion}
    Should Contain X Times    ${output.stdout}    [INFO] BUILD SUCCESS    1
    Should Contain X Times    ${output.stdout}    [INFO] Finished at:    1
    @{files}=    List Directory    ${SALWorkDir}/maven
    File Should Exist    ${SALWorkDir}/maven/${subSystem}-${XMLVersion}_${SALVersion}${Build_Number}${MavenVersion}/pom.xml

Cleanup stdout and stderr Files
    [Tags]
    Remove Files    ${EXECDIR}${/}${subSystem}_stdout.txt    ${EXECDIR}${/}${subSystem}_stderr.txt

