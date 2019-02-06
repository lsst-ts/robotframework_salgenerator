*** Settings ***
Documentation    This suite builds the various interfaces for the Scheduler.
Force Tags    salgen    
Suite Setup    Log Many    ${Host}    ${subSystem}    ${timeout}
Library    OperatingSystem
Library    Process
Resource    ../Global_Vars.resource

*** Variables ***
${subSystem}    Scheduler
${timeout}    1200s

*** Test Cases ***
Verify Scheduler XML Defintions exist
    [Tags]
    Comment    Verify the CSC XML definition files exist.
    ${output}    Run Process    ls     ${SALWorkDir}/Scheduler_*.xml    shell=True
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stderr}    No such file or directory    msg="Scheduler has no XML defintions"    values=False
    Should Not Be Empty    ${output.stdout}
    File Should Exist    ${SALWorkDir}/Scheduler_Events.xml
    File Should Exist    ${SALWorkDir}/Scheduler_Telemetry.xml

Salgen Scheduler Validate
    [Documentation]    Validate the Scheduler XML definitions.
    [Tags]    validate
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    validate    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Processing ${subSystem}
    Should Contain    ${output.stdout}    Completed ${subSystem} validation
    Directory Should Exist    ${SALWorkDir}/idl-templates
    Directory Should Exist    ${SALWorkDir}/idl-templates/validated
    @{files}=    List Directory    ${SALWorkDir}/idl-templates    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_timestamp.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_loopTimeMs.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_nightSummary.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_predictedSchedule.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_surveyTopology.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_schedulerConfig.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_driverConfig.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_obsSiteConfig.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_telescopeConfig.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_rotatorConfig.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_domeConfig.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_cameraConfig.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_slewConfig.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_opticsLoopCorrConfig.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_parkConfig.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_generalPropConfig.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_sequencePropConfig.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_observatoryState.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_observation.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_interestedProposal.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_timeHandler.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_bulkCloud.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_cloudMap.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_seeing.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_wind.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_temperature.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_skyBrightness.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_photometricQuality.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_avoidanceRegions.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_downtime.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_internalCommand.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_heartbeat.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_loopTimeOutOfRange.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_rejectedCommand.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_settingsApplied.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_target.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_invalidateTarget.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_needFilterSwap.idl

Salgen Scheduler HTML
    [Documentation]    Create web form interfaces.
    [Tags]    html    
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    html    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Generating telemetry stream definition editor html
    Should Contain    ${output.stdout}    Creating sal-generator-${subSystem} form
    Should Contain    ${output.stdout}    Added sal-generator-${subSystem}.timestamp to form
    Should Contain    ${output.stdout}    Added sal-generator-${subSystem}.loopTimeMs to form
    Should Contain    ${output.stdout}    Added sal-generator-${subSystem}.nightSummary to form
    Should Contain    ${output.stdout}    Added sal-generator-${subSystem}.predictedSchedule to form
    Should Contain    ${output.stdout}    Added sal-generator-${subSystem}.surveyTopology to form
    Should Contain    ${output.stdout}    Added sal-generator-${subSystem}.schedulerConfig to form
    Should Contain    ${output.stdout}    Added sal-generator-${subSystem}.driverConfig to form
    Should Contain    ${output.stdout}    Added sal-generator-${subSystem}.obsSiteConfig to form
    Should Contain    ${output.stdout}    Added sal-generator-${subSystem}.telescopeConfig to form
    Should Contain    ${output.stdout}    Added sal-generator-${subSystem}.rotatorConfig to form
    Should Contain    ${output.stdout}    Added sal-generator-${subSystem}.domeConfig to form
    Should Contain    ${output.stdout}    Added sal-generator-${subSystem}.cameraConfig to form
    Should Contain    ${output.stdout}    Added sal-generator-${subSystem}.slewConfig to form
    Should Contain    ${output.stdout}    Added sal-generator-${subSystem}.opticsLoopCorrConfig to form
    Should Contain    ${output.stdout}    Added sal-generator-${subSystem}.parkConfig to form
    Should Contain    ${output.stdout}    Added sal-generator-${subSystem}.generalPropConfig to form
    Should Contain    ${output.stdout}    Added sal-generator-${subSystem}.sequencePropConfig to form
    Should Contain    ${output.stdout}    Added sal-generator-${subSystem}.observatoryState to form
    Should Contain    ${output.stdout}    Added sal-generator-${subSystem}.observation to form
    Should Contain    ${output.stdout}    Added sal-generator-${subSystem}.interestedProposal to form
    Should Contain    ${output.stdout}    Added sal-generator-${subSystem}.timeHandler to form
    Should Contain    ${output.stdout}    Added sal-generator-${subSystem}.bulkCloud to form
    Should Contain    ${output.stdout}    Added sal-generator-${subSystem}.cloudMap to form
    Should Contain    ${output.stdout}    Added sal-generator-${subSystem}.seeing to form
    Should Contain    ${output.stdout}    Added sal-generator-${subSystem}.wind to form
    Should Contain    ${output.stdout}    Added sal-generator-${subSystem}.temperature to form
    Should Contain    ${output.stdout}    Added sal-generator-${subSystem}.skyBrightness to form
    Should Contain    ${output.stdout}    Added sal-generator-${subSystem}.photometricQuality to form
    Should Contain    ${output.stdout}    Added sal-generator-${subSystem}.avoidanceRegions to form
    Should Contain    ${output.stdout}    Added sal-generator-${subSystem}.downtime to form
    Directory Should Exist    ${SALWorkDir}/html/salgenerator/${subSystem}
    @{files}=    List Directory    ${SALWorkDir}/html/salgenerator/${subSystem}    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/html/${subSystem}/Scheduler_Events.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/Scheduler_Telemetry.html

