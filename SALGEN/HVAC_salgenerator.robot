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
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vea01P01.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vin01P01.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vec01P01.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_bombaAguaFriaP01.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_valvulaP01.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_temperatuaAmbienteP01.idl
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
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vea03P04.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vea04P04.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vex03P04.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_vex04P04.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_damperLowerP04.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_zonaCargaP04.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_chiller01P01.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_crack01P02.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fancoil01P02.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_manejadoraLower01P05.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_manejadoraSblancaP04.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_manejadraSblancaP04.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_manejadoraSlimpiaP04.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_manejadoraZzzP04.idl
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
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_vea01P01.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_vin01P01.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_vec01P01.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_vea01P05.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_vea08P05.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_vea09P05.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_vea10P05.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_vea11P05.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_vea12P05.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_vea13P05.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_vea14P05.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_vea15P05.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_vea16P05.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_vea17P05.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_vex03P04.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_vex04P04.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_chiller01P01.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_crack01P02.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_fancoil01P02.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_manejadoraLower01P05.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_manejadoraSblancaP04.idl
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
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_vea01P01\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_vin01P01\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_vec01P01\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_vea01P05\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_vea08P05\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_vea09P05\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_vea10P05\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_vea11P05\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_vea12P05\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_vea13P05\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_vea14P05\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_vea15P05\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_vea16P05\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_vea17P05\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_vex03P04\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_vex04P04\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_chiller01P01\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_crack01P02\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_fancoil01P02\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_manejadoraLower01P05\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_manejadoraSblancaP04\\) [a-z0-9]{8,}
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
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vea01P01\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vin01P01\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vec01P01\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_bombaAguaFriaP01\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_valvulaP01\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_temperatuaAmbienteP01\\) [a-z0-9]{8,}
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
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vea03P04\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vea04P04\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vex03P04\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_vex04P04\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_damperLowerP04\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_zonaCargaP04\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_chiller01P01\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_crack01P02\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_fancoil01P02\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_manejadoraLower01P05\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_manejadoraSblancaP04\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_manejadraSblancaP04\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_manejadoraSlimpiaP04\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_manejadoraZzzP04\\) [a-z0-9]{8,}

Salgen HVAC IDL
    [Documentation]    Generate the revCoded IDL for ${subSystem}
    [Tags]    idl
    ${output}=    Run Process    ${SALHome}/bin/salgenerator    ${subSystem}    sal    idl    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    XMLVERSION = ${XMLVersion}
    Should Contain    ${output.stdout}    Completed ${subSystem} validation
    File Should Exist    ${SALWorkDir}/${subSystem}/sal_revCoded_${subSystem}.idl
    @{files}=    List Directory    ${SALWorkDir}/idl-templates/validated/
    Log Many    @{files}

Salgen HVAC C++
    [Documentation]    Generate C++ libraries.
    [Tags]    cpp
    ${output}=    Run Process    ${SALHome}/bin/salgenerator    ${subSystem}    sal    cpp   shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stdout}    *** DDS error in file
    Should Not Contain    ${output.stdout}    Error 1
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    XMLVERSION = ${XMLVersion}
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_vea01P01.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_vin01P01.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_vec01P01.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_bombaAguaFriaP01.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_valvulaP01.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_temperatuaAmbienteP01.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_vea01P05.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_vea08P05.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_vea09P05.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_vea10P05.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_vea11P05.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_vea12P05.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_vea13P05.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_vea14P05.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_vea15P05.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_vea16P05.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_vea17P05.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_vea03P04.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_vea04P04.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_vex03P04.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_vex04P04.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_damperLowerP04.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_zonaCargaP04.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_chiller01P01.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_crack01P02.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_fancoil01P02.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_manejadoraLower01P05.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_manejadoraSblancaP04.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_manejadraSblancaP04.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_manejadoraSlimpiaP04.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_manejadoraZzzP04.idl
    Should Contain X Times    ${output.stdout}    cpp : Done Publisher    31
    Should Contain X Times    ${output.stdout}    cpp : Done Subscriber    31
    Should Contain X Times    ${output.stdout}    cpp : Done Commander    1
    Should Contain X Times    ${output.stdout}    cpp : Done Event/Logger    1

