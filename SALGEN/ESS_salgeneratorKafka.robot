*** Settings ***
Documentation    This suite builds the various interfaces for the ESS.
Force Tags    salgen    ess
Suite Setup    Log Many    ${Host}    ${subSystem}    ${timeout}
Library    OperatingSystem
Library    Process
Resource    ../Global_Vars.resource

*** Variables ***
${subSystem}    ESS
${timeout}    1200s

*** Test Cases ***
Verify ESS XML Defintions exist
    [Tags]    validate
    Comment    Verify the CSC XML definition files exist.
    ${output}    Run Process    ls     ${SALWorkDir}/${subSystem}_*xml    shell=True
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Be Empty    ${output.stdout}
    File Should Exist    ${SALWorkDir}/ESS_Events.xml
    File Should Exist    ${SALWorkDir}/ESS_Telemetry.xml

Salgen ESS Validate
    [Documentation]    Validate the ESS XML definitions.
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
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_Events.xml
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}_evtdef.tcl
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_Telemetry.xml
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}_tlmdef.tcl
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_heartbeat.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_logLevel.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_logMessage.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_softwareVersions.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_errorCode.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_simulationMode.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_summaryState.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_configurationApplied.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_configurationsAvailable.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_lightningStrike.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_highElectricField.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_precipitation.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_sensorStatus.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_airTurbulence.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_airFlow.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_dewPoint.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_pressure.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_rainRate.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_relativeHumidity.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_snowRate.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_solarRadiation.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_temperature.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_accelerometer.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_accelerometerPSD.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_electricFieldStrength.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_lightningStrikeStatus.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_spectrumAnalyzer.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_earthquakeBroadBandHighGain.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_earthquakeBroadBandLowGain.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_earthquakeHighBroadBandHighGain.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_earthquakeHighBroadBandLowGain.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_earthquakeLongPeriodHighGain.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_earthquakeLongPeriodLowGain.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_earthquakeUltraLongPeriodHighGain.json/
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_earthquakeVeryLongPeriodHighGain.json/

Salgen ESS C++
    [Documentation]    Generate C++ libraries.
    [Tags]    cpp
    ${output}=    Run Process    ${SALHome}/bin/salgeneratorKafka    ${subSystem}    sal    cpp   shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stdout}    ERROR : Failed to generate CPP DDS types
    Should Not Contain    ${output.stdout}    *** DDS error in file
    Should Not Contain    ${output.stdout}    Error 1
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    XMLVERSION = ${XMLVersion}
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain X Times    ${output.stdout}    cpp : Done Publisher    22
    Should Contain X Times    ${output.stdout}    cpp : Done Subscriber    22
    Should Contain X Times    ${output.stdout}    cpp : Done Commander    1
    Should Contain X Times    ${output.stdout}    cpp : Done Event/Logger    1

Verify C++ Directories
    [Documentation]    Ensure expected C++ directories and files are created.
    [Tags]    cpp
    Directory Should Exist    ${SALWorkDir}/${subSystem}/cpp
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/cpp/src    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/SAL_${subSystem}.cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/SAL_${subSystem}C.h
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/SAL_${subSystem}LV.h
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/SAL_${subSystem}_actors.h
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/SAL_${subSystem}_enums.h

Verify ESS Telemetry directories
    [Tags]    cpp
    @{files}=    List Directory    ${SALWorkDir}    pattern=*${subSystem}*
    Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/${subSystem}_airTurbulence
    Directory Should Exist    ${SALWorkDir}/${subSystem}_airFlow
    Directory Should Exist    ${SALWorkDir}/${subSystem}_dewPoint
    Directory Should Exist    ${SALWorkDir}/${subSystem}_pressure
    Directory Should Exist    ${SALWorkDir}/${subSystem}_rainRate
    Directory Should Exist    ${SALWorkDir}/${subSystem}_relativeHumidity
    Directory Should Exist    ${SALWorkDir}/${subSystem}_snowRate
    Directory Should Exist    ${SALWorkDir}/${subSystem}_solarRadiation
    Directory Should Exist    ${SALWorkDir}/${subSystem}_temperature
    Directory Should Exist    ${SALWorkDir}/${subSystem}_accelerometer
    Directory Should Exist    ${SALWorkDir}/${subSystem}_accelerometerPSD
    Directory Should Exist    ${SALWorkDir}/${subSystem}_electricFieldStrength
    Directory Should Exist    ${SALWorkDir}/${subSystem}_lightningStrikeStatus
    Directory Should Exist    ${SALWorkDir}/${subSystem}_spectrumAnalyzer
    Directory Should Exist    ${SALWorkDir}/${subSystem}_earthquakeBroadBandHighGain
    Directory Should Exist    ${SALWorkDir}/${subSystem}_earthquakeBroadBandLowGain
    Directory Should Exist    ${SALWorkDir}/${subSystem}_earthquakeHighBroadBandHighGain
    Directory Should Exist    ${SALWorkDir}/${subSystem}_earthquakeHighBroadBandLowGain
    Directory Should Exist    ${SALWorkDir}/${subSystem}_earthquakeLongPeriodHighGain
    Directory Should Exist    ${SALWorkDir}/${subSystem}_earthquakeLongPeriodLowGain
    Directory Should Exist    ${SALWorkDir}/${subSystem}_earthquakeUltraLongPeriodHighGain
    Directory Should Exist    ${SALWorkDir}/${subSystem}_earthquakeVeryLongPeriodHighGain

