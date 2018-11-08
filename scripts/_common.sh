#!/bin/bash
#  Shell script to generate login test case.
#
#  author: Rob Bovill
#  email:  rbovill@lsst.org

#  VARIABLES

#  FUNCTIONS
function getTelemetryTopics() {
	local subSystem=$(getEntity $1)
    local output=$( xml sel -t -m "//SALTelemetrySet/SALTelemetry/EFDB_Topic" -v . -n $HOME/trunk/ts_xml/sal_interfaces/${subSystem}/${subSystem}_Telemetry.xml |sed "s/${subSystem}_//" )
    echo $output
}

function getCommandTopics() {
	local subSystem=$1
    local output=$( xml sel -t -m "//SALCommandSet/SALCommand/EFDB_Topic" -v . -n $HOME/trunk/ts_xml/sal_interfaces/${subSystem}/${subSystem}_Commands.xml |sed "s/${subSystem}_command_//" )
    echo $output
}

function getEventTopics() {
	local subSystem=$1
    local output=$( xml sel -t -m "//SALEventSet/SALEvent/EFDB_Topic" -v . -n $HOME/trunk/ts_xml/sal_interfaces/${subSystem}/${subSystem}_Events.xml |sed "s/${subSystem}_logevent_//" )
    echo $output
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
	echo "ATArchiver ATCamera ATDome ATHeaderService ATMCS ATMonochromator ATPneumatics ATSpectrograph ATTCS ATThermoelectricCooler ATWhiteLight CatchupArchiver CBP Dome DomeADB DomeAPS DomeLouvers DomeLWS DomeMONCS DomeTHCS EEC EFD Electrometer FiberSpectrograph Hexapod Laser LinearStage MTArchiver MTCamera MTHeaderService MTM1M3 MTM2 MTMount MTOFC MTWEP OCS PromptProcessing Rotator Scheduler Sequencer SummitFacility MTTCS Test TunableLaser MTVMS"
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
	if [[ ("$subsystem" == "m1m3") ]]; then
		skipped="TSS-2617"
	elif [[ ("$subsystem" == "vms") ]]; then
		skipped="TSS-2618"
	elif [[ ("$subsystem" == "promptprocessing") ]]; then
		skipped="TSS-2605"
	elif [[ ("$subsystem" == "atScheduler") ]]; then
        skipped="TSS-2610"
	elif [[ ("$subsystem" == "catchupArchiver") ]]; then
        skipped="TSS-3006"
	elif [[ ("$subsystem" == "scheduler") ]]; then
        skipped="TSS-1789"
	elif [[ ("$subsystem" == "AtDome") ]]; then
        skipped="TSS-3055"
	elif [[ ("$subsystem" == "html") ]]; then
		skipped="TSS-3079"
	else
		skipped=""
	fi
	echo -e $skipped
}