Verify C++ Directories
    [Documentation]    Ensure expected C++ directories and files are created.
    [Tags]    cpp
    Directory Should Exist    ${SALWorkDir}/${subSystem}/cpp
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/cpp    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/libsacpp_${subSystem}_types.so
    Directory Should Exist    ${SALWorkDir}/idl-templates/validated/sal
    @{files}=    List Directory    ${SALWorkDir}/idl-templates/validated/sal    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/idl-templates/validated/sal/sal_${subSystem}.idl

Verify HVAC Telemetry directories
    [Tags]    cpp
    @{files}=    List Directory    ${SALWorkDir}    pattern=*${subSystem}*
    Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/${subSystem}_vea01P01
    Directory Should Exist    ${SALWorkDir}/${subSystem}_vin01P01
    Directory Should Exist    ${SALWorkDir}/${subSystem}_vec01P01
    Directory Should Exist    ${SALWorkDir}/${subSystem}_bombaAguaFriaP01
    Directory Should Exist    ${SALWorkDir}/${subSystem}_valvulaP01
    Directory Should Exist    ${SALWorkDir}/${subSystem}_temperatuaAmbienteP01
    Directory Should Exist    ${SALWorkDir}/${subSystem}_vea01P05
    Directory Should Exist    ${SALWorkDir}/${subSystem}_vea08P05
    Directory Should Exist    ${SALWorkDir}/${subSystem}_vea09P05
    Directory Should Exist    ${SALWorkDir}/${subSystem}_vea10P05
    Directory Should Exist    ${SALWorkDir}/${subSystem}_vea11P05
    Directory Should Exist    ${SALWorkDir}/${subSystem}_vea12P05
    Directory Should Exist    ${SALWorkDir}/${subSystem}_vea13P05
    Directory Should Exist    ${SALWorkDir}/${subSystem}_vea14P05
    Directory Should Exist    ${SALWorkDir}/${subSystem}_vea15P05
    Directory Should Exist    ${SALWorkDir}/${subSystem}_vea16P05
    Directory Should Exist    ${SALWorkDir}/${subSystem}_vea17P05
    Directory Should Exist    ${SALWorkDir}/${subSystem}_vea03P04
    Directory Should Exist    ${SALWorkDir}/${subSystem}_vea04P04
    Directory Should Exist    ${SALWorkDir}/${subSystem}_vex03P04
    Directory Should Exist    ${SALWorkDir}/${subSystem}_vex04P04
    Directory Should Exist    ${SALWorkDir}/${subSystem}_damperLowerP04
    Directory Should Exist    ${SALWorkDir}/${subSystem}_zonaCargaP04
    Directory Should Exist    ${SALWorkDir}/${subSystem}_chiller01P01
    Directory Should Exist    ${SALWorkDir}/${subSystem}_crack01P02
    Directory Should Exist    ${SALWorkDir}/${subSystem}_fancoil01P02
    Directory Should Exist    ${SALWorkDir}/${subSystem}_manejadoraLower01P05
    Directory Should Exist    ${SALWorkDir}/${subSystem}_manejadoraSblancaP04
    Directory Should Exist    ${SALWorkDir}/${subSystem}_manejadraSblancaP04
    Directory Should Exist    ${SALWorkDir}/${subSystem}_manejadoraSlimpiaP04
    Directory Should Exist    ${SALWorkDir}/${subSystem}_manejadoraZzzP04

