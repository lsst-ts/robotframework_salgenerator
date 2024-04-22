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
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_authList.json
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
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_fcs java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_fcs/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_bonn_shutter_Device.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_bonn_shutter_Device java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_bonn_shutter_Device/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_daq_monitor_Reb_Trending.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_daq_monitor_Reb_Trending java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_daq_monitor_Reb_Trending/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_daq_monitor_Store.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_daq_monitor_Store java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_daq_monitor_Store/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_daq_monitor_Sum_Trending.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_daq_monitor_Sum_Trending java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_daq_monitor_Sum_Trending/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_rebpower_Reb.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_rebpower_Reb java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_rebpower_Reb/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_rebpower_RebTotalPower.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_rebpower_RebTotalPower java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_rebpower_RebTotalPower/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_rebpower_Rebps.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_rebpower_Rebps java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_rebpower_Rebps/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vacuum_Cold1.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_vacuum_Cold1 java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_vacuum_Cold1/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vacuum_Cold2.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_vacuum_Cold2 java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_vacuum_Cold2/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vacuum_Cryo.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_vacuum_Cryo java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_vacuum_Cryo/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vacuum_IonPumps.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_vacuum_IonPumps java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_vacuum_IonPumps/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vacuum_Rtds.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_vacuum_Rtds java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_vacuum_Rtds/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vacuum_Turbo.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_vacuum_Turbo java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_vacuum_Turbo/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vacuum_VQMonitor.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_vacuum_VQMonitor java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_vacuum_VQMonitor/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_quadbox_BFR.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_quadbox_BFR java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_quadbox_BFR/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_quadbox_PDU_24VC.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_quadbox_PDU_24VC java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_quadbox_PDU_24VC/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_quadbox_PDU_24VD.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_quadbox_PDU_24VD java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_quadbox_PDU_24VD/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_quadbox_PDU_48V.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_quadbox_PDU_48V java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_quadbox_PDU_48V/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_quadbox_PDU_5V.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_quadbox_PDU_5V java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_quadbox_PDU_5V/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_focal_plane_Ccd.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_focal_plane_Ccd java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_focal_plane_Ccd/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_focal_plane_Reb.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_focal_plane_Reb java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_focal_plane_Reb/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_focal_plane_RebTotalPower.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_focal_plane_RebTotalPower java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_focal_plane_RebTotalPower/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_focal_plane_RebsAverageTemp6.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_focal_plane_RebsAverageTemp6 java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_focal_plane_RebsAverageTemp6/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_focal_plane_Segment.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_focal_plane_Segment java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_focal_plane_Segment/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_pathfinder_refrig_Cold1.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_pathfinder_refrig_Cold1 java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_pathfinder_refrig_Cold1/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_pathfinder_refrig_Cold2.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_pathfinder_refrig_Cold2 java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_pathfinder_refrig_Cold2/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_pathfinder_refrig_Cryo1.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_pathfinder_refrig_Cryo1 java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_pathfinder_refrig_Cryo1/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_pathfinder_refrig_Cryo2.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_pathfinder_refrig_Cryo2 java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_pathfinder_refrig_Cryo2/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_pathfinder_refrig_Cryo3.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_pathfinder_refrig_Cryo3 java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_pathfinder_refrig_Cryo3/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_pathfinder_refrig_Cryo4.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_pathfinder_refrig_Cryo4 java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_pathfinder_refrig_Cryo4/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_pathfinder_refrig_Cryo5.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_pathfinder_refrig_Cryo5 java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_pathfinder_refrig_Cryo5/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_pathfinder_refrig_Cryo6.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_pathfinder_refrig_Cryo6 java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_pathfinder_refrig_Cryo6/java/src/org/lsst/sal/salUtils.class
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/saj_${subSystem}_types.jar
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/org/lsst/sal/SAL_${subSystem}.java
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/org/lsst/sal/salActor.java
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/org/lsst/sal/salUtils.java
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/classes/org/lsst/sal//salUtils.class
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

Salgen CCCamera RPM
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
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/ts_sal_utils-${SALVersionBase}-1.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/${subSystem}-${XMLVersionBase}${sep}${Build_Number}-${SALVersionBase}${DIST}.x86_64.rpm
    File Should Exist    ${SALWorkDir}/lib/org/lsst/sal/salUtils.class
    File Should Exist    ${SALWorkDir}/lib/libsalUtils.so
    Should Not Contain    ${output.stdout}    child process exited abnormally

Verify CCCamera RPM Contents
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

