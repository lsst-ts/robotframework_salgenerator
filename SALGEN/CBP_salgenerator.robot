*** Settings ***
Documentation    This suite builds the various interfaces for the CBP.
Force Tags    salgen    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${timeout}
Library    OperatingSystem
Resource    ../Global_Vars.resource

*** Variables ***
${subSystem}    CBP
${timeout}    1200s

*** Test Cases ***
Verify CBP XML Defintions exist
    [Tags]
    Comment    Verify the CSC XML definition files exist.
    ${stdout}    Run    ls ${SALWorkDir}/CBP_*.xml 2>&1
    Should Not Contain    ${stdout}    No such file or directory    msg="CBP has no XML defintions"    values=False
    Should Not Be Empty    ${stdout}
    File Should Exist    ${SALWorkDir}/CBP_Commands.xml
    File Should Exist    ${SALWorkDir}/CBP_Telemetry.xml

Salgen CBP Validate
    [Documentation]    Validate the CBP XML definitions.
    [Tags]
    ${output}=    Run    cd ${SALWorkDir}
    ${output}=    Run    ${SALHome}/scripts/salgenerator ${subSystem} validate
    Log    ${output}
    Should Contain    ${output}    SAL generator - ${SALVersion}
    Should Contain    ${output}    Processing ${subSystem}
    Should Contain    ${output}    Completed ${subSystem} validation
    Directory Should Exist    ${SALWorkDir}/idl-templates
    Directory Should Exist    ${SALWorkDir}/idl-templates/validated
    @{files}=    List Directory    ${SALWorkDir}/idl-templates    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_status.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_mask.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_azimuth.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_altitude.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_focus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_parked.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_clearFault.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_moveAzimuth.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_moveAltitude.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_changeMask.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_setFocus.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_park.idl

Salgen CBP HTML
    [Documentation]    Create web form interfaces.
    [Tags]    html    
    ${output}=    Run    ${SALHome}/scripts/salgenerator ${subSystem} html
    Log    ${output}
    Should Contain    ${output}    SAL generator - ${SALVersion}
    Should Contain    ${output}    Generating telemetry stream definition editor html
    Should Contain    ${output}    Creating sal-generator-${subSystem} form
    Should Contain    ${output}    Added sal-generator-${subSystem}.status to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.mask to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.azimuth to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.altitude to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.focus to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.parked to form
    Directory Should Exist    ${SALWorkDir}/html/salgenerator/${subSystem}
    @{files}=    List Directory    ${SALWorkDir}/html/salgenerator/${subSystem}    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/html/${subSystem}/CBP_Commands.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/CBP_Telemetry.html

Salgen CBP C++
    [Documentation]    Generate C++ wrapper.
    [Tags]    cpp
    ${output}=    Run    ${SALHome}/scripts/salgenerator ${subSystem} sal cpp
    Log    ${output}
    Should Not Contain    ${output}    *** DDS error in file
    Should Not Contain    ${output}    Error 1
    Should Contain    ${output}    SAL generator - ${SALVersion}
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_status.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_mask.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_azimuth.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_altitude.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_focus.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_parked.idl
    Should Contain X Times    ${output}    cpp : Done Publisher    6
    Should Contain X Times    ${output}    cpp : Done Subscriber    6
    Should Contain X Times    ${output}    cpp : Done Commander    1
    Should Contain X Times    ${output}    cpp : Done Event/Logger    1

Verify C++ Directories
    [Documentation]    Ensure expected C++ directories and files.
    [Tags]    cpp
    Directory Should Exist    ${SALWorkDir}/${subSystem}/cpp
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/cpp    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/libsacpp_${subSystem}_types.so
    Directory Should Exist    ${SALWorkDir}/idl-templates/validated/sal
    @{files}=    List Directory    ${SALWorkDir}/idl-templates/validated/sal    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/idl-templates/validated/sal/sal_${subSystem}.idl

Verify CBP Telemetry directories
    [Tags]    cpp
    @{files}=    List Directory    ${SALWorkDir}    pattern=*${subSystem}*
    Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/${subSystem}_status
    Directory Should Exist    ${SALWorkDir}/${subSystem}_mask
    Directory Should Exist    ${SALWorkDir}/${subSystem}_azimuth
    Directory Should Exist    ${SALWorkDir}/${subSystem}_altitude
    Directory Should Exist    ${SALWorkDir}/${subSystem}_focus
    Directory Should Exist    ${SALWorkDir}/${subSystem}_parked

