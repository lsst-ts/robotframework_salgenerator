#!/bin/bash
#  Shell script to generate login test case.
#
#  author: Rob Bovill
#  email:  rbovill@lsst.org

#  VARIABLES
added_generics_mandatory_commands=()

added_generics_mandatory_events=(
    "heartbeat",
    "logLevel",
    "logMessage",
    "softwareVersions",
)

added_generics_csc_commands=(
    "disable",
    "enable",
    "exitControl",
    "setLogLevel",
    "standby",
    "start",
)

added_generics_csc_events=(
    "errorCode",
    "simulationMode",
    "summaryState",
)

added_generics_configurable_commands=()

added_generics_configurable_events=(
    "configurationApplied",
    "configurationsAvailable",
)

## The topics listed below must be listed explicitly
## in the AddedGenerics tag in SALSubsystems.xml.
## They are listed here for completeness only.
## The getCommandTopics() and getEventTopics()
## functions handle explicity named topics.

added_generics_NOT_mandatory_commands=(
    "abort",
    "enterControl",
)

added_generics_NOT_mandatory_events=(
    "largeFileObjectAvailable",
    "statusCode",
)


#  FUNCTIONS
function getRuntimeLanguages() {
    # This function returns, for the given $subsystem (CSC), the values in the 
    # <RuntimeLanguages> field in the ts_xml/python/lsst/ts/xml/data/sal_interfaces/SALSubsystems.xml file.
    #
    # It expects the file to be in the $HOME/repos/ts_xml/python/lsst/ts/xml/data/sal_interfaces/ directory.
    #
    local subsystem=$1
    local output=$( xmlstarlet sel -t -m "//SALSubsystemSet/SALSubsystem[Name='$subsystem']/RuntimeLanguages" -v . -n $HOME/repos/ts_xml/python/lsst/ts/xml/data/sal_interfaces/SALSubsystems.xml )
    echo $output
}


function getTelemetryTopics() {
    # This function takes the $subsystem (CSC) as an argument and returns the values for all the
    # <EFDB_Topic> fields in the ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Telemetry.xml file.
    #
    # It expects the file to be in the $HOME/repos/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem} directory.
    #
    local subSystem=$1
    local output=""
    if test -f $HOME/repos/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Telemetry.xml; then
        output=$( xmlstarlet sel -t -m "//SALTelemetrySet/SALTelemetry/EFDB_Topic" -v . -n $HOME/repos/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Telemetry.xml |sed "s/${subSystem}_//" )
    fi
    echo $output
}


function getCommandTopics() {
    # This function takes the $subsystem (CSC) as an argument and returns the values for all the
    # <EFDB_Topic> fields in the ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Commands.xml file
    # AND the selected values from the <AddedGenerics> field of ts_xml/python/lsst/ts/xml/data/sal_interfaces/SALSubsystems.xml.
    #
    # It expects the files to be in the $HOME/repos/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem} directory.
    #
    local subSystem=$1
    local array=()
    local commands=""
    local generic_commands=""
    ## First, get all the CSC defined commands from the interface definition.
    if test -f $HOME/repos/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Commands.xml; then
        local commands=$( xmlstarlet sel -t -m "//SALCommandSet/SALCommand/EFDB_Topic" -v . -n $HOME/repos/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Commands.xml |sed "s/${subSystem}_command_//" |tr '\r\n' ',' )
    fi
    ## Now, get the desired Generic commands.
    ### If <AddedGenerics> contains "csc," then add the added_generics_csc_commands.  If it contains "log," add the added_generics_log_commands. If it contains "configurable," add the added_generics_configurable_commands.  If it contains individual, comma-delimited topics, just grab the "*command*" items.
    local generic_commands=(${added_generics_mandatory_commands[@]})
    if [[ $( xmlstarlet sel -t -m "//SALSubsystemSet/SALSubsystem[Name='$subSystem']" -v AddedGenerics $HOME/repos/ts_xml/python/lsst/ts/xml/data/sal_interfaces/SALSubsystems.xml ) =~ "csc" ]]; then
        generic_commands+=(${added_generics_csc_commands[@]})
    fi
    if [[ $( xmlstarlet sel -t -m "//SALSubsystemSet/SALSubsystem[Name='$subSystem']" -v AddedGenerics $HOME/repos/ts_xml/python/lsst/ts/xml/data/sal_interfaces/SALSubsystems.xml ) =~ "configurable" ]]; then
        generic_commands+=(${added_generics_configurable_commands[@]})
    fi
    
    # Now add the individual topics.
    local array=($(xmlstarlet sel -t -m "//SALSubsystemSet/SALSubsystem[Name='$subSystem']" -v AddedGenerics $HOME/repos/ts_xml/python/lsst/ts/xml/data/sal_interfaces/SALSubsystems.xml |sed 's/,//g' ))
    for topic in ${array[@]}; do
        if [[ "$topic" == *"command_"* ]]; then
            str=$(echo "$topic," |sed 's/command_//g')
            generic_commands+=("$str")
        fi 
    done
    ## Return the list.
    echo "${generic_commands[@]}${commands[@]}" |sed "s/,/ /g"
}


