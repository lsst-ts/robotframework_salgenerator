*** Settings ***
Documentation    This suite builds the various interfaces for the HVAC.
Force Tags    salgen    
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
    ${output}    Run Process    ls     ${SALWorkDir}/HVAC_*.xml    shell=True
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stderr}    No such file or directory    msg="HVAC has no XML defintions"    values=False
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
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_abort.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_disable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_standby.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_exitControl.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_start.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_enterControl.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_setLogLevel.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_setValue.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_setAuthList.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_chiller01P01_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_chiller01P01_config.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_chiller02P01_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_chiller02P01_config.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_chiller03P01_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_chiller03P01_config.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_vea01P01_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_vec01P01_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_vin01P01_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_crack01P02_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_crack01P02_config.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_crack02P02_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_crack02P02_config.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_fancoil01P02_config.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_fancoil01P02_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_fancoil02P02_config.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_fancoil02P02_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_fancoil03P02_config.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_fancoil03P02_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_fancoil04P02_config.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_fancoil04P02_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_fancoil05P02_config.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_fancoil05P02_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_fancoil06P02_config.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_fancoil06P02_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_fancoil07P02_config.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_fancoil07P02_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_fancoil08P02_config.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_fancoil08P02_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_fancoil09P02_config.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_fancoil09P02_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_fancoil10P02_config.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_fancoil10P02_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_fancoil11P02_config.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_fancoil11P02_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_fancoil12P02_config.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_fancoil12P02_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_manejadoraSblancaP04_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_manejadoraSblancaP04_config.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_manejadoraSlimpiaP04_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_manejadoraSlimpiaP04_config.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_vex03LowerP04_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_vex04CargaP04_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_manejadoraLower01P05_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_manejadoraLower01P05_config.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_manejadoraLower02P05_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_manejadoraLower02P05_config.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_manejadoraLower03P05_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_manejadoraLower03P05_config.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_manejadoraLower04P05_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_manejadoraLower04P05_config.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_vea01P05_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_vea08P05_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_vea09P05_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_vea10P05_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_vea11P05_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_vea12P05_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_vea13P05_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_vea14P05_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_vea15P05_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_vea16P05_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_vea17P05_enable.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_settingVersions.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_errorCode.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_summaryState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_appliedSettingsMatchStart.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_logLevel.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_logMessage.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_settingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_simulationMode.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_softwareVersions.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_heartbeat.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_authList.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_detailedState.idl

Verify HVAC revCodes File
    [Documentation]    Ensure HVAC_revCodes.tcl contains 1 revcode per topic.
    [Tags]    html    
    ${output}=    Log File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_abort\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_enable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_disable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_standby\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_exitControl\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_start\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_enterControl\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_setLogLevel\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_setValue\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_setAuthList\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_chiller01P01_enable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_chiller01P01_config\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_chiller02P01_enable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_chiller02P01_config\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_chiller03P01_enable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_chiller03P01_config\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_vea01P01_enable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_vec01P01_enable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_vin01P01_enable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_crack01P02_enable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_crack01P02_config\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_crack02P02_enable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_crack02P02_config\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_fancoil01P02_config\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_fancoil01P02_enable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_fancoil02P02_config\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_fancoil02P02_enable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_fancoil03P02_config\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_fancoil03P02_enable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_fancoil04P02_config\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_fancoil04P02_enable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_fancoil05P02_config\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_fancoil05P02_enable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_fancoil06P02_config\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_fancoil06P02_enable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_fancoil07P02_config\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_fancoil07P02_enable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_fancoil08P02_config\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_fancoil08P02_enable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_fancoil09P02_config\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_fancoil09P02_enable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_fancoil10P02_config\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_fancoil10P02_enable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_fancoil11P02_config\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_fancoil11P02_enable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_fancoil12P02_config\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_fancoil12P02_enable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_manejadoraSblancaP04_enable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_manejadoraSblancaP04_config\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_manejadoraSlimpiaP04_enable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_manejadoraSlimpiaP04_config\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_vex03LowerP04_enable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_vex04CargaP04_enable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_manejadoraLower01P05_enable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_manejadoraLower01P05_config\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_manejadoraLower02P05_enable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_manejadoraLower02P05_config\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_manejadoraLower03P05_enable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_manejadoraLower03P05_config\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_manejadoraLower04P05_enable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_manejadoraLower04P05_config\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_vea01P05_enable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_vea08P05_enable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_vea09P05_enable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_vea10P05_enable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_vea11P05_enable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_vea12P05_enable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_vea13P05_enable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_vea14P05_enable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_vea15P05_enable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_vea16P05_enable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_vea17P05_enable\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_settingVersions\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_errorCode\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_summaryState\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_appliedSettingsMatchStart\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_logLevel\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_logMessage\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_settingsApplied\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_simulationMode\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_softwareVersions\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_heartbeat\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_authList\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_detailedState\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_bombaAguaFriaP01\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_chiller01P01\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_chiller02P01\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_chiller03P01\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_generalP01\\) [a-z0-9]{8,}
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
    File Should Exist    /tmp/makerpm_${subSystem}_test.log
    File Should Exist    /tmp/makerpm-utils.log
    Log File    /tmp/makerpm_${subSystem}.log
    Log File    /tmp/makerpm_${subSystem}_test.log
    Log File    /tmp/makerpm-utils.log
    Should Not Contain    ${output.stdout}    ERROR : Asset required for rpm
    Should Not Contain    ${output.stdout}    child process exited abnormally
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
    Run Keyword If    "${Build_Number}" == ""
    ...    Set Test Variable    ${dot}    ${EMPTY}
    Run Keyword Unless    "${Build_Number}" == ""
    ...    Set Test Variable    ${dot}    .
    File Should Exist    ${SALWorkDir}/rpmbuild/SPECS/ts_sal_${subSystem}.spec
    File Should Exist    ${SALWorkDir}/rpmbuild/SOURCES/${subSystem}-${XMLVersion}.tgz
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/ts_sal_runtime-${XMLVersion}-${SALVersion}${dot}${Build_Number}${DIST}.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/ts_sal_ATruntime-${XMLVersion}-${SALVersion}${dot}${Build_Number}${DIST}.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/ts_sal_utils-${SALVersion}-1.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/${subSystem}-${XMLVersion}-${SALVersion}${dot}${Build_Number}${DIST}.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/${subSystem}_test-${XMLVersion}-${SALVersion}${dot}${Build_Number}${DIST}.x86_64.rpm

Cleanup stdout and stderr Files
    [Tags]
    Remove Files    ${EXECDIR}${/}${subSystem}_stdout.txt    ${EXECDIR}${/}${subSystem}_stderr.txt

