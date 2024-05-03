*** Settings ***
Documentation    This suite builds the various interfaces for the MTCamera.
Force Tags    salgen    mtcamera
Suite Setup    Log Many    ${Host}    ${subSystem}    ${timeout}
Library    OperatingSystem
Library    Process
Resource    ../Global_Vars.resource

*** Variables ***
${subSystem}    MTCamera
${timeout}    1200s

*** Test Cases ***
Verify MTCamera XML Defintions exist
    [Tags]    validate
    Comment    Verify the CSC XML definition files exist.
    ${output}    Run Process    ls     ${SALWorkDir}/${subSystem}_*xml    shell=True
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Be Empty    ${output.stdout}
    File Should Exist    ${SALWorkDir}/MTCamera_Commands.xml
    File Should Exist    ${SALWorkDir}/MTCamera_Events.xml
    File Should Exist    ${SALWorkDir}/MTCamera_Telemetry.xml

Salgen MTCamera Validate
    [Documentation]    Validate the MTCamera XML definitions.
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
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_BFR_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_BFR_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_BFR_QuadboxConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_Maq20_DeviceConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_Maq20_DevicesConfiguration.json
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
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_REB_Bulk_PS_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_REB_Bulk_PS_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_REB_Bulk_PS_QuadboxConfiguration.json
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
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_hex_Cold1_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_hex_Cold2_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_hex_Cryo1_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_hex_Cryo2_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_hex_Cryo3_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_hex_Cryo4_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_hex_Cryo5_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_hex_Cryo6_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_hex_GeneralConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_hex_Maq20_DeviceConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_hex_Maq20_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_hex_PeriodicTasks_GeneralConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_hex_PeriodicTasks_timersConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_hex_StatusAggregator_GeneralConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_refrig_Cryo1_DeviceConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_refrig_Cryo1_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_refrig_Cryo1_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_refrig_Cryo2_DeviceConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_refrig_Cryo2_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_refrig_Cryo2_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_refrig_Cryo3_DeviceConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_refrig_Cryo3_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_refrig_Cryo3_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_refrig_Cryo3_PicConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_refrig_Cryo4_DeviceConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_refrig_Cryo4_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_refrig_Cryo4_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_refrig_Cryo5_DeviceConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_refrig_Cryo5_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_refrig_Cryo5_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_refrig_Cryo5_PicConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_refrig_Cryo6_DeviceConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_refrig_Cryo6_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_refrig_Cryo6_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_refrig_CryoCompLimits_CompLimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_refrig_PeriodicTasks_GeneralConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_refrig_PeriodicTasks_PicConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_refrig_PeriodicTasks_timersConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_Cip_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_CryoFlineGauge_CryoConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_CryoFlineGauge_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_CryoTurboGauge_CryoConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_CryoTurboGauge_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_CryoTurboPump_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_CryoTurboPump_GeneralConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_CryoVacGauge_CryoConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_CryoVacGauge_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_Cryo_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_HX_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_HexFlineGauge_CryoConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_HexFlineGauge_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_HexTurboGauge_CryoConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_HexTurboGauge_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_HexTurboPump_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_HexTurboPump_GeneralConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_HexVacGauge_CryoConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_HexVacGauge_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_Hip_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_InstVacGauge_CryoConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_InstVacGauge_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_Inst_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_IonPumps_CryoConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_IonPumps_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_Maq20Cryo_DeviceConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_Maq20Cryo_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_Maq20Ut_DeviceConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_Maq20Ut_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_PDU_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_PDU_VacuumConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_PeriodicTasks_GeneralConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_PeriodicTasks_timersConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_PumpCart_CryoConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_PumpCart_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_VacPluto_DeviceConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_VacPluto_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_VacuumConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_daq_monitor_PeriodicTasks_GeneralConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_daq_monitor_PeriodicTasks_timersConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_daq_monitor_Stats_StatisticsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_daq_monitor_StoreConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_daq_monitor_Store_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_daq_monitor_Store_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_daq_monitor_Store_StoreConfiguration.json
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
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_mpm_CLP_RTD_03_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_mpm_CLP_RTD_05_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_mpm_CLP_RTD_50_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_mpm_CLP_RTD_55_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_mpm_CYP_RTD_12_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_mpm_CYP_RTD_14_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_mpm_CYP_RTD_31_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_mpm_CYP_RTD_43_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_mpm_PeriodicTasks_GeneralConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_mpm_PeriodicTasks_timersConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_mpm_Pluto_DeviceConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_mpm_Pluto_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_Autochanger_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_Autochanger_autochangerConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_Autochanger_readRateConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_Autochanger_sensorConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_Canbus0_canbusConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_Canbus0_controllerConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_Canbus0_nodeIDConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_Canbus0_sensorConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_Canbus0_serialNBConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_Canbus1_canbusConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_Canbus1_controllerConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_Canbus1_nodeIDConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_Canbus1_serialNBConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_Carousel_carouselConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_Carousel_readRateConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_Carousel_sensorConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_FilterIdentificator_sensorConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_FilterManager_filterConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_Loader_loaderConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_Loader_readRateConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_Loader_sensorConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_PeriodicTasks_GeneralConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_PeriodicTasks_timersConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_Seneca1_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_Seneca2_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_shutter_GeneralConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_shutter_timersConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_chiller_DeviceConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_chiller_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_chiller_GeneralConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_chiller_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_chiller_timersConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_thermal_DeviceConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_thermal_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_thermal_GeneralConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_thermal_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_thermal_PicConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_thermal_RefrigConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_thermal_ThermalLimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_thermal_timersConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_BFR_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_BFR_UtilConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_BodyMaq20_DeviceConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_BodyMaq20_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_CryoMaq20_DeviceConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_CryoMaq20_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_MPCFan_PicConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_MPC_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_PDU_48V_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_PDU_48V_UtilConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_PeriodicTasks_GeneralConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_PeriodicTasks_PicConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_PeriodicTasks_timersConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Pluto_DeviceConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Pluto_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Telescope_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_UTFan_PicConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_UT_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_UtMaq20_DeviceConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_UtMaq20_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_UtilConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_VPCFan_PicConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_VPCHtrs_VpcConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_VPC_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_summaryStatus.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_alertRaised.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_filterChangerPowerStatus.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_quadbox_BFR.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_quadbox_PDU_24VC.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_quadbox_PDU_24VD.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_quadbox_PDU_48V.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_quadbox_PDU_5V.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_quadbox_REB_Bulk_PS.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_rebpower_Reb.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_rebpower_RebTotalPower.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_rebpower_Rebps.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hex_Cold1.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hex_Cold2.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hex_Cryo1.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hex_Cryo2.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hex_Cryo3.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hex_Cryo4.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hex_Cryo5.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hex_Cryo6.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_refrig_Cryo1.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_refrig_Cryo2.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_refrig_Cryo3.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_refrig_Cryo4.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_refrig_Cryo5.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_refrig_Cryo6.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_vacuum_Cip.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_vacuum_Cryo.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_vacuum_HX.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_vacuum_Hip.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_vacuum_Inst.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_daq_monitor_Reb_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_daq_monitor_Store.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_daq_monitor_Sum_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_focal_plane_Ccd.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_focal_plane_Reb.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_focal_plane_RebTotalPower.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_focal_plane_RebsAverageTemp6.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_focal_plane_Segment.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_mpm_CLP_RTD_03.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_mpm_CLP_RTD_05.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_mpm_CLP_RTD_50.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_mpm_CLP_RTD_55.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_mpm_CYP_RTD_12.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_mpm_CYP_RTD_14.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_mpm_CYP_RTD_31.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_mpm_CYP_RTD_43.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Autochanger_AutochangerTrucks_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Autochanger_Latches_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Autochanger_OnlineClamps_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Autochanger_Temperatures.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Canbus0_AcSensorsGateway_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Canbus0_AcTruckXminusController_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Canbus0_AcTruckXplusController_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Canbus0_Accelerobf_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Canbus0_Ai814_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Canbus0_BrakeSystemGateway_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Canbus0_CarouselController_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Canbus0_ClampXminusController_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Canbus0_ClampXplusController_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Canbus0_Hyttc580_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Canbus0_LatchXminusController_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Canbus0_LatchXplusController_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Canbus0_OnlineClampXminusController_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Canbus0_OnlineClampXplusController_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Canbus0_OnlineClampYminusController_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Canbus0_OnlineStrainGauge_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Canbus0_ProximitySensorsDevice_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Canbus0_Pt100_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Canbus0_TempSensorsDevice1_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Canbus0_TempSensorsDevice2_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Canbus1_CarrierController_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Canbus1_HooksController_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Canbus1_LoaderPlutoGateway_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Carousel_Socket1_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Carousel_Socket2_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Carousel_Socket3_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Carousel_Socket4_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Carousel_Socket5_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Carousel_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Duration_Autochanger_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Duration_Carousel_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Duration_Loader_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Duration_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Fcs_Mcm_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Loader_Carrier_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Loader_Hooks_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_shutter_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_chiller_Chiller.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_chiller_FParam_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_chiller_Maq20.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_thermal_Cold_Temp.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_thermal_Cryo_Temp.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_thermal_Rtd.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_thermal_Trim.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_thermal_Trim_Htrs.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_utiltrunk_Body.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_utiltrunk_MPC.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_utiltrunk_UT.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_utiltrunk_VPC.json/

