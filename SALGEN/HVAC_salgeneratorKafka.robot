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
    [Tags]    validate
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
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_deviceEnabled.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_chillerConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_crackConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fancoilConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_manejadoraConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_manejadoraLowerConfiguration.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_dynCH1PressRemoteSP.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_dynCH2PressRemoteSP.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_dynSystOnOff.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_dynTaRemoteSP.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_dynTmaRemoteSP.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_dynExtAirRemoteSP.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_dynPierFansOnOff.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_dynTelemetryEnable.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_dynaleneState.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_dynaleneTankLevel.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_dynTMAalarm.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_dynTMAalarmCMD.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_dynTMAalarmMonitor.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_dynTAalarm.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_dynTAalarmCMD.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_dynTAalarmMonitor.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_dynMainGridAlarm.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_dynMainGridAlarmCMD.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_dynMainGridFailureFlag.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_dynTankLevelAlarmCMD.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_dynSafetyResetFlag.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_dynSysFault.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_dynSysWarning.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_dynSysOK.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_dynRemoteLocalModeStatus.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_dynAmbientDeltaModeStatus.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_dynExhaustAirBackupModeStatus.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_chiller01P01.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_chiller02P01.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_chiller03P01.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_crack01P02.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_crack02P02.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fancoil01P02.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fancoil02P02.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fancoil03P02.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fancoil04P02.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fancoil05P02.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fancoil06P02.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fancoil07P02.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fancoil08P02.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fancoil09P02.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fancoil10P02.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fancoil11P02.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_fancoil12P02.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_manejadoraSblancaP04.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_manejadoraSlimpiaP04.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_manejadoraLower01P05.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_manejadoraLower02P05.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_manejadoraLower03P05.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_manejadoraLower04P05.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_bombaAguaFriaP01.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_chiller01P01.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_chiller02P01.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_chiller03P01.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_generalP01.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_glycolSensor.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_valvulaP01.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_vea01P01.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_vec01P01.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_vin01P01.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_crack01P02.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_crack02P02.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fancoil01P02.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fancoil02P02.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fancoil03P02.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fancoil04P02.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fancoil05P02.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fancoil06P02.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fancoil07P02.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fancoil08P02.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fancoil09P02.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fancoil10P02.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fancoil11P02.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_fancoil12P02.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_manejadoraSblancaP04.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_manejadoraSlimpiaP04.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_vex03LowerP04.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_vex04CargaP04.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_dynaleneP05.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_manejadoraLower01P05.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_manejadoraLower02P05.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_manejadoraLower03P05.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_manejadoraLower04P05.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_vea01P05.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_vea08P05.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_vea09P05.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_vea10P05.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_vea11P05.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_vea12P05.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_vea13P05.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_vea14P05.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_vea15P05.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_vea16P05.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_vea17P05.json/

Salgen HVAC Lib
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

Cleanup stdout and stderr Files
    [Tags]
    Remove Files    ${EXECDIR}${/}${subSystem}_stdout.txt    ${EXECDIR}${/}${subSystem}_stderr.txt

