*** Settings ***
Variables                variables.py

*** Variables ***
${ContInt}              false
${UserName}             saluser
${PassWord}             ${EMPTY}
${KeyFile}              ${EMPTY}
${PythonVersion}        Python 3.10.4
${AstropyVersion}       5.1
${MvnVersion}           Apache Maven 3.6.3
${MavenVersion}         -SNAPSHOT
${MavenVersion}         -SNAPSHOT
${SALInstall}           /opt/sal
${SALHome}              ${SalInstall}
${SALWorkDir}           ${SalInstall}/test
${SALVersion}           6.1.0-1-gabcdefg
${SALVersionBase}       6.1.0
${XMLVersion}           11.1.1-1-gabcdefg
${XMLVersionBase}       11.1.1
${XMLHome}              /home/appuser/trunk/ts_xml
${Build_Number}         001
${OpenspliceRelease}    Vortex OpenSplice HDE Release
${OpenspliceVersion}    6.10.4p2
${OpenspliceDate}       2020-10-12
${Prompt}               ]$
${Host}                 0.0.0.0
