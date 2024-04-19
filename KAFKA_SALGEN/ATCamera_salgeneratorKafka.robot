*** Settings ***
Documentation    This suite builds the various interfaces for the ATCamera.
Force Tags    salgen    atcamera
Suite Setup    Log Many    ${Host}    ${subSystem}    ${timeout}
Library    OperatingSystem
Library    Process
Resource    ../Global_Vars.resource

*** Variables ***
${subSystem}    ATCamera
${timeout}    1200s

*** Test Cases ***
Verify ATCamera XML Defintions exist
    [Tags]    validate
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
    ${output}=    Run Process    ${SALHome}/bin/salgeneratorKafka    ${subSystem}    validate    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    XMLVERSION = ${XMLVersion}
    Should Contain    ${output.stdout}    Processing ${subSystem}
    Should Contain    ${output.stdout}    Completed ${subSystem} validation
    Directory Should Exist    ${SALWorkDir}/avro-templates
    @{files}=    List Directory    ${SALWorkDir}/avro-templates
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}_cmddef.tcl
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}_evtdef.tcl
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}_tlmdef.tcl
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}_metadata.tcl
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}_revCodes.tcl
    Directory Should Exist    ${SALWorkDir}/avro-templates/${subSystem}
    @{files}=    List Directory    ${SALWorkDir}/avro-templates/${subSystem}
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_Commands.xml
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_Events.xml
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_Generics.xml
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_Telemetry.xml
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
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_notReadyToTakeImage.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_startShutterClose.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_endShutterClose.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_endOfImageTelemetry.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_calibrationDetailedState.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_shutterDetailedState.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_readyToTakeImage.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_ccsCommandState.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_prepareToTakeImage.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_endShutterOpen.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_startIntegration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_startShutterOpen.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_raftsDetailedState.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_startReadout.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_shutterMotionProfile.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_imageReadoutParameters.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focalPlaneSummaryInfo.json
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
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_SequencerConfig_DAQConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_SequencerConfig_GuiderConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_SequencerConfig_SequencerConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_focal_plane_WebHooksConfig_VisualizationConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_daq_monitor_PeriodicTasks_GeneralConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_daq_monitor_PeriodicTasks_timersConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_daq_monitor_Stats_StatisticsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_daq_monitor_StoreConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_daq_monitor_Store_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_daq_monitor_Store_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_daq_monitor_Store_StoreConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_ats_power_Analog_I_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_ats_power_Analog_V_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_ats_power_Aux_I_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_ats_power_Aux_V_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_ats_power_ClkHigh_I_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_ats_power_ClkHigh_V_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_ats_power_ClkLow_I_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_ats_power_ClkLow_V_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_ats_power_DPHI_I_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_ats_power_DPHI_V_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_ats_power_Digital_I_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_ats_power_Digital_V_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_ats_power_Fan_I_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_ats_power_Fan_V_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_ats_power_HVBias_I_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_ats_power_HVBias_V_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_ats_power_Hameg1_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_ats_power_Hameg1_PowerConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_ats_power_Hameg2_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_ats_power_Hameg2_PowerConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_ats_power_Hameg3_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_ats_power_Hameg3_PowerConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_ats_power_Keithley_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_ats_power_Keithley_PowerConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_ats_power_OD_I_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_ats_power_OD_V_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_ats_power_OTM_I_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_ats_power_OTM_V_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_ats_power_PeriodicTasks_GeneralConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_ats_power_PeriodicTasks_timersConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_ats_CryoCon_DeviceConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_ats_CryoCon_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_ats_PeriodicTasks_GeneralConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_ats_PeriodicTasks_timersConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_ats_Pfeiffer_DeviceConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_ats_Pfeiffer_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_ats_TempCCDSetPoint_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_ats_TempCCD_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_ats_TempColdPlate_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_ats_TempCryoHead_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_ats_Vacuum_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_bonn_shutter_Device_DevicesConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_bonn_shutter_Device_GeneralConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_bonn_shutter_Device_LimitsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_bonn_shutter_GeneralConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_bonn_shutter_PeriodicTasks_GeneralConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_bonn_shutter_PeriodicTasks_timersConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_image_handling_FitsService_GeneralConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_image_handling_ImageHandler_CommandsConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_image_handling_ImageHandler_DAQConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_image_handling_ImageHandler_FitsHandlingConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_image_handling_ImageHandler_GuiderConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_image_handling_PeriodicTasks_GeneralConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_image_handling_PeriodicTasks_timersConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_image_handling_StatusAggregator_GeneralConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_shutterBladeMotionProfile.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_imageStored.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fitsFilesWritten.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fileCommandExecution.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_imageVisualization.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_summaryStatus.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_alertRaised.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_focal_plane_Ccd.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_focal_plane_Reb.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_focal_plane_RebTotalPower.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_focal_plane_RebsAverageTemp6.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_daq_monitor_Reb_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_daq_monitor_Store.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_daq_monitor_Sum_Trending.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_power.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_vacuum.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_bonn_shutter_Device.json/

Salgen ATCamera Java
    [Documentation]    Generate Java libraries.
    [Tags]    java
    ${output}=    Run Process    ${SALHome}/bin/salgeneratorKafka    ${subSystem}    sal    java    version\=${MavenVersion}    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stdout}    ERROR : Failed to generate*saj_*_types.jar 
    Should Not Contain    ${output.stdout}    error: package org.apache.avro* does not exist
    Should Not Contain    ${output.stdout}    error: package org.apache.kafka* does not exist
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    XMLVERSION = ${XMLVersion}
    Should Contain    ${output.stdout}    Generating java type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating java type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating java type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating java type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating java type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating java type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating java type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating java type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating java type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating java type support for ${subSystem}
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/saj_${subSystem}_types.jar
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/org/lsst/sal/SAL_${subSystem}.java
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/org/lsst/sal/salActor.java
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/org/lsst/sal/salUtils.java
    File Should Exist    ${SALWorkDir}/salUtils/libsalUtils.so

Salgen ATCamera Maven
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

Salgen ATCamera Lib
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
    File Should Exist    ${SALWorkDir}/lib/saj_${subSystem}_types.jar

Salgen ATCamera RPM
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
    Should Not Contain    ${output.stdout}    child process exited abnormally

Verify ATCamera RPM Contents
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

