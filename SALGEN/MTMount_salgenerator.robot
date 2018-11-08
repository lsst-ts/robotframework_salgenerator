*** Settings ***
Documentation    This suite builds the various interfaces for the MTMount.
Force Tags    salgen    
Suite Setup    Run Keywords    Log Many    ${Host}    ${subSystem}    ${timeout}
...    AND    Create Session    SALGEN
Suite Teardown    Close All Connections
Library    SSHLibrary
Resource    ../Global_Vars.robot
Resource    ../common.robot

*** Variables ***
${subSystem}    MTMount
${timeout}    1200s

*** Test Cases ***
Verify MTMount XML Defintions exist
    [Tags]
    Comment    Verify the CSC XML definition files exist.
    File Should Exist    ${SALWorkDir}/MTMount_Commands.xml
    File Should Exist    ${SALWorkDir}/MTMount_Events.xml
    File Should Exist    ${SALWorkDir}/MTMount_Telemetry.xml

Salgen MTMount Validate
    [Documentation]    Validate the MTMount XML definitions.
    [Tags]
    ${input}=    Write    cd ${SALWorkDir}
    ${output}=    Read Until Prompt
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} validate
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - ${SALVersion}
    Should Contain    ${output}    Processing ${subSystem}
    Should Contain    ${output}    Completed ${subSystem} validation
    Directory Should Exist    ${SALWorkDir}/idl-templates
    Directory Should Exist    ${SALWorkDir}/idl-templates/validated
    @{files}=    List Directory    ${SALWorkDir}/idl-templates    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_Auxliary_Cabinet_Azimuth.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_General.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_Azimuth_Cable_Wrap.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_Azimuth.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_Azimuth_Drives.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_Azimuth_Drives_Thermal.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_OSS.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_Main_Power_Supply.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_Encoder_EIB.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_Balancing_Drives.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_Balancing.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_Elevation.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_Elevation_Drives.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_Locking_Pins.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_Camera_Cable_Wrap.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_Deployable_Platforms.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_Elevation_Drives_Thermal.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_Mirror_Cover.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_Mount_Control_Main_Cabinet.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_Top_End_Chiller.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_Mirror_Cover_Locks.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_Main_Power_Supply_Cabinet.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_Auxiliary_Boxes.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_Compressed_Air.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_Cooling.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_Dynalene_Cooling.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_General_Purpose_Glycol_Water.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_Safety_System.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_closeMirrorCover.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_configure.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_disableCamWrap.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_enableCamWrap.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_moveToTarget.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_openMirrorCover.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_trackTarget.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_clearerror.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_mountState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_mountWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_mountError.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_mountInPosition.idl

Salgen MTMount HTML
    [Documentation]    Create web form interfaces.
    [Tags]    html    TSS-3079
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} html
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - ${SALVersion}
    Should Contain    ${output}    Generating telemetry stream definition editor html
    Should Contain    ${output}    Creating sal-generator-${subSystem} form
    Should Contain    ${output}    Added sal-generator-${subSystem}.Auxliary_Cabinet_Azimuth to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.General to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.Azimuth_Cable_Wrap to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.Azimuth to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.Azimuth_Drives to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.Azimuth_Drives_Thermal to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.OSS to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.Main_Power_Supply to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.Encoder_EIB to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.Balancing_Drives to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.Balancing to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.Elevation to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.Elevation_Drives to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.Locking_Pins to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.Camera_Cable_Wrap to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.Deployable_Platforms to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.Elevation_Drives_Thermal to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.Mirror_Cover to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.Mount_Control_Main_Cabinet to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.Top_End_Chiller to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.Mirror_Cover_Locks to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.Main_Power_Supply_Cabinet to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.Auxiliary_Boxes to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.Compressed_Air to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.Cooling to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.Dynalene_Cooling to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.General_Purpose_Glycol_Water to form
    Should Contain    ${output}    Added sal-generator-${subSystem}.Safety_System to form
    Directory Should Exist    ${SALWorkDir}/html/salgenerator/${subSystem}
    @{files}=    List Directory    ${SALWorkDir}/html/salgenerator/${subSystem}    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/html/${subSystem}/MTMount_Commands.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/MTMount_Events.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/MTMount_Telemetry.html