function getEventTopics() {
    # This function takes the $subsystem (CSC) as an argument and returns the values for all the
    # <EFDB_Topic> fields in the ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Events.xml file
    # AND the selected values from the <AddedGenerics> field of ts_xml/python/lsst/ts/xml/data/sal_interfaces/SALSubsystems.xml.
    #
    # It expects the files to be in the $HOME/repos/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem} directory.
    #
    local subSystem=$1
    local array=()
    local events=""
    local generic_events=""
    ## First, get all the CSC defined events from the interface definition.
    if test -f $HOME/repos/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Events.xml; then
        local events=$( xmlstarlet sel -t -m "//SALEventSet/SALEvent/EFDB_Topic" -v . -n $HOME/repos/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subSystem}/${subSystem}_Events.xml |sed "s/${subSystem}_logevent_//" |tr '\r\n' ',')
    fi
    ## Now, get the desired Generic events.
    ### If <AddedGenerics> contains "csc," then add the added_generics_csc_events.  If it contains "log," add the added_generics_log_events. If it contains "configurable," add the added_generics_configurable_events.  If it contains individual, comma-delimited topics, just grab the "*logevent*" items.
    generic_events=(${added_generics_mandatory_events[@]})
    if [[ $( xmlstarlet sel -t -m "//SALSubsystemSet/SALSubsystem[Name='$subSystem']" -v AddedGenerics $HOME/repos/ts_xml/python/lsst/ts/xml/data/sal_interfaces/SALSubsystems.xml ) =~ "csc" ]]; then
        generic_events+=("${added_generics_csc_events[@]}")
    fi
    if [[ $( xmlstarlet sel -t -m "//SALSubsystemSet/SALSubsystem[Name='$subSystem']" -v AddedGenerics $HOME/repos/ts_xml/python/lsst/ts/xml/data/sal_interfaces/SALSubsystems.xml ) =~ "configurable" ]]; then
        generic_events+=("${added_generics_configurable_events[@]}")
    fi

    # Now add the individual topics.
    local array=($(xmlstarlet sel -t -m "//SALSubsystemSet/SALSubsystem[Name='$subSystem']" -v AddedGenerics $HOME/repos/ts_xml/python/lsst/ts/xml/data/sal_interfaces/SALSubsystems.xml |sed 's/,//g' ))
    for topic in ${array[@]}; do
        if [[ "$topic" == *"logevent_"* ]]; then
            str=$(echo "$topic," |sed 's/logevent_//g')
            generic_events+=("$str")
        fi
    done
    ## Return the list.
    echo "${generic_events[@]}${events[@]}" |sed "s/,/ /g"
}


