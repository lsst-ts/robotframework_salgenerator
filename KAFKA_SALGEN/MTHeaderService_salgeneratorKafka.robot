*** Settings ***
Documentation    This suite builds the various interfaces for the MTHeaderService.
Force Tags    salgen    mtheaderservice
Suite Setup    Log Many    ${Host}    ${subSystem}    ${timeout}
Library    OperatingSystem
Library    Process
Resource    ../Global_Vars.resource

*** Variables ***
${subSystem}    MTHeaderService
${timeout}    1200s

*** Test Cases ***
Verify MTHeaderService XML Defintions exist
    [Tags]    validate
    Comment    Verify the CSC XML definition files exist.
    ${output}    Get File    ${EXECDIR}/../ts_xml/python/lsst/ts/xml/data/sal_interfaces/MTHeaderService/README.md
    Log    ${output}
    Should Contain     ${output}    \# ${subSystem}
    Should Contain     ${output}    This SAL Component only uses generic topics.
    Should Contain     ${output}    This directory is intentionally left empty.

Salgen MTHeaderService Validate
    [Documentation]    Validate the MTHeaderService XML definitions.
    [Tags]    validate
    ${output}=    Run Process    ${SALHome}/bin/salgeneratorKafka    ${subSystem}    validate    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    XMLVERSION = ${XMLVersion}
    Should Contain    ${output.stdout}    Processing ${subSystem}
    Should Contain    ${output.stdout}    Completed ${subSystem} validation
    Directory Should Exist    ${SALWorkDir}/avro-templates
    @{files}=    List Directory    ${SALWorkDir}/avro-templates
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}_cmddef.tcl
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}_evtdef.tcl
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}_tlmdef.tcl
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}_metadata.tcl
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}_revCodes.tcl
    Directory Should Exist    ${SALWorkDir}/avro-templates/${subSystem}
    @{files}=    List Directory    ${SALWorkDir}/avro-templates/${subSystem}
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_hash_table.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_Commands.xml
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_Events.xml
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_Generics.xml
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_heartbeat.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_logLevel.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_logMessage.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_softwareVersions.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_authList.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_errorCode.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_simulationMode.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_summaryState.json
    File Should Exist    ${SALWorkDir}/avro-templates/${subSystem}/${subSystem}_logevent_largeFileObjectAvailable.json

Salgen MTHeaderService Java
    [Documentation]    Generate Java libraries.
    [Tags]    java
    ${output}=    Run Process    ${SALHome}/bin/salgeneratorKafka    ${subSystem}    sal    java    version\=${MavenVersion}    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stdout}    ERROR : Failed to generate*saj_*_types.jar 
    Should Not Contain    ${output.stdout}    error: package org.apache.avro* does not exist
    Should Not Contain    ${output.stdout}    error: package org.apache.kafka* does not exist
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    XMLVERSION = ${XMLVersion}
    Should Contain    ${output.stdout}    WARNING : No Telemetry definitions found for ${subSystem}
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/saj_${subSystem}_types.jar
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/org/lsst/sal/SAL_${subSystem}.java
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/org/lsst/sal/salActor.java
    File Should Exist    ${SALWorkDir}/${subSystem}/java/src/org/lsst/sal/salUtils.java
    File Should Exist    ${SALWorkDir}/salUtils/libsalUtils.so

Salgen MTHeaderService Maven
    [Documentation]    Generate the Maven repository.
    [Tags]    java
    ${output}=    Run Process    ${SALHome}/bin/salgeneratorKafka    ${subSystem}    maven    version\=${MavenVersion}    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    argv = ${subSystem} maven version=${MavenVersion}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    XMLVERSION = ${XMLVersion}
    Should Contain    ${output.stdout}    Running maven install
    Should Contain    ${output.stdout}    [INFO] Building sal_${subSystem} ${XMLVersionBase}_${SALVersionBase}${MavenVersion}
    Should Contain X Times    ${output.stdout}    [INFO] BUILD SUCCESS    1
    Should Contain X Times    ${output.stdout}    [INFO] Finished at:    1
    @{files}=    List Directory    ${SALWorkDir}/maven
    File Should Exist    ${SALWorkDir}/maven/${subSystem}-${XMLVersionBase}_${SALVersionBase}${MavenVersion}/pom.xml

