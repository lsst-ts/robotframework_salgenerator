#!/bin/bash
#  Shell script to generate login test case.
#
#  author: Rob Bovill
#  email:  rbovill@lsst.org

#  VARIABLES

#  FUNCTIONS
function getRuntimeLanguages() {
    local subsystem=$1
    local output=$( xml sel -t -m "//SALSubsystemSet/SALSubsystem[Name='$subsystem']/RuntimeLanguages" -v . -n $HOME/trunk/ts_xml/sal_interfaces/SALSubsystems.xml )
    echo $output
}

function getTelemetryTopics() {
    local subSystem=$(getEntity $1)
    local output=$( xml sel -t -m "//SALTelemetrySet/SALTelemetry/EFDB_Topic" -v . -n $HOME/trunk/ts_xml/sal_interfaces/${subSystem}/${subSystem}_Telemetry.xml |sed "s/${subSystem}_//" )
    echo $output
}

function getCommandTopics() {
    local subSystem=$1
    local array=()
    local commands=""
    local generic_commands=""
    ## First, get all the CSC defined commands from the interface definition.
    if test -f $HOME/trunk/ts_xml/sal_interfaces/${subSystem}/${subSystem}_Commands.xml; then
        local commands=$( xml sel -t -m "//SALCommandSet/SALCommand/EFDB_Topic" -v . -n $HOME/trunk/ts_xml/sal_interfaces/${subSystem}/${subSystem}_Commands.xml |sed "s/${subSystem}_command_//" |tr '\r\n' ' ' )
    fi
    ## Now, get the desired Generic commands.
    ### If <Generics> is "yes", then grab them all.  If "no", grab none.  If comma-delimited list, just grab the "*command*" items.
    if [[ $( xml sel -t -m "//SALSubsystemSet/SALSubsystem[Name='$subSystem']" -v Generics $HOME/trunk/ts_xml/sal_interfaces/SALSubsystems.xml ) == "yes" ]]; then
        local generic_commands=$( xml sel -t -m "//SALObjects/SALCommandSet/SALCommand/EFDB_Topic" -v . -n $HOME/trunk/ts_xml/sal_interfaces/SALGenerics.xml |sed "s/SALGeneric_command_//" |tr '\r\n' ' ' )
    elif [[ $( xml sel -t -m "//SALSubsystemSet/SALSubsystem[Name='$subSystem']" -v Generics $HOME/trunk/ts_xml/sal_interfaces/SALSubsystems.xml ) == "no" ]]; then
        local generic_commands=()
    else
        local array=($(xml sel -t -m "//SALSubsystemSet/SALSubsystem[Name='$subSystem']" -v Generics $HOME/trunk/ts_xml/sal_interfaces/SALSubsystems.xml |sed 's/,//g' ))
        for topic in ${array[@]}; do
            if [[ "$topic" == *"command_"* ]]; then
                generic_commands+=$(echo "$topic " |sed 's/command_//g')
            fi 
        done
    fi
    ## Return the list.
    echo "$generic_commands $commands"
}

function getEventTopics() {
    local subSystem=$1
    local array=()
    local events=""
    local generic_events=""
    ## First, get all the CSC defined events from the interface definition.
    if test -f $HOME/trunk/ts_xml/sal_interfaces/${subSystem}/${subSystem}_Events.xml; then
        local events=$( xml sel -t -m "//SALEventSet/SALEvent/EFDB_Topic" -v . -n $HOME/trunk/ts_xml/sal_interfaces/${subSystem}/${subSystem}_Events.xml |sed "s/${subSystem}_logevent_//" |tr '\r\n' ' ')
    fi
    ## Now, get the desired Generic events.
    ### If <Generics> is "yes", then grab them all.  If "no", grab none.  If comma-delimited list, just grab the "*logevent*" items.
    if [[ $( xml sel -t -m "//SALSubsystemSet/SALSubsystem[Name='$subSystem']" -v Generics $HOME/trunk/ts_xml/sal_interfaces/SALSubsystems.xml ) == "yes" ]]; then
        local generic_events=$( xml sel -t -m "//SALObjects/SALEventSet/SALEvent/EFDB_Topic" -v . -n $HOME/trunk/ts_xml/sal_interfaces/SALGenerics.xml |sed "s/SALGeneric_logevent_//" |tr '\r\n' ' ' )
    elif [[ $( xml sel -t -m "//SALSubsystemSet/SALSubsystem[Name='$subSystem']" -v Generics $HOME/trunk/ts_xml/sal_interfaces/SALSubsystems.xml ) == "no" ]]; then
        local generic_events=()
    else
        local array=($(xml sel -t -m "//SALSubsystemSet/SALSubsystem[Name='$subSystem']" -v Generics $HOME/trunk/ts_xml/sal_interfaces/SALSubsystems.xml |sed 's/,//g' ))
        for topic in ${array[@]}; do
            if [[ "$topic" == *"logevent_"* ]]; then
                generic_events+=$(echo "$topic " |sed 's/logevent_//g')
            fi
        done
    fi
    ## Return the list.
    echo "$generic_events $events"
}

