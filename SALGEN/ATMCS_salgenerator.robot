*** Settings ***
Documentation    This suite builds the various interfaces for the ATMCS.
Force Tags    salgen    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${timeout}
Library    OperatingSystem
Library    Process
Resource    ../Global_Vars.resource

*** Variables ***
${subSystem}    ATMCS
${timeout}    1200s

*** Test Cases ***
Verify ATMCS XML Defintions exist
    [Tags]
    Comment    Verify the CSC XML definition files exist.
    ${output}    Run Process    ls     ${SALWorkDir}/ATMCS_*.xml    shell=True
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stderr}    No such file or directory    msg="ATMCS has no XML defintions"    values=False
    Should Not Be Empty    ${output.stdout}
    File Should Exist    ${SALWorkDir}/ATMCS_Commands.xml
    File Should Exist    ${SALWorkDir}/ATMCS_Events.xml
    File Should Exist    ${SALWorkDir}/ATMCS_Telemetry.xml

Salgen ATMCS Validate
    [Documentation]    Validate the ATMCS XML definitions.
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
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_trajectory.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_mount_AzEl_Encoders.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_mount_Nasmyth_Encoders.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_torqueDemand.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_measuredTorque.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_measuredMotorVelocity.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_nasymth_m3_mountMotorEncoders.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_azEl_mountMotorEncoders.idl
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
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_startTracking.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_trackTarget.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_setInstrumentPort.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_stopTracking.idl
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
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_atMountState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_m3State.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_m3PortSelected.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_positionLimits.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_target.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_elevationInPosition.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_azimuthInPosition.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_nasmyth1RotatorInPosition.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_nasmyth2RotatorInPosition.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_m3InPosition.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_allAxesInPosition.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_azimuthToppleBlockCCW.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_azimuthToppleBlockCW.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_m3RotatorDetentSwitches.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_elevationLimitSwitchLower.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_elevationLimitSwitchUpper.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_azimuthLimitSwitchCCW.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_azimuthLimitSwitchCW.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_nasmyth1LimitSwitchCCW.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_nasmyth1LimitSwitchCW.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_nasmyth2LimitSwitchCCW.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_nasmyth2LimitSwitchCW.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_m3RotatorLimitSwitchCCW.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_m3RotatorLimitSwitchCW.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_elevationDriveStatus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_azimuthDrive1Status.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_azimuthDrive2Status.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_nasmyth1DriveStatus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_nasmyth2DriveStatus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_m3DriveStatus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_elevationBrake.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_azimuthBrake1.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_azimuthBrake2.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_nasmyth1Brake.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_nasmyth2Brake.idl

Salgen ATMCS HTML
    [Documentation]    Create web form interfaces.
    [Tags]    html    
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    html    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Generating telemetry stream definition editor html
    Should Contain    ${output.stdout}    Generating Facility database table creation html
    Should Contain    ${output.stdout}    Generating Subsystem simulation control html
    @{files}=    List Directory    ${SALWorkDir}/html/${subSystem}
    File Should Exist    ${SALWorkDir}/html/${subSystem}/ATMCS_Commands.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/ATMCS_Events.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/ATMCS_Telemetry.html
    @{files}=    List Directory    ${SALWorkDir}/html/dbsimulate    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/html/dbsimulate/index-dbsimulate.html
    File Should Exist    ${SALWorkDir}/html/dbsimulate/index-dbsimulate-${subSystem}.html
    File Should Exist    ${SALWorkDir}/html/dbsimulate/index-simulate-${subSystem}.html
    File Should Exist    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl

