*** Settings ***
Documentation    This suite builds the various interfaces for the ATPneumatics.
Force Tags    salgen    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${timeout}
Library    OperatingSystem
Library    Process
Resource    ../Global_Vars.resource

*** Variables ***
${subSystem}    ATPneumatics
${timeout}    1200s

*** Test Cases ***
Verify ATPneumatics XML Defintions exist
    [Tags]
    Comment    Verify the CSC XML definition files exist.
    ${output}    Run Process    ls     ${SALWorkDir}/ATPneumatics_*.xml    shell=True
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stderr}    No such file or directory    msg="ATPneumatics has no XML defintions"    values=False
    Should Not Be Empty    ${output.stdout}
    File Should Exist    ${SALWorkDir}/ATPneumatics_Commands.xml
    File Should Exist    ${SALWorkDir}/ATPneumatics_Events.xml
    File Should Exist    ${SALWorkDir}/ATPneumatics_Telemetry.xml

Salgen ATPneumatics Validate
    [Documentation]    Validate the ATPneumatics XML definitions.
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
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_m1AirPressure.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_m2AirPressure.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_mainAirSourcePressure.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_loadCell.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_openMasterAirSupply.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_m1SetPressure.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_m2SetPressure.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_openM1CellVents.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_openM1Cover.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_openInstrumentAirValve.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_closeInstrumentAirValve.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_closeMasterAirSupply.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_closeM1Cover.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_m2OpenAirValve.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_m2CloseAirValve.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_m1CloseAirValve.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_m1OpenAirValve.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_closeM1CellVents.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_m1CoverLimitSwitches.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_m1VentsLimitSwitches.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_powerStatus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_eStop.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_m1CoverState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_m1State.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_m2State.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_instrumentState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_cellVentsState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_mainValveState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_m1VentsPosition.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_m1SetPressure.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_m2SetPressure.idl

Salgen ATPneumatics HTML
    [Documentation]    Create web form interfaces.
    [Tags]    html    
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    html    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Generating telemetry stream definition editor html
    Should Contain    ${output.stdout}    Generating Facility database table creation html
    Should Contain    ${output.stdout}    Generating Subsystem simulation control html
    @{files}=    List Directory    ${SALWorkDir}/html/${subSystem}
    File Should Exist    ${SALWorkDir}/html/${subSystem}/ATPneumatics_Commands.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/ATPneumatics_Events.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/ATPneumatics_Telemetry.html
    @{files}=    List Directory    ${SALWorkDir}/html/dbsimulate    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/html/dbsimulate/index-dbsimulate.html
    File Should Exist    ${SALWorkDir}/html/dbsimulate/index-dbsimulate-${subSystem}.html
    File Should Exist    ${SALWorkDir}/html/dbsimulate/index-simulate-${subSystem}.html
    File Should Exist    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl

Verify ATPneumatics revCodes File
    [Documentation]    Ensure ATPneumatics_revCodes.tcl contains 1 revcode per topic.
    [Tags]    html    
    ${output}=    Log File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_openMasterAirSupply\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_m1SetPressure\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_m2SetPressure\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_openM1CellVents\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_openM1Cover\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_openInstrumentAirValve\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_closeInstrumentAirValve\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_closeMasterAirSupply\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_closeM1Cover\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_m2OpenAirValve\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_m2CloseAirValve\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_m1CloseAirValve\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_m1OpenAirValve\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_closeM1CellVents\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_m1CoverLimitSwitches\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_m1VentsLimitSwitches\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_powerStatus\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_eStop\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_m1CoverState\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_m1State\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_m2State\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_instrumentState\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_cellVentsState\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_mainValveState\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_m1VentsPosition\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_m1SetPressure\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_m2SetPressure\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_m1AirPressure\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_m2AirPressure\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_mainAirSourcePressure\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_loadCell\\) [a-z0-9]{8,}

Salgen ATPneumatics IDL
    [Documentation]    Generate the revCoded IDL for ${subSystem}
    [Tags]    idl
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    sal    idl    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Completed ${subSystem} validation
    @{files}=    List Directory    ${SALWorkDir}/idl-templates/validated/
    Log Many    @{files}

Salgen ATPneumatics C++
    [Documentation]    Generate C++ wrapper.
    [Tags]    cpp
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    sal    cpp   shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stdout}    *** DDS error in file
    Should Not Contain    ${output.stdout}    Error 1
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_m1AirPressure.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_m2AirPressure.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_mainAirSourcePressure.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_loadCell.idl
    Should Contain X Times    ${output.stdout}    cpp : Done Publisher    4
    Should Contain X Times    ${output.stdout}    cpp : Done Subscriber    4
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

Verify ATPneumatics Telemetry directories
    [Tags]    cpp
    @{files}=    List Directory    ${SALWorkDir}    pattern=*${subSystem}*
    Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/${subSystem}_m1AirPressure
    Directory Should Exist    ${SALWorkDir}/${subSystem}_m2AirPressure
    Directory Should Exist    ${SALWorkDir}/${subSystem}_mainAirSourcePressure
    Directory Should Exist    ${SALWorkDir}/${subSystem}_loadCell

