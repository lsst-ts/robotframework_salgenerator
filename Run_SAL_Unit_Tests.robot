*** Settings ***
Documentation    This verifies the version of SAL installed on the remote host.
Suite Setup    Log Many    ${SALVersion}    ${OpenspliceVersion}    ${OpenspliceDate}
Library		OperatingSystem
Library		Process
Resource    Global_Vars.resource

*** Variables ***
${timeout}    10s

*** Test Cases ***
Verify Java Camera Unit Tests
    [Documentation]    Run the Java Camera unit tests.
    [Tags]    smoke
    ${output}=    Run Process    mvn    test    -DXms2g    -DXmx4g    -B    shell=True    cwd=${SALInstall}${/}camera-tests    stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stdout}    BUILD FAILURE
    Should Not Contain    ${output.stdout}    [ERROR]
    Should Contain    ${output.stdout}    [INFO] BUILD SUCCESS
