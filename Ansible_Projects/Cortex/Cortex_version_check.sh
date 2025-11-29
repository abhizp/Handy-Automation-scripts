#!/bin/bash

SERVER_NAME=$(hostname)
file_check="/opt/traps/version.txt"


if [[ -e $file_check ]]
then
    AGENT_PRESENT="YES" 
    AGENT_VERSION=$(head -n 1 $file_check)
    #ps -ef | grep /opt/traps/bin/pmd
    if ps -ef | grep /opt/traps/bin/pmd &> /dev/null
    then 
        AGENT_ACTIVE="YES"
    else
        AGENT_ACTIVE="NO"
    fi
else
    AGENT_PRESENT="NO"
fi

echo "$SERVER_NAME,$AGENT_PRESENT,$AGENT_VERSION,$AGENT_ACTIVE"



