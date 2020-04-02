*** Settings ***
Documentation    This suite builds the various interfaces for the MTM2.
Force Tags    salgen    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${timeout}
Library    OperatingSystem
Library    Process
Resource    ../Global_Vars.resource

*** Variables ***
${subSystem}    MTM2
${timeout}    1200s

*** Test Cases ***
Verify MTM2 XML Defintions exist
    [Tags]
    Comment    Verify the CSC XML definition files exist.
    ${output}    Run Process    ls     ${SALWorkDir}/MTM2_*.xml    shell=True
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stderr}    No such file or directory    msg="MTM2 has no XML defintions"    values=False
    Should Not Be Empty    ${output.stdout}
    File Should Exist    ${SALWorkDir}/MTM2_Commands.xml
    File Should Exist    ${SALWorkDir}/MTM2_Events.xml
    File Should Exist    ${SALWorkDir}/MTM2_Telemetry.xml

Salgen MTM2 Validate
    [Documentation]    Validate the MTM2 XML definitions.
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
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_mirrorPositionMeasured.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_axialForceData.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_tangentForceData.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_temperaturesMeasured.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_zenithAngleData.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_axialActuatorSteps.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_tangentActuatorSteps.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_axialEncoderPositions.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_tangentEncoderPositions.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_ilcData.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_displacementSensors.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_netForcesTotal.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_netMomentsTotal.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_applyForces.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_positionMirror.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_resetForceOffsets.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_command_clearErrors.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_m2AssemblyInPosition.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_cellTemperatureHiWarning.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_detailedState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_commandableByDDS.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_interlock.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_tcpIpConnected.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_hardpointList.idl

Salgen MTM2 HTML
    [Documentation]    Create web form interfaces.
    [Tags]    html    
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    html    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Generating telemetry stream definition editor html
    Should Contain    ${output.stdout}    Generating Facility database table creation html
    Should Contain    ${output.stdout}    Generating Subsystem simulation control html
    @{files}=    List Directory    ${SALWorkDir}/html/${subSystem}
    File Should Exist    ${SALWorkDir}/html/${subSystem}/MTM2_Commands.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/MTM2_Events.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/MTM2_Telemetry.html
    @{files}=    List Directory    ${SALWorkDir}/html/dbsimulate    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/html/dbsimulate/index-dbsimulate.html
    File Should Exist    ${SALWorkDir}/html/dbsimulate/index-dbsimulate-${subSystem}.html
    File Should Exist    ${SALWorkDir}/html/dbsimulate/index-simulate-${subSystem}.html
    File Should Exist    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl

Verify MTM2 revCodes File
    [Documentation]    Ensure MTM2_revCodes.tcl contains 1 revcode per topic.
    [Tags]    html    
    ${output}=    Log File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_applyForces\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_positionMirror\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_resetForceOffsets\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_command_clearErrors\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_m2AssemblyInPosition\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_cellTemperatureHiWarning\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_detailedState\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_commandableByDDS\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_interlock\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_tcpIpConnected\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_hardpointList\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_mirrorPositionMeasured\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_axialForceData\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_tangentForceData\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_temperaturesMeasured\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_zenithAngleData\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_axialActuatorSteps\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_tangentActuatorSteps\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_axialEncoderPositions\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_tangentEncoderPositions\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_ilcData\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_displacementSensors\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_netForcesTotal\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_netMomentsTotal\\) [a-z0-9]{8,}

Salgen MTM2 C++
    [Documentation]    Generate C++ wrapper.
    [Tags]    cpp
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    sal    cpp   shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stdout}    *** DDS error in file
    Should Not Contain    ${output.stdout}    Error 1
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_mirrorPositionMeasured.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_axialForceData.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_tangentForceData.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_temperaturesMeasured.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_zenithAngleData.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_axialActuatorSteps.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_tangentActuatorSteps.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_axialEncoderPositions.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_tangentEncoderPositions.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_ilcData.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_displacementSensors.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_netForcesTotal.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_netMomentsTotal.idl
    Should Contain X Times    ${output.stdout}    cpp : Done Publisher    13
    Should Contain X Times    ${output.stdout}    cpp : Done Subscriber    13
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

Verify MTM2 Telemetry directories
    [Tags]    cpp
    @{files}=    List Directory    ${SALWorkDir}    pattern=*${subSystem}*
    Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/${subSystem}_mirrorPositionMeasured
    Directory Should Exist    ${SALWorkDir}/${subSystem}_axialForceData
    Directory Should Exist    ${SALWorkDir}/${subSystem}_tangentForceData
    Directory Should Exist    ${SALWorkDir}/${subSystem}_temperaturesMeasured
    Directory Should Exist    ${SALWorkDir}/${subSystem}_zenithAngleData
    Directory Should Exist    ${SALWorkDir}/${subSystem}_axialActuatorSteps
    Directory Should Exist    ${SALWorkDir}/${subSystem}_tangentActuatorSteps
    Directory Should Exist    ${SALWorkDir}/${subSystem}_axialEncoderPositions
    Directory Should Exist    ${SALWorkDir}/${subSystem}_tangentEncoderPositions
    Directory Should Exist    ${SALWorkDir}/${subSystem}_ilcData
    Directory Should Exist    ${SALWorkDir}/${subSystem}_displacementSensors
    Directory Should Exist    ${SALWorkDir}/${subSystem}_netForcesTotal
    Directory Should Exist    ${SALWorkDir}/${subSystem}_netMomentsTotal

