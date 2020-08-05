*** Settings ***
Documentation    This verifies the version of SAL installed on the remote host.
Suite Setup    Log Many    ${SALVersion}    ${OpenspliceVersion}    ${OpenspliceDate}
Library		OperatingSystem
Library		Process
Resource    Global_Vars.resource

*** Variables ***
${timeout}    10s

*** Test Cases ***
Verify SAL Version
    [Documentation]    Verify the SAL version is correct.
    [Tags]    smoke    version
    ${output}=    Run Process    source    ${SALInstall}${/}setup.env    shell=True
	Set Suite Variable    ${versionData}    ${output}
	Comment    Verify SAL version.
	Log Many    ${versionData.stdout}    ${versionData.stderr}    ${versionData.rc}
	Should Contain    ${versionData.stdout}    SAL development environment is configured
	Should Contain    ${versionData.stdout}    LSST middleware toolset environment v${SALVersion} is configured

Verify Python Version
    [Documentation]    Verify the system Python version.
	[Tags]    smoke    version
	Comment    Verify Python version.
	${stdout}=    Run Process    python3.7     --version
	Log    ${stdout.stdout}
	Should Match    ${stdout.stdout}    ${PythonVersion}

Verify OpenSplice Version
	[Documentation]    Verify the OpenSplice version and date.
	[Tags]    smoke    version
	Log    ${versionData.stdout}
	Log Many    ${OpenspliceRelease}    ${OpenspliceVersion}    ${OpenspliceDate}
	Should Contain    ${versionData.stdout}    ${OpenspliceRelease}
	Should Contain    ${versionData.stdout}    ${OpenspliceVersion} For x86_64.linux
	Should Contain    ${versionData.stdout}    Date ${OpenspliceDate}

Verify XML Version
	[Tags]    smoke    version
    File Should Exist    ${SALInstall}/test/VERSION
	${output}=    Get File    ${SALInstall}/test/VERSION
	Log    ${output}
	Should Contain    ${output}    ${XMLVersion}

Verify SAL Version file exists
    [Tags]    smoke    version
    File Should Exist    ${SALInstall}/VERSION
    File Should Exist    ${SALInstall}/lsstsal/scripts/sal_version.tcl

Verify SAL Version file contents
    [Tags]    smoke    version
    ${output}=    Get File    ${SALInstall}/VERSION
    Log    ${output}
    Should Contain    ${output}    ${SALVersion}
    ${output}=    Get File    ${SALInstall}/lsstsal/scripts/sal_version.tcl
    Log    ${output}
    Should Contain    ${output}    set SALVERSION [exec cat $env(LSST_SDK_INSTALL)${/}VERSION]

Verify SAL CSC list exists
	[Tags]    smoke
	Comment    Verify the list of SAL CSCs exists.
    File Should Exist    ${SALWorkDir}/SALSubsystems.xml

Verify SAL Generics defintion exists
    [Tags]    smoke
    Comment    Verify the SAL Generic topics definition file exists.
    File Should Exist    ${SALWorkDir}/SALGenerics.xml

Verify DDS QoS Settings file exists
    [Tags]    smoke
    Comment    Verify the DDS Quality of Service settings XML file exists.
	File Should Exist    ${SALWorkDir}/DDS_DefaultQoS_All.xml
	File Should Exist    ${SALInstall}/lsstsal/scripts/DDS_DefaultQoS_All.xml
