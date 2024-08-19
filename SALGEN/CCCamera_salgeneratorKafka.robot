*** Settings ***
Documentation    This suite builds the various interfaces for the CCCamera.
Force Tags    salgen    cccamera
Suite Setup    Log Many    ${Host}    ${subSystem}    ${timeout}
Library    OperatingSystem
Library    Process
Resource    ../Global_Vars.resource

*** Variables ***
${subSystem}    CCCamera
${timeout}    1200s

*** Test Cases ***
Verify CCCamera XML Defintions exist
    [Tags]    validate
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
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_Generics.xml
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_Commands.xml
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}_cmddef.tcl
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_Events.xml
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}_evtdef.tcl
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_Telemetry.xml
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}_tlmdef.tcl
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_heartbeat.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_logLevel.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_logMessage.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_softwareVersions.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_errorCode.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_simulationMode.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_summaryState.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_configurationApplied.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_configurationsAvailable.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_largeFileObjectAvailable.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_offlineDetailedState.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_endReadout.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_endTakeImage.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_imageReadinessDetailedState.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_startSetFilter.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_startUnloadFilter.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_notReadyToTakeImage.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_startShutterClose.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_endInitializeGuider.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_endShutterClose.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_endOfImageTelemetry.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_endUnloadFilter.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_calibrationDetailedState.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_endRotateCarousel.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_startLoadFilter.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_filterChangerDetailedState.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_shutterDetailedState.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_readyToTakeImage.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_ccsCommandState.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_prepareToTakeImage.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_ccsConfigured.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_endLoadFilter.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_endShutterOpen.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_startIntegration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_endInitializeImage.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_endSetFilter.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_startShutterOpen.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_raftsDetailedState.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_availableFilters.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_startReadout.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_startRotateCarousel.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_imageReadoutParameters.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focalPlaneSummaryInfo.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_GeneralConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_LinearEncoder_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_LinearEncoder_GeneralConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_PeriodicTasks_GeneralConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_PeriodicTasks_timersConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_StepperMotor_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_StepperMotor_GeneralConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_StepperMotor_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_StepperMotor_MotorConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_bonn_shutter_Device_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_bonn_shutter_Device_GeneralConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_bonn_shutter_Device_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_bonn_shutter_GeneralConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_bonn_shutter_PeriodicTasks_GeneralConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_bonn_shutter_PeriodicTasks_timersConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_daq_monitor_PeriodicTasks_GeneralConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_daq_monitor_PeriodicTasks_timersConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_daq_monitor_Stats_StatisticsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_daq_monitor_StoreConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_daq_monitor_Store_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_daq_monitor_Store_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_daq_monitor_Store_StoreConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_rebpower_EmergencyResponseManager_GeneralConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_rebpower_GeneralConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_rebpower_PeriodicTasks_GeneralConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_rebpower_PeriodicTasks_timersConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_rebpower_RebTotalPower_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_rebpower_Reb_GeneralConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_rebpower_Reb_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_rebpower_Rebps_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_rebpower_Rebps_GeneralConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_rebpower_Rebps_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_rebpower_Rebps_PowerConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_rebpower_Rebps_buildConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_Cold1_CryoconConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_Cold1_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_Cold1_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_Cold2_CryoconConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_Cold2_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_Cold2_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_Cryo_CryoconConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_Cryo_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_Cryo_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_IonPumps_CryoConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_IonPumps_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_IonPumps_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_PeriodicTasks_GeneralConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_PeriodicTasks_timersConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_Rtds_DeviceConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_Rtds_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_Rtds_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_Turbo_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_Turbo_GeneralConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_Turbo_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_Turbo_buildConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_VQMonitor_CryoConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_VQMonitor_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_VQMonitor_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_VacPluto_DeviceConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_VacPluto_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_VacuumConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_BFR_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_BFR_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_BFR_QuadboxConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_PDU_24VC_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_PDU_24VC_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_PDU_24VC_QuadboxConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_PDU_24VD_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_PDU_24VD_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_PDU_24VD_QuadboxConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_PDU_48V_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_PDU_48V_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_PDU_48V_QuadboxConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_PDU_5V_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_PDU_5V_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_PDU_5V_QuadboxConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_PeriodicTasks_GeneralConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_PeriodicTasks_timersConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_Ccd_HardwareIdConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_Ccd_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_ImageDatabaseService_GeneralConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_ImageNameService_GeneralConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_InstrumentConfig_InstrumentConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_MonitoringConfig_MonitoringConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_PeriodicTasks_GeneralConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_PeriodicTasks_timersConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_Raft_HardwareIdConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_Raft_RaftTempControlConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_Raft_RaftTempControlStatusConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_RebTotalPower_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_Reb_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_Reb_GeneralConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_Reb_HardwareIdConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_Reb_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_Reb_RaftsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_Reb_RaftsLimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_Reb_RaftsPowerConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_Reb_timersConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_RebsAverageTemp6_GeneralConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_RebsAverageTemp6_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_Segment_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_SequencerConfig_DAQConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_SequencerConfig_GuiderConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_SequencerConfig_SequencerConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_WebHooksConfig_VisualizationConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_image_handling_FitsService_GeneralConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_image_handling_ImageHandler_CommandsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_image_handling_ImageHandler_DAQConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_image_handling_ImageHandler_FitsHandlingConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_image_handling_ImageHandler_GuiderConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_image_handling_PeriodicTasks_GeneralConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_image_handling_PeriodicTasks_timersConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_image_handling_StatusAggregator_GeneralConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_mpm_PeriodicTasks_GeneralConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_mpm_PeriodicTasks_timersConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_mpm_Pluto_DeviceConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_mpm_Pluto_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_Cold1_DeviceConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_Cold1_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_Cold1_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_Cold1_PicConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_Cold2_DeviceConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_Cold2_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_Cold2_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_Cold2_PicConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_ColdCompLimits_CompLimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_CoolMaq20_DeviceConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_CoolMaq20_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_Cryo1_DeviceConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_Cryo1_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_Cryo1_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_Cryo2_DeviceConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_Cryo2_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_Cryo2_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_Cryo2_PicConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_Cryo3_DeviceConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_Cryo3_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_Cryo3_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_Cryo3_PicConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_Cryo4_DeviceConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_Cryo4_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_Cryo4_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_Cryo5_DeviceConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_Cryo5_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_Cryo5_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_Cryo6_DeviceConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_Cryo6_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_Cryo6_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_CryoCompLimits_CompLimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_PeriodicTasks_GeneralConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_PeriodicTasks_PicConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_PeriodicTasks_timersConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_shutterBladeMotionProfile.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_imageStored.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fitsFilesWritten.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fileCommandExecution.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_imageVisualization.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_summaryStatus.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_alertRaised.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_bonn_shutter_Device.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_daq_monitor_Reb_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_daq_monitor_Store.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_daq_monitor_Sum_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_rebpower_Reb.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_rebpower_RebTotalPower.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_rebpower_Rebps.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_vacuum_Cold1.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_vacuum_Cold2.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_vacuum_Cryo.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_vacuum_IonPumps.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_vacuum_Rtds.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_vacuum_Turbo.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_vacuum_VQMonitor.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_quadbox_BFR.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_quadbox_PDU_24VC.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_quadbox_PDU_24VD.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_quadbox_PDU_48V.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_quadbox_PDU_5V.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_focal_plane_Ccd.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_focal_plane_Reb.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_focal_plane_RebTotalPower.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_focal_plane_RebsAverageTemp6.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_focal_plane_Segment.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_pathfinder_refrig_Cold1.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_pathfinder_refrig_Cold2.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_pathfinder_refrig_Cryo1.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_pathfinder_refrig_Cryo2.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_pathfinder_refrig_Cryo3.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_pathfinder_refrig_Cryo4.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_pathfinder_refrig_Cryo5.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_pathfinder_refrig_Cryo6.json/