Verify ESS C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}_airTurbulence/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_airTurbulence/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_airTurbulence.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_airFlow/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_airFlow/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_airFlow.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_dewPoint/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_dewPoint/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_dewPoint.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_pressure/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_pressure/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_pressure.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_rainRate/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_rainRate/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_rainRate.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_relativeHumidity/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_relativeHumidity/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_relativeHumidity.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_snowRate/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_snowRate/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_snowRate.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_solarRadiation/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_solarRadiation/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_solarRadiation.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_temperature/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_temperature/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_temperature.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_accelerometer/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_accelerometer/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_accelerometer.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_accelerometerPSD/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_accelerometerPSD/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_accelerometerPSD.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_electricFieldStrength/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_electricFieldStrength/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_electricFieldStrength.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_lightningStrikeStatus/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_lightningStrikeStatus/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_lightningStrikeStatus.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_spectrumAnalyzer/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_spectrumAnalyzer/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_spectrumAnalyzer.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_earthquakeBroadBandHighGain/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_earthquakeBroadBandHighGain/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_earthquakeBroadBandHighGain.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_earthquakeBroadBandLowGain/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_earthquakeBroadBandLowGain/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_earthquakeBroadBandLowGain.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_earthquakeHighBroadBandHighGain/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_earthquakeHighBroadBandHighGain/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_earthquakeHighBroadBandHighGain.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_earthquakeHighBroadBandLowGain/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_earthquakeHighBroadBandLowGain/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_earthquakeHighBroadBandLowGain.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_earthquakeLongPeriodHighGain/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_earthquakeLongPeriodHighGain/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_earthquakeLongPeriodHighGain.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_earthquakeLongPeriodLowGain/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_earthquakeLongPeriodLowGain/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_earthquakeLongPeriodLowGain.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_earthquakeUltraLongPeriodHighGain/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_earthquakeUltraLongPeriodHighGain/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_earthquakeUltraLongPeriodHighGain.hh
    File Should Exist    ${SALWorkDir}/${subSystem}_earthquakeVeryLongPeriodHighGain/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_earthquakeVeryLongPeriodHighGain/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_earthquakeVeryLongPeriodHighGain.hh

Verify ESS C++ Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_ackcmd.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_disable_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_disable_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_disable.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enable_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enable_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_enable.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_exitControl_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_exitControl_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_exitControl.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setLogLevel_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setLogLevel_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_setLogLevel.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_standby_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_standby_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_standby.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_start_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_start_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_command_start.hh

Verify ESS C++ Event Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_heartbeat_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_heartbeat_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_heartbeat.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_logLevel_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_logLevel_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_logLevel.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_logMessage_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_logMessage_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_logMessage.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_softwareVersions_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_softwareVersions_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_softwareVersions.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_errorCode_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_errorCode_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_errorCode.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_simulationMode_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_simulationMode_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_simulationMode.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_summaryState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_summaryState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_summaryState.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_configurationApplied_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_configurationApplied_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_configurationApplied.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_configurationsAvailable_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_configurationsAvailable_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_configurationsAvailable.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_lightningStrike_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_lightningStrike_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_lightningStrike.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_highElectricField_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_highElectricField_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_highElectricField.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_precipitation_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_precipitation_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_precipitation.hh
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_sensorStatus_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_sensorStatus_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/${subSystem}_logevent_sensorStatus.hh

