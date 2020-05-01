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
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    validate    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Processing ${subSystem}
    Should Contain    ${output.stdout}    Completed ${subSystem} validation
    Directory Should Exist    ${SALWorkDir}/idl-templates
    Directory Should Exist    ${SALWorkDir}/idl-templates/validated
    @{files}=    List Directory    ${SALWorkDir}/idl-templates    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_lsstBarraoblPiso01BarraoblTccGuionP1GuionSalaGuionMaquinas.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_lsstBarraoblPiso05BarraoblTccGuionP5GuionPir.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_lsstBarraoblPiso04BarraoblTccGuionP4GuionVex.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_lsstBarraoblPiso01BarraoblChiller01.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_lsstBarraoblPiso02BarraoblCrack01.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_lsstBarraoblPiso02BarraoblFancoil01.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_lsstBarraoblPiso05BarraoblManejadoraBarraoblLower_01.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_lsstBarraoblPiso04BarraoblManejadoraBarraoblSlimpia.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_lsstBarraoblPiso01BarraoblTccGuionP1GuionSalaGuionMaquinas.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_lsstBarraoblPiso05BarraoblTccGuionP5GuionPir.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_lsstBarraoblPiso04BarraoblTccGuionP4GuionVex.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_lsstBarraoblPiso01BarraoblChiller01.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_lsstBarraoblPiso02BarraoblCrack01.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_lsstBarraoblPiso02BarraoblFancoil01.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_lsstBarraoblPiso05BarraoblManejadoraBarraoblLower_01.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_detailedState.idl

Salgen HVAC HTML
    [Documentation]    Create web form interfaces.
    [Tags]    html    
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    html    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Generating telemetry stream definition editor html
    Should Contain    ${output.stdout}    Generating Facility database table creation html
    Should Contain    ${output.stdout}    Generating Subsystem simulation control html
    @{files}=    List Directory    ${SALWorkDir}/html/${subSystem}
    File Should Exist    ${SALWorkDir}/html/${subSystem}/HVAC_Commands.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/HVAC_Events.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/HVAC_Telemetry.html
    @{files}=    List Directory    ${SALWorkDir}/html/dbsimulate    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/html/dbsimulate/index-dbsimulate.html
    File Should Exist    ${SALWorkDir}/html/dbsimulate/index-dbsimulate-${subSystem}.html
    File Should Exist    ${SALWorkDir}/html/dbsimulate/index-simulate-${subSystem}.html
    File Should Exist    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl

Verify HVAC revCodes File
    [Documentation]    Ensure HVAC_revCodes.tcl contains 1 revcode per topic.
    [Tags]    html    
    ${output}=    Log File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_lsstBarraoblPiso01BarraoblTccGuionP1GuionSalaGuionMaquinas\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_lsstBarraoblPiso05BarraoblTccGuionP5GuionPir\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_lsstBarraoblPiso04BarraoblTccGuionP4GuionVex\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_lsstBarraoblPiso01BarraoblChiller01\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_lsstBarraoblPiso02BarraoblCrack01\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_lsstBarraoblPiso02BarraoblFancoil01\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_lsstBarraoblPiso05BarraoblManejadoraBarraoblLower_01\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_detailedState\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_lsstBarraoblPiso01BarraoblTccGuionP1GuionSalaGuionMaquinas\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_lsstBarraoblPiso05BarraoblTccGuionP5GuionPir\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_lsstBarraoblPiso04BarraoblTccGuionP4GuionVex\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_lsstBarraoblPiso01BarraoblChiller01\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_lsstBarraoblPiso02BarraoblCrack01\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_lsstBarraoblPiso02BarraoblFancoil01\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_lsstBarraoblPiso05BarraoblManejadoraBarraoblLower_01\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_lsstBarraoblPiso04BarraoblManejadoraBarraoblSlimpia\\) [a-z0-9]{8,}

