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
    [Tags]
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
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_quadbox_BFR.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_quadbox_PDU_24VC.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_quadbox_PDU_24VD.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_quadbox_PDU_48V.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_quadbox_PDU_5V.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_quadbox_REB_Bulk_PS.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_rebpower_Reb.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_rebpower_RebTotalPower.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_rebpower_Rebps.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_hex_Cold1.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_hex_Cold2.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_hex_Cryo1.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_hex_Cryo2.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_hex_Cryo3.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_hex_Cryo4.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_hex_Cryo5.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_hex_Cryo6.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_refrig_Cryo1.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_refrig_Cryo2.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_refrig_Cryo3.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_refrig_Cryo4.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_refrig_Cryo5.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_refrig_Cryo6.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vacuum_Cip.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vacuum_Cryo.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vacuum_HX.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vacuum_Inst.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_daq_monitor_Reb_Trending.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_daq_monitor_Store.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_daq_monitor_Sum_Trending.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_focal_plane_Ccd.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_focal_plane_Reb.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_focal_plane_RebTotalPower.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_focal_plane_RebsAverageTemp6.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_focal_plane_Segment.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Autochanger_AutochangerTrucks_Trending.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Autochanger_Latches_Trending.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Autochanger_OnlineClamps_Trending.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Autochanger_Temperatures.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Canbus0_AcSensorsGateway_Trending.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Canbus0_AcTruckXminusController_Trending.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Canbus0_AcTruckXplusController_Trending.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Canbus0_Accelerobf_Trending.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Canbus0_Ai814_Trending.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Canbus0_BrakeSystemGateway_Trending.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Canbus0_CarouselController_Trending.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Canbus0_ClampXminusController_Trending.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Canbus0_ClampXplusController_Trending.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Canbus0_Hyttc580_Trending.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Canbus0_LatchXminusController_Trending.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Canbus0_LatchXplusController_Trending.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Canbus0_OnlineClampXminusController_Trending.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Canbus0_OnlineClampXplusController_Trending.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Canbus0_OnlineClampYminusController_Trending.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Canbus0_OnlineStrainGauge_Trending.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Canbus0_ProximitySensorsDevice_Trending.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Canbus0_Pt100_Trending.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Canbus0_TempSensorsDevice1_Trending.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Canbus0_TempSensorsDevice2_Trending.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Canbus1_CarrierController_Trending.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Canbus1_HooksController_Trending.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Canbus1_LoaderPlutoGateway_Trending.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Carousel_Socket1_Trending.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Carousel_Socket2_Trending.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Carousel_Socket3_Trending.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Carousel_Socket4_Trending.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Carousel_Socket5_Trending.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Carousel_Trending.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Duration_Autochanger_Trending.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Duration_Carousel_Trending.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Duration_Loader_Trending.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Duration_Trending.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Fcs_Mcm_Trending.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Loader_Carrier_Trending.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Loader_Hooks_Trending.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Trending.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_shutter_Trending.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_chiller_Chiller.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_chiller_FParam_Trending.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_chiller_Maq20.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_thermal_Cold_Temp.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_thermal_Cryo_Temp.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_thermal_Rtd.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_thermal_Trim.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_thermal_Trim_Htrs.idl
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
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_alert.idl
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
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_quadbox_BFR_DevicesConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_quadbox_BFR_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_quadbox_BFR_QuadboxConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_quadbox_Maq20_DeviceConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_quadbox_Maq20_DevicesConfiguration.idl
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
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_quadbox_REB_Bulk_PS_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_quadbox_REB_Bulk_PS_QuadboxConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_rebpower_EmergencyResponseManager_GeneralConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_rebpower_GeneralConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_rebpower_PeriodicTasks_GeneralConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_rebpower_PeriodicTasks_timersConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_rebpower_RebTotalPower_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_rebpower_Reb_GeneralConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_rebpower_Reb_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_rebpower_Rebps_DevicesConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_rebpower_Rebps_GeneralConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_rebpower_Rebps_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_rebpower_Rebps_PowerConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_rebpower_Rebps_buildConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_hex_Cold1_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_hex_Cold2_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_hex_Cryo1_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_hex_Cryo2_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_hex_Cryo3_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_hex_Cryo4_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_hex_Cryo5_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_hex_Cryo6_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_hex_GeneralConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_hex_Maq20_DeviceConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_hex_Maq20_DevicesConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_hex_PeriodicTasks_GeneralConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_hex_PeriodicTasks_timersConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_hex_StatusAggregator_GeneralConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_refrig_Cryo1_DeviceConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_refrig_Cryo1_DevicesConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_refrig_Cryo1_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_refrig_Cryo2_DeviceConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_refrig_Cryo2_DevicesConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_refrig_Cryo2_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_refrig_Cryo3_DeviceConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_refrig_Cryo3_DevicesConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_refrig_Cryo3_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_refrig_Cryo3_PicConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_refrig_Cryo4_DeviceConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_refrig_Cryo4_DevicesConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_refrig_Cryo4_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_refrig_Cryo5_DeviceConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_refrig_Cryo5_DevicesConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_refrig_Cryo5_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_refrig_Cryo5_PicConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_refrig_Cryo6_DeviceConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_refrig_Cryo6_DevicesConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_refrig_Cryo6_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_refrig_CryoCompLimits_CompLimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_refrig_PeriodicTasks_GeneralConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_refrig_PeriodicTasks_PicConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_refrig_PeriodicTasks_timersConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_Cip_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_CryoFlineGauge_CryoConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_CryoFlineGauge_DevicesConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_CryoTurboGauge_CryoConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_CryoTurboGauge_DevicesConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_CryoTurboPump_DevicesConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_CryoTurboPump_GeneralConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_CryoVacGauge_CryoConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_CryoVacGauge_DevicesConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_Cryo_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_HX_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_HexFlineGauge_CryoConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_HexFlineGauge_DevicesConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_HexTurboGauge_CryoConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_HexTurboGauge_DevicesConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_HexTurboPump_DevicesConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_HexTurboPump_GeneralConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_HexVacGauge_CryoConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_HexVacGauge_DevicesConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_InstVacGauge_CryoConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_InstVacGauge_DevicesConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_Inst_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_IonPumps_CryoConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_IonPumps_DevicesConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_Maq20Cryo_DeviceConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_Maq20Cryo_DevicesConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_Maq20Ut_DeviceConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_Maq20Ut_DevicesConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_PDU_DevicesConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_PDU_VacuumConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_PeriodicTasks_GeneralConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_PeriodicTasks_timersConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_PumpCart_CryoConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_PumpCart_DevicesConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_VacPluto_DeviceConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_VacPluto_DevicesConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_VacuumConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_daq_monitor_PeriodicTasks_GeneralConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_daq_monitor_PeriodicTasks_timersConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_daq_monitor_Stats_StatisticsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_daq_monitor_StoreConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_daq_monitor_Store_DevicesConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_daq_monitor_Store_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_daq_monitor_Store_StoreConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_Ccd_HardwareIdConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_Ccd_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_Ccd_RaftsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_ImageDatabaseService_GeneralConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_ImageNameService_GeneralConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_InstrumentConfig_InstrumentConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_MonitoringConfig_MonitoringConfiguration.idl
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
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_RebsAverageTemp6_GeneralConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_RebsAverageTemp6_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_Segment_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_SequencerConfig_DAQConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_SequencerConfig_GuiderConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_SequencerConfig_SequencerConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_WebHooksConfig_VisualizationConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_image_handling_FitsService_GeneralConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_image_handling_ImageHandler_CommandsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_image_handling_ImageHandler_DAQConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_image_handling_ImageHandler_FitsHandlingConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_image_handling_ImageHandler_GuiderConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_image_handling_PeriodicTasks_GeneralConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_image_handling_PeriodicTasks_timersConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_image_handling_StatusAggregator_GeneralConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_Autochanger_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_Autochanger_autochangerConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_Autochanger_readRateConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_Autochanger_sensorConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_Canbus0_canbusConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_Canbus0_controllerConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_Canbus0_nodeIDConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_Canbus0_sensorConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_Canbus0_serialNBConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_Canbus1_canbusConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_Canbus1_controllerConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_Canbus1_nodeIDConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_Canbus1_serialNBConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_Carousel_carouselConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_Carousel_readRateConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_Carousel_sensorConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_FilterIdentificator_sensorConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_FilterManager_filterConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_Loader_loaderConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_Loader_readRateConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_Loader_sensorConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_PeriodicTasks_GeneralConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_PeriodicTasks_timersConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_Seneca1_DevicesConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_Seneca2_DevicesConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_shutter_GeneralConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_shutter_timersConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_chiller_DeviceConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_chiller_DevicesConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_chiller_GeneralConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_chiller_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_chiller_timersConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_thermal_DeviceConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_thermal_DevicesConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_thermal_GeneralConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_thermal_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_thermal_PicConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_thermal_RefrigConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_thermal_ThermalLimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_thermal_timersConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_summaryStatus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_alertRaised.idl