Salgen ESS Java
    [Documentation]    Generate Java libraries.
    [Tags]    java
    ${output}=    Run Process    ${SALHome}/bin/salgeneratorKafka    ${subSystem}    sal    java    version\=${MavenVersion}    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stdout}    ERROR : Failed to generate*saj_*_types.jar 
    Should Not Contain    ${output.stdout}    error: package org.apache.avro* does not exist
    Should Not Contain    ${output.stdout}    error: package org.apache.kafka* does not exist
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    XMLVERSION = ${XMLVersion}
    Should Contain    ${output.stdout}    calling salavrogen ${subSystem} cpp
    Should Contain    ${output.stdout}    Generating cpp type support for ${subSystem}
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_airTurbulence.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_airTurbulence.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_airFlow.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_airFlow.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_dewPoint.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_dewPoint.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_pressure.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_pressure.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_rainRate.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_rainRate.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_relativeHumidity.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_relativeHumidity.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_snowRate.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_snowRate.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_solarRadiation.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_solarRadiation.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_temperature.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_temperature.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_accelerometer.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_accelerometer.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_accelerometerPSD.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_accelerometerPSD.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_electricFieldStrength.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_electricFieldStrength.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_lightningStrikeStatus.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_lightningStrikeStatus.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_spectrumAnalyzer.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_spectrumAnalyzer.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_earthquakeBroadBandHighGain.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_earthquakeBroadBandHighGain.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_earthquakeBroadBandLowGain.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_earthquakeBroadBandLowGain.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_earthquakeHighBroadBandHighGain.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_earthquakeHighBroadBandHighGain.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_earthquakeHighBroadBandLowGain.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_earthquakeHighBroadBandLowGain.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_earthquakeLongPeriodHighGain.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_earthquakeLongPeriodHighGain.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_earthquakeLongPeriodLowGain.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_earthquakeLongPeriodLowGain.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_earthquakeUltraLongPeriodHighGain.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_earthquakeUltraLongPeriodHighGain.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_earthquakeVeryLongPeriodHighGain.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_earthquakeVeryLongPeriodHighGain.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_heartbeat.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_heartbeat.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_logLevel.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_logLevel.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_logMessage.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_logMessage.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_softwareVersions.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_softwareVersions.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_errorCode.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_errorCode.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_simulationMode.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_simulationMode.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_summaryState.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_summaryState.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_configurationApplied.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_configurationApplied.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_configurationsAvailable.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_configurationsAvailable.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_lightningStrike.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_lightningStrike.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_highElectricField.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_highElectricField.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_precipitation.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_precipitation.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_sensorStatus.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_logevent_sensorStatus.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_disable.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_disable.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_enable.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_enable.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_exitControl.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_exitControl.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_setLogLevel.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_setLogLevel.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_standby.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_standby.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Processing ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_command_start.json
    Should Contain    ${output.stdout}    Adding /home/appuser/trunk/ts_sal/test/${subSystem}/cpp/src/${subSystem}_command_start.hh to sal_${subSystem} code fragments
    Should Contain    ${output.stdout}    Configuring ${subSystem}/java/src/org/lsst/sal/SAL_${subSystem}.java
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/saj_${subSystem}_types.jar
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/org/lsst/sal/SAL_${subSystem}.java
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/org/lsst/sal/salActor.java
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/org/lsst/sal/salUtils.java
    File Should Exist    ${SALWorkDir}/salUtils/libsalUtils.so
    File Should Exist    ${SALWorkDir}/lib/org/lsst/sal/salUtils.class 

Salgen ESS Maven
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

Salgen ESS Lib
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
    File Should Exist    ${SALWorkDir}/lib/libSAL_${subSystem}.a
    File Should Exist    ${SALWorkDir}/lib/libsalUtils.so
    File Should Exist    ${SALWorkDir}/lib/org/lsst/sal/salUtils.class 
    File Should Exist    ${SALWorkDir}/lib/saj_${subSystem}_types.jar

Salgen ESS RPM
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
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/ts_sal_utilsKafka-${SALVersionBase}-1.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/${subSystem}-${XMLVersionBase}${sep}${Build_Number}-${SALVersionBase}${DIST}.x86_64.rpm
    File Should Exist    ${SALWorkDir}/lib/org/lsst/sal/salUtils.class
    File Should Exist    ${SALWorkDir}/lib/libsalUtils.so
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/${subSystem}_test-${XMLVersionBase}${sep}${Build_Number}-${SALVersionBase}${DIST}.x86_64.rpm
    Should Not Contain    ${output.stdout}    child process exited abnormally

