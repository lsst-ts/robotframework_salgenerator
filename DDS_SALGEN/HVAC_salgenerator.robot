*** Settings ***
Documentation    This suite builds the various interfaces for the HVAC.
Force Tags    salgen    hvac
Suite Setup    Log Many    ${Host}    ${subSystem}    ${timeout}
Library    OperatingSystem
Library    Process
Resource    ../Global_Vars.resource

*** Variables ***
${subSystem}    HVAC
${timeout}    1200s

*** Test Cases ***
Verify HVAC XML Defintions exist
    [Tags]
    Comment    Verify the CSC XML definition files exist.
    ${output}    Run Process    ls     ${SALWorkDir}/${subSystem}_*xml    shell=True
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Be Empty    ${output.stdout}
    File Should Exist    ${SALWorkDir}/HVAC_Commands.xml
    File Should Exist    ${SALWorkDir}/HVAC_Events.xml
    File Should Exist    ${SALWorkDir}/HVAC_Telemetry.xml

Salgen HVAC Validate
    [Documentation]    Validate the HVAC XML definitions.
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
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_bombaAguaFriaP01.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_chiller01P01.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_chiller02P01.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_chiller03P01.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_generalP01.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_glycolSensor.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_valvulaP01.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vea01P01.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vec01P01.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vin01P01.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_crack01P02.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_crack02P02.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fancoil01P02.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fancoil02P02.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fancoil03P02.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fancoil04P02.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fancoil05P02.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fancoil06P02.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fancoil07P02.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fancoil08P02.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fancoil09P02.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fancoil10P02.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fancoil11P02.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fancoil12P02.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_manejadoraSblancaP04.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_manejadoraSlimpiaP04.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vex03LowerP04.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vex04CargaP04.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_dynaleneP05.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_manejadoraLower01P05.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_manejadoraLower02P05.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_manejadoraLower03P05.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_manejadoraLower04P05.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vea01P05.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vea08P05.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vea09P05.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vea10P05.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vea11P05.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vea12P05.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vea13P05.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vea14P05.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vea15P05.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vea16P05.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vea17P05.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_disable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_exitControl.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_setLogLevel.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_standby.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_start.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_enableDevice.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_disableDevice.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_configChillers.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_configCracks.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_configFancoils.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_configManejadoras.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_configManejadoraLowers.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_dynCH1PressRemoteSP.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_dynCH2PressRemoteSP.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_dynSystOnOff.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_dynTaRemoteSP.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_dynTmaRemoteSP.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_dynExtAirRemoteSP.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_dynPierFansOnOff.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_dynTelemetryEnable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_heartbeat.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_logLevel.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_logMessage.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_softwareVersions.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_errorCode.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_simulationMode.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_summaryState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_deviceEnabled.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_chillerConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_crackConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fancoilConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_manejadoraConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_manejadoraLowerConfiguration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_dynCH1PressRemoteSP.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_dynCH2PressRemoteSP.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_dynSystOnOff.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_dynTaRemoteSP.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_dynTmaRemoteSP.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_dynExtAirRemoteSP.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_dynPierFansOnOff.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_dynTelemetryEnable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_dynaleneState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_dynaleneTankLevel.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_dynTMAalarm.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_dynTMAalarmCMD.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_dynTMAalarmMonitor.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_dynTAalarm.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_dynTAalarmCMD.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_dynTAalarmMonitor.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_dynMainGridAlarm.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_dynMainGridAlarmCMD.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_dynMainGridFailureFlag.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_dynTankLevelAlarmCMD.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_dynSafetyResetFlag.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_dynSysFault.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_dynSysWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_dynSysOK.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_dynRemoteLocalModeStatus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_dynAmbientDeltaModeStatus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_dynExhaustAirBackupModeStatus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_chiller01P01.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_chiller02P01.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_chiller03P01.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_crack01P02.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_crack02P02.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fancoil01P02.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fancoil02P02.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fancoil03P02.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fancoil04P02.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fancoil05P02.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fancoil06P02.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fancoil07P02.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fancoil08P02.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fancoil09P02.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fancoil10P02.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fancoil11P02.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_fancoil12P02.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_manejadoraSblancaP04.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_manejadoraSlimpiaP04.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_manejadoraLower01P05.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_manejadoraLower02P05.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_manejadoraLower03P05.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_manejadoraLower04P05.idl

