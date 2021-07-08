# robotframework_salgenerator
SAL API generation tests and build scripts.

## Test Suite execution
The test-suites/build-scripts are written in Robot-Framework (RF).  To execute the scripts

    robot [options] data_sources

where [options] are numerous and [data_sources] are [test-suites](https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html#creating-test-suites) or [test-lists](https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html#argument-files).  The [options] are too numerous to go over, but below are the common ones.

    -A <argument_file>
        Defines test setup/configuration values.  This option is discussed below.
        Executes the list of test-suites.  The test list option is discussed in the TestLists section. 
    -t "<test case>"
        Run ONLY the listed <test case> inside a given test-suite.  Multiple -t options are allowed and are executed in the listed order.
    -d <path>
        Defines the location of the output files.
    -e <tag>
        skip test cases with this <tag>
    --skiponfailure <tag>
        failed test cases marked with <tag> will not count in the report.  This is used when failures are expected, but we still want to run the test case.
    --variable <variable_name>:<variable_value>
        Define a runtime value for the given variable.  This will overwrite a default value.

Take at look at the [Robot-Framework User Guide](http://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html) for a complete description.

## Test configuration 
RF is highly configurable.  There are two sources of test/build RF-specific configurations, [Resource files and Variable files](http://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html#resource-and-variable-files).

Resource files act as Libraries for the RF tests.  This repo contains a Global_Vars.resource file that contains default values for many of the variables used throughout the tests.  These are imported by the test-suites themselves, so there is no need to specify them on the command line.

Use local Variable files to overwrite specific variables for each test run (SAL and XML versions, things like that).  Variable files contain additional command-line arguments to the **robot** command.  The Variable file can have any name, but usually something like **Test_Vars.txt**.  As such, you can use multiple variable files, with different names, for different configurations and just switch which one you call, or use just one file and change the values as needed.  Here is an example of a local Variable file

    # Arguments file for testing the SAL XML definition files
    # Output directory
    -d /home/appuser/Reports
    
    # Specify tags to NOT run
    -e skipped
    #-e TSS*
    
    # Specify non-critical failures
    --skiponfailure skipped
    --skiponfailure TSS*
    
    # Invoke xmlstarlet in Linux
    --variable ContInt:true
    
    # Redefine default variables
    --variable OpenspliceRelease:Vortex OpenSplice HDE Release
    --variable OpenspliceVersion:6.11.0
    --variable OpenspliceDate:2021-03-04
    --variable SALInstall:/home/appuser/trunk/ts_sal
    --variable SALVersion:6.0.0
    --variable XMLVersion:9.0.0
    --variable Build_Number:pre999
    --variable PythonVersion:Python 3.8.8
    --variable MvnVersion:Apache Maven 3.6.3
    --variable MavenVersion:-SNAPSHOT
    
A typical command-line invocation of RF looks like this

    robot -A ~/bin/Test_Vars.txt SALGEN/Test_salgenerator.robot
    
or for a list of test-suites

    robot -A ~/bin/Test_Vars.txt -A Test_SalGen.list
    
## Test lists
Each CSC has a test-suite, a *.robot* file, for the SALGENERATOR tests.  That means there are N number of SALGENERATOR test-suites, where N is the number of CSCs (62 as of 23 Jun 2021).  To avoid having a robot command with numerous individual arguments, or invoking numerous robot commands, the test-suites are listed in TestList files, with the *.list* extension and stored in the base directory the repository.

For the SALGENERATOR tests, there are four important lists; AT_SalGen.list, MT_SalGen.list, Test_SalGen.list and Validate_SAL.list.

    AT_SalGen.list/MT_SalGen.list
        These two have to be maintained manually.  The AT list contains all the AuxTel salgenerator test-suites and the MT list contains all the Main Telescopes           test-suites, but each contains a mutually-exclusive list of the remaining test-suites such that the run-times for each list are approximately equal.
        They are used in the "Generate the RPMs" parallel block of Jenkinsfile.salxml to run the SALGENERATOR test-suites in parallel.
    Test_SalGen.list
        This contains a list of ALL the test-suites.
        It is maintained with the TestList_SalGen.sh script.  After running SalGen.sh simply execute this Bash script to update the SalGen_Test.list.  It will             pick up newly created test-suites and remove entries for deleted test-suites.
        It isn't really used anymore, but is available just in case. 
    Validate_SAL.list
        This list is maintained manually, as it only contains four test-suites.  These test-suites are the MINIMUM tests to run to validate SAL updates.  The Test         and Script CSCs must be generated in order to run the SAL Python unit tests.
        This list is used in the "Validate" block of Jenkinsfile.salxml.
        
 ## Updating the Test Suites

This section describes the process of updating the test-suites/build-scripts.  In the scripts/ directory is the test-suite generator script, SalGen.sh, and a common functions library, \_common.sh.  Additionally, there is the TestList_SalGen.sh script that is used to automatically generate Test_SalGen.list.  To execute SalGen.sh, in a Terminal, cd into the scripts directory and type
   
    ./SalGen.sh [argument]

where [argument] can be **all** (the default, so [argument] can be blank), to generate the test-suites for ALL the CSCs, or a single **\<CSC\>** to generate just that test-suite.  The CSC argument syntax must MATCH an entry of the subsystemArray function in the \_common.sh library, which resides alongside SalGen.sh.  So, if a CSC is added or removed (or renamed, which is basically both added and removed), the subsystemArray must be updated accordingly. 

The SalGen.sh script starts out by deleting the current test-suite file, then generating a new one.  It reads the [ts_xml](https://github.com/lsst-ts/ts_xml) repo for the XML definition files and then creates all the appropriate test cases within the test-suite.

**Important Notes**

> Before executing SalGen.sh, **ensure** you have checked out and updated the correct branch of ts_xml.

> SalGen.sh expects ts_xml to reside in the $HOME/trunk directory.

The test-suites are added to the SALGEN/ directory, if you should wish to examine them, for example, after doing an update, to make sure everything looks right.

### Questions, comments and concerns.

Contact me at <rbovill@lsst.org>
