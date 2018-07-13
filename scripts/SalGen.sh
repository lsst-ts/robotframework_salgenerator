#!/bin/bash
#  Shellscript to create test suites to
#  create the various interfaces.
#
#  author: Rob Bovill
#  email:  rbovill@lsst.org

# Source common functions
workDir=$HOME/trunk/robotframework_salgenerator
source $workDir/scripts/_common.sh

#  Define variables to be used in script
arg=${1-all}
arg="$(echo ${arg} |tr 'A-Z' 'a-z')"
declare -a subSystemArray=($(subsystemArray))
declare -a stateArray=($(stateArray))

#  FUNCTIONS
function createSettings() {
    echo "*** Settings ***" >> $testSuite
    echo "Documentation    This suite builds the various interfaces for the $subSystemUp." >> $testSuite
	echo "Force Tags    salgen    $skipped" >> $testSuite
	echo "Suite Setup    Run Keywords    Log Many    \${Host}    \${subSystem}    \${timeout}" >> $testSuite
	echo "...    AND    Create Session    SALGEN" >> $testSuite
    echo "Suite Teardown    Close All Connections" >> $testSuite
    echo "Library    SSHLibrary" >> $testSuite
    echo "Resource    ../Global_Vars.robot" >> $testSuite
    echo "Resource    ../common.robot" >> $testSuite
	echo "" >> $testSuite
}

function createVariables() {
	entity=$(getEntity $1)
    echo "*** Variables ***" >> $testSuite
    echo "\${subSystem}    $entity" >> $testSuite
    echo "\${timeout}    1200s" >> $testSuite
    echo "" >> $testSuite
}

function verifyXMLDefinitions() {
    echo "Verify $subSystemUp XML Defintions exist" >> $testSuite
    echo "    [Tags]" >> $testSuite
	for file in "${xmls[@]}"; do
		echo "    File Should Exist    \${SALWorkDir}/$file" >> $testSuite
	done
    echo "" >> $testSuite
}

function salgenValidate() {
    echo "Salgen $subSystemUp Validate" >> $testSuite
    echo "    [Documentation]    Validate the $subSystemUp XML definitions." >> $testSuite
    echo "    [Tags]" >> $testSuite
    echo "    \${input}=    Write    cd \${SALWorkDir}" >> $testSuite
    echo "    \${output}=    Read Until Prompt" >> $testSuite
    echo "    \${input}=    Write    \${SALHome}/scripts/salgenerator \${subSystem} validate" >> $testSuite
    echo "    \${output}=    Read Until Prompt" >> $testSuite
    echo "    Log    \${output}" >> $testSuite
    echo "    Should Contain    \${output}    SAL generator - V\${SALVersion}" >> $testSuite
    echo "    Should Contain    \${output}    Processing \${subSystem}" >> $testSuite
    echo "    Should Contain    \${output}    Completed \${subSystem} validation" >> $testSuite
    echo "    Directory Should Exist    \${SALWorkDir}/idl-templates" >> $testSuite
    echo "    Directory Should Exist    \${SALWorkDir}/idl-templates/validated" >> $testSuite
    echo "    @{files}=    List Directory    \${SALWorkDir}/idl-templates    pattern=*\${subSystem}*" >> $testSuite
    echo "    Log Many    @{files}" >> $testSuite
	for topic in "${telemetryArray[@]}"; do
		echo "    File Should Exist    \${SALWorkDir}/idl-templates/\${subSystem}_${topic}.idl" >> $testSuite
	done
    for topic in "${stateArray[@]}"; do
        echo "    File Should Exist    \${SALWorkDir}/idl-templates/\${subSystem}_command_${topic}.idl" >> $testSuite
    done
    for topic in "${commandArray[@]}"; do
        echo "    File Should Exist    \${SALWorkDir}/idl-templates/\${subSystem}_command_${topic}.idl" >> $testSuite
    done
    for topic in "${eventArray[@]}"; do
        echo "    File Should Exist    \${SALWorkDir}/idl-templates/\${subSystem}_logevent_${topic}.idl" >> $testSuite
    done
    echo "" >> $testSuite
}

