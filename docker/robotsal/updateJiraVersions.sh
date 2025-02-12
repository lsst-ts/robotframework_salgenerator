#!/bin/sh

projectPropertiesFile=`ls target/org-lsst-*.maven.properties`
if [[ -z $projectPropertiesFile ]]
then
projectPropertiesFile=`ls */target/org-lsst-*.maven.properties`
fi

#The following logic is to support GIT migrated projects since they don't have "trunk" in the workspace
projectName=`echo $projectPropertiesFile | cut -d/ -f3 | cut -d. -f1` 
if [[ -z $projectName ]]
then
projectName=`echo $projectPropertiesFile | cut -d/ -f2 | cut -d. -f1`
fi

workspaceDir=`pwd`


if [[ -f $workspaceDir/$projectPropertiesFile ]]
then

projectDescription="`cat $projectPropertiesFile | grep org_lsst_ccs_project_description= | cut -d= -f2`"
projectType="`cat $projectPropertiesFile  | grep org_lsst_ccs_project_type= | cut -d= -f2`"
jiraProject="`cat $projectPropertiesFile  | grep org_lsst_ccs_project_jira_project= | cut -d= -f2`"
org_lsst_ccs_project_version="`cat $projectPropertiesFile  | grep org_lsst_ccs_project_version= | cut -d= -f2`"


if [[ $jiraProject == http* ]]
then
jiraProject=`echo $jiraProject | cut -d/ -f5`
fi
jiraPrefix="`cat $projectPropertiesFile  | grep org_lsst_ccs_project_jira_prefix= | cut -d= -f2`"


else
projectName=${JOB_NAME}
echo set project name to $projectName

fi


if [[ $projectName == *-drivers-*  &&  $projectName != org-lsst-ccs-drivers-commons ]]
then
projectType=driver
if [[ -z $jiraProject ]]
then
jiraProject=LSSTCCSDRIVER
fi
jiraPrefix=$projectName
fi

if [[ $projectName == *-subsystem-*  &&  $projectName != org-lsst-ccs-subsystem-main  &&  $projectName != org-lsst-ccs-subsystem-gui  &&  $projectName != org-lsst-ccs-subsystem-buses   &&  $projectName != org-lsst-ccs-subsystem-commons &&  $projectName != org-lsst-ccs-subsystem-console ]]
then
projectType=subsystem
fi



if [[ $jiraPrefix == org-lsst-ccs-drivers* ]]
then
jiraPrefix="`echo $jiraPrefix | cut -d- -f 5-`"
fi
if [[ $jiraPrefix == org-lsst-ccs-* ]]
then
jiraPrefix="`echo $jiraPrefix | cut -d- -f 4-`"
fi

releaseVersion=${org_lsst_ccs_project_version}
#For release builds we get the SNAPSHOT version from the pom file
projectArtifactId=`cat $projectPropertiesFile | grep org_lsst_ccs_project= | cut -d= -f2`
versionLine=`grep -m 1 -A4 "<artifactId>$projectArtifactId</artifactId>" pom.xml  | grep -m1 "<version>.*</version>"`
snapshotVersion=`echo $versionLine | sed -r 's/<version>(.*)<\/version>/\1/'`
if [  "$releaseVersion" == "$snapshotVersion" ]; then
releaseVersion=
fi

echo /usr/bin/wget -O /tmp/out.out "https://srs.slac.stanford.edu/releaseManagement/updateVersions.jsp?projectName=${projectName}&releaseVersion=${releaseVersion}&snapshotVersion=${snapshotVersion}&projectType=${projectType}&projectDescription=${projectDescription}&projectJiraProject=${jiraProject}&projectJiraPrefix=${jiraPrefix}"
/usr/bin/wget -O /tmp/out.out "https://srs.slac.stanford.edu/releaseManagement/updateVersions.jsp?projectName=${projectName}&releaseVersion=${releaseVersion}&snapshotVersion=${snapshotVersion}&projectType=${projectType}&projectDescription=${projectDescription}&projectJiraProject=${jiraProject}&projectJiraPrefix=${jiraPrefix}" > /dev/null 2>&1
cat /tmp/out.out