Salgen CCCamera Java
    [Documentation]    Generate Java libraries.
    [Tags]    java
    ${output}=    Run Process    ${SALHome}/bin/salgeneratorKafka    ${subSystem}    sal    java    version\=${MavenVersion}    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stdout}    ERROR : Failed to generate*saj_*_types.jar 
    Should Not Contain    ${output.stdout}    error: package org.apache.avro* does not exist
    Should Not Contain    ${output.stdout}    error: package org.apache.kafka* does not exist
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    XMLVERSION = ${XMLVersion}
    Should Contain    ${output.stdout}    calling salavrogen ${subSystem} cpp
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_fcs.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_bonn_shutter_Device.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_bonn_shutter_Device.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_daq_monitor_Reb_Trending.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_daq_monitor_Reb_Trending.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_daq_monitor_Store.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_daq_monitor_Store.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_daq_monitor_Sum_Trending.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_daq_monitor_Sum_Trending.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_rebpower_Reb.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_rebpower_Reb.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_rebpower_RebTotalPower.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_rebpower_RebTotalPower.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_rebpower_Rebps.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_rebpower_Rebps.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_vacuum_Cold1.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_vacuum_Cold1.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_vacuum_Cold2.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_vacuum_Cold2.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_vacuum_Cryo.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_vacuum_Cryo.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_vacuum_IonPumps.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_vacuum_IonPumps.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_vacuum_Rtds.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_vacuum_Rtds.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_vacuum_Turbo.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_vacuum_Turbo.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_vacuum_VQMonitor.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_vacuum_VQMonitor.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_quadbox_BFR.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_quadbox_BFR.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_quadbox_PDU_24VC.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_quadbox_PDU_24VC.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_quadbox_PDU_24VD.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_quadbox_PDU_24VD.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_quadbox_PDU_48V.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_quadbox_PDU_48V.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_quadbox_PDU_5V.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_quadbox_PDU_5V.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_focal_plane_Ccd.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_focal_plane_Ccd.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_focal_plane_Reb.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_focal_plane_Reb.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_focal_plane_RebTotalPower.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_focal_plane_RebTotalPower.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_focal_plane_RebsAverageTemp6.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_focal_plane_RebsAverageTemp6.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_focal_plane_Segment.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_focal_plane_Segment.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_pathfinder_refrig_Cold1.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_pathfinder_refrig_Cold1.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_pathfinder_refrig_Cold2.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_pathfinder_refrig_Cold2.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_pathfinder_refrig_Cryo1.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_pathfinder_refrig_Cryo1.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_pathfinder_refrig_Cryo2.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_pathfinder_refrig_Cryo2.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_pathfinder_refrig_Cryo3.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_pathfinder_refrig_Cryo3.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_pathfinder_refrig_Cryo4.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_pathfinder_refrig_Cryo4.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_pathfinder_refrig_Cryo5.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_pathfinder_refrig_Cryo5.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_pathfinder_refrig_Cryo6.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_pathfinder_refrig_Cryo6.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_heartbeat.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_heartbeat.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_logLevel.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_logLevel.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_logMessage.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_logMessage.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_softwareVersions.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_softwareVersions.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_errorCode.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_errorCode.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_simulationMode.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_simulationMode.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_summaryState.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_summaryState.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_configurationApplied.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_configurationApplied.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_configurationsAvailable.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_configurationsAvailable.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_largeFileObjectAvailable.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_largeFileObjectAvailable.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_offlineDetailedState.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_offlineDetailedState.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_endReadout.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_endReadout.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_endTakeImage.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_endTakeImage.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_imageReadinessDetailedState.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_imageReadinessDetailedState.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_startSetFilter.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_startSetFilter.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_startUnloadFilter.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_startUnloadFilter.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_notReadyToTakeImage.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_notReadyToTakeImage.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_startShutterClose.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_startShutterClose.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_endInitializeGuider.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_endInitializeGuider.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_endShutterClose.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_endShutterClose.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_endOfImageTelemetry.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_endOfImageTelemetry.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_endUnloadFilter.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_endUnloadFilter.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_calibrationDetailedState.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_calibrationDetailedState.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_endRotateCarousel.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_endRotateCarousel.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_startLoadFilter.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_startLoadFilter.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_filterChangerDetailedState.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_filterChangerDetailedState.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_shutterDetailedState.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_shutterDetailedState.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_readyToTakeImage.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_readyToTakeImage.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_ccsCommandState.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_ccsCommandState.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_prepareToTakeImage.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_prepareToTakeImage.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_ccsConfigured.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_ccsConfigured.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_endLoadFilter.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_endLoadFilter.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_endShutterOpen.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_endShutterOpen.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_startIntegration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_startIntegration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_endInitializeImage.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_endInitializeImage.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_endSetFilter.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_endSetFilter.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_startShutterOpen.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_startShutterOpen.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_raftsDetailedState.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_raftsDetailedState.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_availableFilters.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_availableFilters.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_startReadout.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_startReadout.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_startRotateCarousel.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_startRotateCarousel.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_imageReadoutParameters.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_imageReadoutParameters.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focalPlaneSummaryInfo.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_focalPlaneSummaryInfo.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_GeneralConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_fcs_GeneralConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_LinearEncoder_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_fcs_LinearEncoder_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_LinearEncoder_GeneralConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_fcs_LinearEncoder_GeneralConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_PeriodicTasks_GeneralConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_fcs_PeriodicTasks_GeneralConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_PeriodicTasks_timersConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_fcs_PeriodicTasks_timersConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_StepperMotor_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_fcs_StepperMotor_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_StepperMotor_GeneralConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_fcs_StepperMotor_GeneralConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_StepperMotor_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_fcs_StepperMotor_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_StepperMotor_MotorConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_fcs_StepperMotor_MotorConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_bonn_shutter_Device_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_bonn_shutter_Device_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_bonn_shutter_Device_GeneralConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_bonn_shutter_Device_GeneralConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_bonn_shutter_Device_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_bonn_shutter_Device_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_bonn_shutter_GeneralConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_bonn_shutter_GeneralConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_bonn_shutter_PeriodicTasks_GeneralConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_bonn_shutter_PeriodicTasks_GeneralConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_bonn_shutter_PeriodicTasks_timersConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_bonn_shutter_PeriodicTasks_timersConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_daq_monitor_PeriodicTasks_GeneralConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_daq_monitor_PeriodicTasks_GeneralConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_daq_monitor_PeriodicTasks_timersConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_daq_monitor_PeriodicTasks_timersConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_daq_monitor_Stats_StatisticsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_daq_monitor_Stats_StatisticsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_daq_monitor_StoreConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_daq_monitor_StoreConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_daq_monitor_Store_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_daq_monitor_Store_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_daq_monitor_Store_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_daq_monitor_Store_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_daq_monitor_Store_StoreConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_daq_monitor_Store_StoreConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_rebpower_EmergencyResponseManager_GeneralConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_rebpower_EmergencyResponseManager_GeneralConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_rebpower_GeneralConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_rebpower_GeneralConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_rebpower_PeriodicTasks_GeneralConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_rebpower_PeriodicTasks_GeneralConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_rebpower_PeriodicTasks_timersConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_rebpower_PeriodicTasks_timersConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_rebpower_RebTotalPower_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_rebpower_RebTotalPower_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_rebpower_Reb_GeneralConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_rebpower_Reb_GeneralConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_rebpower_Reb_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_rebpower_Reb_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_rebpower_Rebps_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_rebpower_Rebps_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_rebpower_Rebps_GeneralConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_rebpower_Rebps_GeneralConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_rebpower_Rebps_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_rebpower_Rebps_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_rebpower_Rebps_PowerConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_rebpower_Rebps_PowerConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_rebpower_Rebps_buildConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_rebpower_Rebps_buildConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_Cold1_CryoconConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_Cold1_CryoconConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_Cold1_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_Cold1_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_Cold1_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_Cold1_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_Cold2_CryoconConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_Cold2_CryoconConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_Cold2_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_Cold2_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_Cold2_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_Cold2_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_Cryo_CryoconConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_Cryo_CryoconConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_Cryo_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_Cryo_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_Cryo_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_Cryo_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_IonPumps_CryoConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_IonPumps_CryoConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_IonPumps_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_IonPumps_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_IonPumps_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_IonPumps_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_PeriodicTasks_GeneralConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_PeriodicTasks_GeneralConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_PeriodicTasks_timersConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_PeriodicTasks_timersConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_Rtds_DeviceConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_Rtds_DeviceConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_Rtds_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_Rtds_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_Rtds_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_Rtds_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_Turbo_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_Turbo_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_Turbo_GeneralConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_Turbo_GeneralConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_Turbo_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_Turbo_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_Turbo_buildConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_Turbo_buildConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_VQMonitor_CryoConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_VQMonitor_CryoConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_VQMonitor_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_VQMonitor_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_VQMonitor_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_VQMonitor_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_VacPluto_DeviceConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_VacPluto_DeviceConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_VacPluto_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_VacPluto_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_VacuumConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_VacuumConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_BFR_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_quadbox_BFR_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_BFR_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_quadbox_BFR_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_BFR_QuadboxConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_quadbox_BFR_QuadboxConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_PDU_24VC_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_quadbox_PDU_24VC_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_PDU_24VC_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_quadbox_PDU_24VC_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_PDU_24VC_QuadboxConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_quadbox_PDU_24VC_QuadboxConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_PDU_24VD_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_quadbox_PDU_24VD_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_PDU_24VD_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_quadbox_PDU_24VD_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_PDU_24VD_QuadboxConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_quadbox_PDU_24VD_QuadboxConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_PDU_48V_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_quadbox_PDU_48V_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_PDU_48V_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_quadbox_PDU_48V_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_PDU_48V_QuadboxConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_quadbox_PDU_48V_QuadboxConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_PDU_5V_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_quadbox_PDU_5V_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_PDU_5V_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_quadbox_PDU_5V_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_PDU_5V_QuadboxConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_quadbox_PDU_5V_QuadboxConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_PeriodicTasks_GeneralConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_quadbox_PeriodicTasks_GeneralConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_PeriodicTasks_timersConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_quadbox_PeriodicTasks_timersConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_Ccd_HardwareIdConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_focal_plane_Ccd_HardwareIdConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_Ccd_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_focal_plane_Ccd_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_ImageDatabaseService_GeneralConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_focal_plane_ImageDatabaseService_GeneralConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_ImageNameService_GeneralConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_focal_plane_ImageNameService_GeneralConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_InstrumentConfig_InstrumentConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_focal_plane_InstrumentConfig_InstrumentConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_MonitoringConfig_MonitoringConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_focal_plane_MonitoringConfig_MonitoringConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_PeriodicTasks_GeneralConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_focal_plane_PeriodicTasks_GeneralConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_PeriodicTasks_timersConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_focal_plane_PeriodicTasks_timersConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_Raft_HardwareIdConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_focal_plane_Raft_HardwareIdConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_Raft_RaftTempControlConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_focal_plane_Raft_RaftTempControlConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_Raft_RaftTempControlStatusConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_focal_plane_Raft_RaftTempControlStatusConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_RebTotalPower_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_focal_plane_RebTotalPower_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_Reb_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_focal_plane_Reb_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_Reb_GeneralConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_focal_plane_Reb_GeneralConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_Reb_HardwareIdConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_focal_plane_Reb_HardwareIdConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_Reb_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_focal_plane_Reb_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_Reb_RaftsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_focal_plane_Reb_RaftsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_Reb_RaftsLimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_focal_plane_Reb_RaftsLimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_Reb_RaftsPowerConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_focal_plane_Reb_RaftsPowerConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_Reb_timersConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_focal_plane_Reb_timersConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_RebsAverageTemp6_GeneralConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_focal_plane_RebsAverageTemp6_GeneralConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_RebsAverageTemp6_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_focal_plane_RebsAverageTemp6_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_Segment_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_focal_plane_Segment_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_SequencerConfig_DAQConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_focal_plane_SequencerConfig_DAQConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_SequencerConfig_GuiderConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_focal_plane_SequencerConfig_GuiderConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_SequencerConfig_SequencerConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_focal_plane_SequencerConfig_SequencerConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_WebHooksConfig_VisualizationConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_focal_plane_WebHooksConfig_VisualizationConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_image_handling_FitsService_GeneralConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_image_handling_FitsService_GeneralConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_image_handling_ImageHandler_CommandsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_image_handling_ImageHandler_CommandsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_image_handling_ImageHandler_DAQConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_image_handling_ImageHandler_DAQConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_image_handling_ImageHandler_FitsHandlingConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_image_handling_ImageHandler_FitsHandlingConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_image_handling_ImageHandler_GuiderConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_image_handling_ImageHandler_GuiderConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_image_handling_PeriodicTasks_GeneralConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_image_handling_PeriodicTasks_GeneralConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_image_handling_PeriodicTasks_timersConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_image_handling_PeriodicTasks_timersConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_image_handling_StatusAggregator_GeneralConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_image_handling_StatusAggregator_GeneralConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_mpm_PeriodicTasks_GeneralConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_mpm_PeriodicTasks_GeneralConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_mpm_PeriodicTasks_timersConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_mpm_PeriodicTasks_timersConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_mpm_Pluto_DeviceConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_mpm_Pluto_DeviceConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_mpm_Pluto_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_mpm_Pluto_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_Cold1_DeviceConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_pathfinder_refrig_Cold1_DeviceConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_Cold1_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_pathfinder_refrig_Cold1_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_Cold1_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_pathfinder_refrig_Cold1_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_Cold1_PicConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_pathfinder_refrig_Cold1_PicConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_Cold2_DeviceConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_pathfinder_refrig_Cold2_DeviceConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_Cold2_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_pathfinder_refrig_Cold2_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_Cold2_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_pathfinder_refrig_Cold2_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_Cold2_PicConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_pathfinder_refrig_Cold2_PicConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_ColdCompLimits_CompLimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_pathfinder_refrig_ColdCompLimits_CompLimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_CoolMaq20_DeviceConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_pathfinder_refrig_CoolMaq20_DeviceConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_CoolMaq20_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_pathfinder_refrig_CoolMaq20_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_Cryo1_DeviceConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_pathfinder_refrig_Cryo1_DeviceConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_Cryo1_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_pathfinder_refrig_Cryo1_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_Cryo1_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_pathfinder_refrig_Cryo1_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_Cryo2_DeviceConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_pathfinder_refrig_Cryo2_DeviceConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_Cryo2_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_pathfinder_refrig_Cryo2_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_Cryo2_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_pathfinder_refrig_Cryo2_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_Cryo2_PicConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_pathfinder_refrig_Cryo2_PicConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_Cryo3_DeviceConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_pathfinder_refrig_Cryo3_DeviceConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_Cryo3_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_pathfinder_refrig_Cryo3_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_Cryo3_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_pathfinder_refrig_Cryo3_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_Cryo3_PicConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_pathfinder_refrig_Cryo3_PicConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_Cryo4_DeviceConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_pathfinder_refrig_Cryo4_DeviceConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_Cryo4_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_pathfinder_refrig_Cryo4_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_Cryo4_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_pathfinder_refrig_Cryo4_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_Cryo5_DeviceConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_pathfinder_refrig_Cryo5_DeviceConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_Cryo5_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_pathfinder_refrig_Cryo5_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_Cryo5_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_pathfinder_refrig_Cryo5_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_Cryo6_DeviceConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_pathfinder_refrig_Cryo6_DeviceConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_Cryo6_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_pathfinder_refrig_Cryo6_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_Cryo6_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_pathfinder_refrig_Cryo6_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_CryoCompLimits_CompLimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_pathfinder_refrig_CryoCompLimits_CompLimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_PeriodicTasks_GeneralConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_pathfinder_refrig_PeriodicTasks_GeneralConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_PeriodicTasks_PicConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_pathfinder_refrig_PeriodicTasks_PicConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_pathfinder_refrig_PeriodicTasks_timersConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_pathfinder_refrig_PeriodicTasks_timersConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_shutterBladeMotionProfile.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_shutterBladeMotionProfile.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_imageStored.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_imageStored.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fitsFilesWritten.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_fitsFilesWritten.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fileCommandExecution.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_fileCommandExecution.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_imageVisualization.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_imageVisualization.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_summaryStatus.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_summaryStatus.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_alertRaised.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_alertRaised.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_disable.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_disable.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_enable.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_enable.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_exitControl.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_exitControl.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_setLogLevel.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_setLogLevel.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_standby.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_standby.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_start.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_start.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_enterControl.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_enterControl.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_discardRows.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_discardRows.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_startImage.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_startImage.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_disableCalibration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_disableCalibration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_initGuiders.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_initGuiders.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_enableCalibration.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_enableCalibration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_initImage.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_initImage.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_endImage.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_endImage.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_setFilter.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_setFilter.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_clear.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_clear.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_takeImages.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_takeImages.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_stop.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_stop.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_play.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_play.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_playlist.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_playlist.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_alert.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_alert.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Configuring ${subSystem}/java/src/org/lsst/sal/SAL_${subSystem}.java
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/saj_${subSystem}_types.jar
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/org/lsst/sal/SAL_${subSystem}.java
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/org/lsst/sal/salActor.java
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/org/lsst/sal/salUtils.java
    File Should Exist    ${SALWorkDir}/salUtils/libsalUtils.so
    File Should Exist    ${SALWorkDir}/lib/org/lsst/sal/salUtils.class 

