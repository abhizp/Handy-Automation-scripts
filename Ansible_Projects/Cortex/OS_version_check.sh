#!/bin/bash

#script finds the operating system type and version.
#It also finds if Python is installed or not.
#This Script can be used for multiple machines at the same time.

SERVER_LIST=list.txt
OUTPUT_FILE=output.txt

# Check if the server list file exists
if [ ! -f $SERVER_LIST ]
then
    echo " Server list file $SERVER_LIST does not exist in the current directory."
    exit 1
fi

# clear the output file if it exists
if [ -f $OUTPUT_FILE ]
then
    > $OUTPUT_FILE
else
    touch $OUTPUT_FILE
    echo "Output file $OUTPUT_FILE created."
fi

# Loop through each server in the list
while read -r SERVER
do
    echo "Processing server: $SERVER"
    # check if the server is reachable
    if ping -c 1 $SERVER &> /dev/null
    then
        echo "Server $SERVER is reachable."
        # Get the OS type and version
        OS_VERSION=$(sshpass -p 'passwd' ssh -o ConnectTimeout=5 -o StrictHostKeyChecking=no $SERVER "oslevel -s")
        if [ $? -eq 0 ]
        then
            echo "OS Version for $SERVER: $OS_VERSION" >> $OUTPUT_FILE
        else
            echo "Failed to get OS version for $SERVER." >> $OUTPUT_FILE
        fi
        echo "Checking if Python is installed on $SERVER..."
        # Check if Python is installed
        PYTHON_VERSION=$(sshpass -p 'passwd' ssh -o ConnectTimeout=5 -o StrictHostKeyChecking=no $SERVER "python --version 2>&1")
        if [ $? -eq 0 && $PYTHON_VERSION == Python* ]
        then
            echo "Python is installed on $SERVER: $PYTHON_VERSION" >> $OUTPUT_FILE
        else
            echo "Python is not installed on $SERVER." >> $OUTPUT_FILE
        fi
    else
        echo "Server $SERVER is not reachable." >> $OUTPUT_FILE
    fi
done < $SERVER_LIST
#EOF

exit 0