Verify HVAC C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}_vea01P01/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_vea01P01/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_vin01P01/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_vin01P01/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_vec01P01/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_vec01P01/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_bombaAguaFriaP01/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_bombaAguaFriaP01/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_valvulaP01/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_valvulaP01/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_temperatuaAmbienteP01/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_temperatuaAmbienteP01/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_vea01P05/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_vea01P05/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_vea08P05/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_vea08P05/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_vea09P05/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_vea09P05/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_vea10P05/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_vea10P05/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_vea11P05/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_vea11P05/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_vea12P05/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_vea12P05/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_vea13P05/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_vea13P05/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_vea14P05/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_vea14P05/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_vea15P05/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_vea15P05/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_vea16P05/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_vea16P05/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_vea17P05/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_vea17P05/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_vea03P04/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_vea03P04/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_vea04P04/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_vea04P04/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_vex03P04/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_vex03P04/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_vex04P04/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_vex04P04/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_damperLowerP04/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_damperLowerP04/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_zonaCargaP04/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_zonaCargaP04/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_chiller01P01/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_chiller01P01/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_crack01P02/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_crack01P02/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_fancoil01P02/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_fancoil01P02/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_manejadoraLower01P05/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_manejadoraLower01P05/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_manejadoraSblancaP04/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_manejadoraSblancaP04/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_manejadraSblancaP04/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_manejadraSblancaP04/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_manejadoraSlimpiaP04/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_manejadoraSlimpiaP04/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_manejadoraZzzP04/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_manejadoraZzzP04/cpp/standalone/sacpp_${subSystem}_sub

Verify HVAC C++ Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_abort_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_abort_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enable_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enable_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_disable_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_disable_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_standby_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_standby_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_exitControl_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_exitControl_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_start_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_start_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enterControl_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enterControl_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setLogLevel_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setLogLevel_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setValue_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setValue_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setAuthList_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setAuthList_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_vea01P01_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_vea01P01_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_vin01P01_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_vin01P01_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_vec01P01_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_vec01P01_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_vea01P05_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_vea01P05_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_vea08P05_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_vea08P05_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_vea09P05_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_vea09P05_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_vea10P05_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_vea10P05_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_vea11P05_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_vea11P05_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_vea12P05_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_vea12P05_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_vea13P05_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_vea13P05_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_vea14P05_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_vea14P05_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_vea15P05_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_vea15P05_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_vea16P05_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_vea16P05_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_vea17P05_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_vea17P05_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_vex03P04_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_vex03P04_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_vex04P04_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_vex04P04_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_chiller01P01_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_chiller01P01_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_crack01P02_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_crack01P02_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_fancoil01P02_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_fancoil01P02_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_manejadoraLower01P05_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_manejadoraLower01P05_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_manejadoraSblancaP04_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_manejadoraSblancaP04_controller

Verify HVAC C++ Event Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_settingVersions_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_settingVersions_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_errorCode_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_errorCode_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_summaryState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_summaryState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedSettingsMatchStart_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_appliedSettingsMatchStart_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_logLevel_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_logLevel_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_logMessage_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_logMessage_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_settingsApplied_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_settingsApplied_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_simulationMode_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_simulationMode_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_softwareVersions_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_softwareVersions_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_heartbeat_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_heartbeat_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_authList_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_authList_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_detailedState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_detailedState_log

Salgen HVAC Python
    [Documentation]    Generate Python libraries.
    [Tags]    python
    ${output}=    Run Process    ${SALHome}/bin/salgenerator    ${subSystem}    sal    python    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    XMLVERSION = ${XMLVersion}
    Should Contain    ${output.stdout}    Generating Python SAL support for ${subSystem}
    Should Contain    ${output.stdout}    Generating Python bindings
    Should Contain    ${output.stdout}    python : Done SALPY_${subSystem}.so
    Directory Should Exist    ${SALWorkDir}/${subSystem}/python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/SALPY_${subSystem}.so