function clearTestSuites() {
    # Get the terms into the correct capitalization.
    local slash="/"
    local subsystem=$(capitializeSubsystem $1)
    local language=$(echo $2 |tr [a-z] [A-Z]) #Programming language is fully capitalized
    if [ -n "$3" ]; then local topic_type=$(tr '[:lower:]' '[:upper:]' <<< ${3:0:1})${3:1}${slash}; else local topic_type=""; fi #Topic type is capitalized 
    echo "============================================================================================"
    files=$(ls -1 $HOME/trunk/robotframework_salgenerator/$language/$topic_type${subsystem}_*)
    if [ $? -eq 0 ]; then
        echo "Deleting:"
        echo "$files"
        rm $HOME/trunk/robotframework_salgenerator/$language/$topic_type${subsystem}_*
    else
        echo "Nothing to delete. Continuing."
    fi
    echo ""
}

function subsystemArray() {
    echo "AdamSensors ATAOS ATArchiver ATBuilding ATCamera 
    ATDome ATDomeTrajectory ATHeaderService ATHexapod 
    ATMCS ATMonochromator ATOODS ATPneumatics 
    ATPtg ATSpectrograph ATWhiteLight Authorize
    CCArchiver CCCamera CCHeaderService CCOODS
    CatchupArchiver CBP DIMM DSM
    EAS Electrometer ESS
    FiberSpectrograph GenericCamera IOTA 
    MTHexapod HVAC LinearStage LOVE 
    MTAOS MTAlignment MTCamera MTDome 
    MTDomeTrajectory MTEEC MTHeaderService
    MTM1M3 MTM1M3TS MTM2 MTMount MTPtg MTVMS
    OCPS PromptProcessing MTRotator
    Scheduler Script ScriptQueue SummitFacility Test
    TunableLaser Watcher WeatherStation"
}

function stateArray() {
    echo "enable disable standby start"
}

function capitializeSubsystem() {
    local subSystem=$1
    echo $subSystem
}

function getEntity() {
    local entity=$1
    if [ "$entity" == "all" ]; then
        echo "all"
    else
        echo "$entity"
    fi
}

function randomString() {
    datatype=$1
    count=$2
    value=$(cat /dev/random |base64 | tr -dc 'a-zA-Z' | fold -w $count | head -n 1)
    echo $value
}

function generateArgument() {
    parameterType=$1
    parameterIDLSize=$2
    # For string and char, an IDL_Size of 1 means arbitrary size, so set parameterIDLSize to a random, positive number.
    if [[ (-z $parameterIDLSize || $parameterIDLSize == "1") && ($parameterType == "char" || $parameterType == "string") ]]; then
        parameterIDLSize=$((1 + RANDOM % 1000))
    fi    

    ###### Set the test value. ######
    # For char and string, the ONE argument is of length IDL_Size.
    if [[ ($parameterType == "char") || ($parameterType == "string") ]]; then
        testValue=$(randomString "$parameterType" $parameterIDLSize)
    # For everything else, arrays are allowed.  This is handled in the calling script.
    else
        testValue=$(python random_value.py "$parameterType")
    fi
    echo $testValue
}

function checkIfSkipped() {
    subsystem=$1
    topic=$2
    skipped=""
    echo -e "$skipped"
}