Salgen Scheduler C++
    [Documentation]    Generate C++ wrapper.
    [Tags]    cpp
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    sal    cpp   shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stdout}    *** DDS error in file
    Should Not Contain    ${output.stdout}    Error 1
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_timestamp.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_loopTimeMs.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_nightSummary.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_predictedSchedule.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_surveyTopology.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_schedulerConfig.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_driverConfig.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_obsSiteConfig.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_telescopeConfig.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_rotatorConfig.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_domeConfig.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_cameraConfig.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_slewConfig.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_opticsLoopCorrConfig.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_parkConfig.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_generalPropConfig.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_sequencePropConfig.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_observatoryState.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_observation.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_interestedProposal.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_timeHandler.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_bulkCloud.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_cloudMap.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_seeing.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_wind.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_temperature.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_skyBrightness.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_photometricQuality.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_avoidanceRegions.idl
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_downtime.idl
    Should Contain X Times    ${output.stdout}    cpp : Done Publisher    30
    Should Contain X Times    ${output.stdout}    cpp : Done Subscriber    30
    Should Contain X Times    ${output.stdout}    cpp : Done Commander    1
    Should Contain X Times    ${output.stdout}    cpp : Done Event/Logger    1

Verify C++ Directories
    [Documentation]    Ensure expected C++ directories and files.
    [Tags]    cpp
    Directory Should Exist    ${SALWorkDir}/${subSystem}/cpp
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/cpp    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/libsacpp_${subSystem}_types.so
    Directory Should Exist    ${SALWorkDir}/idl-templates/validated/sal
    @{files}=    List Directory    ${SALWorkDir}/idl-templates/validated/sal    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/idl-templates/validated/sal/sal_${subSystem}.idl

Verify Scheduler Telemetry directories
    [Tags]    cpp
    @{files}=    List Directory    ${SALWorkDir}    pattern=*${subSystem}*
    Log Many    @{files}
    Directory Should Exist    ${SALWorkDir}/${subSystem}_timestamp
    Directory Should Exist    ${SALWorkDir}/${subSystem}_loopTimeMs
    Directory Should Exist    ${SALWorkDir}/${subSystem}_nightSummary
    Directory Should Exist    ${SALWorkDir}/${subSystem}_predictedSchedule
    Directory Should Exist    ${SALWorkDir}/${subSystem}_surveyTopology
    Directory Should Exist    ${SALWorkDir}/${subSystem}_schedulerConfig
    Directory Should Exist    ${SALWorkDir}/${subSystem}_driverConfig
    Directory Should Exist    ${SALWorkDir}/${subSystem}_obsSiteConfig
    Directory Should Exist    ${SALWorkDir}/${subSystem}_telescopeConfig
    Directory Should Exist    ${SALWorkDir}/${subSystem}_rotatorConfig
    Directory Should Exist    ${SALWorkDir}/${subSystem}_domeConfig
    Directory Should Exist    ${SALWorkDir}/${subSystem}_cameraConfig
    Directory Should Exist    ${SALWorkDir}/${subSystem}_slewConfig
    Directory Should Exist    ${SALWorkDir}/${subSystem}_opticsLoopCorrConfig
    Directory Should Exist    ${SALWorkDir}/${subSystem}_parkConfig
    Directory Should Exist    ${SALWorkDir}/${subSystem}_generalPropConfig
    Directory Should Exist    ${SALWorkDir}/${subSystem}_sequencePropConfig
    Directory Should Exist    ${SALWorkDir}/${subSystem}_observatoryState
    Directory Should Exist    ${SALWorkDir}/${subSystem}_observation
    Directory Should Exist    ${SALWorkDir}/${subSystem}_interestedProposal
    Directory Should Exist    ${SALWorkDir}/${subSystem}_timeHandler
    Directory Should Exist    ${SALWorkDir}/${subSystem}_bulkCloud
    Directory Should Exist    ${SALWorkDir}/${subSystem}_cloudMap
    Directory Should Exist    ${SALWorkDir}/${subSystem}_seeing
    Directory Should Exist    ${SALWorkDir}/${subSystem}_wind
    Directory Should Exist    ${SALWorkDir}/${subSystem}_temperature
    Directory Should Exist    ${SALWorkDir}/${subSystem}_skyBrightness
    Directory Should Exist    ${SALWorkDir}/${subSystem}_photometricQuality
    Directory Should Exist    ${SALWorkDir}/${subSystem}_avoidanceRegions
    Directory Should Exist    ${SALWorkDir}/${subSystem}_downtime