Salgen MTHeaderService Lib
    [Documentation]    Generate the SAL shared library for ${subSystem}
    [Tags]    lib
    ${output}=    Run Process    ${SALHome}/bin/salgeneratorKafka    ${subSystem}    lib    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    XMLVERSION = ${XMLVersion}
    Should Contain    ${output.stdout}    Building shared library for ${subSystem} subsystem
    Directory Should Exist    ${SALWorkDir}/lib
    @{files}=    List Directory    ${SALWorkDir}/lib    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/lib/saj_${subSystem}_types.jar

Salgen MTHeaderService RPM
    [Documentation]    Generate the SAL runtime RPM for ${subSystem}
    [Tags]    rpm
    Log Many    ${XMLVersion}    ${SALVersion}    ${Build_Number}    ${DIST}
    ${output}=    Run Process    ${SALHome}/bin/salgeneratorKafka    ${subSystem}    rpm    version\=${Build_Number}    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    @{files}=    List Directory    /tmp/
    Should Be Empty    ${output.stderr}
    File Should Exist    /tmp/makerpm_${subSystem}.log
    File Should Exist    /tmp/makerpm-utils.log
    Log File    /tmp/makerpm_${subSystem}.log
    Log File    /tmp/makerpm-utils.log
    Should Not Contain    ${output.stdout}    ERROR : Asset required for rpm
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    XMLVERSION = ${XMLVersion}
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
    IF    "${Build_Number}" == ""
        Set Test Variable    ${sep}    ${EMPTY}
    ELSE IF    any(item in '${Build_Number}' for item in ('pre', 'post', 'rc'))
        Set Test Variable    ${sep}    ~
    ELSE
        Set Test Variable    ${sep}    ${EMPTY}
    END
    File Should Exist    ${SALWorkDir}/rpmbuild/SPECS/ts_sal_${subSystem}.spec
    File Should Exist    ${SALWorkDir}/rpmbuild/SOURCES/${subSystem}-${XMLVersionBase}${sep}${Build_Number}.tgz
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/ts_sal_runtime-${XMLVersionBase}${sep}${Build_Number}-${SALVersionBase}*${DIST}.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/ts_sal_ATruntime-${XMLVersionBase}${sep}${Build_Number}-${SALVersionBase}*${DIST}.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/ts_sal_utils-${SALVersionBase}-1.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/${subSystem}-${XMLVersionBase}${sep}${Build_Number}-${SALVersionBase}${DIST}.x86_64.rpm
    Should Not Contain    ${output.stdout}    child process exited abnormally

Verify MTHeaderService RPM Contents
    [Documentation]    Verify the ${subSystem} RPM contains all the expected libraries
    [Tags]    rpm
    Comment    Re-run the {sep} process, so this test case can run independently.
    IF    "${Build_Number}" == ""
        Set Test Variable    ${sep}    ${EMPTY}
    ELSE IF    any(item in '${Build_Number}' for item in ('pre', 'post', 'rc'))
        Set Test Variable    ${sep}    ~
    ELSE
        Set Test Variable    ${sep}    ${EMPTY}
    END
    ${output}=    Run Process    rpm    -qpl    ${subSystem}-${XMLVersionBase}${sep}${Build_Number}-${SALVersionBase}${DIST}.x86_64.rpm    cwd=${SALWorkDir}/rpmbuild/RPMS/x86_64
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stderr}    error
    Should Not Contain    ${output.stderr}    No such file or directory
    Should Contain     ${output.stdout}    /opt/lsst/ts_sal/scripts/${subSystem}_revCodes.tcl
    Comment    Verify the interface definition files are included.
    Should Contain     ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Generics.xml
    Should Contain     ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Commands.html
    Should Contain     ${output.stdout}    /opt/lsst/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Events.html

Cleanup stdout and stderr Files
    [Tags]
    Remove Files    ${EXECDIR}${/}${subSystem}_stdout.txt    ${EXECDIR}${/}${subSystem}_stderr.txt