Verify HVAC revCodes File
    [Documentation]    Ensure HVAC_revCodes.tcl contains 1 revcode per topic.
    [Tags]    doc    
    ${output}=    Log File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_disable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_enable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_exitControl\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_setLogLevel\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_standby\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_start\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_enableDevice\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_disableDevice\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_configChillers\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_configCracks\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_configFancoils\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_configManejadoras\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_configManejadoraLowers\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_dynCH1PressRemoteSP\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_dynCH2PressRemoteSP\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_dynSystOnOff\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_dynTaRemoteSP\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_dynTmaRemoteSP\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_dynExtAirRemoteSP\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_dynPierFansOnOff\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_dynTelemetryEnable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_heartbeat\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_logLevel\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_logMessage\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_softwareVersions\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_errorCode\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_simulationMode\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_summaryState\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_deviceEnabled\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_chillerConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_crackConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fancoilConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_manejadoraConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_manejadoraLowerConfiguration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_dynCH1PressRemoteSP\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_dynCH2PressRemoteSP\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_dynSystOnOff\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_dynTaRemoteSP\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_dynTmaRemoteSP\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_dynExtAirRemoteSP\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_dynPierFansOnOff\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_dynTelemetryEnable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_dynaleneState\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_dynaleneTankLevel\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_dynTMAalarm\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_dynTMAalarmCMD\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_dynTMAalarmMonitor\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_dynTAalarm\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_dynTAalarmCMD\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_dynTAalarmMonitor\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_dynMainGridAlarm\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_dynMainGridAlarmCMD\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_dynMainGridFailureFlag\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_dynTankLevelAlarmCMD\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_dynSafetyResetFlag\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_dynSysFault\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_dynSysWarning\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_dynSysOK\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_dynRemoteLocalModeStatus\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_dynAmbientDeltaModeStatus\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_dynExhaustAirBackupModeStatus\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_chiller01P01\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_chiller02P01\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_chiller03P01\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_crack01P02\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_crack02P02\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fancoil01P02\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fancoil02P02\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fancoil03P02\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fancoil04P02\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fancoil05P02\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fancoil06P02\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fancoil07P02\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fancoil08P02\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fancoil09P02\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fancoil10P02\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fancoil11P02\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_fancoil12P02\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_manejadoraSblancaP04\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_manejadoraSlimpiaP04\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_manejadoraLower01P05\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_manejadoraLower02P05\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_manejadoraLower03P05\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_manejadoraLower04P05\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_bombaAguaFriaP01\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_chiller01P01\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_chiller02P01\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_chiller03P01\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_generalP01\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_glycolSensor\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_valvulaP01\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vea01P01\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vec01P01\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vin01P01\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_crack01P02\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_crack02P02\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fancoil01P02\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fancoil02P02\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fancoil03P02\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fancoil04P02\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fancoil05P02\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fancoil06P02\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fancoil07P02\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fancoil08P02\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fancoil09P02\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fancoil10P02\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fancoil11P02\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fancoil12P02\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_manejadoraSblancaP04\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_manejadoraSlimpiaP04\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vex03LowerP04\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vex04CargaP04\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_dynaleneP05\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_manejadoraLower01P05\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_manejadoraLower02P05\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_manejadoraLower03P05\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_manejadoraLower04P05\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vea01P05\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vea08P05\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vea09P05\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vea10P05\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vea11P05\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vea12P05\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vea13P05\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vea14P05\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vea15P05\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vea16P05\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vea17P05\\) [a-z0-9]{8,}

Salgen HVAC IDL
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

Salgen HVAC Lib
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

Salgen HVAC RPM
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
    File Should Exist    ${SALWorkDir}/rpmbuild/SPECS/ts_sal_${subSystem}_dds.spec
    File Should Exist    ${SALWorkDir}/rpmbuild/SOURCES/${subSystem}_dds-${XMLVersionBase}${sep}${Build_Number}.tgz
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/ts_sal_runtime_dds-${XMLVersionBase}${sep}${Build_Number}-${SALVersionBase}*${DIST}.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/ts_sal_ATruntime_dds-${XMLVersionBase}${sep}${Build_Number}-${SALVersionBase}*${DIST}.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/ts_sal_utils_dds-${SALVersionBase}-1.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/${subSystem}_dds-${XMLVersionBase}${sep}${Build_Number}-${SALVersionBase}${DIST}.x86_64.rpm
    Should Not Contain    ${output.stdout}    child process exited abnormally

Verify HVAC RPM Contents
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
    ${output}=    Run Process    rpm    -qpl    ${subSystem}_dds-${XMLVersionBase}${sep}${Build_Number}-${SALVersionBase}${DIST}.x86_64.rpm    cwd=${SALWorkDir}/rpmbuild/RPMS/x86_64
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

