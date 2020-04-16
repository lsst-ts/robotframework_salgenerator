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
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    validate    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Processing ${subSystem}
    Should Contain    ${output.stdout}    Completed ${subSystem} validation
    Directory Should Exist    ${SALWorkDir}/idl-templates
    Directory Should Exist    ${SALWorkDir}/idl-templates/validated
    @{files}=    List Directory    ${SALWorkDir}/idl-templates    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_timestamp.idl
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
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_dependenciesVersions.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_target.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_invalidateTarget.idl
    File Should Exist    ${SALWorkDir}/idl-templates/${subSystem}_logevent_needFilterSwap.idl

Salgen Scheduler HTML
    [Documentation]    Create web form interfaces.
    [Tags]    html    
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    html    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Generating telemetry stream definition editor html
    Should Contain    ${output.stdout}    Generating Facility database table creation html
    Should Contain    ${output.stdout}    Generating Subsystem simulation control html
    @{files}=    List Directory    ${SALWorkDir}/html/${subSystem}
    File Should Exist    ${SALWorkDir}/html/${subSystem}/Scheduler_Events.html
    File Should Exist    ${SALWorkDir}/html/${subSystem}/Scheduler_Telemetry.html
    @{files}=    List Directory    ${SALWorkDir}/html/dbsimulate    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/html/dbsimulate/index-dbsimulate.html
    File Should Exist    ${SALWorkDir}/html/dbsimulate/index-dbsimulate-${subSystem}.html
    File Should Exist    ${SALWorkDir}/html/dbsimulate/index-simulate-${subSystem}.html
    File Should Exist    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl

Verify Scheduler revCodes File
    [Documentation]    Ensure Scheduler_revCodes.tcl contains 1 revcode per topic.
    [Tags]    html    
    ${output}=    Log File    ${SALWorkDir}/idl-templates/validated/${subSystem}_revCodes.tcl
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_dependenciesVersions\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_target\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_invalidateTarget\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_logevent_needFilterSwap\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_timestamp\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_nightSummary\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_predictedSchedule\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_surveyTopology\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_schedulerConfig\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_driverConfig\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_obsSiteConfig\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_telescopeConfig\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_rotatorConfig\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_domeConfig\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_cameraConfig\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_slewConfig\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_opticsLoopCorrConfig\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_parkConfig\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_generalPropConfig\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_sequencePropConfig\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_observatoryState\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_observation\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_interestedProposal\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_timeHandler\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_bulkCloud\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_cloudMap\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_seeing\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_wind\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_temperature\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_skyBrightness\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_photometricQuality\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_avoidanceRegions\\) [a-z0-9]{8,}
    Should Match Regexp    ${output}    set REVCODE\\(${subSystem}_downtime\\) [a-z0-9]{8,}

Salgen Scheduler IDL
    [Documentation]    Generate the revCoded IDL for ${subSystem}
    [Tags]    idl
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    sal    idl    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Completed ${subSystem} validation
    @{files}=    List Directory    ${SALWorkDir}/idl-templates/validated/
    Log Many    @{files}

Salgen Scheduler C++
    [Documentation]    Generate C++ wrapper.
    [Tags]    cpp
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    sal    cpp   shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Not Contain    ${output.stdout}    *** DDS error in file
    Should Not Contain    ${output.stdout}    Error 1
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Generating SAL CPP code for ${subSystem}_timestamp.idl
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
    Should Contain X Times    ${output.stdout}    cpp : Done Publisher    29
    Should Contain X Times    ${output.stdout}    cpp : Done Subscriber    29
    Should Contain X Times    ${output.stdout}    cpp : Done Commander    1
    Should Contain X Times    ${output.stdout}    cpp : Done Event/Logger    1

Verify C++ Directories
    [Documentation]    Ensure expected C++ directories and files are created.
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
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_dependenciesVersions_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_dependenciesVersions_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_target_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_target_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_invalidateTarget_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_invalidateTarget_log
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_needFilterSwap_send
    File Should Exist    ${SALWorkDir}/${subSystem}/cpp/src/sacpp_${subSystem}_needFilterSwap_log

Salgen Scheduler Python
    [Documentation]    Generate Python wrapper.
    [Tags]    python
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    sal    python    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
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
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_dependenciesVersions.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_dependenciesVersions.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_target.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_target.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_invalidateTarget.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_invalidateTarget.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_Event_needFilterSwap.py
    File Should Exist    ${SALWorkDir}/${subSystem}/python/${subSystem}_EventLogger_needFilterSwap.py

Salgen Scheduler LabVIEW
    [Documentation]    Generate ${subSystem} low-level LabView interfaces.
    [Tags]    labview
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    labview    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
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
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    sal    java    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Generating SAL Java code for ${subSystem}_timestamp.idl
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
    Should Contain X Times    ${output.stdout}    javac : Done Publisher    29
    Should Contain X Times    ${output.stdout}    javac : Done Subscriber    29
    Directory Should Exist    ${SALWorkDir}/${subSystem}/java
    @{files}=    List Directory    ${SALWorkDir}/${subSystem}/java    pattern=*${subSystem}*
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl
    File Should Exist    ${SALWorkDir}/${subSystem}/java/saj_${subSystem}_types.jar
    File Should Exist    ${SALWorkDir}/${subSystem}/java/sal_${subSystem}.idl