Verify ATMCS revCodes File
    [Documentation]    Ensure ATMCS_revCodes.tcl contains 1 revcode per topic.
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
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_startTracking\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_trackTarget\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_setInstrumentPort\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_stopTracking\\) [a-z0-9]{8,}
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
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_atMountState\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_m3State\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_m3PortSelected\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_positionLimits\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_target\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_elevationInPosition\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_azimuthInPosition\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_nasmyth1RotatorInPosition\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_nasmyth2RotatorInPosition\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_m3InPosition\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_allAxesInPosition\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_azimuthToppleBlockCCW\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_azimuthToppleBlockCW\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_m3RotatorDetentSwitches\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_elevationLimitSwitchLower\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_elevationLimitSwitchUpper\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_azimuthLimitSwitchCCW\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_azimuthLimitSwitchCW\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_nasmyth1LimitSwitchCCW\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_nasmyth1LimitSwitchCW\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_nasmyth2LimitSwitchCCW\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_nasmyth2LimitSwitchCW\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_m3RotatorLimitSwitchCCW\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_m3RotatorLimitSwitchCW\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_elevationDriveStatus\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_azimuthDrive1Status\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_azimuthDrive2Status\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_nasmyth1DriveStatus\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_nasmyth2DriveStatus\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_m3DriveStatus\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_elevationBrake\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_azimuthBrake1\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_azimuthBrake2\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_nasmyth1Brake\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_nasmyth2Brake\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_trajectory\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_mount_AzEl_Encoders\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_mount_Nasmyth_Encoders\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_torqueDemand\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_measuredTorque\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_measuredMotorVelocity\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_nasymth_m3_mountMotorEncoders\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_azEl_mountMotorEncoders\\) [a-z0-9]{8,}

Salgen ATMCS IDL
    [Documentation]    Generate the revCoded IDL for ${subSystem}
    [Tags]    idl
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    sal    idl    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Completed ${subSystem} validation
    File Should Exist    ${SALWorkDir}/${subSystem}/sal_revCoded_${subSystem}.idl
    @{files}=    List Directory    ${SALWorkDir}/idl-templates/validated/
    Log Many    @{files}

Salgen ATMCS C++
    [Documentation]    Generate C++ libraries.
    [Tags]    cpp
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    sal    cpp   shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stdout}    *** DDS error in file
    Should Not Contain    ${output.stdout}    Error 1
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_trajectory.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_mount_AzEl_Encoders.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_mount_Nasmyth_Encoders.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_torqueDemand.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_measuredTorque.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_measuredMotorVelocity.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_nasymth_m3_mountMotorEncoders.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_azEl_mountMotorEncoders.idl
    Should Contain X Times    ${output.stdout}    cpp : Done Publisher    8
    Should Contain X Times    ${output.stdout}    cpp : Done Subscriber    8
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

Verify ATMCS Telemetry directories
    [Tags]    cpp
    @{files}=    List Directory    ${SALWorkDir}    pattern=*${subSystem}*
    Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/${subSystem}_trajectory
    Directory Should Exist    ${SALWorkDir}/${subSystem}_mount_AzEl_Encoders
    Directory Should Exist    ${SALWorkDir}/${subSystem}_mount_Nasmyth_Encoders
    Directory Should Exist    ${SALWorkDir}/${subSystem}_torqueDemand
    Directory Should Exist    ${SALWorkDir}/${subSystem}_measuredTorque
    Directory Should Exist    ${SALWorkDir}/${subSystem}_measuredMotorVelocity
    Directory Should Exist    ${SALWorkDir}/${subSystem}_nasymth_m3_mountMotorEncoders
    Directory Should Exist    ${SALWorkDir}/${subSystem}_azEl_mountMotorEncoders

Verify ATMCS C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}_trajectory/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_trajectory/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_mount_AzEl_Encoders/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_mount_AzEl_Encoders/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_mount_Nasmyth_Encoders/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_mount_Nasmyth_Encoders/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_torqueDemand/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_torqueDemand/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_measuredTorque/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_measuredTorque/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_measuredMotorVelocity/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_measuredMotorVelocity/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_nasymth_m3_mountMotorEncoders/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_nasymth_m3_mountMotorEncoders/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_azEl_mountMotorEncoders/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_azEl_mountMotorEncoders/cpp/standalone/sacpp_${subSystem}_sub

