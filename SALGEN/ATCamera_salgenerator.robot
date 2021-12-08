*** Settings ***
Documentation    This suite builds the various interfaces for the ATCamera.
Force Tags    salgen    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${timeout}
Library    OperatingSystem
Library    Process
Resource    ../Global_Vars.resource

*** Variables ***
${subSystem}    ATCamera
${timeout}    1200s

*** Test Cases ***
Verify ATCamera XML Defintions exist
    [Tags]
    Comment    Verify the CSC XML definition files exist.
    ${output}    Run Process    ls     ${SALWorkDir}/${subSystem}_*xml    shell=True
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Be Empty    ${output.stdout}
    File Should Exist    ${SALWorkDir}/ATCamera_Commands.xml
    File Should Exist    ${SALWorkDir}/ATCamera_Events.xml
    File Should Exist    ${SALWorkDir}/ATCamera_Telemetry.xml

Salgen ATCamera Validate
    [Documentation]    Validate the ATCamera XML definitions.
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
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_focal_plane_Ccd.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_focal_plane_Reb.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_focal_plane_RebTotalPower.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_daq_monitor_Store.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_power.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vacuum.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_disable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_exitControl.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_setAuthList.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_setLogLevel.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_standby.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_start.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_enterControl.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_discardRows.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_startImage.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_disableCalibration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_initGuiders.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_enableCalibration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_initImage.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_endImage.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_clear.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_takeImages.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_stop.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_play.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_playlist.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_heartbeat.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_logLevel.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_logMessage.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_softwareVersions.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_authList.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_errorCode.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_simulationMode.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_summaryState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_appliedSettingsMatchStart.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_settingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_settingVersions.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_largeFileObjectAvailable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_offlineDetailedState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_endReadout.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_endTakeImage.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_imageReadinessDetailedState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_notReadyToTakeImage.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_startShutterClose.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_endShutterClose.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_endOfImageTelemetry.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_calibrationDetailedState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_shutterDetailedState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_readyToTakeImage.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ccsCommandState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_prepareToTakeImage.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_endShutterOpen.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_startIntegration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_startShutterOpen.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_raftsDetailedState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_startReadout.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_shutterMotionProfile.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_imageReadoutParameters.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focalPlaneSummaryInfo.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_Ccd_HardwareIdSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_Ccd_LimitsSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_Ccd_RaftsSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_ImageDatabaseServiceSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_ImageNameServiceSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_InstrumentConfig_InstrumentSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_PeriodicTasksSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_PeriodicTasks_timersSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_Raft_HardwareIdSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_Raft_RaftTempControlSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_Raft_RaftTempControlStatusSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_RebTotalPower_LimitsSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_Reb_HardwareIdSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_Reb_LimitsSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_Reb_RaftsSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_Reb_RaftsLimitsSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_Reb_RaftsPowerSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_Reb_timersSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_SequencerConfig_DAQSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_SequencerConfig_SequencerSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_WebHooksConfig_VisualizationSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_daq_monitor_PeriodicTasksSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_daq_monitor_PeriodicTasks_timersSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_daq_monitor_Stats_StatisticsSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_daq_monitor_Stats_buildSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_daq_monitor_StoreSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_daq_monitor_Store_LimitsSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_daq_monitor_Store_StoreSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ats_power_AgentMonitorService_timersSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ats_power_Analog_I_LimitsSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ats_power_Analog_PowerSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ats_power_Analog_V_LimitsSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ats_power_Aux_I_LimitsSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ats_power_Aux_PowerSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ats_power_Aux_V_LimitsSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ats_power_ClkHigh_I_LimitsSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ats_power_ClkHigh_V_LimitsSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ats_power_ClkLow_I_LimitsSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ats_power_ClkLow_V_LimitsSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ats_power_ClockHigh_PowerSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ats_power_ClockLow_PowerSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ats_power_DPHI_I_LimitsSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ats_power_DPHI_PowerSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ats_power_DPHI_V_LimitsSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ats_power_Digital_I_LimitsSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ats_power_Digital_PowerSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ats_power_Digital_V_LimitsSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ats_power_Fan_I_LimitsSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ats_power_Fan_PowerSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ats_power_Fan_V_LimitsSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ats_power_HVBias_I_LimitsSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ats_power_HVBias_PowerSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ats_power_HVBias_V_LimitsSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ats_power_Hameg1_PowerSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ats_power_Hameg2_PowerSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ats_power_Hameg3_PowerSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ats_power_Heartbeat_timersSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ats_power_Keithley_PowerSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ats_power_Monitor_check_timersSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ats_power_Monitor_publish_timersSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ats_power_Monitor_update_timersSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ats_power_OD_I_LimitsSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ats_power_OD_PowerSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ats_power_OD_V_LimitsSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ats_power_OTM_I_LimitsSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ats_power_OTM_PowerSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ats_power_OTM_V_LimitsSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ats_power_Power_state_timersSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ats_power_RuntimeInfo_timersSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ats_power_SchedulersSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ats_AgentMonitorService_timersSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ats_CryoCon_DeviceSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ats_Heartbeat_timersSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ats_Monitor_check_timersSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ats_Monitor_publish_timersSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ats_Monitor_update_timersSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ats_RuntimeInfo_timersSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ats_SchedulersSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ats_TempCCDSetPoint_LimitsSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ats_TempCCD_LimitsSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ats_TempColdPlate_LimitsSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ats_TempCryoHead_LimitsSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_ats_Vacuum_LimitsSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_bonn_shutter_PeriodicTasksSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_bonn_shutter_PeriodicTasks_timersSettingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_shutterBladeMotionProfile.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_imageStored.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fitsFilesWritten.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fileCommandExecution.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_imageVisualization.idl