Verify ESS RPM Contents
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
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/lib/libSAL_${subSystem}.a
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/SAL_${subSystem}.h
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_ackcmd.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_airTurbulence.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_airFlow.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_dewPoint.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_pressure.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_rainRate.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_relativeHumidity.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_snowRate.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_solarRadiation.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_temperature.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_accelerometer.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_accelerometerPSD.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_electricFieldStrength.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_lightningStrikeStatus.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_spectrumAnalyzer.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_earthquakeBroadBandHighGain.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_earthquakeBroadBandLowGain.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_earthquakeHighBroadBandHighGain.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_earthquakeHighBroadBandLowGain.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_earthquakeLongPeriodHighGain.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_earthquakeLongPeriodLowGain.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_earthquakeUltraLongPeriodHighGain.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_earthquakeVeryLongPeriodHighGain.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_disable.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_enable.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_exitControl.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_setLogLevel.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_standby.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_command_start.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_heartbeat.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_logLevel.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_logMessage.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_softwareVersions.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_errorCode.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_simulationMode.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_summaryState.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_configurationApplied.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_configurationsAvailable.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_lightningStrike.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_highElectricField.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_precipitation.hh
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/include/${subSystem}_logevent_sensorStatus.hh
    Comment    Verify the interface definition files are included.
    Should Contain     ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Generics.xml
    Should Contain     ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Commands.html
    Should Contain     ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Events.xml
    Should Contain     ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Events.html
    Should Contain     ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Telemetry.xml
    Should Contain     ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Telemetry.html

Verify ESS TEST RPM Contents
    [Documentation]    Verify the ${subSystem} TEST RPM contains all the expected libraries
    [Tags]    rpm
    Comment    Re-run the {sep} process, so this test case can run independently.
    IF    "${Build_Number}" == ""
        Set Test Variable    ${sep}    ${EMPTY}
    ELSE IF    any(item in '${Build_Number}' for item in ('pre', 'post', 'rc'))
        Set Test Variable    ${sep}    ~
    ELSE
        Set Test Variable    ${sep}    ${EMPTY}
    END
    ${output}=    Run Process    rpm    -qpl    ${subSystem}_test-${XMLVersionBase}${sep}${Build_Number}-${SALVersionBase}${DIST}.x86_64.rpm    shell=True    cwd=${SALWorkDir}/rpmbuild/RPMS/x86_64    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stderr}    error
    Should Not Contain    ${output.stderr}    No such file or directory
    Comment    Verify the TEST RPM contains the test programs.
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_all_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_all_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_all_sender
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_all_logger
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_all_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_all_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_disable_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_disable_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_enable_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_enable_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_exitControl_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_exitControl_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_setLogLevel_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_setLogLevel_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_standby_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_standby_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_start_commander
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_start_controller
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_heartbeat_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_heartbeat_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_logLevel_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_logLevel_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_logMessage_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_logMessage_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_softwareVersions_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_softwareVersions_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_errorCode_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_errorCode_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_simulationMode_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_simulationMode_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_summaryState_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_summaryState_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_configurationApplied_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_configurationApplied_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_configurationsAvailable_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_configurationsAvailable_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_lightningStrike_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_lightningStrike_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_highElectricField_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_highElectricField_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_precipitation_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_precipitation_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_sensorStatus_send
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_sensorStatus_log
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_airTurbulence_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_airTurbulence_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_airFlow_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_airFlow_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_dewPoint_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_dewPoint_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_pressure_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_pressure_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_rainRate_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_rainRate_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_relativeHumidity_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_relativeHumidity_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_snowRate_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_snowRate_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_solarRadiation_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_solarRadiation_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_temperature_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_temperature_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_accelerometer_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_accelerometer_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_accelerometerPSD_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_accelerometerPSD_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_electricFieldStrength_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_electricFieldStrength_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_lightningStrikeStatus_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_lightningStrikeStatus_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_spectrumAnalyzer_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_spectrumAnalyzer_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_earthquakeBroadBandHighGain_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_earthquakeBroadBandHighGain_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_earthquakeBroadBandLowGain_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_earthquakeBroadBandLowGain_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_earthquakeHighBroadBandHighGain_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_earthquakeHighBroadBandHighGain_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_earthquakeHighBroadBandLowGain_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_earthquakeHighBroadBandLowGain_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_earthquakeLongPeriodHighGain_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_earthquakeLongPeriodHighGain_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_earthquakeLongPeriodLowGain_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_earthquakeLongPeriodLowGain_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_earthquakeUltraLongPeriodHighGain_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_earthquakeUltraLongPeriodHighGain_subscriber
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_earthquakeVeryLongPeriodHighGain_publisher
    Should Contain    ${output.stdout}    /opt/lsst/ts_sal/bin/sacpp_${subSystem}_earthquakeVeryLongPeriodHighGain_subscriber

Cleanup stdout and stderr Files
    [Tags]
    Remove Files    ${EXECDIR}${/}${subSystem}_stdout.txt    ${EXECDIR}${/}${subSystem}_stderr.txt

