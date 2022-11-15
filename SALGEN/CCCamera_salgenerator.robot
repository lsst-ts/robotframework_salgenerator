*** Settings ***
Documentation    This suite builds the various interfaces for the CCCamera.
Force Tags    salgen    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${timeout}
Library    OperatingSystem
Library    Process
Resource    ../Global_Vars.resource

*** Variables ***
${subSystem}    CCCamera
${timeout}    1200s

*** Test Cases ***
Verify CCCamera XML Defintions exist
    [Tags]
    Comment    Verify the CSC XML definition files exist.
    ${output}    Run Process    ls     ${SALWorkDir}/${subSystem}_*xml    shell=True
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Be Empty    ${output.stdout}
    File Should Exist    ${SALWorkDir}/CCCamera_Commands.xml
    File Should Exist    ${SALWorkDir}/CCCamera_Events.xml
    File Should Exist    ${SALWorkDir}/CCCamera_Telemetry.xml

Salgen CCCamera Validate
    [Documentation]    Validate the CCCamera XML definitions.
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
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_bonn_shutter_Device.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_daq_monitor_Store.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_rebpower_Reb.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_rebpower_Rebps.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vacuum_Cold1.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vacuum_Cold2.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vacuum_Cryo.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vacuum_IonPumps.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vacuum_Rtds.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vacuum_Turbo.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vacuum_VQMonitor.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_quadbox_BFR.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_quadbox_PDU_24VC.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_quadbox_PDU_24VD.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_quadbox_PDU_48V.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_quadbox_PDU_5V.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_focal_plane_Ccd.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_focal_plane_Reb.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_focal_plane_RebTotalPower.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_focal_plane_Segment.idl
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
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_setFilter.idl
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
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_configurationApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_configurationsAvailable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_largeFileObjectAvailable.idl
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
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_GeneralConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_LinearEncoder_DevicesConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_LinearEncoder_GeneralConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_LinearEncoder_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_PeriodicTasks_GeneralConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_PeriodicTasks_timersConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_StepperMotor_DevicesConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_StepperMotor_GeneralConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_StepperMotor_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_StepperMotor_MotorConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_bonn_shutter_Device_DevicesConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_bonn_shutter_Device_GeneralConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_bonn_shutter_Device_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_bonn_shutter_GeneralConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_bonn_shutter_PeriodicTasks_GeneralConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_bonn_shutter_PeriodicTasks_timersConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_daq_monitor_PeriodicTasks_GeneralConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_daq_monitor_PeriodicTasks_timersConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_daq_monitor_Stats_StatisticsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_daq_monitor_StoreConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_daq_monitor_Store_DevicesConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_daq_monitor_Store_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_daq_monitor_Store_StoreConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_rebpower_EmergencyResponseManager_GeneralConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_rebpower_GeneralConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_rebpower_PeriodicTasks_GeneralConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_rebpower_PeriodicTasks_timersConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_rebpower_Reb_GeneralConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_rebpower_Reb_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_rebpower_Rebps_DevicesConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_rebpower_Rebps_GeneralConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_rebpower_Rebps_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_rebpower_Rebps_PowerConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_rebpower_Rebps_buildConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_Cold1_CryoconConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_Cold1_DevicesConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_Cold1_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_Cold2_CryoconConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_Cold2_DevicesConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_Cold2_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_Cryo_CryoconConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_Cryo_DevicesConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_Cryo_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_IonPumps_CryoConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_IonPumps_DevicesConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_IonPumps_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_PeriodicTasks_GeneralConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_PeriodicTasks_timersConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_Rtds_DeviceConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_Rtds_DevicesConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_Rtds_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_Turbo_DevicesConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_Turbo_GeneralConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_Turbo_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_VQMonitor_CryoConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_VQMonitor_DevicesConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_VQMonitor_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_VacPluto_DeviceConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_VacPluto_DevicesConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_VacuumConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_quadbox_BFR_DevicesConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_quadbox_BFR_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_quadbox_BFR_QuadboxConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_quadbox_PDU_24VC_DevicesConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_quadbox_PDU_24VC_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_quadbox_PDU_24VC_QuadboxConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_quadbox_PDU_24VD_DevicesConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_quadbox_PDU_24VD_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_quadbox_PDU_24VD_QuadboxConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_quadbox_PDU_48V_DevicesConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_quadbox_PDU_48V_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_quadbox_PDU_48V_QuadboxConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_quadbox_PDU_5V_DevicesConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_quadbox_PDU_5V_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_quadbox_PDU_5V_QuadboxConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_quadbox_PeriodicTasks_GeneralConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_quadbox_PeriodicTasks_timersConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_quadbox_REB_Bulk_PS_DevicesConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_quadbox_REB_Bulk_PS_QuadboxConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_Ccd_HardwareIdConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_Ccd_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_Ccd_RaftsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_ImageDatabaseService_GeneralConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_ImageNameService_GeneralConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_InstrumentConfig_InstrumentConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_PeriodicTasks_GeneralConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_PeriodicTasks_timersConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_Raft_HardwareIdConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_Raft_RaftTempControlConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_Raft_RaftTempControlStatusConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_RebTotalPower_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_Reb_DevicesConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_Reb_HardwareIdConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_Reb_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_Reb_RaftsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_Reb_RaftsLimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_Reb_RaftsPowerConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_Reb_timersConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_Segment_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_SequencerConfig_DAQConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_SequencerConfig_SequencerConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_WebHooksConfig_VisualizationConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_image_handling_ImageHandler_CommandsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_image_handling_ImageHandler_DAQConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_image_handling_ImageHandler_FitsHandlingConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_image_handling_PeriodicTasks_GeneralConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_image_handling_PeriodicTasks_timersConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_image_handling_Reb_FitsHandlingConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_image_handling_Reb_GeneralConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_mpm_PeriodicTasks_GeneralConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_mpm_PeriodicTasks_timersConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_mpm_Pluto_DeviceConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_mpm_Pluto_DevicesConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_shutterBladeMotionProfile.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_imageStored.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fitsFilesWritten.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fileCommandExecution.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_imageVisualization.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_summaryStatus.idl

