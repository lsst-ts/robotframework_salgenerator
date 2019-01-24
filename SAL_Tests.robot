*** Settings ***
Documentation    This verifies the version of SAL installed on the remote host.
Suite Setup    Log Many    ${SALVersion}    ${OpenspliceVersion}    ${OpenspliceDate}
Library		OperatingSystem
Resource    Global_Vars.robot

*** Variables ***
${timeout}    10s

*** Test Cases ***
Verify SAL Version
    [Documentation]    Verify the SAL version is correct.
    [Tags]    smoke    version
    ${output}=    Run    source $LSST_SDK_INSTALL/setup.env
	Set Suite Variable    ${versionData}    ${output}
	Comment    Verify SAL version.
	Should Contain    ${versionData}    SAL development environment is configured
	Should Contain    ${versionData}    LSST middleware toolset environment v${SALVersion} is configured

Verify Python Version
    [Documentation]    Verify the system Python version is 3.6.
	[Tags]    smoke    version
	Comment    Verify Python version.
	${stdout}=    Run    python3.6 --version
	Log    ${stdout}
	Should Match    ${stdout}    ${PythonVersion}

Verify OpenSplice Version
	[Documentation]    Verify the OpenSplice version and date.
	[Tags]    smoke    version
	Log    ${versionData}
	Log Many    ${OpenspliceRelease}    ${OpenspliceVersion}    ${OpenspliceDate}
	Should Contain    ${versionData}    ${OpenspliceRelease}
	Should Contain    ${versionData}    ${OpenspliceVersion} For x86_64.linux
	Should Contain    ${versionData}    Date ${OpenspliceDate}

Verify SAL Version file exists
    [Tags]    smoke    version
	Log    ${SALInstall}/lsstsal/scripts/sal_version.tcl
    File Should Exist    ${SALInstall}/lsstsal/scripts/sal_version.tcl

Verify SAL Version file contents
    [Tags]    smoke    version
    ${output}=    Run    cat ${SALInstall}/lsstsal/scripts/sal_version.tcl
    Log    ${output}
    Should Contain    ${output}    set SALVERSION ${SALVersion}

Verify SAL CSC list exists
	[Tags]    smoke
	Comment    Verify the list of SAL CSCs exists.
    File Should Exist    ${SALWorkDir}/SALSubsystems.xml

Verify SAL Generics defintion exists
    [Tags]    smoke
    Comment    Verify the SAL Generic topics definition file exists.
    File Should Exist    ${SALWorkDir}/SALGenerics.xml

Verify State Enumeration Definition
    [Documentation]    Verify the State Enumeration definition within the SAL.
    [Tags]    smoke
    Comment    Verify Generic Events file.
    File Should Exist    ${SALInstall}/lsstsal/scripts/generateGenericEvents.tcl 
    Comment    Verify Generic Events file contains the State Enumeration definition.
    ${content}=    Run    grep -m 1 "<Enumeration>" ${SALInstall}/lsstsal/scripts/generateGenericEvents.tcl
    Should Contain    ${content}    <Enumeration>DisabledState,EnabledState,FaultState,OfflineState,StandbyState</Enumeration>
