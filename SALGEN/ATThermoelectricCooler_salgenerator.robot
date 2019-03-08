*** Settings ***
Documentation    This suite builds the various interfaces for the ATThermoelectricCooler.
Force Tags    salgen    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${timeout}
Library    OperatingSystem
Library    Process
Resource    ../Global_Vars.resource

*** Variables ***
${subSystem}    ATThermoelectricCooler
${timeout}    1200s

*** Test Cases ***
Verify ATThermoelectricCooler XML Defintions exist
    [Tags]
    Comment    Verify the CSC XML definition files exist.
    ${output}    Run Process    ls     ${SALWorkDir}/ATThermoelectricCooler_*.xml    shell=True
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stderr}    No such file or directory    msg="ATThermoelectricCooler has no XML defintions"    values=False
    Should Not Be Empty    ${output.stdout}
    File Should Exist    ${SALWorkDir}/ATThermoelectricCooler_Commands.xml
    File Should Exist    ${SALWorkDir}/ATThermoelectricCooler_Events.xml
    File Should Exist    ${SALWorkDir}/ATThermoelectricCooler_Telemetry.xml

Salgen ATThermoelectricCooler Validate
    [Documentation]    Validate the ATThermoelectricCooler XML definitions.
    [Tags]    validate
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    validate    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
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
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_fansSpeed.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_unitUpTime.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_temperatureSensors.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_processFlow.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_setTemperature.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_powerChillerOn.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_powerChillerOff.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_detailedState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_internalCommand.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_heartbeat.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_loopTimeOutOfRange.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_rejectedCommand.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_deviceErrorCode.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_hardwareWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_temperatureReached.idl

Salgen ATThermoelectricCooler HTML
    [Documentation]    Create web form interfaces.
    [Tags]    html    
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    html    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Generating telemetry stream definition editor html
    Should Contain    ${output.stdout}    Creating sal-generator-${subSystem} form
    Should Contain    ${output.stdout}    Added sal-generator-${subSystem}.timestamp to form
    Should Contain    ${output.stdout}    Added sal-generator-${subSystem}.loopTime to form
    Should Contain    ${output.stdout}    Added sal-generator-${subSystem}.fansSpeed to form
    Should Contain    ${output.stdout}    Added sal-generator-${subSystem}.unitUpTime to form
    Should Contain    ${output.stdout}    Added sal-generator-${subSystem}.temperatureSensors to form
    Should Contain    ${output.stdout}    Added sal-generator-${subSystem}.processFlow to form
    Directory Should Exist    ${SALWorkDir}/html/salgenerator/${subSystem}
    @{files}=    List Directory    ${SALWorkDir}/html/salgenerator/${subSystem}    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/html/${subSystem}/ATThermoelectricCooler_Commands.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/ATThermoelectricCooler_Events.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/ATThermoelectricCooler_Telemetry.html
    File Should Exist    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl

Salgen ATThermoelectricCooler C++
    [Documentation]    Generate C++ wrapper.
    [Tags]    cpp
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    sal    cpp   shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stdout}    *** DDS error in file
    Should Not Contain    ${output.stdout}    Error 1
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_timestamp.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_loopTime.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_fansSpeed.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_unitUpTime.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_temperatureSensors.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_processFlow.idl
    Should Contain X Times    ${output.stdout}    cpp : Done Publisher    6
    Should Contain X Times    ${output.stdout}    cpp : Done Subscriber    6
    Should Contain X Times    ${output.stdout}    cpp : Done Commander    1
    Should Contain X Times    ${output.stdout}    cpp : Done Event/Logger    1

Verify C++ Directories
    [Documentation]    Ensure expected C++ directories and files.
    [Tags]    cpp
    Directory Should Exist    ${SALWorkDir}/${subSystem}/cpp
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/cpp    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/libsacpp_${subSystem}_types.so
    Directory Should Exist    ${SALWorkDir}/idl-templates/validated/sal
    @{files}=    List Directory    ${SALWorkDir}/idl-templates/validated/sal    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/idl-templates/validated/sal/sal_${subSystem}.idl

Verify ATThermoelectricCooler Telemetry directories
    [Tags]    cpp
    @{files}=    List Directory    ${SALWorkDir}    pattern=*${subSystem}*
    Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/${subSystem}_timestamp
    Directory Should Exist    ${SALWorkDir}/${subSystem}_loopTime
    Directory Should Exist    ${SALWorkDir}/${subSystem}_fansSpeed
    Directory Should Exist    ${SALWorkDir}/${subSystem}_unitUpTime
    Directory Should Exist    ${SALWorkDir}/${subSystem}_temperatureSensors
    Directory Should Exist    ${SALWorkDir}/${subSystem}_processFlow