Verify HVAC Python Telemetry Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_vea01P01_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_vea01P01_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_vin01P01_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_vin01P01_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_vec01P01_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_vec01P01_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_bombaAguaFriaP01_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_bombaAguaFriaP01_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_valvulaP01_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_valvulaP01_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_temperatuaAmbienteP01_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_temperatuaAmbienteP01_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_vea01P05_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_vea01P05_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_vea08P05_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_vea08P05_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_vea09P05_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_vea09P05_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_vea10P05_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_vea10P05_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_vea11P05_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_vea11P05_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_vea12P05_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_vea12P05_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_vea13P05_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_vea13P05_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_vea14P05_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_vea14P05_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_vea15P05_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_vea15P05_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_vea16P05_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_vea16P05_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_vea17P05_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_vea17P05_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_vea03P04_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_vea03P04_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_vea04P04_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_vea04P04_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_vex03P04_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_vex03P04_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_vex04P04_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_vex04P04_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_damperLowerP04_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_damperLowerP04_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_zonaCargaP04_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_zonaCargaP04_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_chiller01P01_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_chiller01P01_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_crack01P02_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_crack01P02_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_fancoil01P02_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_fancoil01P02_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_manejadoraLower01P05_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_manejadoraLower01P05_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_manejadoraSblancaP04_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_manejadoraSblancaP04_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_manejadraSblancaP04_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_manejadraSblancaP04_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_manejadoraSlimpiaP04_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_manejadoraSlimpiaP04_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_manejadoraZzzP04_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_manejadoraZzzP04_Subscriber.py

Verify HVAC Python Command Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_abort.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_abort.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_enable.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_enable.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_disable.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_disable.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_standby.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_standby.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_exitControl.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_exitControl.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_start.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_start.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_enterControl.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_enterControl.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_setLogLevel.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_setLogLevel.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_setValue.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_setValue.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_setAuthList.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_setAuthList.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_vea01P01.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_vea01P01.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_vin01P01.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_vin01P01.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_vec01P01.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_vec01P01.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_vea01P05.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_vea01P05.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_vea08P05.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_vea08P05.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_vea09P05.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_vea09P05.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_vea10P05.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_vea10P05.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_vea11P05.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_vea11P05.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_vea12P05.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_vea12P05.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_vea13P05.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_vea13P05.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_vea14P05.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_vea14P05.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_vea15P05.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_vea15P05.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_vea16P05.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_vea16P05.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_vea17P05.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_vea17P05.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_vex03P04.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_vex03P04.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_vex04P04.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_vex04P04.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_chiller01P01.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_chiller01P01.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_crack01P02.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_crack01P02.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_fancoil01P02.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_fancoil01P02.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_manejadoraLower01P05.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_manejadoraLower01P05.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_manejadoraSblancaP04.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_manejadoraSblancaP04.py

Verify HVAC Python Event Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_settingVersions.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_settingVersions.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_errorCode.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_errorCode.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_summaryState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_summaryState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_appliedSettingsMatchStart.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_appliedSettingsMatchStart.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_logLevel.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_logLevel.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_logMessage.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_logMessage.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_settingsApplied.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_settingsApplied.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_simulationMode.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_simulationMode.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_softwareVersions.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_softwareVersions.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_heartbeat.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_heartbeat.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_authList.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_authList.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_detailedState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_detailedState.py

Salgen HVAC LabVIEW
    [Documentation]    Generate ${subSystem} low-level LabView interfaces.
    [Tags]    labview
    ${output}=    Run Process    ${SALHome}/bin/salgenerator    ${subSystem}    labview    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    XMLVERSION = ${XMLVersion}
    Directory Should Exist    ${SALWorkDir}/${subSystem}/labview
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/labview
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/labview/SAL_${subSystem}_salShmMonitor.cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/labview/SAL_${subSystem}_shmem.h
    File Should Exist    ${SALWorkDir}/${subSystem}/labview/SALLV_${subSystem}.so
    File Should Exist    ${SALWorkDir}/${subSystem}/labview/SALLV_${subSystem}_Monitor