function salgenHTML() {
    echo "Salgen $subSystemUp HTML" >> $testSuite
    echo "    [Documentation]    Create web form interfaces." >> $testSuite
    echo "    [Tags]" >> $testSuite
    echo "    \${input}=    Write    \${SALHome}/scripts/salgenerator \${subSystem} html" >> $testSuite
    echo "    \${output}=    Read Until Prompt" >> $testSuite
    echo "    Log    \${output}" >> $testSuite
    echo "    Should Contain    \${output}    SAL generator - V\${SALVersion}" >> $testSuite
    echo "    Should Contain    \${output}    Generating telemetry stream definition editor html" >> $testSuite
    echo "    Should Contain    \${output}    Creating sal-generator-\${subSystem} form" >> $testSuite
    echo "    Should Contain    \${output}    Added sal-generator-\${subSystem}.logevent to form" >> $testSuite
    echo "    Directory Should Exist    \${SALWorkDir}/html/salgenerator/\${subSystem}" >> $testSuite
    echo "    @{files}=    List Directory    \${SALWorkDir}/html/salgenerator/\${subSystem}    pattern=*\${subSystem}*" >> $testSuite
    echo "    Log Many    @{files}" >> $testSuite
	for file in "${xmls[@]}"; do
		file=$(echo $file |sed "s/xml/html/")
        echo "    File Should Exist    \${SALWorkDir}/html/\${subSystem}/$file" >> $testSuite
    done
    echo "" >> $testSuite
}

