*** Settings ***
Documentation    This suite builds the various interfaces for the GenericCamera.
Force Tags    salgen    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${timeout}
Library    OperatingSystem
Library    Process
Resource    ../Global_Vars.resource

*** Variables ***
${subSystem}    GenericCamera
${timeout}    1200s

*** Test Cases ***
Verify GenericCamera XML Defintions exist
    [Tags]
    Comment    Verify the CSC XML definition files exist.
    ${output}    Run Process    ls     ${SALWorkDir}/GenericCamera_*.xml    shell=True
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stderr}    No such file or directory    msg="GenericCamera has no XML defintions"    values=False
    Should Not Be Empty    ${output.stdout}
    File Should Exist    ${SALWorkDir}/GenericCamera_Commands.xml
    File Should Exist    ${SALWorkDir}/GenericCamera_Events.xml
    File Should Exist    ${SALWorkDir}/GenericCamera_Telemetry.xml

Salgen GenericCamera Validate
    [Documentation]    Validate the GenericCamera XML definitions.
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
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_temperature.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_setROI.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_setFullFrame.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_startLiveView.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_stopLiveView.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_takeImages.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_cameraInfo.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_cameraSpecificProperty.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_roi.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_startLiveView.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_endLiveView.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_startTakeImage.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_startShutterOpen.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_endShutterOpen.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_startIntegration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_endIntegration.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_startShutterClose.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_endShutterClose.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_startReadout.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_endReadout.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_endTakeImage.idl

Salgen GenericCamera HTML
    [Documentation]    Create web form interfaces.
    [Tags]    html    
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    html    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Generating telemetry stream definition editor html
    Should Contain    ${output.stdout}    Generating Facility database table creation html
    Should Contain    ${output.stdout}    Generating Subsystem simulation control html
    @{files}=    List Directory    ${SALWorkDir}/html/${subSystem}
    File Should Exist    ${SALWorkDir}/html/${subSystem}/GenericCamera_Commands.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/GenericCamera_Events.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/GenericCamera_Telemetry.html
    @{files}=    List Directory    ${SALWorkDir}/html/dbsimulate    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/html/dbsimulate/index-dbsimulate.html
    File Should Exist    ${SALWorkDir}/html/dbsimulate/index-dbsimulate-${subSystem}.html
    File Should Exist    ${SALWorkDir}/html/dbsimulate/index-simulate-${subSystem}.html
    File Should Exist    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl

Verify GenericCamera revCodes File
    [Documentation]    Ensure GenericCamera_revCodes.tcl contains 1 revcode per topic.
    [Tags]    html    
    ${output}=    Log File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_setROI\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_setFullFrame\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_startLiveView\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_stopLiveView\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_takeImages\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_cameraInfo\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_cameraSpecificProperty\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_roi\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_startLiveView\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_endLiveView\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_startTakeImage\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_startShutterOpen\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_endShutterOpen\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_startIntegration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_endIntegration\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_startShutterClose\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_endShutterClose\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_startReadout\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_endReadout\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_endTakeImage\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_temperature\\) [a-z0-9]{8,}

Salgen GenericCamera IDL
    [Documentation]    Generate the revCoded IDL for ${subSystem}
    [Tags]    idl
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    sal    idl    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Completed ${subSystem} validation
    File Should Exist    ${SALWorkDir}/${subSystem}/sal_revCoded_${subSystem}.idl
    @{files}=    List Directory    ${SALWorkDir}/idl-templates/validated/
    Log Many    @{files}

Salgen GenericCamera C++
    [Documentation]    Generate C++ wrapper.
    [Tags]    cpp
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    sal    cpp   shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stdout}    *** DDS error in file
    Should Not Contain    ${output.stdout}    Error 1
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_temperature.idl
    Should Contain X Times    ${output.stdout}    cpp : Done Publisher    1
    Should Contain X Times    ${output.stdout}    cpp : Done Subscriber    1
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

Verify GenericCamera Telemetry directories
    [Tags]    cpp
    @{files}=    List Directory    ${SALWorkDir}    pattern=*${subSystem}*
    Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/${subSystem}_temperature

Verify GenericCamera C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}_temperature/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_temperature/cpp/standalone/sacpp_${subSystem}_sub

Verify GenericCamera C++ Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setROI_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setROI_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setFullFrame_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setFullFrame_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startLiveView_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startLiveView_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_stopLiveView_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_stopLiveView_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_takeImages_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_takeImages_controller

Verify GenericCamera C++ Event Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_cameraInfo_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_cameraInfo_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_cameraSpecificProperty_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_cameraSpecificProperty_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_roi_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_roi_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startLiveView_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startLiveView_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endLiveView_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endLiveView_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startTakeImage_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startTakeImage_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startShutterOpen_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startShutterOpen_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endShutterOpen_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endShutterOpen_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startIntegration_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startIntegration_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endIntegration_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endIntegration_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startShutterClose_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startShutterClose_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endShutterClose_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endShutterClose_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startReadout_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_startReadout_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endReadout_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endReadout_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endTakeImage_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_endTakeImage_log

Salgen GenericCamera Python
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

Verify GenericCamera Python Telemetry Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_temperature_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_temperature_Subscriber.py

Verify GenericCamera Python Command Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_setROI.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_setROI.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_setFullFrame.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_setFullFrame.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_startLiveView.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_startLiveView.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_stopLiveView.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_stopLiveView.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_takeImages.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_takeImages.py

Verify GenericCamera Python Event Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_cameraInfo.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_cameraInfo.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_cameraSpecificProperty.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_cameraSpecificProperty.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_roi.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_roi.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_startLiveView.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_startLiveView.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_endLiveView.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_endLiveView.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_startTakeImage.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_startTakeImage.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_startShutterOpen.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_startShutterOpen.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_endShutterOpen.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_endShutterOpen.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_startIntegration.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_startIntegration.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_endIntegration.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_endIntegration.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_startShutterClose.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_startShutterClose.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_endShutterClose.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_endShutterClose.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_startReadout.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_startReadout.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_endReadout.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_endReadout.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_endTakeImage.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_endTakeImage.py

Salgen GenericCamera LabVIEW
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

Salgen GenericCamera Java
    [Documentation]    Generate Java wrapper.
    [Tags]    java
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    sal    java    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_temperature.idl
    Should Contain X Times    ${output.stdout}    javac : Done Publisher    1
    Should Contain X Times    ${output.stdout}    javac : Done Subscriber    1
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl
    File Should Exist    ${SALWorkDir}/${subSystem}/java/saj_${subSystem}_types.jar
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl

Salgen GenericCamera Lib
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

Salgen GenericCamera RPM
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
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/ts_sal_runtime-${SALVersion}${Build_Number}-${XMLVersion}.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/ts_sal_ATruntime-${SALVersion}${Build_Number}-${XMLVersion}.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/ts_sal_utils-${SALVersion}${Build_Number}-1.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/${subSystem}-${SALVersion}${Build_Number}-${XMLVersion}${DIST}.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/${subSystem}_test-${SALVersion}${Build_Number}-${XMLVersion}${DIST}.x86_64.rpm

Salgen GenericCamera Maven
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

