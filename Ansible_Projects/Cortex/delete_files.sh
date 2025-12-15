#!/bin/bash

for file in $(cat files_to_be_deleted.txt); do
    rm -f "$file"
done