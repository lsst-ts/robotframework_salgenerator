*** Settings ***
Documentation    This suite builds the various interfaces for the DomeLWS.
Force Tags    salgen    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${timeout}
Library    OperatingSystem
Library    Process
Resource    ../Global_Vars.resource

*** Variables ***
${subSystem}    DomeLWS
${timeout}    1200s

*** Test Cases ***
Verify DomeLWS XML Defintions exist
    [Tags]
    Comment    Verify the CSC XML definition files exist.
    ${output}    Run Process    ls     ${SALWorkDir}/DomeLWS_*.xml    shell=True
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stderr}    No such file or directory    msg="DomeLWS has no XML defintions"    values=False
    Should Not Be Empty    ${output.stdout}
    File Should Exist    ${SALWorkDir}/DomeLWS_Commands.xml
    File Should Exist    ${SALWorkDir}/DomeLWS_Events.xml
    File Should Exist    ${SALWorkDir}/DomeLWS_Telemetry.xml

Salgen DomeLWS Validate
    [Documentation]    Validate the DomeLWS XML definitions.
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
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_status.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_crawlLWS.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_moveLWS.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_velocityMoveLWS.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_echoLWS.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_stateChanged.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_detailedState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_driveEnabled.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_driveDisabled.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_driveReady.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_driveOverTemp.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_driveFault.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_movementEnabled.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_movementPrevented.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_lockingPinDisengaged.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_LockingPinEngaged.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_lockingPinHomed.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_lockingPinFloating.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_brakeEngaged.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_brakeDisengaged.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_speedLimitReached.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_accelerationLimitReached.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_speedLimitSubsided.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_accelerationLimitSubsided.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_echoResponse.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_motionModeChanged.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_subsystemError.idl

Salgen DomeLWS HTML
    [Documentation]    Create web form interfaces.
    [Tags]    html    
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    html    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Generating telemetry stream definition editor html
    Should Contain    ${output.stdout}    Creating sal-generator-${subSystem} form
    Should Contain    ${output.stdout}    Added sal-generator-${subSystem}.status to form
    Directory Should Exist    ${SALWorkDir}/html/salgenerator/${subSystem}
    @{files}=    List Directory    ${SALWorkDir}/html/salgenerator/${subSystem}    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/html/${subSystem}/DomeLWS_Commands.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/DomeLWS_Events.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/DomeLWS_Telemetry.html
    File Should Exist    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl

Salgen DomeLWS C++
    [Documentation]    Generate C++ wrapper.
    [Tags]    cpp
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    sal    cpp   shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stdout}    *** DDS error in file
    Should Not Contain    ${output.stdout}    Error 1
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_status.idl
    Should Contain X Times    ${output.stdout}    cpp : Done Publisher    1
    Should Contain X Times    ${output.stdout}    cpp : Done Subscriber    1
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

Verify DomeLWS Telemetry directories
    [Tags]    cpp
    @{files}=    List Directory    ${SALWorkDir}    pattern=*${subSystem}*
    Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/${subSystem}_status

Verify DomeLWS C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}_status/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_status/cpp/standalone/sacpp_${subSystem}_sub

Verify DomeLWS C++ Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_crawlLWS_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_crawlLWS_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_moveLWS_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_moveLWS_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_velocityMoveLWS_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_velocityMoveLWS_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_echoLWS_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_echoLWS_controller

Verify DomeLWS C++ Event Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_stateChanged_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_stateChanged_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_detailedState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_detailedState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_driveEnabled_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_driveEnabled_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_driveDisabled_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_driveDisabled_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_driveReady_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_driveReady_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_driveOverTemp_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_driveOverTemp_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_driveFault_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_driveFault_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_movementEnabled_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_movementEnabled_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_movementPrevented_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_movementPrevented_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_lockingPinDisengaged_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_lockingPinDisengaged_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_LockingPinEngaged_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_LockingPinEngaged_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_lockingPinHomed_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_lockingPinHomed_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_lockingPinFloating_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_lockingPinFloating_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_brakeEngaged_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_brakeEngaged_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_brakeDisengaged_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_brakeDisengaged_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_speedLimitReached_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_speedLimitReached_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_accelerationLimitReached_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_accelerationLimitReached_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_speedLimitSubsided_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_speedLimitSubsided_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_accelerationLimitSubsided_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_accelerationLimitSubsided_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_echoResponse_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_echoResponse_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_motionModeChanged_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_motionModeChanged_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_subsystemError_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_subsystemError_log

