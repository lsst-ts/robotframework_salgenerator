#!/bin/bash
#  Shellscript to create test suite argument file
#  for the salgenerator tests.
#
#  author: Rob Bovill
#  email:  rbovill@lsst.org

# Define filename
argfile=$HOME/repos/robotframework_salgenerator/Test_SalGen.list

# Find and remove old argument file.
ls $argfile 1>/dev/null
if [ $? -eq 0 ]; then
	echo "Deleteing $argfile"
	rm $argfile
else
	echo "$argfile does not exist.  Continuing."
fi

# Setup argument file
echo "###  Test Suite list ###" >> $argfile
echo "#  Change the title of the test results" >> $argfile
echo "--name SalGen" >> $argfile
echo "--output SALGENERATOR" >> $argfile
echo "" >> $argfile
echo "# List of test suites" >> $argfile

# Find test suites and add them to the argument file.
echo "Verify_SAL_Setup.robot" >> $argfile
ls -1 $HOME/repos/robotframework_salgenerator/SALGEN |sed 's/^/SALGEN\//' >> $argfile