Verify CCCamera revCodes File
    [Documentation]    Ensure CCCamera_revCodes.tcl contains 1 revcode per topic.
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
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_setFilter\\) [a-z0-9]{8,}
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
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_configurationApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_configurationsAvailable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_largeFileObjectAvailable\\) [a-z0-9]{8,}
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
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_GeneralConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_LinearEncoder_DevicesConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_LinearEncoder_GeneralConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_LinearEncoder_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_PeriodicTasks_GeneralConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_PeriodicTasks_timersConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_StepperMotor_DevicesConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_StepperMotor_GeneralConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_StepperMotor_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_StepperMotor_MotorConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_bonn_shutter_Device_DevicesConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_bonn_shutter_Device_GeneralConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_bonn_shutter_Device_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_bonn_shutter_GeneralConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_bonn_shutter_PeriodicTasks_GeneralConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_bonn_shutter_PeriodicTasks_timersConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_daq_monitor_PeriodicTasks_GeneralConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_daq_monitor_PeriodicTasks_timersConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_daq_monitor_Stats_StatisticsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_daq_monitor_StoreConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_daq_monitor_Store_DevicesConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_daq_monitor_Store_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_daq_monitor_Store_StoreConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_rebpower_EmergencyResponseManager_GeneralConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_rebpower_GeneralConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_rebpower_PeriodicTasks_GeneralConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_rebpower_PeriodicTasks_timersConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_rebpower_Reb_GeneralConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_rebpower_Reb_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_rebpower_Rebps_DevicesConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_rebpower_Rebps_GeneralConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_rebpower_Rebps_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_rebpower_Rebps_PowerConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_rebpower_Rebps_buildConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_Cold1_CryoconConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_Cold1_DevicesConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_Cold1_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_Cold2_CryoconConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_Cold2_DevicesConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_Cold2_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_Cryo_CryoconConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_Cryo_DevicesConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_Cryo_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_IonPumps_CryoConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_IonPumps_DevicesConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_IonPumps_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_PeriodicTasks_GeneralConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_PeriodicTasks_timersConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_Rtds_DeviceConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_Rtds_DevicesConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_Rtds_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_Turbo_DevicesConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_Turbo_GeneralConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_Turbo_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_VQMonitor_CryoConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_VQMonitor_DevicesConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_VQMonitor_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_VacPluto_DeviceConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_VacPluto_DevicesConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_VacuumConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_quadbox_BFR_DevicesConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_quadbox_BFR_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_quadbox_BFR_QuadboxConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_quadbox_PDU_24VC_DevicesConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_quadbox_PDU_24VC_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_quadbox_PDU_24VC_QuadboxConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_quadbox_PDU_24VD_DevicesConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_quadbox_PDU_24VD_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_quadbox_PDU_24VD_QuadboxConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_quadbox_PDU_48V_DevicesConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_quadbox_PDU_48V_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_quadbox_PDU_48V_QuadboxConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_quadbox_PDU_5V_DevicesConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_quadbox_PDU_5V_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_quadbox_PDU_5V_QuadboxConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_quadbox_PeriodicTasks_GeneralConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_quadbox_PeriodicTasks_timersConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_quadbox_REB_Bulk_PS_DevicesConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_quadbox_REB_Bulk_PS_QuadboxConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_Ccd_HardwareIdConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_Ccd_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_Ccd_RaftsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_ImageDatabaseService_GeneralConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_ImageNameService_GeneralConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_InstrumentConfig_InstrumentConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_PeriodicTasks_GeneralConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_PeriodicTasks_timersConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_Raft_HardwareIdConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_Raft_RaftTempControlConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_Raft_RaftTempControlStatusConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_RebTotalPower_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_Reb_DevicesConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_Reb_HardwareIdConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_Reb_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_Reb_RaftsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_Reb_RaftsLimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_Reb_RaftsPowerConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_Reb_timersConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_Segment_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_SequencerConfig_DAQConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_SequencerConfig_SequencerConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_WebHooksConfig_VisualizationConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_image_handling_ImageHandler_CommandsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_image_handling_ImageHandler_DAQConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_image_handling_ImageHandler_FitsHandlingConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_image_handling_PeriodicTasks_GeneralConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_image_handling_PeriodicTasks_timersConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_image_handling_Reb_FitsHandlingConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_image_handling_Reb_GeneralConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_mpm_PeriodicTasks_GeneralConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_mpm_PeriodicTasks_timersConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_mpm_Pluto_DeviceConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_mpm_Pluto_DevicesConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_shutterBladeMotionProfile\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_imageStored\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fitsFilesWritten\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fileCommandExecution\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_imageVisualization\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_summaryStatus\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_bonn_shutter_Device\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_daq_monitor_Store\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_rebpower_Reb\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_rebpower_Rebps\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vacuum_Cold1\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vacuum_Cold2\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vacuum_Cryo\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vacuum_IonPumps\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vacuum_Rtds\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vacuum_Turbo\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vacuum_VQMonitor\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_quadbox_BFR\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_quadbox_PDU_24VC\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_quadbox_PDU_24VD\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_quadbox_PDU_48V\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_quadbox_PDU_5V\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_focal_plane_Ccd\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_focal_plane_Reb\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_focal_plane_RebTotalPower\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_focal_plane_Segment\\) [a-z0-9]{8,}