Verify ATCamera revCodes File
    [Documentation]    Ensure ATCamera_revCodes.tcl contains 1 revcode per topic.
    [Tags]    doc    
    ${output}=    Log File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_disable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_enable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_exitControl\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_setAuthList\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_setLogLevel\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_standby\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_start\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_enterControl\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_discardRows\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_startImage\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_disableCalibration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_initGuiders\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_enableCalibration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_initImage\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_endImage\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_clear\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_takeImages\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_stop\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_play\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_playlist\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_heartbeat\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_logLevel\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_logMessage\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_softwareVersions\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_authList\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_errorCode\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_simulationMode\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_summaryState\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_appliedSettingsMatchStart\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_settingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_settingVersions\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_largeFileObjectAvailable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_offlineDetailedState\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_endReadout\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_endTakeImage\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_imageReadinessDetailedState\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_notReadyToTakeImage\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_startShutterClose\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_endShutterClose\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_endOfImageTelemetry\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_calibrationDetailedState\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_shutterDetailedState\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_readyToTakeImage\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ccsCommandState\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_prepareToTakeImage\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_endShutterOpen\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_startIntegration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_startShutterOpen\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_raftsDetailedState\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_startReadout\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_shutterMotionProfile\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_imageReadoutParameters\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focalPlaneSummaryInfo\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_Ccd_HardwareIdSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_Ccd_LimitsSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_Ccd_RaftsSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_ImageDatabaseServiceSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_ImageNameServiceSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_InstrumentConfig_InstrumentSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_PeriodicTasksSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_PeriodicTasks_timersSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_Raft_HardwareIdSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_Raft_RaftTempControlSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_Raft_RaftTempControlStatusSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_RebTotalPower_LimitsSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_Reb_HardwareIdSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_Reb_LimitsSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_Reb_RaftsSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_Reb_RaftsLimitsSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_Reb_RaftsPowerSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_Reb_timersSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_SequencerConfig_DAQSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_SequencerConfig_SequencerSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_WebHooksConfig_VisualizationSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_daq_monitor_PeriodicTasksSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_daq_monitor_PeriodicTasks_timersSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_daq_monitor_Stats_StatisticsSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_daq_monitor_Stats_buildSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_daq_monitor_StoreSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_daq_monitor_Store_LimitsSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_daq_monitor_Store_StoreSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ats_power_AgentMonitorService_timersSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ats_power_Analog_I_LimitsSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ats_power_Analog_PowerSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ats_power_Analog_V_LimitsSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ats_power_Aux_I_LimitsSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ats_power_Aux_PowerSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ats_power_Aux_V_LimitsSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ats_power_ClkHigh_I_LimitsSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ats_power_ClkHigh_V_LimitsSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ats_power_ClkLow_I_LimitsSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ats_power_ClkLow_V_LimitsSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ats_power_ClockHigh_PowerSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ats_power_ClockLow_PowerSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ats_power_DPHI_I_LimitsSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ats_power_DPHI_PowerSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ats_power_DPHI_V_LimitsSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ats_power_Digital_I_LimitsSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ats_power_Digital_PowerSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ats_power_Digital_V_LimitsSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ats_power_Fan_I_LimitsSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ats_power_Fan_PowerSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ats_power_Fan_V_LimitsSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ats_power_HVBias_I_LimitsSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ats_power_HVBias_PowerSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ats_power_HVBias_V_LimitsSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ats_power_Hameg1_PowerSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ats_power_Hameg2_PowerSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ats_power_Hameg3_PowerSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ats_power_Heartbeat_timersSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ats_power_Keithley_PowerSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ats_power_Monitor_check_timersSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ats_power_Monitor_publish_timersSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ats_power_Monitor_update_timersSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ats_power_OD_I_LimitsSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ats_power_OD_PowerSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ats_power_OD_V_LimitsSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ats_power_OTM_I_LimitsSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ats_power_OTM_PowerSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ats_power_OTM_V_LimitsSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ats_power_Power_state_timersSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ats_power_RuntimeInfo_timersSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ats_power_SchedulersSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ats_AgentMonitorService_timersSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ats_CryoCon_DeviceSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ats_Heartbeat_timersSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ats_Monitor_check_timersSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ats_Monitor_publish_timersSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ats_Monitor_update_timersSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ats_RuntimeInfo_timersSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ats_SchedulersSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ats_TempCCDSetPoint_LimitsSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ats_TempCCD_LimitsSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ats_TempColdPlate_LimitsSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ats_TempCryoHead_LimitsSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_ats_Vacuum_LimitsSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_bonn_shutter_PeriodicTasksSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_bonn_shutter_PeriodicTasks_timersSettingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_shutterBladeMotionProfile\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_imageStored\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fitsFilesWritten\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fileCommandExecution\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_imageVisualization\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_focal_plane_Ccd\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_focal_plane_Reb\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_focal_plane_RebTotalPower\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_daq_monitor_Store\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_power\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vacuum\\) [a-z0-9]{8,}