Verify MTCamera revCodes File
    [Documentation]    Ensure MTCamera_revCodes.tcl contains 1 revcode per topic.
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
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_alert\\) [a-z0-9]{8,}
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
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_quadbox_BFR_DevicesConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_quadbox_BFR_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_quadbox_BFR_QuadboxConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_quadbox_Maq20_DeviceConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_quadbox_Maq20_DevicesConfiguration\\) [a-z0-9]{8,}
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
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_quadbox_REB_Bulk_PS_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_quadbox_REB_Bulk_PS_QuadboxConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_rebpower_EmergencyResponseManager_GeneralConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_rebpower_GeneralConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_rebpower_PeriodicTasks_GeneralConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_rebpower_PeriodicTasks_timersConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_rebpower_RebTotalPower_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_rebpower_Reb_GeneralConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_rebpower_Reb_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_rebpower_Rebps_DevicesConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_rebpower_Rebps_GeneralConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_rebpower_Rebps_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_rebpower_Rebps_PowerConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_rebpower_Rebps_buildConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_hex_Cold1_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_hex_Cold2_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_hex_Cryo1_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_hex_Cryo2_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_hex_Cryo3_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_hex_Cryo4_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_hex_Cryo5_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_hex_Cryo6_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_hex_GeneralConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_hex_Maq20_DeviceConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_hex_Maq20_DevicesConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_hex_PeriodicTasks_GeneralConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_hex_PeriodicTasks_timersConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_hex_StatusAggregator_GeneralConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_refrig_Cryo1_DeviceConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_refrig_Cryo1_DevicesConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_refrig_Cryo1_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_refrig_Cryo2_DeviceConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_refrig_Cryo2_DevicesConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_refrig_Cryo2_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_refrig_Cryo3_DeviceConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_refrig_Cryo3_DevicesConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_refrig_Cryo3_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_refrig_Cryo3_PicConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_refrig_Cryo4_DeviceConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_refrig_Cryo4_DevicesConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_refrig_Cryo4_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_refrig_Cryo5_DeviceConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_refrig_Cryo5_DevicesConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_refrig_Cryo5_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_refrig_Cryo5_PicConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_refrig_Cryo6_DeviceConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_refrig_Cryo6_DevicesConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_refrig_Cryo6_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_refrig_CryoCompLimits_CompLimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_refrig_PeriodicTasks_GeneralConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_refrig_PeriodicTasks_PicConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_refrig_PeriodicTasks_timersConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_Cip_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_CryoFlineGauge_CryoConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_CryoFlineGauge_DevicesConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_CryoTurboGauge_CryoConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_CryoTurboGauge_DevicesConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_CryoTurboPump_DevicesConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_CryoTurboPump_GeneralConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_CryoVacGauge_CryoConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_CryoVacGauge_DevicesConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_Cryo_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_HX_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_HexFlineGauge_CryoConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_HexFlineGauge_DevicesConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_HexTurboGauge_CryoConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_HexTurboGauge_DevicesConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_HexTurboPump_DevicesConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_HexTurboPump_GeneralConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_HexVacGauge_CryoConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_HexVacGauge_DevicesConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_InstVacGauge_CryoConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_InstVacGauge_DevicesConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_Inst_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_IonPumps_CryoConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_IonPumps_DevicesConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_Maq20Cryo_DeviceConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_Maq20Cryo_DevicesConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_Maq20Ut_DeviceConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_Maq20Ut_DevicesConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_PDU_DevicesConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_PDU_VacuumConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_PeriodicTasks_GeneralConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_PeriodicTasks_timersConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_PumpCart_CryoConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_PumpCart_DevicesConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_VacPluto_DeviceConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_VacPluto_DevicesConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_VacuumConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_daq_monitor_PeriodicTasks_GeneralConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_daq_monitor_PeriodicTasks_timersConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_daq_monitor_Stats_StatisticsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_daq_monitor_StoreConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_daq_monitor_Store_DevicesConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_daq_monitor_Store_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_daq_monitor_Store_StoreConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_Ccd_HardwareIdConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_Ccd_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_Ccd_RaftsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_ImageDatabaseService_GeneralConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_ImageNameService_GeneralConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_InstrumentConfig_InstrumentConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_MonitoringConfig_MonitoringConfiguration\\) [a-z0-9]{8,}
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
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_RebsAverageTemp6_GeneralConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_RebsAverageTemp6_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_Segment_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_SequencerConfig_DAQConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_SequencerConfig_GuiderConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_SequencerConfig_SequencerConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_WebHooksConfig_VisualizationConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_image_handling_FitsService_GeneralConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_image_handling_ImageHandler_CommandsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_image_handling_ImageHandler_DAQConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_image_handling_ImageHandler_FitsHandlingConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_image_handling_ImageHandler_GuiderConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_image_handling_PeriodicTasks_GeneralConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_image_handling_PeriodicTasks_timersConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_image_handling_StatusAggregator_GeneralConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_Autochanger_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_Autochanger_autochangerConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_Autochanger_readRateConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_Autochanger_sensorConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_Canbus0_canbusConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_Canbus0_controllerConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_Canbus0_nodeIDConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_Canbus0_sensorConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_Canbus0_serialNBConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_Canbus1_canbusConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_Canbus1_controllerConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_Canbus1_nodeIDConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_Canbus1_serialNBConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_Carousel_carouselConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_Carousel_readRateConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_Carousel_sensorConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_FilterIdentificator_sensorConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_FilterManager_filterConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_Loader_loaderConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_Loader_readRateConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_Loader_sensorConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_PeriodicTasks_GeneralConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_PeriodicTasks_timersConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_Seneca1_DevicesConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_Seneca2_DevicesConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_shutter_GeneralConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_shutter_timersConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_chiller_DeviceConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_chiller_DevicesConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_chiller_GeneralConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_chiller_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_chiller_timersConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_thermal_DeviceConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_thermal_DevicesConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_thermal_GeneralConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_thermal_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_thermal_PicConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_thermal_RefrigConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_thermal_ThermalLimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_thermal_timersConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_summaryStatus\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_alertRaised\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_quadbox_BFR\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_quadbox_PDU_24VC\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_quadbox_PDU_24VD\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_quadbox_PDU_48V\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_quadbox_PDU_5V\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_quadbox_REB_Bulk_PS\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_rebpower_Reb\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_rebpower_RebTotalPower\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_rebpower_Rebps\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_hex_Cold1\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_hex_Cold2\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_hex_Cryo1\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_hex_Cryo2\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_hex_Cryo3\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_hex_Cryo4\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_hex_Cryo5\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_hex_Cryo6\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_refrig_Cryo1\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_refrig_Cryo2\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_refrig_Cryo3\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_refrig_Cryo4\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_refrig_Cryo5\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_refrig_Cryo6\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vacuum_Cip\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vacuum_Cryo\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vacuum_HX\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vacuum_Inst\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_daq_monitor_Reb_Trending\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_daq_monitor_Store\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_daq_monitor_Sum_Trending\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_focal_plane_Ccd\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_focal_plane_Reb\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_focal_plane_RebTotalPower\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_focal_plane_RebsAverageTemp6\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_focal_plane_Segment\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Autochanger_AutochangerTrucks_Trending\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Autochanger_Latches_Trending\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Autochanger_OnlineClamps_Trending\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Autochanger_Temperatures\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Canbus0_AcSensorsGateway_Trending\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Canbus0_AcTruckXminusController_Trending\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Canbus0_AcTruckXplusController_Trending\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Canbus0_Accelerobf_Trending\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Canbus0_Ai814_Trending\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Canbus0_BrakeSystemGateway_Trending\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Canbus0_CarouselController_Trending\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Canbus0_ClampXminusController_Trending\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Canbus0_ClampXplusController_Trending\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Canbus0_Hyttc580_Trending\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Canbus0_LatchXminusController_Trending\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Canbus0_LatchXplusController_Trending\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Canbus0_OnlineClampXminusController_Trending\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Canbus0_OnlineClampXplusController_Trending\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Canbus0_OnlineClampYminusController_Trending\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Canbus0_OnlineStrainGauge_Trending\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Canbus0_ProximitySensorsDevice_Trending\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Canbus0_Pt100_Trending\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Canbus0_TempSensorsDevice1_Trending\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Canbus0_TempSensorsDevice2_Trending\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Canbus1_CarrierController_Trending\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Canbus1_HooksController_Trending\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Canbus1_LoaderPlutoGateway_Trending\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Carousel_Socket1_Trending\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Carousel_Socket2_Trending\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Carousel_Socket3_Trending\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Carousel_Socket4_Trending\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Carousel_Socket5_Trending\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Carousel_Trending\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Duration_Autochanger_Trending\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Duration_Carousel_Trending\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Duration_Loader_Trending\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Duration_Trending\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Fcs_Mcm_Trending\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Loader_Carrier_Trending\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Loader_Hooks_Trending\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Trending\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_shutter_Trending\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_chiller_Chiller\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_chiller_FParam_Trending\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_chiller_Maq20\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_thermal_Cold_Temp\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_thermal_Cryo_Temp\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_thermal_Rtd\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_thermal_Trim\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_thermal_Trim_Htrs\\) [a-z0-9]{8,}

