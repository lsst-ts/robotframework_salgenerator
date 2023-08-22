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
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_rebpower_Rebps.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_hex_Cold1.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_hex_Cold2.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_hex_Cryo1.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_hex_Cryo2.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_hex_Cryo3.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_hex_Cryo4.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_hex_Cryo5.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_hex_Cryo6.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_refrig_Cold1.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_refrig_Cold2.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_refrig_Cryo1.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_refrig_Cryo2.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_refrig_Cryo3.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_refrig_Cryo4.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_refrig_Cryo5.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_refrig_Cryo6.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vacuum_CIP1_I.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vacuum_CIP1_V.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vacuum_CIP2_I.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vacuum_CIP2_V.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vacuum_CIP3_I.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vacuum_CIP3_V.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vacuum_CIP4_I.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vacuum_CIP4_V.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vacuum_CIP5_I.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vacuum_CIP5_V.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vacuum_CIP6_I.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vacuum_CIP6_V.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vacuum_CryoVac.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vacuum_ForelineVac.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vacuum_Hex1Vac.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vacuum_Hex2Vac.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vacuum_TurboCurrent.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vacuum_TurboPower.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vacuum_TurboPumpTemp.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vacuum_TurboSpeed.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vacuum_TurboVac.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vacuum_TurboVoltage.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_daq_monitor_Store.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_focal_plane_Ccd.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_focal_plane_Reb.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_focal_plane_RebTotalPower.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_focal_plane_Segment.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_AcSensorsGateway.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_AcTruckXminus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_AcTruckXminusController.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_AcTruckXplus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_AcTruckXplusController.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Accelerobf.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Ai814.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Autochanger.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_AutochangerTrucks.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_BrakeSystemGateway.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Carousel.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_CarouselController.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Carrier.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_CarrierController.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_CcsVersions.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_ClampXminus1.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_ClampXminus2.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_ClampXminus3.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_ClampXminus4.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_ClampXminus5.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_ClampXminusController.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_ClampXplus1.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_ClampXplus2.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_ClampXplus3.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_ClampXplus4.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_ClampXplus5.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_ClampXplusController.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Config.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Hooks.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_HooksController.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Hyttc580.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_LatchXminus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_LatchXminusController.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_LatchXplus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_LatchXplusController.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Latches.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Loader.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_LoaderPlutoGateway.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_OnlineClampXminus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_OnlineClampXminusController.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_OnlineClampXplus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_OnlineClampXplusController.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_OnlineClampYminus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_OnlineClampYminusController.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_OnlineClamps.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_OnlineStrainGauge.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_ProximitySensorsDevice.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Pt100.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_RuntimeInfo.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Socket1.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Socket2.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Socket3.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Socket4.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_Socket5.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_TempSensorsDevice1.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fcs_TempSensorsDevice2.idl
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
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_quadbox_BFR_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_quadbox_BFR_QuadboxConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_quadbox_PDU_24VC_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_quadbox_PDU_24VC_QuadboxConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_quadbox_PDU_24VD_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_quadbox_PDU_24VD_QuadboxConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_quadbox_PDU_48V_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_quadbox_PDU_48V_QuadboxConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_quadbox_PDU_5V_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_quadbox_PDU_5V_QuadboxConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_quadbox_PeriodicTasksConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_quadbox_PeriodicTasks_timersConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_quadbox_REB_Bulk_PS_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_quadbox_REB_Bulk_PS_QuadboxConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_rebpowerConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_rebpower_EmergencyResponseManagerConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_rebpower_PeriodicTasksConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_rebpower_PeriodicTasks_timersConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_rebpower_RebConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_rebpower_Reb_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_rebpower_Rebps_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_rebpower_Rebps_PowerConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_hexConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_hex_Cold1_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_hex_Cold2_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_hex_Cryo1_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_hex_Cryo2_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_hex_Cryo3_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_hex_Cryo4_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_hex_Cryo5_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_hex_Cryo6_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_hex_Maq20_DeviceConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_hex_Maq20x_DeviceConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_hex_PeriodicTasksConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_hex_PeriodicTasks_timersConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_refrig_Cold1_CompLimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_refrig_Cold1_DeviceConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_refrig_Cold1_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_refrig_Cold2_CompLimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_refrig_Cold2_DeviceConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_refrig_Cold2_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_refrig_CoolMaq20_DeviceConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_refrig_Cryo1_CompLimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_refrig_Cryo1_DeviceConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_refrig_Cryo1_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_refrig_Cryo2_CompLimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_refrig_Cryo2_DeviceConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_refrig_Cryo2_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_refrig_Cryo3_CompLimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_refrig_Cryo3_DeviceConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_refrig_Cryo3_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_refrig_Cryo4_CompLimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_refrig_Cryo4_DeviceConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_refrig_Cryo4_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_refrig_Cryo5_CompLimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_refrig_Cryo5_DeviceConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_refrig_Cryo5_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_refrig_Cryo6_CompLimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_refrig_Cryo6_DeviceConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_refrig_Cryo6_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_refrig_PeriodicTasksConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_refrig_PeriodicTasks_timersConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_AgentMonitorServiceConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_CIP1CConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_CIP1_IConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_CIP1_VConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_CIP2CConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_CIP2_IConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_CIP2_VConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_CIP3CConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_CIP3_IConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_CIP3_VConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_CIP4CConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_CIP4_IConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_CIP4_VConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_CIP5CConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_CIP5_IConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_CIP5_VConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_CIP6CConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_CIP6_IConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_CIP6_VConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_CryoVacConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_CryoVacGaugeConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_ForelineVacConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_ForelineVacGaugeConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_HeartbeatConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_Hex1VacConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_Hex1VacGaugeConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_Hex2VacConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_Hex2VacGaugeConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_IonPumpsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_Monitor_checkConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_Monitor_publishConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_Monitor_updateConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_RuntimeInfoConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_SchedulersConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_TurboCurrentConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_TurboPowerConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_TurboPumpConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_TurboPumpTempConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_TurboSpeedConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_TurboVacConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_TurboVacGaugeConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_TurboVoltageConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_VacPlutoConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_vacuum_Vacuum_stateConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_daq_monitor_PeriodicTasksConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_daq_monitor_PeriodicTasks_timersConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_daq_monitor_Stats_StatisticsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_daq_monitor_Stats_buildConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_daq_monitor_StoreConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_daq_monitor_Store_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_daq_monitor_Store_StoreConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_Ccd_HardwareIdConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_Ccd_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_Ccd_RaftsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_ImageDatabaseServiceConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_ImageNameServiceConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_InstrumentConfig_InstrumentConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_PeriodicTasksConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_PeriodicTasks_timersConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_Raft_HardwareIdConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_Raft_RaftTempControlConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_Raft_RaftTempControlStatusConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_focal_plane_RebTotalPower_LimitsConfiguration.idl
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
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_image_handling_ImageHandler_DAQConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_image_handling_ImageHandler_FitsHandlingConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_image_handling_PeriodicTasks_GeneralConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_image_handling_PeriodicTasks_timersConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_image_handling_Reb_FitsHandlingConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_image_handling_Reb_GeneralConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_Loader_sensorConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_LockOutSensors_sensorConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_LockOutShunt_sensorConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_LpmEngineeringKeySensors_sensorConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_LpmLatchesStatus_sensorConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_LpmLinearRail1Status_sensorConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_LpmLinearRail2Status_sensorConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_LpmOnlineClampsStatus_sensorConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_OUT_AF0_Sensors_sensorConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_OUT_AF1_Sensors_sensorConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_OUT_AF3_Sensors_sensorConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_OUT_AIN_sensorConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_OUT_AOL_sensorConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_OUT_AP1_Sensors_sensorConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_OUT_AP2_Sensors_sensorConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_OUT_AP3_Sensors_sensorConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_PeriodicTasks_GeneralConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_PeriodicTasks_timersConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_Seneca1_DevicesConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_Seneca2_DevicesConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_TcpProxy_canbusConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_TcpProxy_controllerConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_TcpProxy_nodeIDConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_TcpProxy_sensorConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_TcpProxy_serialNBConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_TempCellXminus_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_TempClampMotorXminus_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_TempClampMotorXplus_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_TempClampMotorYminus_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_TempFrontBox_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_TempLinearRailMotorXminus_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_TempLinearRailMotorXplus_LimitsConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fcs_TempRearBox_LimitsConfiguration.idl
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
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_quadbox_BFR_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_quadbox_BFR_QuadboxConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_quadbox_PDU_24VC_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_quadbox_PDU_24VC_QuadboxConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_quadbox_PDU_24VD_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_quadbox_PDU_24VD_QuadboxConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_quadbox_PDU_48V_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_quadbox_PDU_48V_QuadboxConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_quadbox_PDU_5V_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_quadbox_PDU_5V_QuadboxConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_quadbox_PeriodicTasksConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_quadbox_PeriodicTasks_timersConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_quadbox_REB_Bulk_PS_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_quadbox_REB_Bulk_PS_QuadboxConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_rebpowerConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_rebpower_EmergencyResponseManagerConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_rebpower_PeriodicTasksConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_rebpower_PeriodicTasks_timersConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_rebpower_RebConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_rebpower_Reb_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_rebpower_Rebps_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_rebpower_Rebps_PowerConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_hexConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_hex_Cold1_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_hex_Cold2_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_hex_Cryo1_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_hex_Cryo2_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_hex_Cryo3_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_hex_Cryo4_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_hex_Cryo5_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_hex_Cryo6_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_hex_Maq20_DeviceConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_hex_Maq20x_DeviceConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_hex_PeriodicTasksConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_hex_PeriodicTasks_timersConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_refrig_Cold1_CompLimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_refrig_Cold1_DeviceConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_refrig_Cold1_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_refrig_Cold2_CompLimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_refrig_Cold2_DeviceConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_refrig_Cold2_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_refrig_CoolMaq20_DeviceConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_refrig_Cryo1_CompLimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_refrig_Cryo1_DeviceConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_refrig_Cryo1_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_refrig_Cryo2_CompLimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_refrig_Cryo2_DeviceConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_refrig_Cryo2_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_refrig_Cryo3_CompLimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_refrig_Cryo3_DeviceConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_refrig_Cryo3_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_refrig_Cryo4_CompLimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_refrig_Cryo4_DeviceConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_refrig_Cryo4_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_refrig_Cryo5_CompLimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_refrig_Cryo5_DeviceConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_refrig_Cryo5_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_refrig_Cryo6_CompLimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_refrig_Cryo6_DeviceConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_refrig_Cryo6_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_refrig_PeriodicTasksConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_refrig_PeriodicTasks_timersConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_AgentMonitorServiceConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_CIP1CConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_CIP1_IConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_CIP1_VConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_CIP2CConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_CIP2_IConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_CIP2_VConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_CIP3CConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_CIP3_IConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_CIP3_VConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_CIP4CConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_CIP4_IConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_CIP4_VConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_CIP5CConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_CIP5_IConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_CIP5_VConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_CIP6CConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_CIP6_IConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_CIP6_VConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_CryoVacConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_CryoVacGaugeConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_ForelineVacConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_ForelineVacGaugeConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_HeartbeatConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_Hex1VacConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_Hex1VacGaugeConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_Hex2VacConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_Hex2VacGaugeConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_IonPumpsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_Monitor_checkConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_Monitor_publishConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_Monitor_updateConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_RuntimeInfoConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_SchedulersConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_TurboCurrentConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_TurboPowerConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_TurboPumpConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_TurboPumpTempConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_TurboSpeedConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_TurboVacConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_TurboVacGaugeConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_TurboVoltageConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_VacPlutoConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_vacuum_Vacuum_stateConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_daq_monitor_PeriodicTasksConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_daq_monitor_PeriodicTasks_timersConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_daq_monitor_Stats_StatisticsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_daq_monitor_Stats_buildConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_daq_monitor_StoreConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_daq_monitor_Store_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_daq_monitor_Store_StoreConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_Ccd_HardwareIdConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_Ccd_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_Ccd_RaftsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_ImageDatabaseServiceConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_ImageNameServiceConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_InstrumentConfig_InstrumentConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_PeriodicTasksConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_PeriodicTasks_timersConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_Raft_HardwareIdConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_Raft_RaftTempControlConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_Raft_RaftTempControlStatusConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_focal_plane_RebTotalPower_LimitsConfiguration\\) [a-z0-9]{8,}
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
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_image_handling_ImageHandler_DAQConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_image_handling_ImageHandler_FitsHandlingConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_image_handling_PeriodicTasks_GeneralConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_image_handling_PeriodicTasks_timersConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_image_handling_Reb_FitsHandlingConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_image_handling_Reb_GeneralConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_Loader_sensorConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_LockOutSensors_sensorConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_LockOutShunt_sensorConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_LpmEngineeringKeySensors_sensorConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_LpmLatchesStatus_sensorConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_LpmLinearRail1Status_sensorConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_LpmLinearRail2Status_sensorConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_LpmOnlineClampsStatus_sensorConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_OUT_AF0_Sensors_sensorConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_OUT_AF1_Sensors_sensorConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_OUT_AF3_Sensors_sensorConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_OUT_AIN_sensorConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_OUT_AOL_sensorConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_OUT_AP1_Sensors_sensorConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_OUT_AP2_Sensors_sensorConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_OUT_AP3_Sensors_sensorConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_PeriodicTasks_GeneralConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_PeriodicTasks_timersConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_Seneca1_DevicesConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_Seneca2_DevicesConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_TcpProxy_canbusConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_TcpProxy_controllerConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_TcpProxy_nodeIDConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_TcpProxy_sensorConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_TcpProxy_serialNBConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_TempCellXminus_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_TempClampMotorXminus_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_TempClampMotorXplus_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_TempClampMotorYminus_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_TempFrontBox_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_TempLinearRailMotorXminus_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_TempLinearRailMotorXplus_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fcs_TempRearBox_LimitsConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_summaryStatus\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_alertRaised\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_quadbox_BFR\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_quadbox_PDU_24VC\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_quadbox_PDU_24VD\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_quadbox_PDU_48V\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_quadbox_PDU_5V\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_quadbox_REB_Bulk_PS\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_rebpower_Reb\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_rebpower_Rebps\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_hex_Cold1\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_hex_Cold2\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_hex_Cryo1\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_hex_Cryo2\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_hex_Cryo3\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_hex_Cryo4\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_hex_Cryo5\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_hex_Cryo6\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_refrig_Cold1\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_refrig_Cold2\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_refrig_Cryo1\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_refrig_Cryo2\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_refrig_Cryo3\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_refrig_Cryo4\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_refrig_Cryo5\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_refrig_Cryo6\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vacuum_CIP1_I\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vacuum_CIP1_V\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vacuum_CIP2_I\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vacuum_CIP2_V\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vacuum_CIP3_I\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vacuum_CIP3_V\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vacuum_CIP4_I\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vacuum_CIP4_V\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vacuum_CIP5_I\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vacuum_CIP5_V\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vacuum_CIP6_I\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vacuum_CIP6_V\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vacuum_CryoVac\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vacuum_ForelineVac\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vacuum_Hex1Vac\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vacuum_Hex2Vac\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vacuum_TurboCurrent\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vacuum_TurboPower\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vacuum_TurboPumpTemp\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vacuum_TurboSpeed\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vacuum_TurboVac\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vacuum_TurboVoltage\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_daq_monitor_Store\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_focal_plane_Ccd\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_focal_plane_Reb\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_focal_plane_RebTotalPower\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_focal_plane_Segment\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_AcSensorsGateway\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_AcTruckXminus\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_AcTruckXminusController\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_AcTruckXplus\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_AcTruckXplusController\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Accelerobf\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Ai814\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Autochanger\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_AutochangerTrucks\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_BrakeSystemGateway\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Carousel\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_CarouselController\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Carrier\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_CarrierController\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_CcsVersions\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_ClampXminus1\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_ClampXminus2\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_ClampXminus3\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_ClampXminus4\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_ClampXminus5\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_ClampXminusController\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_ClampXplus1\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_ClampXplus2\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_ClampXplus3\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_ClampXplus4\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_ClampXplus5\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_ClampXplusController\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Config\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Hooks\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_HooksController\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Hyttc580\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_LatchXminus\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_LatchXminusController\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_LatchXplus\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_LatchXplusController\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Latches\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Loader\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_LoaderPlutoGateway\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_OnlineClampXminus\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_OnlineClampXminusController\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_OnlineClampXplus\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_OnlineClampXplusController\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_OnlineClampYminus\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_OnlineClampYminusController\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_OnlineClamps\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_OnlineStrainGauge\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_ProximitySensorsDevice\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Pt100\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_RuntimeInfo\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Socket1\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Socket2\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Socket3\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Socket4\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_Socket5\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_TempSensorsDevice1\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fcs_TempSensorsDevice2\\) [a-z0-9]{8,}

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
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_rebpower_Rebps.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_hex_Cold1.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_hex_Cold2.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_hex_Cryo1.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_hex_Cryo2.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_hex_Cryo3.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_hex_Cryo4.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_hex_Cryo5.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_hex_Cryo6.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_refrig_Cold1.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_refrig_Cold2.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_refrig_Cryo1.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_refrig_Cryo2.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_refrig_Cryo3.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_refrig_Cryo4.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_refrig_Cryo5.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_refrig_Cryo6.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vacuum_CIP1_I.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vacuum_CIP1_V.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vacuum_CIP2_I.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vacuum_CIP2_V.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vacuum_CIP3_I.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vacuum_CIP3_V.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vacuum_CIP4_I.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vacuum_CIP4_V.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vacuum_CIP5_I.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vacuum_CIP5_V.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vacuum_CIP6_I.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vacuum_CIP6_V.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vacuum_CryoVac.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vacuum_ForelineVac.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vacuum_Hex1Vac.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vacuum_Hex2Vac.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vacuum_TurboCurrent.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vacuum_TurboPower.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vacuum_TurboPumpTemp.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vacuum_TurboSpeed.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vacuum_TurboVac.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vacuum_TurboVoltage.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_daq_monitor_Store.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_focal_plane_Ccd.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_focal_plane_Reb.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_focal_plane_RebTotalPower.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_focal_plane_Segment.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_AcSensorsGateway.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_AcTruckXminus.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_AcTruckXminusController.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_AcTruckXplus.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_AcTruckXplusController.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Accelerobf.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Ai814.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Autochanger.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_AutochangerTrucks.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_BrakeSystemGateway.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Carousel.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_CarouselController.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Carrier.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_CarrierController.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_CcsVersions.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_ClampXminus1.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_ClampXminus2.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_ClampXminus3.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_ClampXminus4.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_ClampXminus5.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_ClampXminusController.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_ClampXplus1.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_ClampXplus2.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_ClampXplus3.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_ClampXplus4.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_ClampXplus5.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_ClampXplusController.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Config.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Hooks.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_HooksController.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Hyttc580.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_LatchXminus.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_LatchXminusController.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_LatchXplus.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_LatchXplusController.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Latches.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Loader.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_LoaderPlutoGateway.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_OnlineClampXminus.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_OnlineClampXminusController.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_OnlineClampXplus.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_OnlineClampXplusController.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_OnlineClampYminus.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_OnlineClampYminusController.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_OnlineClamps.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_OnlineStrainGauge.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_ProximitySensorsDevice.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Pt100.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_RuntimeInfo.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Socket1.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Socket2.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Socket3.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Socket4.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_Socket5.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_TempSensorsDevice1.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fcs_TempSensorsDevice2.idl
    Should Contain X Times    ${output.stdout}    javac : Done Publisher    107
    Should Contain X Times    ${output.stdout}    javac : Done Subscriber    107
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
        Set Test Variable    ${dot}    ${EMPTY}
    ELSE IF    any(item in '${Build_Number}' for item in ('pre', 'rc'))
        Set Test Variable    ${dot}    .
    ELSE
        Set Test Variable    ${dot}    ${EMPTY}
    END
    File Should Exist    ${SALWorkDir}/rpmbuild/SPECS/ts_sal_${subSystem}.spec
    File Should Exist    ${SALWorkDir}/rpmbuild/SOURCES/${subSystem}-${XMLVersionBase}.tgz
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/ts_sal_runtime-${XMLVersionBase}-${SALVersionBase}*${DIST}.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/ts_sal_ATruntime-${XMLVersionBase}-${SALVersionBase}*${DIST}.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/ts_sal_utils-${SALVersionBase}-1.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/${subSystem}-${XMLVersionBase}-${SALVersionBase}${dot}${Build_Number}${DIST}.x86_64.rpm
    Should Not Contain    ${output.stdout}    child process exited abnormally

Verify MTCamera RPM Contents
    [Documentation]    Verify the ${subSystem} RPM contains all the expected libraries
    [Tags]    rpm
    Comment    Re-run the {dot} process, so this test case can run independently.
    IF    "${Build_Number}" == ""
        Set Test Variable    ${dot}    ${EMPTY}
    ELSE IF    any(item in '${Build_Number}' for item in ('pre', 'rc'))
        Set Test Variable    ${dot}    .
    ELSE
        Set Test Variable    ${dot}    ${EMPTY}
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