Verify ATMCS C++ Command Interfaces
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
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startTracking_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startTracking_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_trackTarget_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_trackTarget_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setInstrumentPort_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setInstrumentPort_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_stopTracking_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_stopTracking_controller

Verify ATMCS C++ Event Interfaces
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
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_atMountState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_atMountState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m3State_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m3State_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m3PortSelected_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m3PortSelected_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_positionLimits_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_positionLimits_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_target_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_target_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_elevationInPosition_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_elevationInPosition_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthInPosition_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthInPosition_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth1RotatorInPosition_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth1RotatorInPosition_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth2RotatorInPosition_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth2RotatorInPosition_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m3InPosition_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m3InPosition_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_allAxesInPosition_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_allAxesInPosition_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthToppleBlockCCW_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthToppleBlockCCW_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthToppleBlockCW_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthToppleBlockCW_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m3RotatorDetentSwitches_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m3RotatorDetentSwitches_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_elevationLimitSwitchLower_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_elevationLimitSwitchLower_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_elevationLimitSwitchUpper_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_elevationLimitSwitchUpper_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthLimitSwitchCCW_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthLimitSwitchCCW_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthLimitSwitchCW_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthLimitSwitchCW_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth1LimitSwitchCCW_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth1LimitSwitchCCW_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth1LimitSwitchCW_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth1LimitSwitchCW_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth2LimitSwitchCCW_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth2LimitSwitchCCW_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth2LimitSwitchCW_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth2LimitSwitchCW_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m3RotatorLimitSwitchCCW_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m3RotatorLimitSwitchCCW_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m3RotatorLimitSwitchCW_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m3RotatorLimitSwitchCW_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_elevationDriveStatus_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_elevationDriveStatus_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthDrive1Status_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthDrive1Status_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthDrive2Status_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthDrive2Status_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth1DriveStatus_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth1DriveStatus_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth2DriveStatus_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth2DriveStatus_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m3DriveStatus_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m3DriveStatus_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_elevationBrake_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_elevationBrake_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthBrake1_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthBrake1_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthBrake2_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_azimuthBrake2_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth1Brake_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth1Brake_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth2Brake_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nasmyth2Brake_log

Salgen ATMCS Python
    [Documentation]    Generate Python libraries.
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

Verify ATMCS Python Telemetry Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_trajectory_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_trajectory_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_mount_AzEl_Encoders_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_mount_AzEl_Encoders_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_mount_Nasmyth_Encoders_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_mount_Nasmyth_Encoders_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_torqueDemand_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_torqueDemand_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_measuredTorque_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_measuredTorque_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_measuredMotorVelocity_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_measuredMotorVelocity_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_nasymth_m3_mountMotorEncoders_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_nasymth_m3_mountMotorEncoders_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_azEl_mountMotorEncoders_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_azEl_mountMotorEncoders_Subscriber.py

Verify ATMCS Python Command Interfaces
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
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_startTracking.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_startTracking.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_trackTarget.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_trackTarget.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_setInstrumentPort.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_setInstrumentPort.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_stopTracking.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_stopTracking.py