Verify ATPneumatics C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}_m1AirPressure/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_m1AirPressure/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_m2AirPressure/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_m2AirPressure/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_mainAirSourcePressure/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_mainAirSourcePressure/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_loadCell/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_loadCell/cpp/standalone/sacpp_${subSystem}_sub

Verify ATPneumatics C++ Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_openMasterAirSupply_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_openMasterAirSupply_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m1SetPressure_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m1SetPressure_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m2SetPressure_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m2SetPressure_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_openM1CellVents_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_openM1CellVents_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_openM1Cover_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_openM1Cover_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_openInstrumentAirValve_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_openInstrumentAirValve_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_closeInstrumentAirValve_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_closeInstrumentAirValve_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_closeMasterAirSupply_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_closeMasterAirSupply_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_closeM1Cover_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_closeM1Cover_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m2OpenAirValve_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m2OpenAirValve_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m2CloseAirValve_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m2CloseAirValve_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m1CloseAirValve_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m1CloseAirValve_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m1OpenAirValve_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m1OpenAirValve_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_closeM1CellVents_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_closeM1CellVents_controller

Verify ATPneumatics C++ Event Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m1CoverLimitSwitches_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m1CoverLimitSwitches_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m1VentsLimitSwitches_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m1VentsLimitSwitches_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_powerStatus_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_powerStatus_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_eStop_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_eStop_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m1CoverState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m1CoverState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m1State_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m1State_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m2State_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m2State_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_instrumentState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_instrumentState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_cellVentsState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_cellVentsState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_mainValveState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_mainValveState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m1VentsPosition_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m1VentsPosition_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m1SetPressure_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m1SetPressure_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m2SetPressure_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m2SetPressure_log

Salgen ATPneumatics Python
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

Verify ATPneumatics Python Telemetry Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_m1AirPressure_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_m1AirPressure_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_m2AirPressure_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_m2AirPressure_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_mainAirSourcePressure_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_mainAirSourcePressure_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_loadCell_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_loadCell_Subscriber.py

Verify ATPneumatics Python Command Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_openMasterAirSupply.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_openMasterAirSupply.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_m1SetPressure.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_m1SetPressure.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_m2SetPressure.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_m2SetPressure.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_openM1CellVents.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_openM1CellVents.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_openM1Cover.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_openM1Cover.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_openInstrumentAirValve.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_openInstrumentAirValve.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_closeInstrumentAirValve.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_closeInstrumentAirValve.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_closeMasterAirSupply.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_closeMasterAirSupply.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_closeM1Cover.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_closeM1Cover.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_m2OpenAirValve.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_m2OpenAirValve.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_m2CloseAirValve.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_m2CloseAirValve.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_m1CloseAirValve.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_m1CloseAirValve.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_m1OpenAirValve.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_m1OpenAirValve.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_closeM1CellVents.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_closeM1CellVents.py

Verify ATPneumatics Python Event Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_m1CoverLimitSwitches.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_m1CoverLimitSwitches.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_m1VentsLimitSwitches.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_m1VentsLimitSwitches.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_powerStatus.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_powerStatus.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_eStop.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_eStop.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_m1CoverState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_m1CoverState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_m1State.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_m1State.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_m2State.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_m2State.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_instrumentState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_instrumentState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_cellVentsState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_cellVentsState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_mainValveState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_mainValveState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_m1VentsPosition.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_m1VentsPosition.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_m1SetPressure.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_m1SetPressure.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_m2SetPressure.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_m2SetPressure.py

Salgen ATPneumatics LabVIEW
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

Salgen ATPneumatics Java
    [Documentation]    Generate Java wrapper.
    [Tags]    java
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    sal    java    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_m1AirPressure.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_m2AirPressure.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_mainAirSourcePressure.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_loadCell.idl
    Should Contain X Times    ${output.stdout}    javac : Done Publisher    4
    Should Contain X Times    ${output.stdout}    javac : Done Subscriber    4
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl
    File Should Exist    ${SALWorkDir}/${subSystem}/java/saj_${subSystem}_types.jar
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl

Salgen ATPneumatics Lib
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

Salgen ATPneumatics RPM
    [Documentation]    Generate the SAL library RPM for ${subSystem}
    [Tags]    rpm
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    rpm    version\=${SALVersion}${Build_Number}    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    @{files}=    List Directory    /tmp/
    File Should Exist    /tmp/makerpm.log
    File Should Exist    /tmp/makerpm_${subSystem}.log
    File Should Exist    /tmp/makerpm_${subSystem}_test.log
    Log File    /tmp/makerpm.log
    Log File    /tmp/makerpm_${subSystem}.log
    Log File    /tmp/makerpm_${subSystem}_test.log
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
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/ts_sal_utils-${SALVersion}${Build_Number}-1.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/${subSystem}-${SALVersion}${Build_Number}-${XMLVersion}${DIST}.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/${subSystem}_test-${SALVersion}${Build_Number}-${XMLVersion}${DIST}.x86_64.rpm

Salgen ATPneumatics Maven
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

