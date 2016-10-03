#!/bin/bash
# Install an app in a connected device
if [ $# -ne 1 ]
	then
	echo "USAGE: $0 <IPA absolute path>" 
else	
	IFS=$'\n'
	# Get devices UIDS
	ids=(`xcrun instruments -s devices | cut -d "[" -f2 | cut -d "]" -f1 | tail -n +2`)
	# Get devices names
	dev=(`xcrun instruments -s devices | cut -d "(" -f1 | tail -n +2`)
	correct=0
	while [ $correct -ne 1 ]; do
		for (( i = 1 ; i < ${#ids[@]}; i++)) 
		do
	        echo "Device [$i]: ${dev[$i]} ${ids[$i]}"
		done

		echo "Select device"
		read selection
		if [ $selection -gt ${#ids[@]} ] 
			then
			echo "Invalid option"
		else
			echo "Installing IPA..."
            ideviceinstaller -u ${ids[$selection]} -i $1
            echo "Done"
			correct=$((correct + 1))
		fi
	done
fi
