#! /bin/bash

year=$(date +%Y)

welcome() {
	echo "File Janitor, $(date +%Y)"
	echo "Powered by Bash"
	echo ""
}


lister() {
	if [[  $1 == ''  ]]; then
		echo "Listing files in the current directory"
		echo ''
		ls -A1 .
	else
		if [  ! -e "$1"  ]; then
			echo "$1 is not found"
		elif [  -d "$1"  ]; then
			echo "Listing files in $1"
			echo ''
			ls -A1 $1
		else 
			echo "$1 is not a directory"
		fi
	fi
}


report() {

	if [[  $1 == ''  ]]; then
		echo "The current directory contains:"
		path=.
	else
		if [  ! -e "$1"  ]; then
			echo "$1 is not found"
			exit
		elif [  -d "$1"  ]; then
			echo "$1 contains:"
			path=$1
		else
			echo "$1 is not a directory"
			exit
		fi
	fi	

	for i in tmp log py;
	do
		count=$(find $path -maxdepth 1 -type f -name "*.$i" | wc -l)
		size=$(( $(find $path -maxdepth 1 -type f -name "*.$i" -exec du -cb {} \+ | tail -1 | cut -f 1) + 0 ))
		echo "$count $i file(s), with total size of $size bytes"
	done
}


cleaner() {

        if [[  $1 == ''  ]]; then
                echo "Cleaning the current directory..."
                path=.
        else
                if [  ! -e "$1"  ]; then
                        echo "$1 is not found"
                        exit
                elif [  -d "$1"  ]; then
                        echo "Cleaning $1..."
                        path=$1
                else
                        echo "$1 is not a directory"
                        exit
                fi
        fi

		echo -n "Deleting old log file..."
        count=$(find $path -maxdepth 1 -type f -name "*.log" -mtime +3 | wc -l)
        find $path -maxdepth 1 -type f -name "*.log" -mtime +3 -exec rm -f {} \;
        echo " done! $count files have been deleted"

		echo -n "Deleting temporary files..."
		count=$(find $path -maxdepth 1 -type f -name "*.tmp" | wc -l)
        find $path -maxdepth 1 -type f -name "*.tmp" -exec rm -f {} \;
        echo " done! $count files have been deleted"


		echo -n "Moving python files... "
        count=$(find $path -maxdepth 1 -type f -name "*.py" | wc -l)
		if [[  $count -gt 0  ]]; then 
				if [  ! -e "$path/python_scripts"  ]; then
				fi
			echo "$path/python_scripts"
			find $path -maxdepth 1 -type f -name "*.py" -exec mv {} "$path/python_scripts/" \;
		fi
		echo "done! $count files have been moved" 
		echo ''

		if [[  "$path" == '.'  ]]; then
			echo "Clean up of the current directory is complete!"
		else
			echo "Clean up of $path is complete!"
		fi	
}		 


welcome
case "${1}" in 
	"help")
		cat file-janitor-help.txt
		;;
	"list")
		lister "${2}"
		;;
	"report")
		report "${2}" 
		;;
	"clean")
		cleaner "${2}"
		;;
	*)
		echo "Type file-janitor.sh help to see available options"
		;;
esac


