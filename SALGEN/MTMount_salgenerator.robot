*** Settings ***
Documentation    This suite builds the various interfaces for the MTMount.
Force Tags    salgen    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${timeout}
Library    OperatingSystem
Library    Process
Resource    ../Global_Vars.resource

*** Variables ***
${subSystem}    MTMount
${timeout}    1200s

*** Test Cases ***
Verify MTMount XML Defintions exist
    [Tags]
    Comment    Verify the CSC XML definition files exist.
    ${output}    Run Process    ls     ${SALWorkDir}/MTMount_*.xml    shell=True
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stderr}    No such file or directory    msg="MTMount has no XML defintions"    values=False
    Should Not Be Empty    ${output.stdout}
    File Should Exist    ${SALWorkDir}/MTMount_Commands.xml
    File Should Exist    ${SALWorkDir}/MTMount_Events.xml
    File Should Exist    ${SALWorkDir}/MTMount_Telemetry.xml

Salgen MTMount Validate
    [Documentation]    Validate the MTMount XML definitions.
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
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_Auxliary_Cabinet_Azimuth.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_General.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_Azimuth_Cable_Wrap.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_Azimuth.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_Azimuth_Drives.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_Azimuth_Drives_Thermal.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_OSS.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_OSS2.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_OSS4.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_OSS5.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_OSS6.idl
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
    [Tags]    html    
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    html    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Generating telemetry stream definition editor html
    Should Contain    ${output.stdout}    Generating Facility database table creation html
    Should Contain    ${output.stdout}    Generating Subsystem simulation control html
    @{files}=    List Directory    ${SALWorkDir}/html/${subSystem}
    File Should Exist    ${SALWorkDir}/html/${subSystem}/MTMount_Commands.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/MTMount_Events.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/MTMount_Telemetry.html
    @{files}=    List Directory    ${SALWorkDir}/html/dbsimulate    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/html/dbsimulate/index-dbsimulate.html
    File Should Exist    ${SALWorkDir}/html/dbsimulate/index-dbsimulate-${subSystem}.html
    File Should Exist    ${SALWorkDir}/html/dbsimulate/index-simulate-${subSystem}.html
    File Should Exist    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl

Verify MTMount revCodes File
    [Documentation]    Ensure MTMount_revCodes.tcl contains 1 revcode per topic.
    [Tags]    html    
    ${output}=    Log File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_closeMirrorCover\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_configure\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_disableCamWrap\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_enableCamWrap\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_moveToTarget\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_openMirrorCover\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_trackTarget\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_clearerror\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_mountState\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_mountWarning\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_mountError\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_mountInPosition\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_Auxliary_Cabinet_Azimuth\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_General\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_Azimuth_Cable_Wrap\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_Azimuth\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_Azimuth_Drives\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_Azimuth_Drives_Thermal\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_OSS\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_OSS2\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_OSS4\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_OSS5\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_OSS6\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_Main_Power_Supply\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_Encoder_EIB\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_Balancing_Drives\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_Balancing\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_Elevation\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_Elevation_Drives\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_Locking_Pins\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_Camera_Cable_Wrap\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_Deployable_Platforms\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_Elevation_Drives_Thermal\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_Mirror_Cover\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_Mount_Control_Main_Cabinet\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_Top_End_Chiller\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_Mirror_Cover_Locks\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_Main_Power_Supply_Cabinet\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_Auxiliary_Boxes\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_Compressed_Air\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_Cooling\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_Dynalene_Cooling\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_General_Purpose_Glycol_Water\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_Safety_System\\) [a-z0-9]{8,}

Salgen MTMount IDL
    [Documentation]    Generate the revCoded IDL for ${subSystem}
    [Tags]    idl
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    sal    idl    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Completed ${subSystem} validation
    File Should Exist    ${SALWorkDir}/${subSystem}/sal_revCoded_${subSystem}.idl
    @{files}=    List Directory    ${SALWorkDir}/idl-templates/validated/
    Log Many    @{files}