Verify Scheduler C++ Telemetry Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}_timestamp/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_timestamp/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_loopTimeMs/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_loopTimeMs/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_nightSummary/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_nightSummary/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_predictedSchedule/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_predictedSchedule/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_surveyTopology/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_surveyTopology/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_schedulerConfig/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_schedulerConfig/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_driverConfig/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_driverConfig/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_obsSiteConfig/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_obsSiteConfig/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_telescopeConfig/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_telescopeConfig/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_rotatorConfig/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_rotatorConfig/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_domeConfig/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_domeConfig/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_cameraConfig/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_cameraConfig/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_slewConfig/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_slewConfig/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_opticsLoopCorrConfig/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_opticsLoopCorrConfig/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_parkConfig/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_parkConfig/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_generalPropConfig/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_generalPropConfig/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_sequencePropConfig/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_sequencePropConfig/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_observatoryState/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_observatoryState/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_observation/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_observation/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_interestedProposal/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_interestedProposal/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_timeHandler/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_timeHandler/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_bulkCloud/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_bulkCloud/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_cloudMap/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_cloudMap/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_seeing/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_seeing/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_wind/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_wind/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_temperature/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_temperature/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_skyBrightness/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_skyBrightness/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_photometricQuality/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_photometricQuality/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_avoidanceRegions/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_avoidanceRegions/cpp/standalone/sacpp_${subSystem}_sub
    File Should Exist    ${SALWorkDir}/${subSystem}_downtime/cpp/standalone/sacpp_${subSystem}_pub
    File Should Exist    ${SALWorkDir}/${subSystem}_downtime/cpp/standalone/sacpp_${subSystem}_sub

Verify Scheduler C++ Event Interfaces
    [Documentation]    Verify the C++ interfaces were properly created.
    [Tags]    cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_internalCommand_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_internalCommand_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_heartbeat_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_heartbeat_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_loopTimeOutOfRange_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_loopTimeOutOfRange_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_rejectedCommand_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_rejectedCommand_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_settingsApplied_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_settingsApplied_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_target_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_target_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_invalidateTarget_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_invalidateTarget_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_needFilterSwap_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_needFilterSwap_log

Salgen Scheduler Python
    [Documentation]    Generate Python wrapper.
    [Tags]    python    DM-17459
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    sal    python    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Generating Python SAL support for ${subSystem}
    Should Contain    ${output.stdout}    Generating Python bindings
    Should Contain    ${output.stdout}    python : Done SALPY_${subSystem}.so
    Directory Should Exist    ${SALWorkDir}/${subSystem}/python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/SALPY_${subSystem}.so