Salgen HVAC IDL
    [Documentation]    Generate the revCoded IDL for ${subSystem}
    [Tags]    idl
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    sal    idl    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Completed ${subSystem} validation
    File Should Exist    ${SALWorkDir}/${subSystem}/sal_revCoded_${subSystem}.idl
    @{files}=    List Directory    ${SALWorkDir}/idl-templates/validated/
    Log Many    @{files}

Salgen HVAC C++
    [Documentation]    Generate C++ wrapper.
    [Tags]    cpp
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    sal    cpp   shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stdout}    *** DDS error in file
    Should Not Contain    ${output.stdout}    Error 1
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_lsstBarraoblPiso01BarraoblTccGuionP1GuionSalaGuionMaquinas.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_lsstBarraoblPiso05BarraoblTccGuionP5GuionPir.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_lsstBarraoblPiso04BarraoblTccGuionP4GuionVex.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_lsstBarraoblPiso01BarraoblChiller01.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_lsstBarraoblPiso02BarraoblCrack01.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_lsstBarraoblPiso02BarraoblFancoil01.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_lsstBarraoblPiso05BarraoblManejadoraBarraoblLower_01.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_lsstBarraoblPiso04BarraoblManejadoraBarraoblSlimpia.idl
    Should Contain X Times    ${output.stdout}    cpp : Done Publisher    9
    Should Contain X Times    ${output.stdout}    cpp : Done Subscriber    9
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
    Directory Should Exist    ${SALWorkDir}/${subSystem}_lsstBarraoblPiso01BarraoblTccGuionP1GuionSalaGuionMaquinas
    Directory Should Exist    ${SALWorkDir}/${subSystem}_lsstBarraoblPiso05BarraoblTccGuionP5GuionPir
    Directory Should Exist    ${SALWorkDir}/${subSystem}_lsstBarraoblPiso04BarraoblTccGuionP4GuionVex
    Directory Should Exist    ${SALWorkDir}/${subSystem}_lsstBarraoblPiso01BarraoblChiller01
    Directory Should Exist    ${SALWorkDir}/${subSystem}_lsstBarraoblPiso02BarraoblCrack01
    Directory Should Exist    ${SALWorkDir}/${subSystem}_lsstBarraoblPiso02BarraoblFancoil01
    Directory Should Exist    ${SALWorkDir}/${subSystem}_lsstBarraoblPiso05BarraoblManejadoraBarraoblLower_01
    Directory Should Exist    ${SALWorkDir}/${subSystem}_lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca
    Directory Should Exist    ${SALWorkDir}/${subSystem}_lsstBarraoblPiso04BarraoblManejadoraBarraoblSlimpia

Verify HVAC C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}_lsstBarraoblPiso01BarraoblTccGuionP1GuionSalaGuionMaquinas/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_lsstBarraoblPiso01BarraoblTccGuionP1GuionSalaGuionMaquinas/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_lsstBarraoblPiso05BarraoblTccGuionP5GuionPir/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_lsstBarraoblPiso05BarraoblTccGuionP5GuionPir/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_lsstBarraoblPiso04BarraoblTccGuionP4GuionVex/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_lsstBarraoblPiso04BarraoblTccGuionP4GuionVex/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_lsstBarraoblPiso01BarraoblChiller01/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_lsstBarraoblPiso01BarraoblChiller01/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_lsstBarraoblPiso02BarraoblCrack01/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_lsstBarraoblPiso02BarraoblCrack01/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_lsstBarraoblPiso02BarraoblFancoil01/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_lsstBarraoblPiso02BarraoblFancoil01/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_lsstBarraoblPiso05BarraoblManejadoraBarraoblLower_01/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_lsstBarraoblPiso05BarraoblManejadoraBarraoblLower_01/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_lsstBarraoblPiso04BarraoblManejadoraBarraoblSlimpia/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_lsstBarraoblPiso04BarraoblManejadoraBarraoblSlimpia/cpp/standalone/sacpp_${subSystem}_sub

