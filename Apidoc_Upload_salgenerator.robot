*** Settings ***
Documentation    This suite builds the various interfaces for the .
Force Tags    salgen    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${timeout}
Library    OperatingSystem
Library    Process
Resource    Global_Vars.resource

*** Variables ***
${subSystem}    
${timeout}    1200s

*** Test Cases ***
Salgen Doc Upload
    [Documentation]    Upload the CSC documentation.
    [Tags]    doc
    ${output}=    Run Process    ${SALHome}/bin/salgenerator    upload    apidoc    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}apidoc_upload_stdout.txt    stderr=${EXECDIR}${/}apidoc_upload_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    XMLVERSION = ${XMLVersion}
    Should Contain    ${output.stdout}    checking upload
    Should Contain    ${output.stdout}    checking apidoc
    Should Contain    ${output.stdout}    SAL apidoc - Initializing
    Should Contain    ${output.stdout}    SAL apidoc - Rebuilding CSC index
    Should Contain    ${output.stdout}    SAL apidoc - Uploading to ts_sal_apidoc
    Should Contain    ${output.stdout}    SAL apidoc - All done
    Directory Should Exist    ${SALWorkDir}/docbuild_upload/ts_sal_apidoc
    @{files}=    List Directory    ${SALWorkDir}/docbuild_upload/ts_sal_apidoc/doc
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/docbuild_upload/ts_sal_apidoc/doc/sal-apis.rst
    Directory Should Exist    ${SALWorkDir}/docbuild_upload/ts_sal_apidoc/doc/_build/html/apiDocumentation/
    @{files}=    List Directory    ${SALWorkDir}/docbuild_upload/ts_sal_apidoc/doc/_build/html/apiDocumentation/
    Log Many    @{files}

Cleanup stdout and stderr Files
    [Tags]
    Remove Files    ${EXECDIR}${/}apidoc_upload_stdout.txt    ${EXECDIR}${/}apidoc_upload_stderr.txt