Verify ATThermoelectricCooler C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}_timestamp/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_timestamp/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_loopTime/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_loopTime/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_fansSpeed/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_fansSpeed/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_unitUpTime/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_unitUpTime/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_temperatureSensors/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_temperatureSensors/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_processFlow/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_processFlow/cpp/standalone/sacpp_${subSystem}_sub

Verify ATThermoelectricCooler C++ Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setTemperature_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setTemperature_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_powerChillerOn_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_powerChillerOn_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_powerChillerOff_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_powerChillerOff_controller

Verify ATThermoelectricCooler C++ Event Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_detailedState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_detailedState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_internalCommand_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_internalCommand_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_heartbeat_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_heartbeat_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_loopTimeOutOfRange_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_loopTimeOutOfRange_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_rejectedCommand_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_rejectedCommand_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_deviceErrorCode_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_deviceErrorCode_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_hardwareWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_hardwareWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_temperatureReached_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_temperatureReached_log

Salgen ATThermoelectricCooler Python
    [Documentation]    Generate Python wrapper.
    [Tags]    python
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    sal    python    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Generating Python SAL support for ${subSystem}
    Should Contain    ${output.stdout}    Generating Python bindings
    Should Contain    ${output.stdout}    python : Done SALPY_${subSystem}.so
    Directory Should Exist    ${SALWorkDir}/${subSystem}/python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/SALPY_${subSystem}.so

Verify ATThermoelectricCooler Python Telemetry Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_timestamp_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_timestamp_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_loopTime_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_loopTime_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_fansSpeed_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_fansSpeed_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_unitUpTime_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_unitUpTime_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_temperatureSensors_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_temperatureSensors_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_processFlow_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_processFlow_Subscriber.py

Verify ATThermoelectricCooler Python Command Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_setTemperature.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_setTemperature.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_powerChillerOn.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_powerChillerOn.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_powerChillerOff.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_powerChillerOff.py

Verify ATThermoelectricCooler Python Event Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_detailedState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_detailedState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_internalCommand.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_internalCommand.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_heartbeat.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_heartbeat.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_loopTimeOutOfRange.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_loopTimeOutOfRange.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_rejectedCommand.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_rejectedCommand.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_deviceErrorCode.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_deviceErrorCode.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_hardwareWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_hardwareWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_temperatureReached.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_temperatureReached.py

Salgen ATThermoelectricCooler LabVIEW
    [Documentation]    Generate ${subSystem} low-level LabView interfaces.
    [Tags]    labview
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    labview    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Directory Should Exist    ${SALWorkDir}/${subSystem}/labview
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/labview
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/labview/SAL_${subSystem}_salShmMonitor.cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/labview/SAL_${subSystem}_shmem.h
    File Should Exist    ${SALWorkDir}/${subSystem}/labview/SALLV_${subSystem}.so
    File Should Exist    ${SALWorkDir}/${subSystem}/labview/SALLV_${subSystem}_Monitor

Salgen ATThermoelectricCooler Java
    [Documentation]    Generate Java wrapper.
    [Tags]    java
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    sal    java    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_timestamp.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_loopTime.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_fansSpeed.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_unitUpTime.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_temperatureSensors.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_processFlow.idl
    Should Contain X Times    ${output.stdout}    javac : Done Publisher    6
    Should Contain X Times    ${output.stdout}    javac : Done Subscriber    6
    Should Contain X Times    ${output.stdout}    javac : Done Commander/Controller    6
    Should Contain X Times    ${output.stdout}    javac : Done Event/Logger    6
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl
    File Should Exist    ${SALWorkDir}/${subSystem}/java/saj_${subSystem}_types.jar
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/saj_${subSystem}_cmdctl.jar
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/saj_${subSystem}_event.jar

Salgen ATThermoelectricCooler Lib
    [Documentation]    Generate the SAL shared library for ${subSystem}
    [Tags]    lib
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    lib    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
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

Salgen ATThermoelectricCooler RPM
    [Documentation]    Generate the SAL library RPM for ${subSystem}
    [Tags]    rpm
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    rpm    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
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
    File Should Exist    ${SALWorkDir}/rpmbuild/SOURCES/${subSystem}-${SALVersion}.tgz
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/${subSystem}-${SALVersion}-1${DIST}.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/${subSystem}-debuginfo-${SALVersion}-1${DIST}.x86_64.rpm

Salgen ATThermoelectricCooler Maven
    [Documentation]    Generate the Maven repository.
    [Tags]    java
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    maven    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Running maven install
    Should Contain    ${output.stdout}    [INFO] Building sal_${subSystem} ${SALVersion}
    Should Contain X Times    ${output.stdout}    [INFO] BUILD SUCCESS    1
    Should Contain X Times    ${output.stdout}    [INFO] Finished at:    1
    @{files}=    List Directory    ${SALWorkDir}/maven
    File Should Exist    ${SALWorkDir}/maven/${subSystem}_${SALVersion}/pom.xml

