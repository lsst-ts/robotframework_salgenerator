*** Settings ***
Variables                variables.py

*** Variables ***
${ContInt}              false
${UserName}             saluser
${PassWord}             ${EMPTY}
${KeyFile}              ${EMPTY}
${PythonVersion}        Python 3.11.4
${AstropyVersion}       6.1.1
${MvnVersion}           Apache Maven 3.9.3
${MavenVersion}         -SNAPSHOT
${SALInstall}           /opt/sal
${SALHome}              ${SalInstall}
${SALWorkDir}           ${SalInstall}/test
${SALVersion}           7.3.0
${SALVersionBase}       7.3.0
${XMLVersion}           17.1.0
${XMLVersionBase}       17.1.0
${XMLHome}              /home/appuser/trunk/ts_xml
${Build_Number}         001
${OpenspliceRelease}    Vortex OpenSplice HDE Release
${OpenspliceVersion}    6.10.4p2
${OpenspliceDate}       2020-10-12
${Prompt}               ]$
${Host}                 0.0.0.0