Verify MTM2 C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}_mirrorPositionMeasured/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_mirrorPositionMeasured/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_axialForceData/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_axialForceData/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_tangentForceData/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_tangentForceData/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_temperaturesMeasured/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_temperaturesMeasured/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_zenithAngleData/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_zenithAngleData/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_axialActuatorSteps/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_axialActuatorSteps/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_tangentActuatorSteps/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_tangentActuatorSteps/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_axialEncoderPositions/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_axialEncoderPositions/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_tangentEncoderPositions/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_tangentEncoderPositions/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_ilcData/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_ilcData/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_displacementSensors/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_displacementSensors/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_netForcesTotal/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_netForcesTotal/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_netMomentsTotal/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_netMomentsTotal/cpp/standalone/sacpp_${subSystem}_sub

Verify MTM2 C++ Command Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_applyForces_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_applyForces_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_positionMirror_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_positionMirror_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_resetForceOffsets_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_resetForceOffsets_controller
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_clearErrors_commander
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_clearErrors_controller

Verify MTM2 C++ Event Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m2AssemblyInPosition_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_m2AssemblyInPosition_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_cellTemperatureHiWarning_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_cellTemperatureHiWarning_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_detailedState_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_detailedState_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_commandableByDDS_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_commandableByDDS_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_interlock_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_interlock_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_tcpIpConnected_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_tcpIpConnected_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_hardpointList_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_hardpointList_log

Salgen MTM2 Python
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

Verify MTM2 Python Telemetry Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_mirrorPositionMeasured_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_mirrorPositionMeasured_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_axialForceData_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_axialForceData_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_tangentForceData_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_tangentForceData_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_temperaturesMeasured_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_temperaturesMeasured_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_zenithAngleData_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_zenithAngleData_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_axialActuatorSteps_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_axialActuatorSteps_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_tangentActuatorSteps_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_tangentActuatorSteps_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_axialEncoderPositions_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_axialEncoderPositions_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_tangentEncoderPositions_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_tangentEncoderPositions_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_ilcData_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_ilcData_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_displacementSensors_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_displacementSensors_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_netForcesTotal_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_netForcesTotal_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_netMomentsTotal_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_netMomentsTotal_Subscriber.py

Verify MTM2 Python Command Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_applyForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_applyForces.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_positionMirror.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_positionMirror.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_resetForceOffsets.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_resetForceOffsets.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Commander_clearErrors.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Controller_clearErrors.py

Verify MTM2 Python Event Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_m2AssemblyInPosition.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_m2AssemblyInPosition.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_cellTemperatureHiWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_cellTemperatureHiWarning.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_detailedState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_detailedState.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_commandableByDDS.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_commandableByDDS.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_interlock.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_interlock.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_tcpIpConnected.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_tcpIpConnected.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_hardpointList.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_hardpointList.py

Salgen MTM2 LabVIEW
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

Salgen MTM2 Java
    [Documentation]    Generate Java wrapper.
    [Tags]    java
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    sal    java    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_mirrorPositionMeasured.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_axialForceData.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_tangentForceData.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_temperaturesMeasured.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_zenithAngleData.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_axialActuatorSteps.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_tangentActuatorSteps.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_axialEncoderPositions.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_tangentEncoderPositions.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_ilcData.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_displacementSensors.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_netForcesTotal.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_netMomentsTotal.idl
    Should Contain X Times    ${output.stdout}    javac : Done Publisher    13
    Should Contain X Times    ${output.stdout}    javac : Done Subscriber    13
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl
    File Should Exist    ${SALWorkDir}/${subSystem}/java/saj_${subSystem}_types.jar
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl

Salgen MTM2 Lib
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

Salgen MTM2 RPM
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

Salgen MTM2 Maven
    [Documentation]    Generate the Maven repository.
    [Tags]    java
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    maven    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Running maven install
    Should Contain    ${output.stdout}    [INFO] Building sal_${subSystem} ${SALVersion}
    Should Contain X Times    ${output.stdout}    [INFO] BUILD SUCCESS    1
    Should Contain X Times    ${output.stdout}    [INFO] Finished at:    1
    @{files}=    List Directory    ${SALWorkDir}/maven
    File Should Exist    ${SALWorkDir}/maven/${subSystem}_${SALVersion}/pom.xml

Cleanup stdout and stderr Files
    [Tags]
    Remove Files    ${EXECDIR}${/}${subSystem}_stdout.txt    ${EXECDIR}${/}${subSystem}_stderr.txt

