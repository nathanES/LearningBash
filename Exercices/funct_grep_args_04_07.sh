#!/bin/bash
# List file based on the month and the year (if the file is older than 6 month)
function lsd
{
	date=$1
	echo "Filtering by date: $date"
        ls -l | grep "$date" | awk '{for (i=9; i<=NF; i++) printf $i " "; print ""}'
}

"$@" # allow to run directly the function