Salgen MTCamera IDL
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

Salgen MTCamera Java
    [Documentation]    Generate Java libraries.
    [Tags]    java
    ${output}=    Run Process    ${SALHome}/bin/salgenerator    ${subSystem}    sal    java    version\=${MavenVersion}    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stdout}    ERROR : Failed to generate Java DDS types
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    XMLVERSION = ${XMLVersion}
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_quadbox_BFR.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_quadbox_PDU_24VC.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_quadbox_PDU_24VD.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_quadbox_PDU_48V.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_quadbox_PDU_5V.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_quadbox_REB_Bulk_PS.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_rebpower_Reb.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_rebpower_RebTotalPower.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_rebpower_Rebps.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_hex_Cold1.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_hex_Cold2.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_hex_Cryo1.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_hex_Cryo2.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_hex_Cryo3.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_hex_Cryo4.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_hex_Cryo5.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_hex_Cryo6.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_refrig_Cryo1.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_refrig_Cryo2.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_refrig_Cryo3.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_refrig_Cryo4.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_refrig_Cryo5.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_refrig_Cryo6.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vacuum_Cip.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vacuum_Cryo.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vacuum_HX.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vacuum_Inst.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_daq_monitor_Reb_Trending.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_daq_monitor_Store.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_daq_monitor_Sum_Trending.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_focal_plane_Ccd.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_focal_plane_Reb.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_focal_plane_RebTotalPower.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_focal_plane_RebsAverageTemp6.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_focal_plane_Segment.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Autochanger_AutochangerTrucks_Trending.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Autochanger_Latches_Trending.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Autochanger_OnlineClamps_Trending.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Autochanger_Temperatures.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Canbus0_AcSensorsGateway_Trending.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Canbus0_AcTruckXminusController_Trending.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Canbus0_AcTruckXplusController_Trending.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Canbus0_Accelerobf_Trending.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Canbus0_Ai814_Trending.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Canbus0_BrakeSystemGateway_Trending.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Canbus0_CarouselController_Trending.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Canbus0_ClampXminusController_Trending.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Canbus0_ClampXplusController_Trending.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Canbus0_Hyttc580_Trending.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Canbus0_LatchXminusController_Trending.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Canbus0_LatchXplusController_Trending.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Canbus0_OnlineClampXminusController_Trending.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Canbus0_OnlineClampXplusController_Trending.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Canbus0_OnlineClampYminusController_Trending.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Canbus0_OnlineStrainGauge_Trending.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Canbus0_ProximitySensorsDevice_Trending.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Canbus0_Pt100_Trending.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Canbus0_TempSensorsDevice1_Trending.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Canbus0_TempSensorsDevice2_Trending.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Canbus1_CarrierController_Trending.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Canbus1_HooksController_Trending.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Canbus1_LoaderPlutoGateway_Trending.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Carousel_Socket1_Trending.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Carousel_Socket2_Trending.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Carousel_Socket3_Trending.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Carousel_Socket4_Trending.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Carousel_Socket5_Trending.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Carousel_Trending.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Duration_Autochanger_Trending.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Duration_Carousel_Trending.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Duration_Loader_Trending.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Duration_Trending.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Fcs_Mcm_Trending.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Loader_Carrier_Trending.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Loader_Hooks_Trending.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Trending.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_shutter_Trending.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_chiller_Chiller.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_chiller_FParam_Trending.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_chiller_Maq20.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_thermal_Cold_Temp.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_thermal_Cryo_Temp.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_thermal_Rtd.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_thermal_Trim.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_thermal_Trim_Htrs.idl
    Should Contain X Times    ${output.stdout}    javac : Done Publisher    85
    Should Contain X Times    ${output.stdout}    javac : Done Subscriber    85
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl
    File Should Exist    ${SALWorkDir}/${subSystem}/java/saj_${subSystem}_types.jar
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl

Salgen MTCamera Maven
    [Documentation]    Generate the Maven repository.
    [Tags]    java
    ${output}=    Run Process    ${SALHome}/bin/salgenerator    ${subSystem}    maven    version\=${MavenVersion}    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
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
    ${output}=    Run Process    ${SALHome}/bin/salgenerator    ${subSystem}    lib    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    XMLVERSION = ${XMLVersion}
    Should Contain    ${output.stdout}    Building shared library for ${subSystem} subsystem
    Directory Should Exist    ${SALWorkDir}/lib
    @{files}=    List Directory    ${SALWorkDir}/lib    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/lib/saj_${subSystem}_types.jar

Salgen MTCamera RPM
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
    File Should Exist    ${SALWorkDir}/rpmbuild/SPECS/ts_sal_${subSystem}.spec
    File Should Exist    ${SALWorkDir}/rpmbuild/SOURCES/${subSystem}-${XMLVersionBase}${sep}${Build_Number}.tgz
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/ts_sal_runtime-${XMLVersionBase}${sep}${Build_Number}-${SALVersionBase}*${DIST}.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/ts_sal_ATruntime-${XMLVersionBase}${sep}${Build_Number}-${SALVersionBase}*${DIST}.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/ts_sal_utils-${SALVersionBase}-1.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/${subSystem}-${XMLVersionBase}${sep}${Build_Number}-${SALVersionBase}${DIST}.x86_64.rpm
    Should Not Contain    ${output.stdout}    child process exited abnormally

Verify MTCamera RPM Contents
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