Salgen MTMount C++
    [Documentation]    Generate C++ wrapper.
    [Tags]    cpp
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} sal cpp
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Not Contain    ${output}    *** DDS error in file
    Should Not Contain    ${output}    Error 1
    Should Contain    ${output}    SAL generator - ${SALVersion}
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_Auxliary_Cabinet_Azimuth.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_General.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_Azimuth_Cable_Wrap.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_Azimuth.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_Azimuth_Drives.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_Azimuth_Drives_Thermal.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_OSS.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_Main_Power_Supply.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_Encoder_EIB.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_Balancing_Drives.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_Balancing.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_Elevation.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_Elevation_Drives.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_Locking_Pins.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_Camera_Cable_Wrap.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_Deployable_Platforms.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_Elevation_Drives_Thermal.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_Mirror_Cover.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_Mount_Control_Main_Cabinet.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_Top_End_Chiller.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_Mirror_Cover_Locks.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_Main_Power_Supply_Cabinet.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_Auxiliary_Boxes.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_Compressed_Air.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_Cooling.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_Dynalene_Cooling.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_General_Purpose_Glycol_Water.idl
    Should Contain    ${output}    Generating SAL CPP code for ${subSystem}_Safety_System.idl
    Should Contain X Times    ${output}    cpp : Done Publisher    28
    Should Contain X Times    ${output}    cpp : Done Subscriber    28
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

Verify MTMount Telemetry directories
    [Tags]    cpp
    @{files}=    List Directory    ${SALWorkDir}    pattern=*${subSystem}*
    Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Auxliary_Cabinet_Azimuth
    Directory Should Exist    ${SALWorkDir}/${subSystem}_General
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Azimuth_Cable_Wrap
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Azimuth
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Azimuth_Drives
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Azimuth_Drives_Thermal
    Directory Should Exist    ${SALWorkDir}/${subSystem}_OSS
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Main_Power_Supply
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Encoder_EIB
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Balancing_Drives
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Balancing
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Elevation
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Elevation_Drives
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Locking_Pins
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Camera_Cable_Wrap
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Deployable_Platforms
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Elevation_Drives_Thermal
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Mirror_Cover
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Mount_Control_Main_Cabinet
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Top_End_Chiller
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Mirror_Cover_Locks
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Main_Power_Supply_Cabinet
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Auxiliary_Boxes
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Compressed_Air
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Cooling
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Dynalene_Cooling
    Directory Should Exist    ${SALWorkDir}/${subSystem}_General_Purpose_Glycol_Water
    Directory Should Exist    ${SALWorkDir}/${subSystem}_Safety_System

Verify MTMount C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}_Auxliary_Cabinet_Azimuth/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_Auxliary_Cabinet_Azimuth/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_General/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_General/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_Azimuth_Cable_Wrap/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_Azimuth_Cable_Wrap/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_Azimuth/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_Azimuth/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_Azimuth_Drives/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_Azimuth_Drives/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_Azimuth_Drives_Thermal/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_Azimuth_Drives_Thermal/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_OSS/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_OSS/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_Main_Power_Supply/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_Main_Power_Supply/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_Encoder_EIB/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_Encoder_EIB/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_Balancing_Drives/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_Balancing_Drives/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_Balancing/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_Balancing/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_Elevation/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_Elevation/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_Elevation_Drives/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_Elevation_Drives/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_Locking_Pins/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_Locking_Pins/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_Camera_Cable_Wrap/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_Camera_Cable_Wrap/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_Deployable_Platforms/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_Deployable_Platforms/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_Elevation_Drives_Thermal/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_Elevation_Drives_Thermal/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_Mirror_Cover/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_Mirror_Cover/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_Mount_Control_Main_Cabinet/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_Mount_Control_Main_Cabinet/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_Top_End_Chiller/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_Top_End_Chiller/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_Mirror_Cover_Locks/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_Mirror_Cover_Locks/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_Main_Power_Supply_Cabinet/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_Main_Power_Supply_Cabinet/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_Auxiliary_Boxes/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_Auxiliary_Boxes/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_Compressed_Air/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_Compressed_Air/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_Cooling/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_Cooling/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_Dynalene_Cooling/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_Dynalene_Cooling/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_General_Purpose_Glycol_Water/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_General_Purpose_Glycol_Water/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_Safety_System/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_Safety_System/cpp/standalone/sacpp_${subSystem}_sub

Verify MTMount C++ Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_closeMirrorCover_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_closeMirrorCover_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_configure_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_configure_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_disableCamWrap_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_disableCamWrap_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enableCamWrap_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_enableCamWrap_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_moveToTarget_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_moveToTarget_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_openMirrorCover_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_openMirrorCover_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_trackTarget_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_trackTarget_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_clearerror_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_clearerror_controller

Verify MTMount C++ Event Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_mountState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_mountState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_mountWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_mountWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_mountError_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_mountError_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_mountInPosition_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_mountInPosition_log

Salgen MTMount Python
    [Documentation]    Generate Python wrapper.
    [Tags]    python
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} sal python
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - ${SALVersion}
    Should Contain    ${output}    Generating Python SAL support for ${subSystem}
    Should Contain    ${output}    Generating Python bindings
    Should Contain    ${output}    python : Done SALPY_${subSystem}.so
    Directory Should Exist    ${SALWorkDir}/${subSystem}/python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/SALPY_${subSystem}.so

