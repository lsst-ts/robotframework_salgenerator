*** Settings ***
Documentation    This suite builds the various interfaces for the OCS.
Force Tags    salgen    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${timeout}
Library    OperatingSystem
Library    Process
Resource    ../Global_Vars.resource

*** Variables ***
${subSystem}    OCS
${timeout}    1200s

*** Test Cases ***
Verify OCS XML Defintions exist
    [Tags]
    Comment    Verify the CSC XML definition files exist.
    ${output}    Run Process    ls     ${SALWorkDir}/OCS_*.xml    shell=True
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stderr}    No such file or directory    msg="OCS has no XML defintions"    values=False
    Should Not Be Empty    ${output.stdout}
    File Should Exist    ${SALWorkDir}/OCS_Commands.xml
    File Should Exist    ${SALWorkDir}/OCS_Events.xml
    File Should Exist    ${SALWorkDir}/OCS_Telemetry.xml

Salgen OCS Validate
    [Documentation]    Validate the OCS XML definitions.
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
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_sequencerHeartbeat.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_sequence.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_script.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_oCSEntitySummaryState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_oCSEntityStartup.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_oCSEntityShutdown.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_oCSCommandIssued.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_oCSCommandStatus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_oCSCurrentScript.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_oCSNextScript.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_oCSScriptStart.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_oCSScriptEnd.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_oCSScriptError.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_oCSScriptEntititesInUse.idl

Salgen OCS HTML
    [Documentation]    Create web form interfaces.
    [Tags]    html    
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    html    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Generating telemetry stream definition editor html
    Should Contain    ${output.stdout}    Creating sal-generator-${subSystem} form
    Should Contain    ${output.stdout}    Added sal-generator-${subSystem}.sequencerHeartbeat to form
    Directory Should Exist    ${SALWorkDir}/html/salgenerator/${subSystem}
    @{files}=    List Directory    ${SALWorkDir}/html/salgenerator/${subSystem}    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/html/${subSystem}/OCS_Commands.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/OCS_Events.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/OCS_Telemetry.html
    File Should Exist    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl

Salgen OCS C++
    [Documentation]    Generate C++ wrapper.
    [Tags]    cpp
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    sal    cpp   shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stdout}    *** DDS error in file
    Should Not Contain    ${output.stdout}    Error 1
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_sequencerHeartbeat.idl
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

Verify OCS Telemetry directories
    [Tags]    cpp
    @{files}=    List Directory    ${SALWorkDir}    pattern=*${subSystem}*
    Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/${subSystem}_sequencerHeartbeat

Verify OCS C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}_sequencerHeartbeat/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_sequencerHeartbeat/cpp/standalone/sacpp_${subSystem}_sub

Verify OCS C++ Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_sequence_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_sequence_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_script_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_script_controller

Verify OCS C++ Event Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_oCSEntitySummaryState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_oCSEntitySummaryState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_oCSEntityStartup_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_oCSEntityStartup_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_oCSEntityShutdown_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_oCSEntityShutdown_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_oCSCommandIssued_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_oCSCommandIssued_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_oCSCommandStatus_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_oCSCommandStatus_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_oCSCurrentScript_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_oCSCurrentScript_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_oCSNextScript_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_oCSNextScript_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_oCSScriptStart_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_oCSScriptStart_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_oCSScriptEnd_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_oCSScriptEnd_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_oCSScriptError_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_oCSScriptError_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_oCSScriptEntititesInUse_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_oCSScriptEntititesInUse_log

Salgen OCS Python
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

Verify OCS Python Telemetry Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_sequencerHeartbeat_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_sequencerHeartbeat_Subscriber.py

Verify OCS Python Command Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_sequence.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_sequence.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_script.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_script.py

Verify OCS Python Event Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_oCSEntitySummaryState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_oCSEntitySummaryState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_oCSEntityStartup.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_oCSEntityStartup.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_oCSEntityShutdown.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_oCSEntityShutdown.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_oCSCommandIssued.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_oCSCommandIssued.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_oCSCommandStatus.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_oCSCommandStatus.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_oCSCurrentScript.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_oCSCurrentScript.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_oCSNextScript.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_oCSNextScript.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_oCSScriptStart.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_oCSScriptStart.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_oCSScriptEnd.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_oCSScriptEnd.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_oCSScriptError.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_oCSScriptError.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_oCSScriptEntititesInUse.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_oCSScriptEntititesInUse.py

Salgen OCS LabVIEW
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

Salgen OCS Java
    [Documentation]    Generate Java wrapper.
    [Tags]    java
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    sal    java    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_sequencerHeartbeat.idl
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

Salgen OCS Lib
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

Salgen OCS RPM
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

Salgen OCS Maven
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

