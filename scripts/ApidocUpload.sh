#!/bin/bash
#  Shellscript to create test suites to
#  create the various interfaces.
#
#  author: Rob Bovill
#  email:  rbovill@lsst.org

# Source common functions
workDir=$HOME/repos/robotframework_salgenerator
source $workDir/scripts/_common.sh

#  Define variables to be used in script
arg=${1-all}
declare -a subSystemArray=($(subsystemArray))

#  FUNCTIONS
function createSettings() {
    echo "*** Settings ***" >> $testSuite
    echo "Documentation    This suite builds the various interfaces for the $subSystemUp." >> $testSuite
    echo "Force Tags    salgen    $skipped" >> $testSuite
    echo "Suite Setup    Log Many    \${Host}    \${subSystem}    \${timeout}" >> $testSuite
    echo "Library    OperatingSystem" >> $testSuite
    echo "Library    Process" >> $testSuite
    echo "Resource    Global_Vars.resource" >> $testSuite
    echo "" >> $testSuite
}

function createVariables() {
    entity=$(getEntity $1)
    echo "*** Variables ***" >> $testSuite
    echo "\${subSystem}    $entity" >> $testSuite
    echo "\${timeout}    1200s" >> $testSuite
    echo "" >> $testSuite
}

function cleanupOutputs() {
    echo "Cleanup stdout and stderr Files" >> $testSuite
    echo "    [Tags]" >> $testSuite
    echo "    Remove Files    \${EXECDIR}\${/}apidoc_upload_stdout.txt    \${EXECDIR}\${/}apidoc_upload_stderr.txt" >> $testSuite
    echo "" >> $testSuite
}

function salgenDocUpload() {
    skipped=$(checkIfSkipped "doc")
    echo "Salgen Doc Upload" >> $testSuite
    echo "    [Documentation]    Upload the CSC documentation." >> $testSuite
    echo "    [Tags]    doc$skipped" >> $testSuite
    echo "    \${output}=    Run Process    \${SALHome}/bin/salgenerator    upload    apidoc    \
shell=True    cwd=\${SALWorkDir}    stdout=\${EXECDIR}\${/}apidoc_upload_stdout.txt    stderr=\${EXECDIR}\${/}apidoc_upload_stderr.txt" >> $testSuite
    echo "    Log Many    \${output.stdout}    \${output.stderr}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    SAL generator - \${SALVersion}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    XMLVERSION = \${XMLVersion}" >> $testSuite
    echo "    Should Contain    \${output.stdout}    checking upload" >> $testSuite
    echo "    Should Contain    \${output.stdout}    checking apidoc" >> $testSuite
    echo "    Should Contain    \${output.stdout}    SAL apidoc - Initializing" >> $testSuite
    echo "    Should Contain    \${output.stdout}    SAL apidoc - Rebuilding CSC index" >> $testSuite
    echo "    Should Contain    \${output.stdout}    SAL apidoc - Uploading to ts_sal_apidoc" >> $testSuite
    echo "    Should Contain    \${output.stdout}    SAL apidoc - All done" >> $testSuite
    echo "    Directory Should Exist    \${SALWorkDir}/docbuild_upload/ts_sal_apidoc" >> $testSuite
    echo "    @{files}=    List Directory    \${SALWorkDir}/docbuild_upload/ts_sal_apidoc/doc" >> $testSuite
    echo "    Log Many    @{files}" >> $testSuite
    echo "    File Should Exist    \${SALWorkDir}/docbuild_upload/ts_sal_apidoc/doc/sal-apis.rst" >> $testSuite
    echo "    Directory Should Exist    \${SALWorkDir}/docbuild_upload/ts_sal_apidoc/doc/_build/html/apiDocumentation/" >> $testSuite
    echo "    @{files}=    List Directory    \${SALWorkDir}/docbuild_upload/ts_sal_apidoc/doc/_build/html/apiDocumentation/" >> $testSuite
    echo "    Log Many    @{files}" >> $testSuite
    echo "" >> $testSuite
}

function createTestSuite() {
    #  Define test suite name
    testSuite=$workDir/Apidoc_Upload_salgenerator.robot

    #  Check to see if the TestSuite exists then, if it does, delete it.
    rm $testSuite

    #  Check if test suite should be skipped.
    skipped=$(checkIfSkipped apidoc $topic)

    #  Create test suite.
    echo Creating $testSuite
    createSettings
    createVariables $subSystem
    echo "*** Test Cases ***" >> $testSuite
    # Upload the CSC documentation
    salgenDocUpload
    # Indicate completion of the test suite.
    cleanupOutputs
    echo ""
}


#  MAIN
createTestSuite $subSystem
echo COMPLETED test suite for apidoc upload.