function clearTestSuites() {
    # This function takes the $subsystem (CSC) and "SALGEN" as arguments and deletes the appropriate test suite.
    # It is used prior to creating the updated test suite and is the cleanest way of capturing all changes, which 
    # often includes deletions.
    #
    local slash="/"
    local subsystem=$(capitializeSubsystem $1)
    local language=$(echo $2 |tr [a-z] [A-Z]) #Programming language is fully capitalized
    if [ -n "$3" ]; then local topic_type=$(tr '[:lower:]' '[:upper:]' <<< ${3:0:1})${3:1}${slash}; else local topic_type=""; fi #Topic type is capitalized 
    echo "============================================================================================"
    files=$(ls -1 $HOME/repos/robotframework_salgenerator/$language/$topic_type${subsystem}_*)
    if [ $? -eq 0 ]; then
        echo "Deleting:"
        echo "$files"
        rm $HOME/repos/robotframework_salgenerator/$language/$topic_type${subsystem}_*
    else
        echo "Nothing to delete. Continuing."
    fi
    echo ""
}


function subsystemArrayDDS() {
    # Independent definition of all the CSCs (called Subsystems in SalGen.sh).
    #
    # While it is possible to use ts_xml/python/lsst/ts/xml/data/sal_interfaces/SALSubsystems.xml to 
    # generate this list, it is better to have an independent list, such that
    # the thing being tested is not used to test the thing.
    #
    echo "ATAOS ATBuilding ATCamera 
    ATDome ATDomeTrajectory ATHeaderService ATHexapod 
    ATMCS ATMonochromator ATOODS ATPneumatics 
    ATPtg ATSpectrograph ATWhiteLight
    CCCamera CCHeaderService CCOODS CBP 
    DIMM DREAM DSM
    EAS Electrometer EPM ESS FiberSpectrograph 
    GCHeaderService GenericCamera GIS Guider 
    HVAC LaserTracker LEDProjector LinearStage LOVE 
    MOSS MTAirCompressor MTAOS MTCamera MTDome 
    MTDomeTrajectory MTHexapod MTEEC MTHeaderService
    MTM1M3 MTM1M3TS MTM2 MTMount MTOODS MTPtg 
    MTReflector MTRotator MTVMS OCPS PMD 
    Scheduler Script ScriptQueue SummitFacility 
    Test TunableLaser 
    Watcher WeatherForecast"
}


function subsystemArray() {
    # Independent definition of all the CSCs (called Subsystems in SalGen.sh)
    # to build under Kafka.
    #
    # While it is possible to use ts_xml/python/lsst/ts/xml/data/sal_interfaces/SALSubsystems.xml to 
    # generate this list, it is better to have an independent list, such that
    # the thing being tested is not used to test the thing.
    #
    echo "ATCamera ATHeaderService ATMCS ATPtg 
    CCCamera CCHeaderService
    ESS GCHeaderService Guider MTM1M3 
    MTCamera MTHeaderService
    MTMount MTPtg MTRotator MTVMS Test"
}


function capitializeSubsystem() {
    local subSystem=$1
    echo $subSystem
}


function checkIfSkipped() {
    subsystem=$1
    topic=$2
    skipped=""
    echo -e "$skipped"
}

function fieldEnums() {
    local subsystem=$1
    local topicType=$2
    if [ ${topicType} != "Telemetry" ]; then
        topicSet=${topicType%?}
    fi
    if [ -f $HOME/repos/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subsystem}/${subsystem}_${topicType}.xml ]; then
        if [ "$(xmlstarlet sel -t -m "//SAL${topicSet}Set/SAL${topicSet}/item/Enumeration" -v . -n $HOME/repos/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subsystem}/${subsystem}_${topicType}.xml)" != "" ]; then 
            echo 1 
        else
            echo 0
        fi
    else
        echo 0
     fi
}

function globalEnums() {
    local subsystem=$1
    local topicType=$2
    if [ "${topicType}" != "Telemetry" ]; then
        topicSet=${topicType%?}
    fi
    if [ -f $HOME/repos/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subsystem}/${subsystem}_${topicType}.xml ]; then
        if [ "$(xmlstarlet sel -t -m "//SAL${topicSet}Set/Enumeration" -v . -n $HOME/repos/ts_xml/python/lsst/ts/xml/data/sal_interfaces/${subsystem}/${subsystem}_${topicType}.xml)" != "" ]; then
            echo 1
        else
            echo 0
        fi
    else
        echo 0
     fi
}