Verify CBP C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}_status/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_status/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_mask/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_mask/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_azimuth/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_azimuth/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_altitude/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_altitude/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_focus/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_focus/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_parked/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_parked/cpp/standalone/sacpp_${subSystem}_sub

Verify CBP C++ Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_clearFault_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_clearFault_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_moveAzimuth_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_moveAzimuth_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_moveAltitude_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_moveAltitude_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_changeMask_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_changeMask_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setFocus_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_setFocus_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_park_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_park_controller

Salgen CBP Python
    [Documentation]    Generate Python wrapper.
    [Tags]    python
    ${output}=    Run    ${SALHome}/scripts/salgenerator ${subSystem} sal python
    Log    ${output}
    Should Contain    ${output}    SAL generator - ${SALVersion}
    Should Contain    ${output}    Generating Python SAL support for ${subSystem}
    Should Contain    ${output}    Generating Python bindings
    Should Contain    ${output}    python : Done SALPY_${subSystem}.so
    Directory Should Exist    ${SALWorkDir}/${subSystem}/python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/SALPY_${subSystem}.so

Verify CBP Python Telemetry Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_status_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_status_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_mask_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_mask_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_azimuth_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_azimuth_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_altitude_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_altitude_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_focus_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_focus_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_parked_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_parked_Subscriber.py

Verify CBP Python Command Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_clearFault.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_clearFault.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_moveAzimuth.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_moveAzimuth.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_moveAltitude.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_moveAltitude.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_changeMask.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_changeMask.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_setFocus.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_setFocus.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_park.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_park.py

Salgen CBP LabVIEW
    [Documentation]    Generate ${subSystem} low-level LabView interfaces.
    [Tags]    labview
    ${output}=    Run    ${SALHome}/scripts/salgenerator ${subSystem} labview
    Log    ${output}
    Should Contain    ${output}    SAL generator - ${SALVersion}
    Directory Should Exist    ${SALWorkDir}/${subSystem}/labview
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/labview
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/labview/SAL_${subSystem}_salShmMonitor.cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/labview/SAL_${subSystem}_shmem.h
    File Should Exist    ${SALWorkDir}/${subSystem}/labview/SALLV_${subSystem}.so
    File Should Exist    ${SALWorkDir}/${subSystem}/labview/SALLV_${subSystem}_Monitor

Salgen CBP Java
    [Documentation]    Generate Java wrapper.
    [Tags]    java
    ${output}=    Run    ${SALHome}/scripts/salgenerator ${subSystem} sal java
    Log    ${output}
    Should Contain    ${output}    SAL generator - ${SALVersion}
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_status.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_mask.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_azimuth.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_altitude.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_focus.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_parked.idl
    Should Contain X Times    ${output}    javac : Done Publisher    6
    Should Contain X Times    ${output}    javac : Done Subscriber    6
    Should Contain X Times    ${output}    javac : Done Commander/Controller    6
    Should Contain X Times    ${output}    javac : Done Event/Logger    6
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl

Salgen CBP Lib
    [Documentation]    Generate the SAL shared library for ${subSystem}
    [Tags]    
    ${output}=    Run    ${SALHome}/scripts/salgenerator ${subSystem} lib
    Log    ${output}
    Should Contain    ${output}    SAL generator - ${SALVersion}
    Should Contain    ${output}    Building shared library for ${subSystem} subsystem
    Directory Should Exist    ${SALWorkDir}/lib
    @{files}=    List Directory    ${SALWorkDir}/lib
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/lib/libsacpp_${subSystem}_types.so
    File Should Exist    ${SALWorkDir}/lib/libSAL_${subSystem}.so
    File Should Exist    ${SALWorkDir}/lib/SALLV_${subSystem}.so
    File Should Exist    ${SALWorkDir}/lib/SALPY_${subSystem}.so

Salgen CBP Maven
    [Documentation]    Generate the Maven repository.
    [Tags]    java
    ${output}=    Run    ${SALHome}/scripts/salgenerator ${subSystem} maven
    Log    ${output}
    Should Contain    ${output}    SAL generator - ${SALVersion}
    Should Contain    ${output}    Running maven install
    Should Contain    ${output}    [INFO] Building sal_${subSystem} ${SALVersion}
    Should Contain X Times    ${output}    [INFO] BUILD SUCCESS    1
    Should Contain X Times    ${output}    [INFO] Finished at:    1
    @{files}=    List Directory    ${SALWorkDir}/maven
    File Should Exist    ${SALWorkDir}/maven/${subSystem}_${SALVersion}/pom.xml

