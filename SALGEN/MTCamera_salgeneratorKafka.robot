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
    ${output}    Run Process    ls    ${SALWorkDir}/${subSystem}_*xml    shell=True
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
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_Generics.xml
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_Commands.xml
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}_cmddef.tcl
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_Events.xml
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}_evtdef.tcl
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_Telemetry.xml
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}_tlmdef.tcl
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_ackcmd.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_field_enums.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_disable.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_enable.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_exitControl.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_setLogLevel.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_standby.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_start.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_enterControl.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_discardRows.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_startImage.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_disableCalibration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_initGuiders.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_enableCalibration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_initImage.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_endImage.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_setFilter.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_clear.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_takeImages.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_stop.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_play.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_playlist.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_alert.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_wakeFilterChanger.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_generic.json
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
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_rebpower_Power_timersConfiguration.json
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
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_image_handling_ImageHandler_GeneralConfiguration.json
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
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_shutter_GeneralConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_shutter_timersConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_chiller_DeviceConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_chiller_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_chiller_GeneralConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_chiller_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_chiller_PicConfiguration.json
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
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_AmbAirtemp_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_AverageTemp_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_BackFlngXMinusTemp_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_BackFlngXPlusTemp_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_BackFlngYMinusTemp_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_CamBodyXPlusTemp_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_CamBodyYMinusTemp_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_CamBodyYPlusTemp_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_CamHousXMinusTemp_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_CamHousXPlusTemp_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_CamHousYMinusTemp_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_CamHousYPlusTemp_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_ChgrYMinusRtnAirTemp_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_ChgrYMinusRtnAirVel_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_DomeXMinusTemp_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_DomeYMinusTemp_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_L1XMinusTemp_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_L1YMinusTemp_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_L2XMinusTemp_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_L2XPlusTemp_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_L2YPlusTemp_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_ShrdRngXMinusTemp_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_ShrdRngXPlusTemp_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_ShrdRngYMinusTemp_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_ShrdRngYPlusTemp_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_ShtrEboxRtnAirTemp_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_ShtrEboxRtnAirVel_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_ShtrMtrRtnAirTemp_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_ShtrMtrRtnAirVel_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_VPPlenumInTemp_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_MPCFan_PicConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_MPC_AvgAirtempOut_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_MPC_DeltaPressFilt_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_MPC_DeltaPressTotal_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_MPC_DeltaTempAct_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_MPC_FanRunTime_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_MPC_FanSpeed_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_MPC_Humidity_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_MPC_PreFiltPress_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_MPC_RetnAirTemp_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_MPC_RetnPress_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_MPC_SplyAirTemp_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_MPC_SplyPress_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_MPC_ValvePosn_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_PDU_48V_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_PDU_48V_UtilConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_PeriodicTasks_AgentMonitorService_timersConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_PeriodicTasks_BodyMaq20_check_status_timersConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_PeriodicTasks_Fan_loop_MPCFan_PicConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_PeriodicTasks_Fan_loop_UTFan_PicConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_PeriodicTasks_Fan_loop_VPCFan_PicConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_PeriodicTasks_Heartbeat_timersConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_PeriodicTasks_Monitor_check_timersConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_PeriodicTasks_Monitor_publish_timersConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_PeriodicTasks_Monitor_update_timersConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_PeriodicTasks_RuntimeInfo_timersConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_PeriodicTasks_Schedulers_GeneralConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_PeriodicTasks_UT_alarms_timersConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_PeriodicTasks_UT_state_timersConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_PeriodicTasks_UtMaq20_check_status_timersConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_PeriodicTasks_Vpc_loop_VPCHtrs_timersConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Telescope_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_UTFan_PicConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_UT_AverageTemp_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_UT_CoolFlowRate_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_UT_CoolPipeRetnTemp_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_UT_CoolPipeSplyTemp_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_UT_DomeXMinusTemp_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_UT_DomeYMinusTemp_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_UT_FanInletTemp_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_UT_FanRunTime_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_UT_FanSpeed_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_UT_MidXMinusTemp_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_UT_MidXPlusTemp_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_UT_SuppXMinusTemp_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_UT_SuppXPlusTemp_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_UT_TopXMinusTemp_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_UT_TopXPlusTemp_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_UT_ValvePosn_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_UT_W2Q1Temp_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_UT_W4Q3Temp_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_UtMaq20_DeviceConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_UtMaq20_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_UtilConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_VPCFan_PicConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_VPCHtrs_VpcConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_VPC_DeltaPressFilt_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_VPC_DeltaPressTotal_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_VPC_DeltaTempAct_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_VPC_FanRunTime_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_VPC_FanSpeed_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_VPC_HtrCurrent_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_VPC_Humidity_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_VPC_PreFiltPress_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_VPC_RetnAirTemp_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_VPC_RetnPress_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_VPC_SplyAirTemp_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_VPC_SplyAirVel_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_VPC_SplyPress_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_VPC_ValvePosn_LimitsConfiguration.json
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
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Autochanger_Temperatures_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Autochanger_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Canbus0_AcSensorsGateway_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Canbus0_AcTruckXminusController_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Canbus0_AcTruckXplusController_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Canbus0_Accelerobf_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Canbus0_Ai814_Trending.json/
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
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Carousel_Brakes_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Carousel_Socket1_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Carousel_Socket2_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Carousel_Socket3_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Carousel_Socket4_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Carousel_Socket5_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Carousel_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Counters_Autochanger_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Counters_Carousel_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Counters_Loader_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Counters_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Duration_Autochanger_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Duration_Carousel_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Duration_Loader_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Duration_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Fcs_Mcm_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Fcs_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Loader_Carrier_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Loader_Hooks_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Loader_Trending.json/
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
    Should Contain    ${output.stdout}    calling salavrogen ${subSystem} cpp
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_quadbox_BFR.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_quadbox_BFR.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_quadbox_PDU_24VC.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_quadbox_PDU_24VC.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_quadbox_PDU_24VD.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_quadbox_PDU_24VD.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_quadbox_PDU_48V.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_quadbox_PDU_48V.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_quadbox_PDU_5V.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_quadbox_PDU_5V.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_quadbox_REB_Bulk_PS.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_quadbox_REB_Bulk_PS.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_rebpower_Reb.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_rebpower_Reb.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_rebpower_RebTotalPower.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_rebpower_RebTotalPower.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_rebpower_Rebps.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_rebpower_Rebps.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hex_Cold1.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_hex_Cold1.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hex_Cold2.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_hex_Cold2.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hex_Cryo1.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_hex_Cryo1.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hex_Cryo2.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_hex_Cryo2.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hex_Cryo3.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_hex_Cryo3.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hex_Cryo4.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_hex_Cryo4.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hex_Cryo5.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_hex_Cryo5.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hex_Cryo6.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_hex_Cryo6.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_refrig_Cryo1.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_refrig_Cryo1.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_refrig_Cryo2.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_refrig_Cryo2.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_refrig_Cryo3.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_refrig_Cryo3.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_refrig_Cryo4.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_refrig_Cryo4.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_refrig_Cryo5.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_refrig_Cryo5.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_refrig_Cryo6.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_refrig_Cryo6.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_vacuum_Cip.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_vacuum_Cip.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_vacuum_Cryo.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_vacuum_Cryo.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_vacuum_HX.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_vacuum_HX.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_vacuum_Hip.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_vacuum_Hip.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_vacuum_Inst.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_vacuum_Inst.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_daq_monitor_Reb_Trending.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_daq_monitor_Reb_Trending.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_daq_monitor_Store.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_daq_monitor_Store.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_daq_monitor_Sum_Trending.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_daq_monitor_Sum_Trending.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_focal_plane_Ccd.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_focal_plane_Ccd.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_focal_plane_Reb.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_focal_plane_Reb.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_focal_plane_RebTotalPower.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_focal_plane_RebTotalPower.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_focal_plane_RebsAverageTemp6.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_focal_plane_RebsAverageTemp6.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_focal_plane_Segment.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_focal_plane_Segment.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_mpm_CLP_RTD_03.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_mpm_CLP_RTD_03.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_mpm_CLP_RTD_05.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_mpm_CLP_RTD_05.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_mpm_CLP_RTD_50.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_mpm_CLP_RTD_50.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_mpm_CLP_RTD_55.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_mpm_CLP_RTD_55.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_mpm_CYP_RTD_12.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_mpm_CYP_RTD_12.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_mpm_CYP_RTD_14.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_mpm_CYP_RTD_14.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_mpm_CYP_RTD_31.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_mpm_CYP_RTD_31.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_mpm_CYP_RTD_43.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_mpm_CYP_RTD_43.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Autochanger_AutochangerTrucks_Trending.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_fcs_Autochanger_AutochangerTrucks_Trending.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Autochanger_Latches_Trending.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_fcs_Autochanger_Latches_Trending.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Autochanger_OnlineClamps_Trending.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_fcs_Autochanger_OnlineClamps_Trending.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Autochanger_Temperatures_Trending.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_fcs_Autochanger_Temperatures_Trending.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Autochanger_Trending.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_fcs_Autochanger_Trending.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Canbus0_AcSensorsGateway_Trending.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_fcs_Canbus0_AcSensorsGateway_Trending.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Canbus0_AcTruckXminusController_Trending.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_fcs_Canbus0_AcTruckXminusController_Trending.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Canbus0_AcTruckXplusController_Trending.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_fcs_Canbus0_AcTruckXplusController_Trending.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Canbus0_Accelerobf_Trending.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_fcs_Canbus0_Accelerobf_Trending.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Canbus0_Ai814_Trending.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_fcs_Canbus0_Ai814_Trending.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Canbus0_CarouselController_Trending.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_fcs_Canbus0_CarouselController_Trending.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Canbus0_ClampXminusController_Trending.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_fcs_Canbus0_ClampXminusController_Trending.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Canbus0_ClampXplusController_Trending.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_fcs_Canbus0_ClampXplusController_Trending.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Canbus0_Hyttc580_Trending.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_fcs_Canbus0_Hyttc580_Trending.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Canbus0_LatchXminusController_Trending.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_fcs_Canbus0_LatchXminusController_Trending.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Canbus0_LatchXplusController_Trending.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_fcs_Canbus0_LatchXplusController_Trending.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Canbus0_OnlineClampXminusController_Trending.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_fcs_Canbus0_OnlineClampXminusController_Trending.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Canbus0_OnlineClampXplusController_Trending.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_fcs_Canbus0_OnlineClampXplusController_Trending.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Canbus0_OnlineClampYminusController_Trending.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_fcs_Canbus0_OnlineClampYminusController_Trending.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Canbus0_OnlineStrainGauge_Trending.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_fcs_Canbus0_OnlineStrainGauge_Trending.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Canbus0_ProximitySensorsDevice_Trending.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_fcs_Canbus0_ProximitySensorsDevice_Trending.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Canbus0_Pt100_Trending.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_fcs_Canbus0_Pt100_Trending.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Canbus0_TempSensorsDevice1_Trending.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_fcs_Canbus0_TempSensorsDevice1_Trending.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Canbus0_TempSensorsDevice2_Trending.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_fcs_Canbus0_TempSensorsDevice2_Trending.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Canbus1_CarrierController_Trending.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_fcs_Canbus1_CarrierController_Trending.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Canbus1_HooksController_Trending.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_fcs_Canbus1_HooksController_Trending.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Canbus1_LoaderPlutoGateway_Trending.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_fcs_Canbus1_LoaderPlutoGateway_Trending.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Carousel_Brakes_Trending.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_fcs_Carousel_Brakes_Trending.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Carousel_Socket1_Trending.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_fcs_Carousel_Socket1_Trending.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Carousel_Socket2_Trending.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_fcs_Carousel_Socket2_Trending.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Carousel_Socket3_Trending.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_fcs_Carousel_Socket3_Trending.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Carousel_Socket4_Trending.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_fcs_Carousel_Socket4_Trending.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Carousel_Socket5_Trending.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_fcs_Carousel_Socket5_Trending.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Carousel_Trending.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_fcs_Carousel_Trending.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Counters_Autochanger_Trending.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_fcs_Counters_Autochanger_Trending.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Counters_Carousel_Trending.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_fcs_Counters_Carousel_Trending.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Counters_Loader_Trending.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_fcs_Counters_Loader_Trending.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Counters_Trending.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_fcs_Counters_Trending.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Duration_Autochanger_Trending.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_fcs_Duration_Autochanger_Trending.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Duration_Carousel_Trending.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_fcs_Duration_Carousel_Trending.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Duration_Loader_Trending.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_fcs_Duration_Loader_Trending.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Duration_Trending.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_fcs_Duration_Trending.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Fcs_Mcm_Trending.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_fcs_Fcs_Mcm_Trending.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Fcs_Trending.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_fcs_Fcs_Trending.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Loader_Carrier_Trending.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_fcs_Loader_Carrier_Trending.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Loader_Hooks_Trending.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_fcs_Loader_Hooks_Trending.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Loader_Trending.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_fcs_Loader_Trending.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fcs_Trending.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_fcs_Trending.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_shutter_Trending.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_shutter_Trending.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_chiller_Chiller.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_chiller_Chiller.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_chiller_FParam_Trending.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_chiller_FParam_Trending.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_chiller_Maq20.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_chiller_Maq20.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_thermal_Cold_Temp.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_thermal_Cold_Temp.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_thermal_Cryo_Temp.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_thermal_Cryo_Temp.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_thermal_Rtd.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_thermal_Rtd.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_thermal_Trim.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_thermal_Trim.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_thermal_Trim_Htrs.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_thermal_Trim_Htrs.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_utiltrunk_Body.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_utiltrunk_Body.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_utiltrunk_MPC.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_utiltrunk_MPC.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_utiltrunk_UT.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_utiltrunk_UT.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_utiltrunk_VPC.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_utiltrunk_VPC.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_heartbeat.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_heartbeat.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_logLevel.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_logLevel.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_logMessage.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_logMessage.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_softwareVersions.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_softwareVersions.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_errorCode.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_errorCode.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_simulationMode.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_simulationMode.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_summaryState.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_summaryState.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_configurationApplied.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_configurationApplied.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_configurationsAvailable.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_configurationsAvailable.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_largeFileObjectAvailable.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_largeFileObjectAvailable.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_offlineDetailedState.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_offlineDetailedState.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_endReadout.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_endReadout.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_endTakeImage.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_endTakeImage.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_imageReadinessDetailedState.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_imageReadinessDetailedState.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_startSetFilter.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_startSetFilter.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_startUnloadFilter.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_startUnloadFilter.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_notReadyToTakeImage.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_notReadyToTakeImage.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_startShutterClose.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_startShutterClose.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_endInitializeGuider.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_endInitializeGuider.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_endShutterClose.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_endShutterClose.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_endOfImageTelemetry.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_endOfImageTelemetry.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_endUnloadFilter.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_endUnloadFilter.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_calibrationDetailedState.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_calibrationDetailedState.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_endRotateCarousel.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_endRotateCarousel.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_startLoadFilter.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_startLoadFilter.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_filterChangerDetailedState.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_filterChangerDetailedState.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_shutterDetailedState.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_shutterDetailedState.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_readyToTakeImage.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_readyToTakeImage.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_ccsCommandState.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_ccsCommandState.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_prepareToTakeImage.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_prepareToTakeImage.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_ccsConfigured.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_ccsConfigured.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_endLoadFilter.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_endLoadFilter.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_endShutterOpen.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_endShutterOpen.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_startIntegration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_startIntegration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_endInitializeImage.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_endInitializeImage.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_endSetFilter.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_endSetFilter.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_startShutterOpen.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_startShutterOpen.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_raftsDetailedState.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_raftsDetailedState.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_availableFilters.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_availableFilters.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_startReadout.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_startReadout.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_startRotateCarousel.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_startRotateCarousel.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_imageReadoutParameters.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_imageReadoutParameters.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focalPlaneSummaryInfo.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_focalPlaneSummaryInfo.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_BFR_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_quadbox_BFR_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_BFR_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_quadbox_BFR_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_BFR_QuadboxConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_quadbox_BFR_QuadboxConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_Maq20_DeviceConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_quadbox_Maq20_DeviceConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_Maq20_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_quadbox_Maq20_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_PDU_24VC_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_quadbox_PDU_24VC_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_PDU_24VC_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_quadbox_PDU_24VC_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_PDU_24VC_QuadboxConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_quadbox_PDU_24VC_QuadboxConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_PDU_24VD_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_quadbox_PDU_24VD_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_PDU_24VD_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_quadbox_PDU_24VD_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_PDU_24VD_QuadboxConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_quadbox_PDU_24VD_QuadboxConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_PDU_48V_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_quadbox_PDU_48V_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_PDU_48V_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_quadbox_PDU_48V_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_PDU_48V_QuadboxConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_quadbox_PDU_48V_QuadboxConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_PDU_5V_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_quadbox_PDU_5V_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_PDU_5V_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_quadbox_PDU_5V_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_PDU_5V_QuadboxConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_quadbox_PDU_5V_QuadboxConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_PeriodicTasks_GeneralConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_quadbox_PeriodicTasks_GeneralConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_PeriodicTasks_timersConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_quadbox_PeriodicTasks_timersConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_REB_Bulk_PS_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_quadbox_REB_Bulk_PS_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_REB_Bulk_PS_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_quadbox_REB_Bulk_PS_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_quadbox_REB_Bulk_PS_QuadboxConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_quadbox_REB_Bulk_PS_QuadboxConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_rebpower_EmergencyResponseManager_GeneralConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_rebpower_EmergencyResponseManager_GeneralConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_rebpower_GeneralConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_rebpower_GeneralConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_rebpower_PeriodicTasks_GeneralConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_rebpower_PeriodicTasks_GeneralConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_rebpower_PeriodicTasks_timersConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_rebpower_PeriodicTasks_timersConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_rebpower_Power_timersConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_rebpower_Power_timersConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_rebpower_RebTotalPower_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_rebpower_RebTotalPower_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_rebpower_Reb_GeneralConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_rebpower_Reb_GeneralConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_rebpower_Reb_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_rebpower_Reb_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_rebpower_Rebps_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_rebpower_Rebps_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_rebpower_Rebps_GeneralConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_rebpower_Rebps_GeneralConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_rebpower_Rebps_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_rebpower_Rebps_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_rebpower_Rebps_PowerConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_rebpower_Rebps_PowerConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_rebpower_Rebps_buildConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_rebpower_Rebps_buildConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_hex_Cold1_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_hex_Cold1_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_hex_Cold2_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_hex_Cold2_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_hex_Cryo1_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_hex_Cryo1_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_hex_Cryo2_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_hex_Cryo2_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_hex_Cryo3_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_hex_Cryo3_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_hex_Cryo4_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_hex_Cryo4_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_hex_Cryo5_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_hex_Cryo5_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_hex_Cryo6_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_hex_Cryo6_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_hex_GeneralConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_hex_GeneralConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_hex_Maq20_DeviceConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_hex_Maq20_DeviceConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_hex_Maq20_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_hex_Maq20_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_hex_PeriodicTasks_GeneralConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_hex_PeriodicTasks_GeneralConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_hex_PeriodicTasks_timersConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_hex_PeriodicTasks_timersConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_hex_StatusAggregator_GeneralConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_hex_StatusAggregator_GeneralConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_refrig_Cryo1_DeviceConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_refrig_Cryo1_DeviceConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_refrig_Cryo1_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_refrig_Cryo1_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_refrig_Cryo1_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_refrig_Cryo1_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_refrig_Cryo2_DeviceConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_refrig_Cryo2_DeviceConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_refrig_Cryo2_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_refrig_Cryo2_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_refrig_Cryo2_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_refrig_Cryo2_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_refrig_Cryo3_DeviceConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_refrig_Cryo3_DeviceConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_refrig_Cryo3_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_refrig_Cryo3_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_refrig_Cryo3_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_refrig_Cryo3_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_refrig_Cryo3_PicConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_refrig_Cryo3_PicConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_refrig_Cryo4_DeviceConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_refrig_Cryo4_DeviceConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_refrig_Cryo4_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_refrig_Cryo4_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_refrig_Cryo4_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_refrig_Cryo4_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_refrig_Cryo5_DeviceConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_refrig_Cryo5_DeviceConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_refrig_Cryo5_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_refrig_Cryo5_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_refrig_Cryo5_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_refrig_Cryo5_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_refrig_Cryo5_PicConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_refrig_Cryo5_PicConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_refrig_Cryo6_DeviceConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_refrig_Cryo6_DeviceConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_refrig_Cryo6_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_refrig_Cryo6_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_refrig_Cryo6_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_refrig_Cryo6_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_refrig_CryoCompLimits_CompLimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_refrig_CryoCompLimits_CompLimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_refrig_PeriodicTasks_GeneralConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_refrig_PeriodicTasks_GeneralConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_refrig_PeriodicTasks_PicConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_refrig_PeriodicTasks_PicConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_refrig_PeriodicTasks_timersConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_refrig_PeriodicTasks_timersConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_Cip_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_Cip_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_CryoFlineGauge_CryoConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_CryoFlineGauge_CryoConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_CryoFlineGauge_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_CryoFlineGauge_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_CryoTurboGauge_CryoConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_CryoTurboGauge_CryoConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_CryoTurboGauge_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_CryoTurboGauge_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_CryoTurboPump_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_CryoTurboPump_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_CryoTurboPump_GeneralConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_CryoTurboPump_GeneralConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_CryoVacGauge_CryoConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_CryoVacGauge_CryoConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_CryoVacGauge_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_CryoVacGauge_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_Cryo_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_Cryo_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_HX_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_HX_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_HexFlineGauge_CryoConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_HexFlineGauge_CryoConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_HexFlineGauge_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_HexFlineGauge_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_HexTurboGauge_CryoConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_HexTurboGauge_CryoConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_HexTurboGauge_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_HexTurboGauge_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_HexTurboPump_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_HexTurboPump_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_HexTurboPump_GeneralConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_HexTurboPump_GeneralConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_HexVacGauge_CryoConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_HexVacGauge_CryoConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_HexVacGauge_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_HexVacGauge_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_Hip_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_Hip_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_InstVacGauge_CryoConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_InstVacGauge_CryoConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_InstVacGauge_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_InstVacGauge_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_Inst_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_Inst_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_IonPumps_CryoConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_IonPumps_CryoConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_IonPumps_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_IonPumps_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_Maq20Cryo_DeviceConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_Maq20Cryo_DeviceConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_Maq20Cryo_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_Maq20Cryo_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_Maq20Ut_DeviceConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_Maq20Ut_DeviceConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_Maq20Ut_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_Maq20Ut_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_PDU_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_PDU_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_PDU_VacuumConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_PDU_VacuumConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_PeriodicTasks_GeneralConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_PeriodicTasks_GeneralConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_PeriodicTasks_timersConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_PeriodicTasks_timersConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_PumpCart_CryoConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_PumpCart_CryoConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_PumpCart_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_PumpCart_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_VacPluto_DeviceConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_VacPluto_DeviceConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_VacPluto_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_VacPluto_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_vacuum_VacuumConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_vacuum_VacuumConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_daq_monitor_PeriodicTasks_GeneralConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_daq_monitor_PeriodicTasks_GeneralConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_daq_monitor_PeriodicTasks_timersConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_daq_monitor_PeriodicTasks_timersConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_daq_monitor_Stats_StatisticsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_daq_monitor_Stats_StatisticsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_daq_monitor_StoreConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_daq_monitor_StoreConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_daq_monitor_Store_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_daq_monitor_Store_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_daq_monitor_Store_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_daq_monitor_Store_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_daq_monitor_Store_StoreConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_daq_monitor_Store_StoreConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_Ccd_HardwareIdConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_focal_plane_Ccd_HardwareIdConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_Ccd_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_focal_plane_Ccd_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_ImageDatabaseService_GeneralConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_focal_plane_ImageDatabaseService_GeneralConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_ImageNameService_GeneralConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_focal_plane_ImageNameService_GeneralConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_InstrumentConfig_InstrumentConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_focal_plane_InstrumentConfig_InstrumentConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_MonitoringConfig_MonitoringConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_focal_plane_MonitoringConfig_MonitoringConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_PeriodicTasks_GeneralConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_focal_plane_PeriodicTasks_GeneralConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_PeriodicTasks_timersConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_focal_plane_PeriodicTasks_timersConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_Raft_HardwareIdConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_focal_plane_Raft_HardwareIdConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_Raft_RaftTempControlConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_focal_plane_Raft_RaftTempControlConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_Raft_RaftTempControlStatusConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_focal_plane_Raft_RaftTempControlStatusConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_RebTotalPower_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_focal_plane_RebTotalPower_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_Reb_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_focal_plane_Reb_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_Reb_GeneralConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_focal_plane_Reb_GeneralConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_Reb_HardwareIdConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_focal_plane_Reb_HardwareIdConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_Reb_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_focal_plane_Reb_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_Reb_RaftsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_focal_plane_Reb_RaftsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_Reb_RaftsLimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_focal_plane_Reb_RaftsLimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_Reb_RaftsPowerConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_focal_plane_Reb_RaftsPowerConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_Reb_timersConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_focal_plane_Reb_timersConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_RebsAverageTemp6_GeneralConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_focal_plane_RebsAverageTemp6_GeneralConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_RebsAverageTemp6_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_focal_plane_RebsAverageTemp6_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_Segment_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_focal_plane_Segment_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_SequencerConfig_DAQConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_focal_plane_SequencerConfig_DAQConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_SequencerConfig_GuiderConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_focal_plane_SequencerConfig_GuiderConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_SequencerConfig_SequencerConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_focal_plane_SequencerConfig_SequencerConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_WebHooksConfig_VisualizationConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_focal_plane_WebHooksConfig_VisualizationConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_image_handling_FitsService_GeneralConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_image_handling_FitsService_GeneralConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_image_handling_ImageHandler_CommandsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_image_handling_ImageHandler_CommandsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_image_handling_ImageHandler_DAQConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_image_handling_ImageHandler_DAQConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_image_handling_ImageHandler_FitsHandlingConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_image_handling_ImageHandler_FitsHandlingConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_image_handling_ImageHandler_GeneralConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_image_handling_ImageHandler_GeneralConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_image_handling_ImageHandler_GuiderConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_image_handling_ImageHandler_GuiderConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_image_handling_PeriodicTasks_GeneralConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_image_handling_PeriodicTasks_GeneralConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_image_handling_PeriodicTasks_timersConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_image_handling_PeriodicTasks_timersConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_image_handling_StatusAggregator_GeneralConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_image_handling_StatusAggregator_GeneralConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_mpm_CLP_RTD_03_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_mpm_CLP_RTD_03_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_mpm_CLP_RTD_05_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_mpm_CLP_RTD_05_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_mpm_CLP_RTD_50_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_mpm_CLP_RTD_50_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_mpm_CLP_RTD_55_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_mpm_CLP_RTD_55_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_mpm_CYP_RTD_12_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_mpm_CYP_RTD_12_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_mpm_CYP_RTD_14_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_mpm_CYP_RTD_14_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_mpm_CYP_RTD_31_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_mpm_CYP_RTD_31_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_mpm_CYP_RTD_43_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_mpm_CYP_RTD_43_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_mpm_PeriodicTasks_GeneralConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_mpm_PeriodicTasks_GeneralConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_mpm_PeriodicTasks_timersConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_mpm_PeriodicTasks_timersConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_mpm_Pluto_DeviceConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_mpm_Pluto_DeviceConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_mpm_Pluto_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_mpm_Pluto_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_Autochanger_autochangerConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_fcs_Autochanger_autochangerConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_Autochanger_readRateConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_fcs_Autochanger_readRateConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_Autochanger_sensorConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_fcs_Autochanger_sensorConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_Canbus0_canbusConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_fcs_Canbus0_canbusConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_Canbus0_controllerConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_fcs_Canbus0_controllerConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_Canbus0_nodeIDConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_fcs_Canbus0_nodeIDConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_Canbus0_sensorConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_fcs_Canbus0_sensorConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_Canbus0_serialNBConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_fcs_Canbus0_serialNBConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_Canbus1_canbusConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_fcs_Canbus1_canbusConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_Canbus1_controllerConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_fcs_Canbus1_controllerConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_Canbus1_nodeIDConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_fcs_Canbus1_nodeIDConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_Canbus1_serialNBConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_fcs_Canbus1_serialNBConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_Carousel_carouselConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_fcs_Carousel_carouselConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_Carousel_readRateConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_fcs_Carousel_readRateConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_Carousel_sensorConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_fcs_Carousel_sensorConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_FilterIdentificator_sensorConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_fcs_FilterIdentificator_sensorConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_FilterManager_filterConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_fcs_FilterManager_filterConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_Loader_loaderConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_fcs_Loader_loaderConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_Loader_readRateConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_fcs_Loader_readRateConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_Loader_sensorConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_fcs_Loader_sensorConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_PeriodicTasks_GeneralConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_fcs_PeriodicTasks_GeneralConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fcs_PeriodicTasks_timersConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_fcs_PeriodicTasks_timersConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_shutter_GeneralConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_shutter_GeneralConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_shutter_timersConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_shutter_timersConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_chiller_DeviceConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_chiller_DeviceConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_chiller_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_chiller_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_chiller_GeneralConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_chiller_GeneralConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_chiller_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_chiller_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_chiller_PicConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_chiller_PicConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_chiller_timersConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_chiller_timersConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_thermal_DeviceConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_thermal_DeviceConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_thermal_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_thermal_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_thermal_GeneralConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_thermal_GeneralConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_thermal_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_thermal_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_thermal_PicConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_thermal_PicConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_thermal_RefrigConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_thermal_RefrigConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_thermal_ThermalLimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_thermal_ThermalLimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_thermal_timersConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_thermal_timersConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_BFR_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_BFR_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_BFR_UtilConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_BFR_UtilConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_BodyMaq20_DeviceConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_BodyMaq20_DeviceConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_BodyMaq20_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_BodyMaq20_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_AmbAirtemp_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_Body_AmbAirtemp_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_AverageTemp_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_Body_AverageTemp_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_BackFlngXMinusTemp_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_Body_BackFlngXMinusTemp_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_BackFlngXPlusTemp_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_Body_BackFlngXPlusTemp_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_BackFlngYMinusTemp_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_Body_BackFlngYMinusTemp_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_CamBodyXPlusTemp_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_Body_CamBodyXPlusTemp_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_CamBodyYMinusTemp_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_Body_CamBodyYMinusTemp_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_CamBodyYPlusTemp_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_Body_CamBodyYPlusTemp_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_CamHousXMinusTemp_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_Body_CamHousXMinusTemp_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_CamHousXPlusTemp_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_Body_CamHousXPlusTemp_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_CamHousYMinusTemp_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_Body_CamHousYMinusTemp_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_CamHousYPlusTemp_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_Body_CamHousYPlusTemp_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_ChgrYMinusRtnAirTemp_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_Body_ChgrYMinusRtnAirTemp_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_ChgrYMinusRtnAirVel_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_Body_ChgrYMinusRtnAirVel_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_DomeXMinusTemp_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_Body_DomeXMinusTemp_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_DomeYMinusTemp_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_Body_DomeYMinusTemp_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_L1XMinusTemp_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_Body_L1XMinusTemp_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_L1YMinusTemp_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_Body_L1YMinusTemp_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_L2XMinusTemp_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_Body_L2XMinusTemp_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_L2XPlusTemp_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_Body_L2XPlusTemp_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_L2YPlusTemp_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_Body_L2YPlusTemp_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_ShrdRngXMinusTemp_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_Body_ShrdRngXMinusTemp_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_ShrdRngXPlusTemp_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_Body_ShrdRngXPlusTemp_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_ShrdRngYMinusTemp_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_Body_ShrdRngYMinusTemp_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_ShrdRngYPlusTemp_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_Body_ShrdRngYPlusTemp_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_ShtrEboxRtnAirTemp_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_Body_ShtrEboxRtnAirTemp_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_ShtrEboxRtnAirVel_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_Body_ShtrEboxRtnAirVel_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_ShtrMtrRtnAirTemp_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_Body_ShtrMtrRtnAirTemp_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_ShtrMtrRtnAirVel_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_Body_ShtrMtrRtnAirVel_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Body_VPPlenumInTemp_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_Body_VPPlenumInTemp_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_MPCFan_PicConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_MPCFan_PicConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_MPC_AvgAirtempOut_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_MPC_AvgAirtempOut_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_MPC_DeltaPressFilt_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_MPC_DeltaPressFilt_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_MPC_DeltaPressTotal_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_MPC_DeltaPressTotal_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_MPC_DeltaTempAct_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_MPC_DeltaTempAct_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_MPC_FanRunTime_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_MPC_FanRunTime_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_MPC_FanSpeed_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_MPC_FanSpeed_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_MPC_Humidity_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_MPC_Humidity_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_MPC_PreFiltPress_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_MPC_PreFiltPress_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_MPC_RetnAirTemp_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_MPC_RetnAirTemp_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_MPC_RetnPress_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_MPC_RetnPress_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_MPC_SplyAirTemp_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_MPC_SplyAirTemp_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_MPC_SplyPress_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_MPC_SplyPress_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_MPC_ValvePosn_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_MPC_ValvePosn_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_PDU_48V_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_PDU_48V_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_PDU_48V_UtilConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_PDU_48V_UtilConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_PeriodicTasks_AgentMonitorService_timersConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_PeriodicTasks_AgentMonitorService_timersConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_PeriodicTasks_BodyMaq20_check_status_timersConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_PeriodicTasks_BodyMaq20_check_status_timersConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_PeriodicTasks_Fan_loop_MPCFan_PicConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_PeriodicTasks_Fan_loop_MPCFan_PicConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_PeriodicTasks_Fan_loop_UTFan_PicConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_PeriodicTasks_Fan_loop_UTFan_PicConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_PeriodicTasks_Fan_loop_VPCFan_PicConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_PeriodicTasks_Fan_loop_VPCFan_PicConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_PeriodicTasks_Heartbeat_timersConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_PeriodicTasks_Heartbeat_timersConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_PeriodicTasks_Monitor_check_timersConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_PeriodicTasks_Monitor_check_timersConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_PeriodicTasks_Monitor_publish_timersConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_PeriodicTasks_Monitor_publish_timersConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_PeriodicTasks_Monitor_update_timersConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_PeriodicTasks_Monitor_update_timersConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_PeriodicTasks_RuntimeInfo_timersConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_PeriodicTasks_RuntimeInfo_timersConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_PeriodicTasks_Schedulers_GeneralConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_PeriodicTasks_Schedulers_GeneralConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_PeriodicTasks_UT_alarms_timersConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_PeriodicTasks_UT_alarms_timersConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_PeriodicTasks_UT_state_timersConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_PeriodicTasks_UT_state_timersConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_PeriodicTasks_UtMaq20_check_status_timersConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_PeriodicTasks_UtMaq20_check_status_timersConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_PeriodicTasks_Vpc_loop_VPCHtrs_timersConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_PeriodicTasks_Vpc_loop_VPCHtrs_timersConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_Telescope_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_Telescope_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_UTFan_PicConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_UTFan_PicConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_UT_AverageTemp_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_UT_AverageTemp_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_UT_CoolFlowRate_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_UT_CoolFlowRate_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_UT_CoolPipeRetnTemp_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_UT_CoolPipeRetnTemp_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_UT_CoolPipeSplyTemp_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_UT_CoolPipeSplyTemp_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_UT_DomeXMinusTemp_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_UT_DomeXMinusTemp_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_UT_DomeYMinusTemp_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_UT_DomeYMinusTemp_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_UT_FanInletTemp_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_UT_FanInletTemp_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_UT_FanRunTime_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_UT_FanRunTime_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_UT_FanSpeed_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_UT_FanSpeed_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_UT_MidXMinusTemp_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_UT_MidXMinusTemp_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_UT_MidXPlusTemp_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_UT_MidXPlusTemp_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_UT_SuppXMinusTemp_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_UT_SuppXMinusTemp_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_UT_SuppXPlusTemp_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_UT_SuppXPlusTemp_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_UT_TopXMinusTemp_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_UT_TopXMinusTemp_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_UT_TopXPlusTemp_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_UT_TopXPlusTemp_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_UT_ValvePosn_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_UT_ValvePosn_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_UT_W2Q1Temp_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_UT_W2Q1Temp_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_UT_W4Q3Temp_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_UT_W4Q3Temp_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_UtMaq20_DeviceConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_UtMaq20_DeviceConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_UtMaq20_DevicesConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_UtMaq20_DevicesConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_UtilConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_UtilConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_VPCFan_PicConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_VPCFan_PicConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_VPCHtrs_VpcConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_VPCHtrs_VpcConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_VPC_DeltaPressFilt_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_VPC_DeltaPressFilt_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_VPC_DeltaPressTotal_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_VPC_DeltaPressTotal_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_VPC_DeltaTempAct_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_VPC_DeltaTempAct_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_VPC_FanRunTime_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_VPC_FanRunTime_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_VPC_FanSpeed_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_VPC_FanSpeed_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_VPC_HtrCurrent_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_VPC_HtrCurrent_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_VPC_Humidity_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_VPC_Humidity_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_VPC_PreFiltPress_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_VPC_PreFiltPress_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_VPC_RetnAirTemp_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_VPC_RetnAirTemp_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_VPC_RetnPress_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_VPC_RetnPress_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_VPC_SplyAirTemp_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_VPC_SplyAirTemp_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_VPC_SplyAirVel_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_VPC_SplyAirVel_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_VPC_SplyPress_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_VPC_SplyPress_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_utiltrunk_VPC_ValvePosn_LimitsConfiguration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_utiltrunk_VPC_ValvePosn_LimitsConfiguration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_summaryStatus.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_summaryStatus.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_alertRaised.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_alertRaised.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_filterChangerPowerStatus.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_filterChangerPowerStatus.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_disable.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_disable.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_enable.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_enable.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_exitControl.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_exitControl.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_setLogLevel.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_setLogLevel.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_standby.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_standby.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_start.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_start.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_enterControl.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_enterControl.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_discardRows.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_discardRows.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_startImage.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_startImage.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_disableCalibration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_disableCalibration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_initGuiders.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_initGuiders.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_enableCalibration.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_enableCalibration.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_initImage.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_initImage.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_endImage.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_endImage.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_setFilter.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_setFilter.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_clear.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_clear.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_takeImages.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_takeImages.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_stop.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_stop.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_play.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_play.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_playlist.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_playlist.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_alert.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_alert.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_wakeFilterChanger.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_wakeFilterChanger.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_generic.json
    Should Contain    ${output.stdout}    Adding /home/saluser/repos/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_generic.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Configuring ${subSystem}/java/src/org/lsst/sal/SAL_${subSystem}.java
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/saj_${subSystem}_types.jar
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/org/lsst/sal/SAL_${subSystem}.java
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/org/lsst/sal/salActor.java
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/org/lsst/sal/salUtils.java
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
    File Should Exist    ${SALWorkDir}/maven/${subSystem}-${XMLVersionBase}_${SALVersionBase}${MavenVersion}/target/sal_${subSystem}-${XMLVersionBase}_${SALVersionBase}${MavenVersion}.jar

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

