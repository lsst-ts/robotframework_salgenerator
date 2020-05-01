*** Settings ***
Documentation    This suite builds the various interfaces for the ATWhiteLight.
Force Tags    salgen    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${timeout}
Library    OperatingSystem
Library    Process
Resource    ../Global_Vars.resource

*** Variables ***
${subSystem}    ATWhiteLight
${timeout}    1200s

*** Test Cases ***
Verify ATWhiteLight XML Defintions exist
    [Tags]
    Comment    Verify the CSC XML definition files exist.
    ${output}    Run Process    ls     ${SALWorkDir}/ATWhiteLight_*.xml    shell=True
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stderr}    No such file or directory    msg="ATWhiteLight has no XML defintions"    values=False
    Should Not Be Empty    ${output.stdout}
    File Should Exist    ${SALWorkDir}/ATWhiteLight_Commands.xml
    File Should Exist    ${SALWorkDir}/ATWhiteLight_Events.xml
    File Should Exist    ${SALWorkDir}/ATWhiteLight_Telemetry.xml

Salgen ATWhiteLight Validate
    [Documentation]    Validate the ATWhiteLight XML definitions.
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
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_timestamp.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_loopTime.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_bulbhour.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_bulbWatthour.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_chillerFansSpeed.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_chillerUpTime.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_chillerTempSensors.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_chillerProcessFlow.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_chillerTECBankCurrent.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_chillerTEDriveLevel.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_powerLightOn.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_powerLightOff.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_emergencyPowerLightOff.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_setLightPower.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_setChillerTemperature.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_startCooling.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_stopCooling.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_loopTimeOutOfRange.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_rejectedCommand.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_whiteLightStatus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_chillerLowFlowWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_chillerFluidLevelWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_chillerSwitchToSupplyTempWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_chillerHighControlTempWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_chillerLowControlTempWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_chillerHighAmbientTempWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_chillerLowAmbientTempWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_chillerTempReached.idl

Salgen ATWhiteLight HTML
    [Documentation]    Create web form interfaces.
    [Tags]    html    
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    html    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Generating telemetry stream definition editor html
    Should Contain    ${output.stdout}    Generating Facility database table creation html
    Should Contain    ${output.stdout}    Generating Subsystem simulation control html
    @{files}=    List Directory    ${SALWorkDir}/html/${subSystem}
    File Should Exist    ${SALWorkDir}/html/${subSystem}/ATWhiteLight_Commands.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/ATWhiteLight_Events.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/ATWhiteLight_Telemetry.html
    @{files}=    List Directory    ${SALWorkDir}/html/dbsimulate    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/html/dbsimulate/index-dbsimulate.html
    File Should Exist    ${SALWorkDir}/html/dbsimulate/index-dbsimulate-${subSystem}.html
    File Should Exist    ${SALWorkDir}/html/dbsimulate/index-simulate-${subSystem}.html
    File Should Exist    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl

Verify ATWhiteLight revCodes File
    [Documentation]    Ensure ATWhiteLight_revCodes.tcl contains 1 revcode per topic.
    [Tags]    html    
    ${output}=    Log File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_powerLightOn\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_powerLightOff\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_emergencyPowerLightOff\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_setLightPower\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_setChillerTemperature\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_startCooling\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_stopCooling\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_loopTimeOutOfRange\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_rejectedCommand\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_whiteLightStatus\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_chillerLowFlowWarning\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_chillerFluidLevelWarning\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_chillerSwitchToSupplyTempWarning\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_chillerHighControlTempWarning\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_chillerLowControlTempWarning\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_chillerHighAmbientTempWarning\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_chillerLowAmbientTempWarning\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_chillerTempReached\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_timestamp\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_loopTime\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_bulbhour\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_bulbWatthour\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_chillerFansSpeed\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_chillerUpTime\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_chillerTempSensors\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_chillerProcessFlow\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_chillerTECBankCurrent\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_chillerTEDriveLevel\\) [a-z0-9]{8,}

Salgen ATWhiteLight IDL
    [Documentation]    Generate the revCoded IDL for ${subSystem}
    [Tags]    idl
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    sal    idl    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Completed ${subSystem} validation
    File Should Exist    ${SALWorkDir}/${subSystem}/sal_revCoded_${subSystem}.idl
    @{files}=    List Directory    ${SALWorkDir}/idl-templates/validated/
    Log Many    @{files}

Salgen ATWhiteLight C++
    [Documentation]    Generate C++ wrapper.
    [Tags]    cpp
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    sal    cpp   shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stdout}    *** DDS error in file
    Should Not Contain    ${output.stdout}    Error 1
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_timestamp.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_loopTime.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_bulbhour.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_bulbWatthour.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_chillerFansSpeed.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_chillerUpTime.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_chillerTempSensors.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_chillerProcessFlow.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_chillerTECBankCurrent.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_chillerTEDriveLevel.idl
    Should Contain X Times    ${output.stdout}    cpp : Done Publisher    10
    Should Contain X Times    ${output.stdout}    cpp : Done Subscriber    10
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

