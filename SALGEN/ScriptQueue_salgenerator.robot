*** Settings ***
Documentation    This suite builds the various interfaces for the ScriptQueue.
Force Tags    salgen    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${timeout}
Library    OperatingSystem
Library    Process
Resource    ../Global_Vars.resource

*** Variables ***
${subSystem}    ScriptQueue
${timeout}    1200s

*** Test Cases ***
Verify ScriptQueue XML Defintions exist
    [Tags]
    Comment    Verify the CSC XML definition files exist.
    ${output}    Run Process    ls     ${SALWorkDir}/ScriptQueue_*.xml    shell=True
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stderr}    No such file or directory    msg="ScriptQueue has no XML defintions"    values=False
    Should Not Be Empty    ${output.stdout}
    File Should Exist    ${SALWorkDir}/ScriptQueue_Commands.xml
    File Should Exist    ${SALWorkDir}/ScriptQueue_Events.xml

Salgen ScriptQueue Validate
    [Documentation]    Validate the ScriptQueue XML definitions.
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
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_showAvailableScripts.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_showSchema.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_showQueue.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_showScript.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_pause.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_resume.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_add.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_move.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_requeue.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_stopScripts.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_availableScripts.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_configSchema.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_nextVisit.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_nextVisitCanceled.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_script.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_queue.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_rootDirectories.idl

Salgen ScriptQueue HTML
    [Documentation]    Create web form interfaces.
    [Tags]    html    
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    html    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Generating telemetry stream definition editor html
    Should Contain    ${output.stdout}    Generating Facility database table creation html
    Should Contain    ${output.stdout}    Generating Subsystem simulation control html
    @{files}=    List Directory    ${SALWorkDir}/html/${subSystem}
    File Should Exist    ${SALWorkDir}/html/${subSystem}/ScriptQueue_Commands.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/ScriptQueue_Events.html
    @{files}=    List Directory    ${SALWorkDir}/html/dbsimulate    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/html/dbsimulate/index-dbsimulate.html
    File Should Exist    ${SALWorkDir}/html/dbsimulate/index-dbsimulate-${subSystem}.html
    File Should Exist    ${SALWorkDir}/html/dbsimulate/index-simulate-${subSystem}.html
    File Should Exist    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl

Verify ScriptQueue revCodes File
    [Documentation]    Ensure ScriptQueue_revCodes.tcl contains 1 revcode per topic.
    [Tags]    html    
    ${output}=    Log File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_showAvailableScripts\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_showSchema\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_showQueue\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_showScript\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_pause\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_resume\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_add\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_move\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_requeue\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_stopScripts\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_availableScripts\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_configSchema\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_nextVisit\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_nextVisitCanceled\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_script\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_queue\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_rootDirectories\\) [a-z0-9]{8,}

Salgen ScriptQueue IDL
    [Documentation]    Generate the revCoded IDL for ${subSystem}
    [Tags]    idl
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    sal    idl    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Completed ${subSystem} validation
    @{files}=    List Directory    ${SALWorkDir}/idl-templates/validated/
    Log Many    @{files}

Salgen ScriptQueue C++
    [Documentation]    Generate C++ wrapper.
    [Tags]    cpp
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    sal    cpp   shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stdout}    *** DDS error in file
    Should Not Contain    ${output.stdout}    Error 1
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    WARNING : No Telemetry definitions found for ${subSystem}
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

Verify ScriptQueue C++ Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_showAvailableScripts_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_showAvailableScripts_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_showSchema_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_showSchema_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_showQueue_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_showQueue_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_showScript_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_showScript_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_pause_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_pause_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_resume_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_resume_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_add_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_add_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_move_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_move_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_requeue_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_requeue_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_stopScripts_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_stopScripts_controller

Verify ScriptQueue C++ Event Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_availableScripts_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_availableScripts_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_configSchema_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_configSchema_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nextVisit_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nextVisit_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nextVisitCanceled_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_nextVisitCanceled_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_script_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_script_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_queue_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_queue_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_rootDirectories_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_rootDirectories_log

Salgen ScriptQueue Python
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

Verify ScriptQueue Python Command Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_showAvailableScripts.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_showAvailableScripts.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_showSchema.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_showSchema.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_showQueue.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_showQueue.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_showScript.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_showScript.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_pause.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_pause.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_resume.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_resume.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_add.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_add.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_move.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_move.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_requeue.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_requeue.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_stopScripts.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_stopScripts.py

Verify ScriptQueue Python Event Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_availableScripts.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_availableScripts.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_configSchema.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_configSchema.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_nextVisit.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_nextVisit.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_nextVisitCanceled.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_nextVisitCanceled.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_script.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_script.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_queue.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_queue.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_rootDirectories.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_rootDirectories.py

Salgen ScriptQueue LabVIEW
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

Salgen ScriptQueue Java
    [Documentation]    Generate Java wrapper.
    [Tags]    java
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    sal    java    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    WARNING : No Telemetry definitions found for ${subSystem}
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl
    File Should Exist    ${SALWorkDir}/${subSystem}/java/saj_${subSystem}_types.jar
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl

Salgen ScriptQueue Lib
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

Salgen ScriptQueue RPM
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

Salgen ScriptQueue Maven
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