Verify HVAC C++ Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_lsstBarraoblPiso01BarraoblTccGuionP1GuionSalaGuionMaquinas_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_lsstBarraoblPiso01BarraoblTccGuionP1GuionSalaGuionMaquinas_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_lsstBarraoblPiso05BarraoblTccGuionP5GuionPir_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_lsstBarraoblPiso05BarraoblTccGuionP5GuionPir_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_lsstBarraoblPiso04BarraoblTccGuionP4GuionVex_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_lsstBarraoblPiso04BarraoblTccGuionP4GuionVex_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_lsstBarraoblPiso01BarraoblChiller01_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_lsstBarraoblPiso01BarraoblChiller01_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_lsstBarraoblPiso02BarraoblCrack01_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_lsstBarraoblPiso02BarraoblCrack01_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_lsstBarraoblPiso02BarraoblFancoil01_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_lsstBarraoblPiso02BarraoblFancoil01_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_lsstBarraoblPiso05BarraoblManejadoraBarraoblLower_01_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_lsstBarraoblPiso05BarraoblManejadoraBarraoblLower_01_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca_controller

Verify HVAC C++ Event Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_detailedState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_detailedState_log

Salgen HVAC Python
    [Documentation]    Generate Python wrapper.
    [Tags]    python
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    sal    python    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
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
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_lsstBarraoblPiso01BarraoblTccGuionP1GuionSalaGuionMaquinas_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_lsstBarraoblPiso01BarraoblTccGuionP1GuionSalaGuionMaquinas_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_lsstBarraoblPiso05BarraoblTccGuionP5GuionPir_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_lsstBarraoblPiso05BarraoblTccGuionP5GuionPir_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_lsstBarraoblPiso04BarraoblTccGuionP4GuionVex_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_lsstBarraoblPiso04BarraoblTccGuionP4GuionVex_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_lsstBarraoblPiso01BarraoblChiller01_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_lsstBarraoblPiso01BarraoblChiller01_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_lsstBarraoblPiso02BarraoblCrack01_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_lsstBarraoblPiso02BarraoblCrack01_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_lsstBarraoblPiso02BarraoblFancoil01_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_lsstBarraoblPiso02BarraoblFancoil01_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_lsstBarraoblPiso05BarraoblManejadoraBarraoblLower_01_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_lsstBarraoblPiso05BarraoblManejadoraBarraoblLower_01_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_lsstBarraoblPiso04BarraoblManejadoraBarraoblSlimpia_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_lsstBarraoblPiso04BarraoblManejadoraBarraoblSlimpia_Subscriber.py

Verify HVAC Python Command Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_lsstBarraoblPiso01BarraoblTccGuionP1GuionSalaGuionMaquinas.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_lsstBarraoblPiso01BarraoblTccGuionP1GuionSalaGuionMaquinas.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_lsstBarraoblPiso05BarraoblTccGuionP5GuionPir.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_lsstBarraoblPiso05BarraoblTccGuionP5GuionPir.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_lsstBarraoblPiso04BarraoblTccGuionP4GuionVex.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_lsstBarraoblPiso04BarraoblTccGuionP4GuionVex.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_lsstBarraoblPiso01BarraoblChiller01.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_lsstBarraoblPiso01BarraoblChiller01.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_lsstBarraoblPiso02BarraoblCrack01.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_lsstBarraoblPiso02BarraoblCrack01.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_lsstBarraoblPiso02BarraoblFancoil01.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_lsstBarraoblPiso02BarraoblFancoil01.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_lsstBarraoblPiso05BarraoblManejadoraBarraoblLower_01.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_lsstBarraoblPiso05BarraoblManejadoraBarraoblLower_01.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca.py

Verify HVAC Python Event Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_detailedState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_detailedState.py

Salgen HVAC LabVIEW
    [Documentation]    Generate ${subSystem} low-level LabView interfaces.
    [Tags]    labview
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    labview    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Directory Should Exist    ${SALWorkDir}/${subSystem}/labview
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/labview
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/labview/SAL_${subSystem}_salShmMonitor.cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/labview/SAL_${subSystem}_shmem.h
    File Should Exist    ${SALWorkDir}/${subSystem}/labview/SALLV_${subSystem}.so
    File Should Exist    ${SALWorkDir}/${subSystem}/labview/SALLV_${subSystem}_Monitor

