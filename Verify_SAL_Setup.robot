*** Settings ***
Documentation    This verifies the SAL and all dependencies are installed correctly on the host.
...     It verifies the versions of installed software and that the installation
...     worked as expected, putting important files in the correct locations.
Suite Setup    Log Many    ${SALVersion}    ${OpenspliceVersion}    ${OpenspliceDate}
Library        OperatingSystem
Library        Process
Resource    Global_Vars.resource
Force Tags    verify_sal_setup

*** Variables ***
${timeout}    10s

*** Test Cases ***
Verify SAL Version
    [Documentation]    Verify the SAL version is correct.
    [Tags]    smoke    version
    ${output}=    Run Process    source    ${SALInstall}${/}setupKafka.env    shell=True
    Set Suite Variable    ${versionData}    ${output}
    Comment    Verify SAL version.
    Log Many    ${versionData.stdout}    ${versionData.stderr}    ${versionData.rc}
    Should Contain    ${versionData.stdout}    SAL development environment is configured
    Should Contain    ${versionData.stdout}    LSST middleware toolset environment
    Should Contain    ${versionData.stdout}    v${SALVersion}
    Should Contain    ${versionData.stdout}    (Kafka) is configured.
    Should Be Empty    ${versionData.stderr}
    Should Be Equal As Integers    ${versionData.rc}    ${0}

Verify Python Version
    [Documentation]    Verify the system Python version.
    [Tags]    smoke    version
    Comment    Verify Python version.
    ${stdout}=    Run Process    python3     --version
    Log    ${stdout.stdout}
    Should Match    ${stdout.stdout}    ${PythonVersion}

Verify Astropy Version
    [Documentation]    Verify the Astropy library version.
    [Tags]    smoke    version
    Comment    Verify Astropy version.
    ${stdout}=    Run Process    pip3.12    freeze
    Log    ${stdout.stdout}
    Should Contain    ${stdout.stdout}    astropy==${AstropyVersion}

Verify Maven Version
    [Documentation]    Verify the system Maven version.
    [Tags]    smoke    version
    Comment    Verify Maven version.
    ${stdout}=    Run Process    mvn     --version
    Log    ${stdout.stdout}
    Should Contain    ${stdout.stdout}    ${MvnVersion}

Verify XML Version
    [Tags]    smoke    version
    ${output}=    Run Process    git    describe    cwd=${XMLHome}
    Log    ${output.stdout}
    Should Contain    ${output.stdout}    v${XMLVersion}

Verify SAL Version file exists
    [Tags]    smoke    version
    File Should Exist    ${SALInstall}/lsstsal/scripts/sal_version.tcl

Verify SAL Version file contents
    [Tags]    smoke    version
    ${output}=    Get File    ${SALInstall}/lsstsal/scripts/sal_version.tcl
    Log    ${output}
    Should Contain    ${output}    [string trim [exec git describe --tags --dirty] "v"]

Verify SAL CSC list exists
    [Tags]    smoke
    Comment    Verify the list of SAL CSCs exists.
    File Should Exist    ${SALWorkDir}/SALSubsystems.xml

Verify SAL Generics defintion exists
    [Tags]    smoke
    Comment    Verify the SAL Generic topics definition file exists.
    File Should Exist    ${SALWorkDir}/SALGenerics.xml

Verify Proper SAL Setup - base dir
    [Documentation]    There are a few dozen files that are necessary for SAL and salgenerator to function properly. This test verifies those files exist in the correct locations.
    File Should Exist   ${SALInstall}/setup.env
    File Should Exist   ${SALInstall}/setupKafka.env
    File Should Exist   ${SALInstall}/SConstruct
    File Should Exist   ${SALInstall}/doc/sal_user_guide.rst

Verify Proper SAL Setup - bin
    [Documentation]    There are a few dozen files that are necessary for SAL and salgenerator to function properly. This test verifies those files exist in the correct locations.
    Directory Should Exist   ${SALInstall}/bin
    File Should Exist   ${SALInstall}/bin/buildsharedlib
    File Should Exist   ${SALInstall}/bin/make_salUtils
    File Should Exist   ${SALInstall}/bin/salgenerator
    File Should Exist   ${SALInstall}/bin/salgeneratorKafka
    File Should Exist   ${SALInstall}/bin/set-tai
    File Should Exist   ${SALInstall}/bin/setupSALKafkaBuildEnvironment
    File Should Exist   ${SALInstall}/bin/setupStackBuildEnvironment
    File Should Exist   ${SALInstall}/bin/update_leapseconds

Verify Proper SAL Setup - lsstsal
    [Documentation]    There are a few dozen files that are necessary for SAL and salgenerator to function properly. This test verifies those files exist in the correct locations.
    Directory Should Exist   ${SALInstall}/lsstsal
    File Should Exist   ${SALInstall}/lsstsal/salenv.sh
    File Should Exist   ${SALInstall}/lsstsal/scripts/update_ts_xml_dictionary.tcl
    File Should Exist   ${SALInstall}/lsstsal/scripts/code/templates/Makefile.sacpp_SAL_types.template
    File Should Exist   ${SALInstall}/lsstsal/scripts/code/templates/Makefile.saj_SAL_types.template
    File Should Exist   ${SALInstall}/lsstsal/scripts/code/templates/salActor.java
    File Should Exist   ${SALInstall}/lsstsal/scripts/code/templates/salUtils.c
    File Should Exist   ${SALInstall}/lsstsal/scripts/code/templates/salUtils.h
    File Should Exist   ${SALInstall}/lsstsal/scripts/code/templates/salUtils.java
    File Should Exist   ${SALInstall}/lsstsal/scripts/code/templates/SAL_defines.h
    File Should Exist   ${SALInstall}/lsstsal/scripts/code/templates/SALDDS.cpp.template
    File Should Exist   ${SALInstall}/lsstsal/scripts/code/templates/SALDDS.h.template
    File Should Exist   ${SALInstall}/lsstsal/scripts/code/templates/SALDDS.java.template

Verify Proper SAL Setup - scripts
    [Documentation]    There are a few dozen files that are necessary for SAL and salgenerator to function properly. This test verifies those files exist in the correct locations.
    Directory Should Exist   ${SALInstall}/scripts
    File Should Exist   ${SALInstall}/scripts/buildJavaLibraries.sh

Verify Proper SAL Setup - ups
    [Documentation]    There are a few dozen files that are necessary for SAL and salgenerator to function properly. This test verifies those files exist in the correct locations.
    Directory Should Exist   ${SALInstall}/ups
    File Should Exist   ${SALInstall}/ups/eupspkg.cfg.sh
    File Should Exist   ${SALInstall}/ups/ts_sal.cfg
    File Should Exist   ${SALInstall}/ups/ts_sal.table