Salgen CCCamera Maven
    [Documentation]    Generate the Maven repository.
    [Tags]    java
    ${output}=    Run Process    ${SALHome}/bin/salgeneratorKafka    ${subSystem}    maven    version\=${MavenVersion}    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    argv = ${subSystem} maven version=${MavenVersion}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    XMLVERSION = ${XMLVersion}
    Should Contain    ${output.stdout}    Running maven install
    Should Contain    ${output.stdout}    [INFO] Building sal_${subSystem} ${XMLVersionBase}_${SALVersionBase}${MavenVersion}
    Should Contain X Times    ${output.stdout}    [INFO] BUILD SUCCESS    1
    Should Contain X Times    ${output.stdout}    [INFO] Finished at:    1
    @{files}=    List Directory    ${SALWorkDir}/maven
    File Should Exist    ${SALWorkDir}/maven/${subSystem}-${XMLVersionBase}_${SALVersionBase}${MavenVersion}/pom.xml

Salgen CCCamera Lib
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
    File Should Exist    ${SALWorkDir}/lib/libsalUtils.so
    File Should Exist    ${SALWorkDir}/lib/org/lsst/sal/salUtils.class 
    File Should Exist    ${SALWorkDir}/lib/saj_${subSystem}_types.jar

Cleanup stdout and stderr Files
    [Tags]
    Remove Files    ${EXECDIR}${/}${subSystem}_stdout.txt    ${EXECDIR}${/}${subSystem}_stderr.txt

