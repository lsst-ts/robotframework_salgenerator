*** Settings ***
Documentation    This verifies the version of SAL installed on the remote host.
Suite Setup    Log Many    ${SALVersion}    ${OpenspliceVersion}    ${OpenspliceDate}
Library		OperatingSystem
Library		Process
Resource    Global_Vars.resource

*** Variables ***
${timeout}    10s

*** Test Cases ***
Verify Python Unit Tests
    [Documentation]    Run the SAL PyTest unit tests.
    [Tags]    smoke
	${output}=    Run Process    pytest    tests/*.py    shell=True    cwd=${SALInstall}    stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
	Log Many    ${output.stdout}    ${output.stderr}
	Should Not Contain    ${output.stdout}    FAILURES
	Should Contain    ${output.stdout}    test session starts
	Should Contain    ${output.stdout}    collected 28 items
	Should Contain    ${output.stdout}    tests/test_lsst_dds_domain.py
	Should Contain    ${output.stdout}    tests/test_sal.py
	Should Contain    ${output.stdout}    23 passed

Verify Java Camera Unit Tests
	[Documentation]    Run the Java Camera unit tests.
    [Tags]    smoke
	${output}=    Run Process    mvn test   shell=True    cwd=${SALInstall}${/}camera-tests    stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
	Log Many    ${output.stdout}    ${output.stderr}
	Should Not Contain    ${output.stdout}    BUILD FAILURE
	Should Not Contain    ${output.stdout}    [ERROR]