Salgen HVAC Java
    [Documentation]    Generate Java wrapper.
    [Tags]    java
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    sal    java    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_lsstBarraoblPiso01BarraoblTccGuionP1GuionSalaGuionMaquinas.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_lsstBarraoblPiso05BarraoblTccGuionP5GuionPir.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_lsstBarraoblPiso04BarraoblTccGuionP4GuionVex.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_lsstBarraoblPiso01BarraoblChiller01.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_lsstBarraoblPiso02BarraoblCrack01.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_lsstBarraoblPiso02BarraoblFancoil01.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_lsstBarraoblPiso05BarraoblManejadoraBarraoblLower_01.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_lsstBarraoblPiso04BarraoblManejadoraBarraoblSblanca.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_lsstBarraoblPiso04BarraoblManejadoraBarraoblSlimpia.idl
    Should Contain X Times    ${output.stdout}    javac : Done Publisher    9
    Should Contain X Times    ${output.stdout}    javac : Done Subscriber    9
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl
    File Should Exist    ${SALWorkDir}/${subSystem}/java/saj_${subSystem}_types.jar
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl

Salgen HVAC Lib
    [Documentation]    Generate the SAL shared library for ${subSystem}
    [Tags]    lib
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    lib    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
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
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    rpm    version\=${SALVersion}${Build_Number}    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    @{files}=    List Directory    /tmp/
    File Should Exist    /tmp/makerpm_${subSystem}.log
    File Should Exist    /tmp/makerpm_${subSystem}_test.log
    File Should Exist    /tmp/makerpm-utils.log
    File Should Exist    /tmp/makerpm-meta.log
    File Should Exist    /tmp/makerpm-atmeta.log
    Log File    /tmp/makerpm_${subSystem}.log
    Log File    /tmp/makerpm_${subSystem}_test.log
    Log File    /tmp/makerpm-utils.log
    Log File    /tmp/makerpm-meta.log
    Log File    /tmp/makerpm-atmeta.log
    Should Not Contain    ${output.stdout}    ERROR : Asset required for rpm
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}${Build_Number}
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
    File Should Exist    ${SALWorkDir}/rpmbuild/SOURCES/${subSystem}-${SALVersion}${Build_Number}.tgz
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/ts_sal_runtime-${SALVersion}${Build_Number}-${XMLVersion}.el7.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/ts_sal_ATruntime-${SALVersion}${Build_Number}-${XMLVersion}.el7.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/ts_sal_utils-${SALVersion}${Build_Number}-1.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/${subSystem}-${SALVersion}${Build_Number}-${XMLVersion}${DIST}.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/${subSystem}_test-${SALVersion}${Build_Number}-${XMLVersion}${DIST}.x86_64.rpm

Salgen HVAC Maven
    [Documentation]    Generate the Maven repository.
    [Tags]    java
    ${maven}=    Set Variable    ${SAL_Version}_${XML_Version}${MavenVersion}
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    maven    version\=${maven}    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${maven}
    Should Contain    ${output.stdout}    Running maven install
    Should Contain    ${output.stdout}    [INFO] Building sal_${subSystem} ${SALVersion}
    Should Contain X Times    ${output.stdout}    [INFO] BUILD SUCCESS    1
    Should Contain X Times    ${output.stdout}    [INFO] Finished at:    1
    @{files}=    List Directory    ${SALWorkDir}/maven
    File Should Exist    ${SALWorkDir}/maven/${subSystem}_${maven}/pom.xml

Cleanup stdout and stderr Files
    [Tags]
    Remove Files    ${EXECDIR}${/}${subSystem}_stdout.txt    ${EXECDIR}${/}${subSystem}_stderr.txt