Salgen HVAC Java
    [Documentation]    Generate Java libraries.
    [Tags]    java
    ${output}=    Run Process    ${SALHome}/bin/salgenerator    ${subSystem}    sal    java    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    XMLVERSION = ${XMLVersion}
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vea01P01.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vin01P01.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vec01P01.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_bombaAguaFriaP01.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_valvulaP01.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_temperatuaAmbienteP01.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vea01P05.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vea08P05.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vea09P05.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vea10P05.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vea11P05.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vea12P05.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vea13P05.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vea14P05.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vea15P05.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vea16P05.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vea17P05.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vea03P04.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vea04P04.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vex03P04.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_vex04P04.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_damperLowerP04.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_zonaCargaP04.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_chiller01P01.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_crack01P02.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fancoil01P02.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_manejadoraLower01P05.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_manejadoraSblancaP04.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_manejadraSblancaP04.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_manejadoraSlimpiaP04.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_manejadoraZzzP04.idl
    Should Contain X Times    ${output.stdout}    javac : Done Publisher    31
    Should Contain X Times    ${output.stdout}    javac : Done Subscriber    31
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl
    File Should Exist    ${SALWorkDir}/${subSystem}/java/saj_${subSystem}_types.jar
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl

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
    File Should Exist    ${SALWorkDir}/lib/libsacpp_${subSystem}_types.so
    File Should Exist    ${SALWorkDir}/lib/libSAL_${subSystem}.so
    File Should Exist    ${SALWorkDir}/lib/SALLV_${subSystem}.so
    File Should Exist    ${SALWorkDir}/lib/SALPY_${subSystem}.so
    File Should Exist    ${SALWorkDir}/lib/libsacpp_${subSystem}_types.so
    File Should Exist    ${SALWorkDir}/lib/libSAL_${subSystem}.so
    File Should Exist    ${SALWorkDir}/lib/saj_${subSystem}_types.jar
    File Should Exist    ${SALWorkDir}/lib/SALLV_${subSystem}.so

Salgen HVAC RPM
    [Documentation]    Generate the SAL library RPM for ${subSystem}
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
    File Should Exist    ${SALWorkDir}/rpmbuild/SPECS/ts_sal_${subSystem}.spec
    File Should Exist    ${SALWorkDir}/rpmbuild/SOURCES/${subSystem}-${XMLVersion}.tgz
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/ts_sal_runtime-${XMLVersion}-${SALVersion}.${Build_Number}${DIST}.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/ts_sal_ATruntime-${XMLVersion}-${SALVersion}.${Build_Number}${DIST}.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/ts_sal_utils-${SALVersion}-1.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/${subSystem}-${XMLVersion}-${SALVersion}.${Build_Number}${DIST}.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/${subSystem}_test-${XMLVersion}-${SALVersion}.${Build_Number}${DIST}.x86_64.rpm

Salgen HVAC Maven
    [Documentation]    Generate the Maven repository.
    [Tags]    java
    ${output}=    Run Process    ${SALHome}/bin/salgenerator    ${subSystem}    maven    version\=${Build_Number}${MavenVersion}    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    argv = ${subSystem} maven version=${Build_Number}${MavenVersion}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    XMLVERSION = ${XMLVersion}
    Should Contain    ${output.stdout}    Running maven install
    Should Contain    ${output.stdout}    [INFO] Building sal_${subSystem} ${XMLVersion}_${SALVersion}${Build_Number}${MavenVersion}
    Should Contain X Times    ${output.stdout}    [INFO] BUILD SUCCESS    1
    Should Contain X Times    ${output.stdout}    [INFO] Finished at:    1
    @{files}=    List Directory    ${SALWorkDir}/maven
    File Should Exist    ${SALWorkDir}/maven/${subSystem}-${XMLVersion}_${SALVersion}${Build_Number}${MavenVersion}/pom.xml

Cleanup stdout and stderr Files
    [Tags]
    Remove Files    ${EXECDIR}${/}${subSystem}_stdout.txt    ${EXECDIR}${/}${subSystem}_stderr.txt