Salgen CCCamera IDL
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

Salgen CCCamera Java
    [Documentation]    Generate Java libraries.
    [Tags]    java
    ${output}=    Run Process    ${SALHome}/bin/salgenerator    ${subSystem}    sal    java    version\=${Build_Number}${MavenVersion}    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stdout}    ERROR : Failed to generate Java DDS types
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    XMLVERSION = ${XMLVersion}
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_bonn_shutter_Device.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_daq_monitor_Store.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_rebpower_Reb.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_rebpower_Rebps.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vacuum_Cold1.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vacuum_Cold2.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vacuum_Cryo.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vacuum_IonPumps.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vacuum_Rtds.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vacuum_Turbo.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vacuum_VQMonitor.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_quadbox_BFR.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_quadbox_PDU_24VC.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_quadbox_PDU_24VD.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_quadbox_PDU_48V.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_quadbox_PDU_5V.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_focal_plane_Ccd.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_focal_plane_Reb.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_focal_plane_RebTotalPower.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_focal_plane_Segment.idl
    Should Contain X Times    ${output.stdout}    javac : Done Publisher    21
    Should Contain X Times    ${output.stdout}    javac : Done Subscriber    21
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl
    File Should Exist    ${SALWorkDir}/${subSystem}/java/saj_${subSystem}_types.jar
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl

Salgen CCCamera Maven
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

Salgen CCCamera Lib
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

Salgen CCCamera RPM
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
        Set Test Variable    ${dot}    ${EMPTY}
    ELSE IF    ${{'RC' in '${Build_Number}'}}
        Set Test Variable    ${dot}    ${EMPTY}
    ELSE
        Set Test Variable    ${dot}    .
    END
    File Should Exist    ${SALWorkDir}/rpmbuild/SPECS/ts_sal_${subSystem}.spec
    File Should Exist    ${SALWorkDir}/rpmbuild/SOURCES/${subSystem}-${XMLVersionBase}.tgz
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/ts_sal_runtime-${XMLVersionBase}-${SALVersionBase}*${DIST}.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/ts_sal_ATruntime-${XMLVersionBase}-${SALVersionBase}*${DIST}.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/ts_sal_utils-${SALVersionBase}-1.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/${subSystem}-${XMLVersionBase}-${SALVersionBase}${dot}${Build_Number}${DIST}.x86_64.rpm
    Should Not Contain    ${output.stdout}    child process exited abnormally

Verify CCCamera RPM Contents
    [Documentation]    Verify the ${subSystem} RPM contains all the expected libraries
    [Tags]    rpm
    Comment    Re-run the {dot} process, so this test case can run independently.
    IF    "${Build_Number}" == ""
        Set Test Variable    ${dot}    ${EMPTY}
    ELSE IF    ${{'RC' in '${Build_Number}'}}
        Set Test Variable    ${dot}    ${EMPTY}
    ELSE
        Set Test Variable    ${dot}    .
    END
    ${output}=    Run Process    rpm    -qpl    ${subSystem}-${XMLVersionBase}-${SALVersionBase}${dot}${Build_Number}${DIST}.x86_64.rpm    cwd=${SALWorkDir}/rpmbuild/RPMS/x86_64
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stderr}    error
    Should Not Contain    ${output.stderr}    No such file or directory
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/idl/sal_revCoded_${subSystem}.idl
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/scripts/${subSystem}_revCodes.tcl
    Comment    Verify the interface definition files are included.
    Should Contain     ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Generics.xml
    Should Contain     ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Commands.xml
    Should Contain     ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Commands.html
    Should Contain     ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Events.xml
    Should Contain     ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Events.html
    Should Contain     ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Telemetry.xml
    Should Contain     ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Telemetry.html

Cleanup stdout and stderr Files
    [Tags]
    Remove Files    ${EXECDIR}${/}${subSystem}_stdout.txt    ${EXECDIR}${/}${subSystem}_stderr.txt