Verify ATMCS Python Event Interfaces
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
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_atMountState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_atMountState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_m3State.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_m3State.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_m3PortSelected.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_m3PortSelected.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_positionLimits.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_positionLimits.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_target.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_target.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_elevationInPosition.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_elevationInPosition.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_azimuthInPosition.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_azimuthInPosition.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_nasmyth1RotatorInPosition.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_nasmyth1RotatorInPosition.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_nasmyth2RotatorInPosition.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_nasmyth2RotatorInPosition.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_m3InPosition.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_m3InPosition.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_allAxesInPosition.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_allAxesInPosition.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_azimuthToppleBlockCCW.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_azimuthToppleBlockCCW.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_azimuthToppleBlockCW.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_azimuthToppleBlockCW.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_m3RotatorDetentSwitches.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_m3RotatorDetentSwitches.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_elevationLimitSwitchLower.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_elevationLimitSwitchLower.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_elevationLimitSwitchUpper.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_elevationLimitSwitchUpper.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_azimuthLimitSwitchCCW.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_azimuthLimitSwitchCCW.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_azimuthLimitSwitchCW.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_azimuthLimitSwitchCW.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_nasmyth1LimitSwitchCCW.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_nasmyth1LimitSwitchCCW.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_nasmyth1LimitSwitchCW.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_nasmyth1LimitSwitchCW.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_nasmyth2LimitSwitchCCW.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_nasmyth2LimitSwitchCCW.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_nasmyth2LimitSwitchCW.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_nasmyth2LimitSwitchCW.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_m3RotatorLimitSwitchCCW.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_m3RotatorLimitSwitchCCW.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_m3RotatorLimitSwitchCW.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_m3RotatorLimitSwitchCW.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_elevationDriveStatus.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_elevationDriveStatus.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_azimuthDrive1Status.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_azimuthDrive1Status.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_azimuthDrive2Status.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_azimuthDrive2Status.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_nasmyth1DriveStatus.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_nasmyth1DriveStatus.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_nasmyth2DriveStatus.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_nasmyth2DriveStatus.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_m3DriveStatus.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_m3DriveStatus.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_elevationBrake.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_elevationBrake.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_azimuthBrake1.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_azimuthBrake1.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_azimuthBrake2.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_azimuthBrake2.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_nasmyth1Brake.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_nasmyth1Brake.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_nasmyth2Brake.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_nasmyth2Brake.py

Salgen ATMCS LabVIEW
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

Salgen ATMCS Java
    [Documentation]    Generate Java libraries.
    [Tags]    java
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    sal    java    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_trajectory.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_mount_AzEl_Encoders.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_mount_Nasmyth_Encoders.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_torqueDemand.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_measuredTorque.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_measuredMotorVelocity.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_nasymth_m3_mountMotorEncoders.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_azEl_mountMotorEncoders.idl
    Should Contain X Times    ${output.stdout}    javac : Done Publisher    8
    Should Contain X Times    ${output.stdout}    javac : Done Subscriber    8
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl
    File Should Exist    ${SALWorkDir}/${subSystem}/java/saj_${subSystem}_types.jar
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl

Salgen ATMCS Lib
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

Salgen ATMCS RPM
    [Documentation]    Generate the SAL library RPM for ${subSystem}
    [Tags]    rpm
    Log Many    ${XMLVersion}    ${SALVersion}    ${Build_Number}    ${DIST}
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    rpm    version\=${Build_Number}    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
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
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
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

Salgen ATMCS Maven
    [Documentation]    Generate the Maven repository.
    [Tags]    java
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    maven    version\=${MavenVersion}    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    argv = ${subSystem} maven version=${MavenVersion}
    Should Contain    ${output.stdout}    SAL generator - ${SAL_Version}
    Should Contain    ${output.stdout}    Running maven install
    Should Contain    ${output.stdout}    [INFO] Building sal_${subSystem} ${XMLVersion}_${SALVersion}${MavenVersion}
    Should Contain X Times    ${output.stdout}    [INFO] BUILD SUCCESS    1
    Should Contain X Times    ${output.stdout}    [INFO] Finished at:    1
    @{files}=    List Directory    ${SALWorkDir}/maven
    File Should Exist    ${SALWorkDir}/maven/${subSystem}-${XMLVersion}_${SALVersion}${MavenVersion}/pom.xml

Cleanup stdout and stderr Files
    [Tags]
    Remove Files    ${EXECDIR}${/}${subSystem}_stdout.txt    ${EXECDIR}${/}${subSystem}_stderr.txt