Salgen DomeLWS Python
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

Verify DomeLWS Python Telemetry Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_status_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_status_Subscriber.py

Verify DomeLWS Python Command Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_crawlLWS.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_crawlLWS.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_moveLWS.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_moveLWS.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_velocityMoveLWS.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_velocityMoveLWS.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_echoLWS.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_echoLWS.py

Verify DomeLWS Python Event Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_stateChanged.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_stateChanged.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_detailedState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_detailedState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_driveEnabled.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_driveEnabled.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_driveDisabled.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_driveDisabled.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_driveReady.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_driveReady.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_driveOverTemp.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_driveOverTemp.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_driveFault.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_driveFault.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_movementEnabled.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_movementEnabled.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_movementPrevented.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_movementPrevented.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_lockingPinDisengaged.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_lockingPinDisengaged.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_LockingPinEngaged.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_LockingPinEngaged.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_lockingPinHomed.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_lockingPinHomed.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_lockingPinFloating.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_lockingPinFloating.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_brakeEngaged.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_brakeEngaged.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_brakeDisengaged.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_brakeDisengaged.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_speedLimitReached.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_speedLimitReached.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_accelerationLimitReached.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_accelerationLimitReached.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_speedLimitSubsided.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_speedLimitSubsided.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_accelerationLimitSubsided.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_accelerationLimitSubsided.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_echoResponse.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_echoResponse.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_motionModeChanged.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_motionModeChanged.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_subsystemError.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_subsystemError.py

Salgen DomeLWS LabVIEW
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

Salgen DomeLWS Java
    [Documentation]    Generate Java wrapper.
    [Tags]    java
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    sal    java    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_status.idl
    Should Contain X Times    ${output.stdout}    javac : Done Publisher    1
    Should Contain X Times    ${output.stdout}    javac : Done Subscriber    1
    Should Contain X Times    ${output.stdout}    javac : Done Commander/Controller    1
    Should Contain X Times    ${output.stdout}    javac : Done Event/Logger    1
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl
    File Should Exist    ${SALWorkDir}/${subSystem}/java/saj_${subSystem}_types.jar
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/saj_${subSystem}_cmdctl.jar
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/saj_${subSystem}_event.jar

Salgen DomeLWS Lib
    [Documentation]    Generate the SAL shared library for ${subSystem}
    [Tags]    lib
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    lib    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Building shared library for ${subSystem} subsystem
    Directory Should Exist    ${SALWorkDir}/lib
    @{files}=    List Directory    ${SALWorkDir}/lib
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/lib/libsacpp_${subSystem}_types.so
    File Should Exist    ${SALWorkDir}/lib/libSAL_${subSystem}.so
    File Should Exist    ${SALWorkDir}/lib/SALLV_${subSystem}.so
    File Should Exist    ${SALWorkDir}/lib/SALPY_${subSystem}.so
    File Should Exist    ${SALWorkDir}/lib/libsacpp_${subSystem}_types.so
    File Should Exist    ${SALWorkDir}/lib/libSAL_${subSystem}.so
    File Should Exist    ${SALWorkDir}/lib/saj_${subSystem}_types.jar
    File Should Exist    ${SALWorkDir}/lib/SALLV_${subSystem}.so

Salgen DomeLWS RPM
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
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/${subSystem}-${SALVersion}-1.el7.centos.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/${subSystem}-debuginfo-${SALVersion}-1.el7.centos.x86_64.rpm

Salgen DomeLWS Maven
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

