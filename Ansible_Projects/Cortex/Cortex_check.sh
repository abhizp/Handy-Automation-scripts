#!/bin/bash 
#ansible server: clheanspr001
#ssh key location : /c/Users/2374906/.ssh/id_rs

#checks whether the cortex is installed or not on the server if installed fetches the agent version:

file_check="/opt/traps/version.txt"
if [[ -f $file_check ]]
then
    echo " agent is present "
    echo "$(head -n 1 $file_check) is the cortex version"
    ps -ef | grep /opt/traps/bin/pmd
    if [[ echo $? ]]
    then 
        echo "agent is running"
    else
        echo "agent is not running"
else
    echo "agent not present"