Salgen Scheduler Lib
    [Documentation]    Generate the SAL shared library for ${subSystem}
    [Tags]    lib
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    lib    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}
    Should Contain    ${output.stdout}    Building shared library for ${subSystem} subsystem
    Directory Should Exist    ${SALWorkDir}/lib
    @{files}=    List Directory    ${SALWorkDir}/lib    pattern=*${subSystem}*
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/lib/libsacpp_${subSystem}_types.so
    File Should Exist    ${SALWorkDir}/lib/libSAL_${subSystem}.so
    File Should Exist    ${SALWorkDir}/lib/SALLV_${subSystem}.so
    File Should Exist    ${SALWorkDir}/lib/SALPY_${subSystem}.so
    File Should Exist    ${SALWorkDir}/lib/libsacpp_${subSystem}_types.so
    File Should Exist    ${SALWorkDir}/lib/libSAL_${subSystem}.so
    File Should Exist    ${SALWorkDir}/lib/saj_${subSystem}_types.jar
    File Should Exist    ${SALWorkDir}/lib/SALLV_${subSystem}.so

Salgen Scheduler RPM
    [Documentation]    Generate the SAL library RPM for ${subSystem}
    [Tags]    rpm
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    rpm    version\=${SALVersion}${Build_Number}    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    @{files}=    List Directory    /tmp/
    File Should Exist    /tmp/makerpm.log
    File Should Exist    /tmp/makerpm_${subSystem}.log
    File Should Exist    /tmp/makerpm_${subSystem}_test.log
    Log File    /tmp/makerpm.log
    Log File    /tmp/makerpm_${subSystem}.log
    Log File    /tmp/makerpm_${subSystem}_test.log
    Should Not Contain    ${output.stdout}    ERROR : Asset required for rpm
    Should Contain    ${output.stdout}    SAL generator - ${SALVersion}${Build_Number}
    Should Contain    ${output.stdout}    Building runtime RPM for ${subSystem} subsystem
    Directory Should Exist    ${SALWorkDir}/rpmbuild
    Directory Should Exist    ${SALWorkDir}/rpmbuild/BUILD
    Directory Should Exist    ${SALWorkDir}/rpmbuild/BUILDROOT
    Directory Should Exist    ${SALWorkDir}/rpmbuild/RPMS
    Directory Should Exist    ${SALWorkDir}/rpmbuild/SOURCES
    Directory Should Exist    ${SALWorkDir}/rpmbuild/SPECS
    Directory Should Exist    ${SALWorkDir}/rpmbuild/SRPMS
    Directory Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/
    @{files}=    List Directory    ${SALWorkDir}/rpmbuild/RPMS/x86_64/
    Log Many    @{files}
    File Should Exist    ${SALWorkDir}/rpmbuild/SPECS/ts_sal_${subSystem}.spec
    File Should Exist    ${SALWorkDir}/rpmbuild/SOURCES/${subSystem}-${SALVersion}${Build_Number}.tgz
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/ts_sal_utils-${SALVersion}${Build_Number}-1.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/${subSystem}-${SALVersion}${Build_Number}-${XMLVersion}${DIST}.x86_64.rpm
    File Should Exist    ${SALWorkDir}/rpmbuild/RPMS/x86_64/${subSystem}_test-${SALVersion}${Build_Number}-${XMLVersion}${DIST}.x86_64.rpm

Salgen Scheduler Maven
    [Documentation]    Generate the Maven repository.
    [Tags]    java
    ${maven}=    Set Variable    ${SAL_Version}_${XML_Version}${MavenVersion}
    ${output}=    Run Process    ${SALHome}/scripts/salgenerator    ${subSystem}    maven    version\=${maven}    shell=True    cwd=${SALWorkDir}    stdout=${EXECDIR}${/}${subSystem}_stdout.txt    stderr=${EXECDIR}${/}${subSystem}_stderr.txt
    Log Many    ${output.stdout}    ${output.stderr}
    Should Contain    ${output.stdout}    SAL generator - ${maven}
    Should Contain    ${output.stdout}    Running maven install
    Should Contain    ${output.stdout}    [INFO] Building sal_${subSystem} ${SALVersion}
    Should Contain X Times    ${output.stdout}    [INFO] BUILD SUCCESS    1
    Should Contain X Times    ${output.stdout}    [INFO] Finished at:    1
    @{files}=    List Directory    ${SALWorkDir}/maven
    File Should Exist    ${SALWorkDir}/maven/${subSystem}_${maven}/pom.xml

Cleanup stdout and stderr Files
    [Tags]
    Remove Files    ${EXECDIR}${/}${subSystem}_stdout.txt    ${EXECDIR}${/}${subSystem}_stderr.txt