Salgen MTMount C++
    [Documentation]    Generate C++ wrapper.
    [Tags]    cpp
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    sal    cpp   shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stdout}    *** DDS error in file
    Should Not Contain    ${output.stdout}    Error 1
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_Auxliary_Cabinet_Azimuth.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_General.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_Azimuth_Cable_Wrap.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_Azimuth.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_Azimuth_Drives.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_Azimuth_Drives_Thermal.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_OSS.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_OSS2.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_OSS4.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_OSS5.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_OSS6.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_Main_Power_Supply.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_Encoder_EIB.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_Balancing_Drives.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_Balancing.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_Elevation.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_Elevation_Drives.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_Locking_Pins.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_Camera_Cable_Wrap.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_Deployable_Platforms.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_Elevation_Drives_Thermal.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_Mirror_Cover.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_Mount_Control_Main_Cabinet.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_Top_End_Chiller.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_Mirror_Cover_Locks.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_Main_Power_Supply_Cabinet.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_Auxiliary_Boxes.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_Compressed_Air.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_Cooling.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_Dynalene_Cooling.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_General_Purpose_Glycol_Water.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_Safety_System.idl
    Should Contain X Times    ${output.stdout}    cpp : Done Publisher    32
    Should Contain X Times    ${output.stdout}    cpp : Done Subscriber    32
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
    Directory Should Exist    ${SALWorkDir}/${subSystem}_OSS2
    Directory Should Exist    ${SALWorkDir}/${subSystem}_OSS4
    Directory Should Exist    ${SALWorkDir}/${subSystem}_OSS5
    Directory Should Exist    ${SALWorkDir}/${subSystem}_OSS6
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
    File Should Exist    ${SALWorkDir}/${subSystem}_OSS2/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_OSS2/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_OSS4/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_OSS4/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_OSS5/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_OSS5/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_OSS6/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_OSS6/cpp/standalone/sacpp_${subSystem}_sub
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
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_OSS2_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_OSS2_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_OSS4_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_OSS4_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_OSS5_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_OSS5_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_OSS6_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_OSS6_Subscriber.py
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

Salgen MTMount Java
    [Documentation]    Generate Java wrapper.
    [Tags]    java    DM-18229
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    sal    java    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_Auxliary_Cabinet_Azimuth.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_General.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_Azimuth_Cable_Wrap.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_Azimuth.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_Azimuth_Drives.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_Azimuth_Drives_Thermal.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_OSS.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_OSS2.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_OSS4.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_OSS5.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_OSS6.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_Main_Power_Supply.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_Encoder_EIB.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_Balancing_Drives.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_Balancing.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_Elevation.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_Elevation_Drives.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_Locking_Pins.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_Camera_Cable_Wrap.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_Deployable_Platforms.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_Elevation_Drives_Thermal.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_Mirror_Cover.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_Mount_Control_Main_Cabinet.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_Top_End_Chiller.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_Mirror_Cover_Locks.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_Main_Power_Supply_Cabinet.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_Auxiliary_Boxes.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_Compressed_Air.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_Cooling.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_Dynalene_Cooling.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_General_Purpose_Glycol_Water.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_Safety_System.idl
    Should Contain X Times    ${output.stdout}    javac : Done Publisher    32
    Should Contain X Times    ${output.stdout}    javac : Done Subscriber    32
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl
    File Should Exist    ${SALWorkDir}/${subSystem}/java/saj_${subSystem}_types.jar
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl

Salgen MTMount Lib
    [Documentation]    Generate the SAL shared library for ${subSystem}
    [Tags]    lib    DM-18229
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

Salgen MTMount RPM
    [Documentation]    Generate the SAL library RPM for ${subSystem}
    [Tags]    rpm    DM-18229
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

Salgen MTMount Maven
    [Documentation]    Generate the Maven repository.
    [Tags]    java    DM-18229
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