Verify ATWhiteLight Telemetry directories
    [Tags]    cpp
    @{files}=    List Directory    ${SALWorkDir}    pattern=*${subSystem}*
    Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/${subSystem}_timestamp
    Directory Should Exist    ${SALWorkDir}/${subSystem}_loopTime
    Directory Should Exist    ${SALWorkDir}/${subSystem}_bulbhour
    Directory Should Exist    ${SALWorkDir}/${subSystem}_bulbWatthour
    Directory Should Exist    ${SALWorkDir}/${subSystem}_chillerFansSpeed
    Directory Should Exist    ${SALWorkDir}/${subSystem}_chillerUpTime
    Directory Should Exist    ${SALWorkDir}/${subSystem}_chillerTempSensors
    Directory Should Exist    ${SALWorkDir}/${subSystem}_chillerProcessFlow
    Directory Should Exist    ${SALWorkDir}/${subSystem}_chillerTECBankCurrent
    Directory Should Exist    ${SALWorkDir}/${subSystem}_chillerTEDriveLevel

Verify ATWhiteLight C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}_timestamp/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_timestamp/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_loopTime/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_loopTime/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_bulbhour/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_bulbhour/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_bulbWatthour/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_bulbWatthour/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_chillerFansSpeed/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_chillerFansSpeed/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_chillerUpTime/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_chillerUpTime/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_chillerTempSensors/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_chillerTempSensors/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_chillerProcessFlow/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_chillerProcessFlow/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_chillerTECBankCurrent/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_chillerTECBankCurrent/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_chillerTEDriveLevel/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_chillerTEDriveLevel/cpp/standalone/sacpp_${subSystem}_sub

Verify ATWhiteLight C++ Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_powerLightOn_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_powerLightOn_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_powerLightOff_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_powerLightOff_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_emergencyPowerLightOff_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_emergencyPowerLightOff_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setLightPower_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setLightPower_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setChillerTemperature_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setChillerTemperature_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startCooling_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startCooling_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_stopCooling_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_stopCooling_controller

Verify ATWhiteLight C++ Event Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_loopTimeOutOfRange_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_loopTimeOutOfRange_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_rejectedCommand_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_rejectedCommand_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_whiteLightStatus_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_whiteLightStatus_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_chillerLowFlowWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_chillerLowFlowWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_chillerFluidLevelWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_chillerFluidLevelWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_chillerSwitchToSupplyTempWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_chillerSwitchToSupplyTempWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_chillerHighControlTempWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_chillerHighControlTempWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_chillerLowControlTempWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_chillerLowControlTempWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_chillerHighAmbientTempWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_chillerHighAmbientTempWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_chillerLowAmbientTempWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_chillerLowAmbientTempWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_chillerTempReached_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_chillerTempReached_log

Salgen ATWhiteLight Python
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

Verify ATWhiteLight Python Telemetry Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_timestamp_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_timestamp_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_loopTime_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_loopTime_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_bulbhour_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_bulbhour_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_bulbWatthour_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_bulbWatthour_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_chillerFansSpeed_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_chillerFansSpeed_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_chillerUpTime_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_chillerUpTime_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_chillerTempSensors_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_chillerTempSensors_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_chillerProcessFlow_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_chillerProcessFlow_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_chillerTECBankCurrent_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_chillerTECBankCurrent_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_chillerTEDriveLevel_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_chillerTEDriveLevel_Subscriber.py

Verify ATWhiteLight Python Command Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_powerLightOn.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_powerLightOn.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_powerLightOff.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_powerLightOff.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_emergencyPowerLightOff.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_emergencyPowerLightOff.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_setLightPower.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_setLightPower.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_setChillerTemperature.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_setChillerTemperature.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_startCooling.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_startCooling.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_stopCooling.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_stopCooling.py

Verify ATWhiteLight Python Event Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_loopTimeOutOfRange.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_loopTimeOutOfRange.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_rejectedCommand.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_rejectedCommand.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_whiteLightStatus.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_whiteLightStatus.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_chillerLowFlowWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_chillerLowFlowWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_chillerFluidLevelWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_chillerFluidLevelWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_chillerSwitchToSupplyTempWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_chillerSwitchToSupplyTempWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_chillerHighControlTempWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_chillerHighControlTempWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_chillerLowControlTempWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_chillerLowControlTempWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_chillerHighAmbientTempWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_chillerHighAmbientTempWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_chillerLowAmbientTempWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_chillerLowAmbientTempWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_chillerTempReached.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_chillerTempReached.py

Salgen ATWhiteLight LabVIEW
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

Salgen ATWhiteLight Java
    [Documentation]    Generate Java wrapper.
    [Tags]    java
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    sal    java    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_timestamp.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_loopTime.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_bulbhour.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_bulbWatthour.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_chillerFansSpeed.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_chillerUpTime.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_chillerTempSensors.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_chillerProcessFlow.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_chillerTECBankCurrent.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_chillerTEDriveLevel.idl
    Should Contain X Times    ${output.stdout}    javac : Done Publisher    10
    Should Contain X Times    ${output.stdout}    javac : Done Subscriber    10
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl
    File Should Exist    ${SALWorkDir}/${subSystem}/java/saj_${subSystem}_types.jar
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl

Salgen ATWhiteLight Lib
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

Salgen ATWhiteLight RPM
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

Salgen ATWhiteLight Maven
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