Salgen ATCamera IDL
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

Salgen ATCamera Java
    [Documentation]    Generate Java libraries.
    [Tags]    java
    ${output}=    Run Process    ${SALHome}/bin/salgenerator    ${subSystem}    sal    java    version\=${Build_Number}${MavenVersion}    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stdout}    ERROR : Failed to generate Java DDS types
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    XMLVERSION = ${XMLVersion}
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_focal_plane_Ccd.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_focal_plane_Reb.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_focal_plane_RebTotalPower.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_daq_monitor_Store.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_power.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vacuum.idl
    Should Contain X Times    ${output.stdout}    javac : Done Publisher    6
    Should Contain X Times    ${output.stdout}    javac : Done Subscriber    6
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl
    File Should Exist    ${SALWorkDir}/${subSystem}/java/saj_${subSystem}_types.jar
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl

Salgen ATCamera Maven
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

Salgen ATCamera Lib
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
    File Should Exist    ${SALWorkDir}/lib/saj_${subSystem}_types.jar

Salgen ATCamera RPM
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
    Run Keyword If    "${Build_Number}" == ""
    ...    Set Test Variable    ${dot}    ${EMPTY}
    Run Keyword Unless    "${Build_Number}" == ""
    ...    Set Test Variable    ${dot}    .
    File Should Exist    ${SALWorkDir}/rpmbuild/SPECS/ts_sal_${subSystem}.spec
    File Should Exist    ${SALWorkDir}/rpmbuild/SOURCES/${subSystem}-${XMLVersionBase}.tgz
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/ts_sal_runtime-${XMLVersionBase}-${SALVersionBase}*${DIST}.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/ts_sal_ATruntime-${XMLVersionBase}-${SALVersionBase}*${DIST}.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/ts_sal_utils-${SALVersionBase}-1.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/${subSystem}-${XMLVersionBase}-${SALVersionBase}${dot}${Build_Number}${DIST}.x86_64.rpm
    Should Not Contain    ${output.stdout}    child process exited abnormally

Verify ATCamera RPM Contents
    [Documentation]    Verify the ${subSystem} RPM contains all the expected libraries
    [Tags]    rpm
    Comment    Re-run the {dot} process, so this test case can run independently.
    Run Keyword If    "${Build_Number}" == ""
    ...    Set Test Variable    ${dot}    ${EMPTY}
    Run Keyword Unless    "${Build_Number}" == ""
    ...    Set Test Variable    ${dot}    .
    ${output}=    Run Process    rpm    -qpl    ${subSystem}-${XMLVersionBase}-${SALVersionBase}${dot}${Build_Number}${DIST}.x86_64.rpm    cwd=${SALWorkDir}/rpmbuild/RPMS/x86_64
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stderr}    error
    Should Not Contain    ${output.stderr}    No such file or directory
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/idl/sal_revCoded_${subSystem}.idl
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/scripts/${subSystem}_revCodes.tcl
    Comment    Verify the interface definition files are included.
    Should Contain     ${output.stdout}    /opt/lsst/ts_xml/sal_interfaces/${subSystem}/${subSystem}_Generics.xml
    Should Contain     ${output.stdout}    /opt/lsst/ts_xml/sal_interfaces/${subSystem}/${subSystem}_Commands.xml
    Should Contain     ${output.stdout}    /opt/lsst/ts_xml/sal_interfaces/${subSystem}/${subSystem}_Commands.html
    Should Contain     ${output.stdout}    /opt/lsst/ts_xml/sal_interfaces/${subSystem}/${subSystem}_Events.xml
    Should Contain     ${output.stdout}    /opt/lsst/ts_xml/sal_interfaces/${subSystem}/${subSystem}_Events.html
    Should Contain     ${output.stdout}    /opt/lsst/ts_xml/sal_interfaces/${subSystem}/${subSystem}_Telemetry.xml
    Should Contain     ${output.stdout}    /opt/lsst/ts_xml/sal_interfaces/${subSystem}/${subSystem}_Telemetry.html

Cleanup stdout and stderr Files
    [Tags]
    Remove Files    ${EXECDIR}${/}${subSystem}_stdout.txt    ${EXECDIR}${/}${subSystem}_stderr.txt

