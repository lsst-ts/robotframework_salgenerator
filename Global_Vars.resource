*** Settings ***
Variables                variables.py

*** Variables ***
${ContInt}              false
${UserName}             saluser
${PassWord}             ${EMPTY}
${KeyFile}              ${EMPTY}
${PythonVersion}        Python 3.6.5
${MvnVersion}           Apache Maven 3.0.5
${MavenVersion}         -SNAPSHOT
${MavenVersion}         -SNAPSHOT
${SALInstall}           /opt/sal
${SALHome}              ${SalInstall}
${SALWorkDir}           ${SalInstall}/test
${SALVersion}           4.0
${XMLVersion}           4.8.0
${XMLHome}              /home/appuser/trunk/ts_xml
${Build_Number}         001
${OpenspliceRelease}    Vortex OpenSplice HDE Release
${OpenspliceVersion}    6.7.170523OSS
${OpenspliceDate}       2017-06-21
${Prompt}               ]$
${Host}                 0.0.0.0
