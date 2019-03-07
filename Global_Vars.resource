*** Settings ***
Variables				variables.py

*** Variables ***
${ContInt}       		false
${UserName}      		saluser
${PassWord}      		${EMPTY}
${KeyFile}       		${EMPTY}
${PythonVersion}		Python 3.6.5
${SALInstall}    		/opt/sal
${SALHome}       		${SalInstall}/lsstsal
${SALWorkDir}    		${SalInstall}/test
${SALVersion}    		3.0
${OpenspliceRelease}	Vortex OpenSplice HDE Release
${OpenspliceVersion}	6.7.170523OSS
${OpenspliceDate}		2017-06-21
${Prompt}        		]$
${Host}          		0.0.0.0