Verify MTMount Python Telemetry Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Auxliary_Cabinet_Azimuth_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Auxliary_Cabinet_Azimuth_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_General_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_General_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Azimuth_Cable_Wrap_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Azimuth_Cable_Wrap_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Azimuth_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Azimuth_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Azimuth_Drives_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Azimuth_Drives_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Azimuth_Drives_Thermal_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Azimuth_Drives_Thermal_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_OSS_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_OSS_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Main_Power_Supply_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Main_Power_Supply_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Encoder_EIB_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Encoder_EIB_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Balancing_Drives_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Balancing_Drives_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Balancing_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Balancing_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Elevation_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Elevation_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Elevation_Drives_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Elevation_Drives_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Locking_Pins_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Locking_Pins_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Camera_Cable_Wrap_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Camera_Cable_Wrap_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Deployable_Platforms_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Deployable_Platforms_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Elevation_Drives_Thermal_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Elevation_Drives_Thermal_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Mirror_Cover_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Mirror_Cover_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Mount_Control_Main_Cabinet_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Mount_Control_Main_Cabinet_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Top_End_Chiller_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Top_End_Chiller_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Mirror_Cover_Locks_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Mirror_Cover_Locks_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Main_Power_Supply_Cabinet_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Main_Power_Supply_Cabinet_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Auxiliary_Boxes_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Auxiliary_Boxes_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Compressed_Air_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Compressed_Air_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Cooling_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Cooling_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Dynalene_Cooling_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Dynalene_Cooling_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_General_Purpose_Glycol_Water_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_General_Purpose_Glycol_Water_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Safety_System_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Safety_System_Subscriber.py

Verify MTMount Python Command Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_closeMirrorCover.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_closeMirrorCover.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_configure.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_configure.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_disableCamWrap.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_disableCamWrap.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_enableCamWrap.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_enableCamWrap.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_moveToTarget.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_moveToTarget.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_openMirrorCover.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_openMirrorCover.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_trackTarget.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_trackTarget.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_clearerror.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_clearerror.py

Verify MTMount Python Event Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_mountState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_mountState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_mountWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_mountWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_mountError.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_mountError.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_mountInPosition.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_mountInPosition.py

Salgen MTMount LabVIEW
    [Documentation]    Generate ${subSystem} low-level LabView interfaces.
    [Tags]    labview
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} labview
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - ${SALVersion}
    Directory Should Exist    ${SALWorkDir}/${subSystem}/labview
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/labview
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/labview/SAL_${subSystem}_salShmMonitor.cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/labview/SAL_${subSystem}_shmem.h
    File Should Exist    ${SALWorkDir}/${subSystem}/labview/SALLV_${subSystem}.so
    File Should Exist    ${SALWorkDir}/${subSystem}/labview/SALLV_${subSystem}_Monitor

Salgen MTMount Java
    [Documentation]    Generate Java wrapper.
    [Tags]    java
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} sal java
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - ${SALVersion}
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_Auxliary_Cabinet_Azimuth.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_General.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_Azimuth_Cable_Wrap.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_Azimuth.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_Azimuth_Drives.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_Azimuth_Drives_Thermal.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_OSS.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_Main_Power_Supply.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_Encoder_EIB.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_Balancing_Drives.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_Balancing.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_Elevation.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_Elevation_Drives.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_Locking_Pins.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_Camera_Cable_Wrap.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_Deployable_Platforms.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_Elevation_Drives_Thermal.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_Mirror_Cover.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_Mount_Control_Main_Cabinet.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_Top_End_Chiller.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_Mirror_Cover_Locks.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_Main_Power_Supply_Cabinet.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_Auxiliary_Boxes.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_Compressed_Air.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_Cooling.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_Dynalene_Cooling.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_General_Purpose_Glycol_Water.idl
    Should Contain    ${output}    Generating SAL Java code for ${subSystem}_Safety_System.idl
    Should Contain X Times    ${output}    javac : Done Publisher    28
    Should Contain X Times    ${output}    javac : Done Subscriber    28
    Should Contain X Times    ${output}    javac : Done Commander/Controller    28
    Should Contain X Times    ${output}    javac : Done Event/Logger    28
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl

Salgen MTMount Lib
    [Documentation]    Generate the SAL shared library for ${subSystem}
    [Tags]    
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} lib
    ${output}=    Read Until Prompt
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

Salgen MTMount Maven
    [Documentation]    Generate the Maven repository.
    [Tags]    java
    ${input}=    Write    ${SALHome}/scripts/salgenerator ${subSystem} maven
    ${output}=    Read Until Prompt
    Log    ${output}
    Should Contain    ${output}    SAL generator - ${SALVersion}
    Should Contain    ${output}    Running maven install
    Should Contain    ${output}    [INFO] Building sal_${subSystem} ${SALVersion}
    Should Contain X Times    ${output}    [INFO] BUILD SUCCESS    1
    Should Contain X Times    ${output}    [INFO] Finished at:    1
    @{files}=    List Directory    ${SALWorkDir}/maven
    File Should Exist    ${SALWorkDir}/maven/${subSystem}_${SALVersion}/pom.xml