Verify Scheduler Python Telemetry Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_timestamp_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_timestamp_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_loopTimeMs_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_loopTimeMs_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_nightSummary_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_nightSummary_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_predictedSchedule_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_predictedSchedule_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_surveyTopology_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_surveyTopology_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_schedulerConfig_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_schedulerConfig_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_driverConfig_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_driverConfig_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_obsSiteConfig_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_obsSiteConfig_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_telescopeConfig_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_telescopeConfig_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_rotatorConfig_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_rotatorConfig_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_domeConfig_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_domeConfig_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_cameraConfig_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_cameraConfig_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_slewConfig_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_slewConfig_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_opticsLoopCorrConfig_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_opticsLoopCorrConfig_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_parkConfig_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_parkConfig_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_generalPropConfig_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_generalPropConfig_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_sequencePropConfig_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_sequencePropConfig_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_observatoryState_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_observatoryState_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_observation_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_observation_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_interestedProposal_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_interestedProposal_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_timeHandler_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_timeHandler_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_bulkCloud_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_bulkCloud_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_cloudMap_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_cloudMap_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_seeing_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_seeing_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_wind_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_wind_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_temperature_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_temperature_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_skyBrightness_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_skyBrightness_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_photometricQuality_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_photometricQuality_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_avoidanceRegions_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_avoidanceRegions_Subscriber.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_downtime_Publisher.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_downtime_Subscriber.py

Verify Scheduler Python Event Interfaces
    [Documentation]    Verify the Python interfaces were properly created.
    [Tags]    python
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/python    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_internalCommand.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_internalCommand.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_heartbeat.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_heartbeat.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_loopTimeOutOfRange.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_loopTimeOutOfRange.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_rejectedCommand.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_rejectedCommand.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_settingsApplied.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_settingsApplied.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_target.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_target.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_invalidateTarget.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_invalidateTarget.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_needFilterSwap.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_needFilterSwap.py

Salgen Scheduler LabVIEW
    [Documentation]    Generate ${subSystem} low-level LabView interfaces.
    [Tags]    labview    DM-17459
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    labview    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Directory Should Exist    ${SALWorkDir}/${subSystem}/labview
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/labview
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/${subSystem}/labview/SAL_${subSystem}_salShmMonitor.cpp
    File Should Exist    ${SALWorkDir}/${subSystem}/labview/SAL_${subSystem}_shmem.h
    File Should Exist    ${SALWorkDir}/${subSystem}/labview/SALLV_${subSystem}.so
    File Should Exist    ${SALWorkDir}/${subSystem}/labview/SALLV_${subSystem}_Monitor

Salgen Scheduler Java
    [Documentation]    Generate Java wrapper.
    [Tags]    java
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    sal    java    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_timestamp.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_loopTimeMs.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_nightSummary.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_predictedSchedule.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_surveyTopology.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_schedulerConfig.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_driverConfig.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_obsSiteConfig.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_telescopeConfig.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_rotatorConfig.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_domeConfig.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_cameraConfig.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_slewConfig.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_opticsLoopCorrConfig.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_parkConfig.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_generalPropConfig.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_sequencePropConfig.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_observatoryState.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_observation.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_interestedProposal.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_timeHandler.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_bulkCloud.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_cloudMap.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_seeing.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_wind.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_temperature.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_skyBrightness.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_photometricQuality.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_avoidanceRegions.idl
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_downtime.idl
    Should Contain X Times    ${output.stdout}    javac : Done Publisher    30
    Should Contain X Times    ${output.stdout}    javac : Done Subscriber    30
    Should Contain X Times    ${output.stdout}    javac : Done Commander/Controller    30
    Should Contain X Times    ${output.stdout}    javac : Done Event/Logger    30
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl

Salgen Scheduler Lib
    [Documentation]    Generate the SAL shared library for ${subSystem}
    [Tags]    lib    DM-17459
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    lib    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Building shared library for ${subSystem} subsystem
    Directory Should Exist    ${SALWorkDir}/lib
    @{files}=    List Directory    ${SALWorkDir}/lib
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/lib/libsacpp_${subSystem}_types.so
    File Should Exist    ${SALWorkDir}/lib/libSAL_${subSystem}.so
    File Should Exist    ${SALWorkDir}/lib/SALLV_${subSystem}.so
    File Should Exist    ${SALWorkDir}/lib/SALPY_${subSystem}.so

Salgen Scheduler Maven
    [Documentation]    Generate the Maven repository.
    [Tags]    java
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    maven    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}stdout.txt    stderr=${EXECDIR}${/}stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Running maven install
    Should Contain    ${output.stdout}    [INFO] Building sal_${subSystem} ${SALVersion}
    Should Contain X Times    ${output.stdout}    [INFO] BUILD SUCCESS    1
    Should Contain X Times    ${output.stdout}    [INFO] Finished at:    1
    @{files}=    List Directory    ${SALWorkDir}/maven
    File Should Exist    ${SALWorkDir}/maven/${subSystem}_${SALVersion}/pom.xml