function salgenCPP {
    echo "Salgen $subSystemUp C++" >> $testSuite
    echo "    [Documentation]    Generate C++ wrapper." >> $testSuite
    echo "    [Tags]    cpp" >> $testSuite
    echo "    \${input}=    Write    \${SALHome}/scripts/salgenerator \${subSystem} sal cpp" >> $testSuite
    echo "    \${output}=    Read Until Prompt" >> $testSuite
    echo "    Log    \${output}" >> $testSuite
    echo "    Should Not Contain    \${output}    *** DDS error in file" >> $testSuite
    echo "    Should Not Contain    \${output}    Error 1" >> $testSuite
    echo "    Should Contain    \${output}    SAL generator - V\${SALVersion}" >> $testSuite
	for topic in "${telemetryArray[@]}"; do
		echo "    Should Contain    \${output}    Generating SAL CPP code for \${subSystem}_${topic}.idl" >> $testSuite
	done
    if [ ${#telemetryArray[@]} -gt 0 ]; then
		echo "    Should Contain X Times    \${output}    cpp : Done Publisher    ${#telemetryArray[@]}" >> $testSuite
    	echo "    Should Contain X Times    \${output}    cpp : Done Subscriber    ${#telemetryArray[@]}" >> $testSuite
	fi
    echo "    Should Contain X Times    \${output}    cpp : Done Commander    1" >> $testSuite
    echo "    Should Contain X Times    \${output}    cpp : Done Event/Logger    1" >> $testSuite
    echo "" >> $testSuite
}

function verifyCppDirectories() {
	echo "Verify C++ Directories" >> $testSuite
    echo "    [Documentation]    Ensure expected C++ directories and files." >> $testSuite
    echo "    [Tags]    cpp" >> $testSuite
    echo "    Directory Should Exist    \${SALWorkDir}/\${subSystem}/cpp" >> $testSuite
    echo "    @{files}=    List Directory    \${SALWorkDir}/\${subSystem}/cpp    pattern=*\${subSystem}*" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/cpp/libsacpp_\${subSystem}_types.so" >> $testSuite
    echo "    Directory Should Exist    \${SALWorkDir}/idl-templates/validated/sal" >> $testSuite
    echo "    @{files}=    List Directory    \${SALWorkDir}/idl-templates/validated/sal    pattern=*\${subSystem}*" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/idl-templates/validated/sal/sal_\${subSystem}.idl" >> $testSuite
    echo "" >> $testSuite
}

function verifyTelemetryDirectories() {
    echo "Verify $subSystemUp Telemetry directories" >> $testSuite
    echo "    [Tags]    cpp" >> $testSuite
    echo "    @{files}=    List Directory    \${SALWorkDir}    pattern=*\${subSystem}*" >> $testSuite
    echo "    Log Many    @{files}" >> $testSuite
	for topic in "${telemetryArray[@]}"; do
		echo "    Directory Should Exist    \${SALWorkDir}/\${subSystem}_${topic}" >> $testSuite
	done
    echo "" >> $testSuite
}

function verifyCppTelemetryInterfaces() {
    echo "Verify $subSystemUp C++ Telemetry Interfaces" >> $testSuite
    echo "    [Documentation]    Verify the C++ interfaces were properly created." >> $testSuite
    echo "    [Tags]    cpp" >> $testSuite
    for topic in "${telemetryArray[@]}"; do
        echo "    File Should Exist    \${SALWorkDir}/\${subSystem}_${topic}/cpp/standalone/sacpp_\${subSystem}_pub" >> $testSuite
        echo "    File Should Exist    \${SALWorkDir}/\${subSystem}_${topic}/cpp/standalone/sacpp_\${subSystem}_sub" >> $testSuite
    done
    echo "" >> $testSuite
}

function verifyCppStateInterfaces() {
    echo "Verify $subSystemUp C++ State Command Interfaces" >> $testSuite
    echo "    [Documentation]    Verify the C++ interfaces were properly created." >> $testSuite
    echo "    [Tags]    cpp" >> $testSuite
    for state in "${stateArray[@]}"; do
		echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/cpp/src/sacpp_\${subSystem}_${state}_commander" >> $testSuite
        echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/cpp/src/sacpp_\${subSystem}_${state}_controller" >> $testSuite
	done
    echo "" >> $testSuite
}

function verifyCppCommandInterfaces() {
    echo "Verify $subSystemUp C++ Command Interfaces" >> $testSuite
    echo "    [Documentation]    Verify the C++ interfaces were properly created." >> $testSuite
    echo "    [Tags]    cpp" >> $testSuite
    for topic in "${commandArray[@]}"; do
        echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/cpp/src/sacpp_\${subSystem}_${topic}_commander" >> $testSuite
        echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/cpp/src/sacpp_\${subSystem}_${topic}_controller" >> $testSuite
    done
    echo "" >> $testSuite
}

function verifyCppEventInterfaces() {
    echo "Verify $subSystemUp C++ Event Interfaces" >> $testSuite
    echo "    [Documentation]    Verify the C++ interfaces were properly created." >> $testSuite
    echo "    [Tags]    cpp" >> $testSuite
    for topic in "${eventArray[@]}"; do
        echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/cpp/src/sacpp_\${subSystem}_${topic}_send" >> $testSuite
        echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/cpp/src/sacpp_\${subSystem}_${topic}_log" >> $testSuite
    done
    echo "" >> $testSuite
}

function salgenJava() {
    echo "Salgen $subSystemUp Java" >> $testSuite
    echo "    [Documentation]    Generate Java wrapper." >> $testSuite
    echo "    [Tags]    java" >> $testSuite
    echo "    \${input}=    Write    \${SALHome}/scripts/salgenerator \${subSystem} sal java" >> $testSuite
    echo "    \${output}=    Read Until Prompt" >> $testSuite
    echo "    Log    \${output}" >> $testSuite
    echo "    Should Contain    \${output}    SAL generator - V\${SALVersion}" >> $testSuite
	for topic in "${telemetryArray[@]}"; do
        echo "    Should Contain    \${output}    Generating SAL Java code for \${subSystem}_${topic}.idl" >> $testSuite
    done
	if [ ${#telemetryArray[@]} -gt 0 ]; then
		echo "    Should Contain X Times    \${output}    javac : Done Publisher    ${#telemetryArray[@]}" >> $testSuite
    	echo "    Should Contain X Times    \${output}    javac : Done Subscriber    ${#telemetryArray[@]}" >> $testSuite
	fi
    echo "    Should Contain X Times    \${output}    javac : Done Commander/Controller    ${#telemetryArray[@]}" >> $testSuite
    echo "    Should Contain X Times    \${output}    javac : Done Event/Logger    ${#telemetryArray[@]}" >> $testSuite
    echo "    Directory Should Exist    \${SALWorkDir}/\${subSystem}/java" >> $testSuite
    echo "    @{files}=    List Directory    \${SALWorkDir}/\${subSystem}/java    pattern=*\${subSystem}*" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/java/sal_\${subSystem}.idl" >> $testSuite
    echo "" >> $testSuite
}

function salgenMaven() {
    echo "Salgen $subSystemUp Maven" >> $testSuite
    echo "    [Documentation]    Generate the Maven repository." >> $testSuite
    echo "    [Tags]    java" >> $testSuite
    echo "    \${input}=    Write    \${SALHome}/scripts/salgenerator \${subSystem} maven" >> $testSuite
    echo "    \${output}=    Read Until Prompt" >> $testSuite
    echo "    Log    \${output}" >> $testSuite
    echo "    Should Contain    \${output}    SAL generator - V\${SALVersion}" >> $testSuite
    echo "    Should Contain    \${output}    Running maven install" >> $testSuite
    echo "    Should Contain    \${output}    [INFO] Building sal_\${subSystem} \${SALVersion}" >> $testSuite
    echo "    Should Contain X Times    \${output}    [INFO] BUILD SUCCESS    1" >> $testSuite
    echo "    Should Contain X Times    \${output}    [INFO] Finished at:    1" >> $testSuite
    echo "    @{files}=    List Directory    \${SALWorkDir}/maven" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/maven/\${subSystem}_\${SALVersion}/pom.xml" >> $testSuite
    echo "" >> $testSuite
}

function salgenPython() {
    echo "Salgen $subSystemUp Python" >> $testSuite
    echo "    [Documentation]    Generate Python wrapper." >> $testSuite
    echo "    [Tags]    python" >> $testSuite
    echo "    \${input}=    Write    \${SALHome}/scripts/salgenerator \${subSystem} sal python" >> $testSuite
    echo "    \${output}=    Read Until Prompt" >> $testSuite
    echo "    Log    \${output}" >> $testSuite
    echo "    Should Contain    \${output}    SAL generator - V\${SALVersion}" >> $testSuite
    echo "    Should Contain    \${output}    Generating Python SAL support for \${subSystem}" >> $testSuite
    echo "    Should Contain    \${output}    Generating Boost.Python bindings" >> $testSuite
    echo "    Should Contain    \${output}    python : Done SALPY_\${subSystem}.so" >> $testSuite
    echo "    Directory Should Exist    \${SALWorkDir}/\${subSystem}/python" >> $testSuite
    echo "    @{files}=    List Directory    \${SALWorkDir}/\${subSystem}/python    pattern=*\${subSystem}*" >> $testSuite
    echo "    Log Many    @{files}" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/cpp/src/SALPY_\${subSystem}.so" >> $testSuite
    echo "" >> $testSuite
}

function verifyPythonTelemetryInterfaces() {
    echo "Verify $subSystemUp Python Telemetry Interfaces" >> $testSuite
    echo "    [Documentation]    Verify the Python interfaces were properly created." >> $testSuite
    echo "    [Tags]    python" >> $testSuite
    echo "    @{files}=    List Directory    \${SALWorkDir}/\${subSystem}/python    pattern=*\${subSystem}*" >> $testSuite
    echo "    Log Many    @{files}" >> $testSuite
	for topic in "${telemetryArray[@]}"; do
        echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/python/\${subSystem}_${topic}_Publisher.py" >> $testSuite
        echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/python/\${subSystem}_${topic}_Subscriber.py" >> $testSuite
    done
    echo "" >> $testSuite
}

function verifyPythonStateInterfaces() {
    echo "Verify $subSystemUp Python State Command Interfaces" >> $testSuite
    echo "    [Documentation]    Verify the C++ interfaces were properly created." >> $testSuite
    echo "    [Tags]    python" >> $testSuite
    for state in "${stateArray[@]}"; do
        echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/python/\${subSystem}_Commander_${state}.py" >> $testSuite
        echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/python/\${subSystem}_Controller_${state}.py" >> $testSuite
    done
    echo "" >> $testSuite
}

function verifyPythonCommandInterfaces() {
    echo "Verify $subSystemUp Python Command Interfaces" >> $testSuite
    echo "    [Documentation]    Verify the Python interfaces were properly created." >> $testSuite
    echo "    [Tags]    python" >> $testSuite
    echo "    @{files}=    List Directory    \${SALWorkDir}/\${subSystem}/python    pattern=*\${subSystem}*" >> $testSuite
    echo "    Log Many    @{files}" >> $testSuite
    for topic in "${commandArray[@]}"; do
        echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/python/\${subSystem}_Commander_${topic}.py" >> $testSuite
        echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/python/\${subSystem}_Controller_${topic}.py" >> $testSuite
    done
    echo "" >> $testSuite
}

function verifyPythonEventInterfaces() {
    echo "Verify $subSystemUp Python Event Interfaces" >> $testSuite
    echo "    [Documentation]    Verify the Python interfaces were properly created." >> $testSuite
    echo "    [Tags]    python" >> $testSuite
    echo "    @{files}=    List Directory    \${SALWorkDir}/\${subSystem}/python    pattern=*\${subSystem}*" >> $testSuite
    echo "    Log Many    @{files}" >> $testSuite
    for topic in "${eventArray[@]}"; do
        echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/python/\${subSystem}_Event_${topic}.py" >> $testSuite
        echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/python/\${subSystem}_EventLogger_${topic}.py" >> $testSuite
    done
    echo "" >> $testSuite
}

function salgenLabview() {
    echo "Salgen $subSystemUp LabVIEW" >> $testSuite
    echo "    [Documentation]    Generate \${subSystem} low-level LabView interfaces." >> $testSuite
    echo "    [Tags]    labview" >> $testSuite
    echo "    \${input}=    Write    \${SALHome}/scripts/salgenerator \${subSystem} labview" >> $testSuite
    echo "    \${output}=    Read Until Prompt" >> $testSuite
    echo "    Log    \${output}" >> $testSuite
    echo "    Should Contain    \${output}    SAL generator - V\${SALVersion}" >> $testSuite
    echo "    Directory Should Exist    \${SALWorkDir}/\${subSystem}/labview" >> $testSuite
    echo "    @{files}=    List Directory    \${SALWorkDir}/\${subSystem}/labview" >> $testSuite
    echo "    Log Many    @{files}" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/labview/SAL_\${subSystem}_salShmMonitor.cpp" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/labview/SAL_\${subSystem}_shmem.h" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/labview/SALLV_\${subSystem}.so" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/\${subSystem}/labview/SALLV_\${subSystem}_Monitor" >> $testSuite
    echo "" >> $testSuite
}

function salgenLib() {
	echo "Salgen $subSystemUp Lib" >> $testSuite
    echo "    [Documentation]    Generate the SAL shared library for \${subSystem}" >> $testSuite
	echo "    [Tags]    " >> $testSuite
    echo "    \${input}=    Write    \${SALHome}/scripts/salgenerator \${subSystem} lib" >> $testSuite
    echo "    \${output}=    Read Until Prompt" >> $testSuite
    echo "    Log    \${output}" >> $testSuite
    echo "    Should Contain    \${output}    SAL generator - V\${SALVersion}" >> $testSuite
    echo "    Should Contain    \${output}    Building shared library for \${subSystem} subsystem" >> $testSuite
	echo "    Directory Should Exist    \${SALWorkDir}/lib" >> $testSuite
    echo "    @{files}=    List Directory    \${SALWorkDir}/lib" >> $testSuite
    echo "    Log Many    @{files}" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/lib/libsacpp_\${subSystem}_types.so" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/lib/libSAL_\${subSystem}.so" >> $testSuite
	if ! [ "$subSystem" == "scheduler" ]; then    # The SALLV_* files are produced by the labview option. This is skipped for the scheduler.
    	echo "    File Should Exist    \${SALWorkDir}/lib/SALLV_\${subSystem}.so" >> $testSuite
    fi
    echo "    File Should Exist    \${SALWorkDir}/lib/SALPY_\${subSystem}.so" >> $testSuite
    echo "" >> $testSuite
}

function createTestSuite() {
	subSystem=$1

	#  Define test suite name
	subSystemUp=$(capitializeSubsystem $subSystem)
	testSuite=$workDir/SALGEN/${subSystemUp}_salgenerator.robot
		
	#  Check to see if the TestSuite exists then, if it does, delete it.
	clearTestSuites $subSystem "SALGEN" 
		
	# Get XML topic definitions.  Not all subsystems have all types of topics.
	declare -a xmls=($(ls $HOME/trunk/ts_xml/sal_interfaces/$subSystem))
	# Declare topic arrays
	declare -a telemetryArray=($(getTelemetryTopics $subSystem))
	if [[ ${xmls[*]} =~ "${subSystem}_Commands.xml" ]]; then
		declare -a commandArray=($(getCommandTopics $subSystem))
	fi
	if [[ ${xmls[*]} =~ "${subSystem}_Events.xml" ]]; then
		declare -a eventArray=($(getEventTopics $subSystem))
	fi

    #  Check if test suite should be skipped.
    skipped=$(checkIfSkipped $subSystem $topic)

	#  Create test suite.
	echo Creating $testSuite
	createSettings
	createVariables $subSystem
	echo "*** Test Cases ***" >> $testSuite
    verifyXMLDefinitions
	salgenValidate
	salgenHTML
	# Create and verify C++ interfaces.
	salgenCPP
	verifyCppDirectories
	if [[ ${xmls[*]} =~ "${subSystem}_Telemetry.xml" ]]; then
		verifyTelemetryDirectories
		verifyCppTelemetryInterfaces
	fi
	verifyCppStateInterfaces
	if [[ ${xmls[*]} =~ "${subSystem}_Commands.xml" ]]; then
		verifyCppCommandInterfaces
	fi
	if [[ ${xmls[*]} =~ "${subSystem}_Events.xml" ]]; then
		verifyCppEventInterfaces
    fi
	# Create and verify Python interfaces.
    salgenPython
	if [[ ${xmls[*]} =~ "${subSystem}_Telemetry.xml" ]]; then
    	verifyPythonTelemetryInterfaces
	fi
    verifyPythonStateInterfaces
    if [[ ${xmls[*]} =~ "${subSystem}_Commands.xml" ]]; then
		verifyPythonCommandInterfaces
	fi
	if [[ ${xmls[*]} =~ "${subSystem}_Events.xml" ]]; then
		verifyPythonEventInterfaces
	fi
	# Create LabVIEW interfaces.  NOTE: There are NO such scheduler interfaces.
	if ! [ "$subSystem" == "scheduler" ]; then
		salgenLabview
	fi
	# Create and verify Java interfaces.
	salgenJava
	# Move/Generate the share libraries.
	salgenLib
	# Run the Maven tests.
    salgenMaven
	# Indicate completion of the test suite.
	echo Done with test suite.
	echo ""
}


#  MAIN
subSystem=$(getEntity $arg)
if [ "$arg" == "all" ]; then
	for subSystem in "${subSystemArray[@]}"; do
		createTestSuite $subSystem
	done
	echo COMPLETED ALL test suites for ALL subsystems.
elif [[ ${subSystemArray[*]} =~ $subSystem ]]; then
    createTestSuite $subSystem
	echo COMPLETED all test suites for the $subSystem.
else
	echo USAGE - Argument must be one of: ${subSystemArray[*]} OR all.
fi