Salgen MTCamera Java
    [Documentation]    Generate Java libraries.
    [Tags]    java
    ${output}=    Run Process    ${SALHome}/bin/salgeneratorKafka    ${subSystem}    sal    java    version\=${MavenVersion}    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stdout}    ERROR : Failed to generate*saj_*_types.jar 
    Should Not Contain    ${output.stdout}    error: package org.apache.avro* does not exist
    Should Not Contain    ${output.stdout}    error: package org.apache.kafka* does not exist
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    XMLVERSION = ${XMLVersion}
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
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_quadbox_REB_Bulk_PS.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_quadbox_REB_Bulk_PS java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_quadbox_REB_Bulk_PS/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_rebpower_Reb.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_rebpower_Reb java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_rebpower_Reb/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_rebpower_RebTotalPower.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_rebpower_RebTotalPower java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_rebpower_RebTotalPower/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_rebpower_Rebps.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_rebpower_Rebps java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_rebpower_Rebps/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_hex_Cold1.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_hex_Cold1 java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_hex_Cold1/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_hex_Cold2.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_hex_Cold2 java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_hex_Cold2/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_hex_Cryo1.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_hex_Cryo1 java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_hex_Cryo1/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_hex_Cryo2.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_hex_Cryo2 java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_hex_Cryo2/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_hex_Cryo3.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_hex_Cryo3 java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_hex_Cryo3/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_hex_Cryo4.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_hex_Cryo4 java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_hex_Cryo4/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_hex_Cryo5.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_hex_Cryo5 java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_hex_Cryo5/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_hex_Cryo6.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_hex_Cryo6 java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_hex_Cryo6/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_refrig_Cryo1.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_refrig_Cryo1 java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_refrig_Cryo1/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_refrig_Cryo2.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_refrig_Cryo2 java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_refrig_Cryo2/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_refrig_Cryo3.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_refrig_Cryo3 java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_refrig_Cryo3/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_refrig_Cryo4.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_refrig_Cryo4 java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_refrig_Cryo4/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_refrig_Cryo5.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_refrig_Cryo5 java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_refrig_Cryo5/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_refrig_Cryo6.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_refrig_Cryo6 java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_refrig_Cryo6/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vacuum_Cip.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_vacuum_Cip java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_vacuum_Cip/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vacuum_Cryo.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_vacuum_Cryo java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_vacuum_Cryo/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vacuum_HX.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_vacuum_HX java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_vacuum_HX/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vacuum_Hip.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_vacuum_Hip java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_vacuum_Hip/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vacuum_Inst.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_vacuum_Inst java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_vacuum_Inst/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_daq_monitor_Reb_Trending.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_daq_monitor_Reb_Trending java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_daq_monitor_Reb_Trending/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_daq_monitor_Store.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_daq_monitor_Store java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_daq_monitor_Store/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_daq_monitor_Sum_Trending.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_daq_monitor_Sum_Trending java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_daq_monitor_Sum_Trending/java/src/org/lsst/sal/salUtils.class
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
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_mpm_CLP_RTD_03.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_mpm_CLP_RTD_03 java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_mpm_CLP_RTD_03/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_mpm_CLP_RTD_05.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_mpm_CLP_RTD_05 java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_mpm_CLP_RTD_05/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_mpm_CLP_RTD_50.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_mpm_CLP_RTD_50 java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_mpm_CLP_RTD_50/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_mpm_CLP_RTD_55.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_mpm_CLP_RTD_55 java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_mpm_CLP_RTD_55/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_mpm_CYP_RTD_12.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_mpm_CYP_RTD_12 java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_mpm_CYP_RTD_12/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_mpm_CYP_RTD_14.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_mpm_CYP_RTD_14 java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_mpm_CYP_RTD_14/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_mpm_CYP_RTD_31.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_mpm_CYP_RTD_31 java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_mpm_CYP_RTD_31/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_mpm_CYP_RTD_43.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_mpm_CYP_RTD_43 java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_mpm_CYP_RTD_43/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Autochanger_AutochangerTrucks_Trending.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_fcs_Autochanger_AutochangerTrucks_Trending java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_fcs_Autochanger_AutochangerTrucks_Trending/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Autochanger_Latches_Trending.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_fcs_Autochanger_Latches_Trending java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_fcs_Autochanger_Latches_Trending/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Autochanger_OnlineClamps_Trending.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_fcs_Autochanger_OnlineClamps_Trending java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_fcs_Autochanger_OnlineClamps_Trending/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Autochanger_Temperatures.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_fcs_Autochanger_Temperatures java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_fcs_Autochanger_Temperatures/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Canbus0_AcSensorsGateway_Trending.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_fcs_Canbus0_AcSensorsGateway_Trending java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_fcs_Canbus0_AcSensorsGateway_Trending/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Canbus0_AcTruckXminusController_Trending.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_fcs_Canbus0_AcTruckXminusController_Trending java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_fcs_Canbus0_AcTruckXminusController_Trending/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Canbus0_AcTruckXplusController_Trending.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_fcs_Canbus0_AcTruckXplusController_Trending java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_fcs_Canbus0_AcTruckXplusController_Trending/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Canbus0_Accelerobf_Trending.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_fcs_Canbus0_Accelerobf_Trending java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_fcs_Canbus0_Accelerobf_Trending/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Canbus0_Ai814_Trending.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_fcs_Canbus0_Ai814_Trending java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_fcs_Canbus0_Ai814_Trending/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Canbus0_BrakeSystemGateway_Trending.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_fcs_Canbus0_BrakeSystemGateway_Trending java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_fcs_Canbus0_BrakeSystemGateway_Trending/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Canbus0_CarouselController_Trending.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_fcs_Canbus0_CarouselController_Trending java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_fcs_Canbus0_CarouselController_Trending/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Canbus0_ClampXminusController_Trending.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_fcs_Canbus0_ClampXminusController_Trending java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_fcs_Canbus0_ClampXminusController_Trending/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Canbus0_ClampXplusController_Trending.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_fcs_Canbus0_ClampXplusController_Trending java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_fcs_Canbus0_ClampXplusController_Trending/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Canbus0_Hyttc580_Trending.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_fcs_Canbus0_Hyttc580_Trending java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_fcs_Canbus0_Hyttc580_Trending/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Canbus0_LatchXminusController_Trending.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_fcs_Canbus0_LatchXminusController_Trending java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_fcs_Canbus0_LatchXminusController_Trending/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Canbus0_LatchXplusController_Trending.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_fcs_Canbus0_LatchXplusController_Trending java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_fcs_Canbus0_LatchXplusController_Trending/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Canbus0_OnlineClampXminusController_Trending.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_fcs_Canbus0_OnlineClampXminusController_Trending java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_fcs_Canbus0_OnlineClampXminusController_Trending/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Canbus0_OnlineClampXplusController_Trending.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_fcs_Canbus0_OnlineClampXplusController_Trending java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_fcs_Canbus0_OnlineClampXplusController_Trending/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Canbus0_OnlineClampYminusController_Trending.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_fcs_Canbus0_OnlineClampYminusController_Trending java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_fcs_Canbus0_OnlineClampYminusController_Trending/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Canbus0_OnlineStrainGauge_Trending.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_fcs_Canbus0_OnlineStrainGauge_Trending java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_fcs_Canbus0_OnlineStrainGauge_Trending/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Canbus0_ProximitySensorsDevice_Trending.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_fcs_Canbus0_ProximitySensorsDevice_Trending java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_fcs_Canbus0_ProximitySensorsDevice_Trending/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Canbus0_Pt100_Trending.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_fcs_Canbus0_Pt100_Trending java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_fcs_Canbus0_Pt100_Trending/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Canbus0_TempSensorsDevice1_Trending.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_fcs_Canbus0_TempSensorsDevice1_Trending java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_fcs_Canbus0_TempSensorsDevice1_Trending/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Canbus0_TempSensorsDevice2_Trending.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_fcs_Canbus0_TempSensorsDevice2_Trending java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_fcs_Canbus0_TempSensorsDevice2_Trending/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Canbus1_CarrierController_Trending.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_fcs_Canbus1_CarrierController_Trending java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_fcs_Canbus1_CarrierController_Trending/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Canbus1_HooksController_Trending.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_fcs_Canbus1_HooksController_Trending java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_fcs_Canbus1_HooksController_Trending/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Canbus1_LoaderPlutoGateway_Trending.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_fcs_Canbus1_LoaderPlutoGateway_Trending java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_fcs_Canbus1_LoaderPlutoGateway_Trending/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Carousel_Socket1_Trending.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_fcs_Carousel_Socket1_Trending java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_fcs_Carousel_Socket1_Trending/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Carousel_Socket2_Trending.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_fcs_Carousel_Socket2_Trending java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_fcs_Carousel_Socket2_Trending/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Carousel_Socket3_Trending.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_fcs_Carousel_Socket3_Trending java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_fcs_Carousel_Socket3_Trending/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Carousel_Socket4_Trending.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_fcs_Carousel_Socket4_Trending java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_fcs_Carousel_Socket4_Trending/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Carousel_Socket5_Trending.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_fcs_Carousel_Socket5_Trending java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_fcs_Carousel_Socket5_Trending/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Carousel_Trending.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_fcs_Carousel_Trending java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_fcs_Carousel_Trending/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Duration_Autochanger_Trending.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_fcs_Duration_Autochanger_Trending java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_fcs_Duration_Autochanger_Trending/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Duration_Carousel_Trending.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_fcs_Duration_Carousel_Trending java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_fcs_Duration_Carousel_Trending/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Duration_Loader_Trending.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_fcs_Duration_Loader_Trending java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_fcs_Duration_Loader_Trending/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Duration_Trending.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_fcs_Duration_Trending java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_fcs_Duration_Trending/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Fcs_Mcm_Trending.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_fcs_Fcs_Mcm_Trending java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_fcs_Fcs_Mcm_Trending/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Loader_Carrier_Trending.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_fcs_Loader_Carrier_Trending java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_fcs_Loader_Carrier_Trending/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Loader_Hooks_Trending.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_fcs_Loader_Hooks_Trending java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_fcs_Loader_Hooks_Trending/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Trending.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_fcs_Trending java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_fcs_Trending/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_shutter_Trending.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_shutter_Trending java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_shutter_Trending/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_chiller_Chiller.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_chiller_Chiller java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_chiller_Chiller/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_chiller_FParam_Trending.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_chiller_FParam_Trending java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_chiller_FParam_Trending/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_chiller_Maq20.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_chiller_Maq20 java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_chiller_Maq20/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_thermal_Cold_Temp.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_thermal_Cold_Temp java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_thermal_Cold_Temp/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_thermal_Cryo_Temp.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_thermal_Cryo_Temp java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_thermal_Cryo_Temp/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_thermal_Rtd.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_thermal_Rtd java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_thermal_Rtd/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_thermal_Trim.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_thermal_Trim java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_thermal_Trim/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_thermal_Trim_Htrs.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_thermal_Trim_Htrs java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_thermal_Trim_Htrs/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_utiltrunk_Body.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_utiltrunk_Body java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_utiltrunk_Body/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_utiltrunk_MPC.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_utiltrunk_MPC java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_utiltrunk_MPC/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_utiltrunk_UT.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_utiltrunk_UT java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_utiltrunk_UT/java/src/org/lsst/sal/salUtils.class
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_utiltrunk_VPC.json
    Should Contain    ${output.stdout}    done addSALKAFKAtypes ${subSystem}_utiltrunk_VPC java ${subSystem}
    File Should Exist    ${SALWorkDir}/${subSystem}_utiltrunk_VPC/java/src/org/lsst/sal/salUtils.class
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/saj_${subSystem}_types.jar
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/org/lsst/sal/SAL_${subSystem}.java
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/org/lsst/sal/salActor.java
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/org/lsst/sal/salUtils.java
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/classes/org/lsst/sal//salUtils.class
    File Should Exist    ${SALWorkDir}/salUtils/libsalUtils.so
    File Should Exist    ${SALWorkDir}/lib/org/lsst/sal/salUtils.class 

Salgen MTCamera Maven
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

Salgen MTCamera Lib
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

