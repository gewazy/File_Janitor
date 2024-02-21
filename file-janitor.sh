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

	count_tmp=$(find $path -maxdepth 1 -type f -name "*.tmp" | wc -l)
	size_tmp=$(( $(find $path -maxdepth 1 -type f -name "*.tmp" -exec du -cb {} \+ | tail -1 | cut -f 1) + 0 ))
	count_log=$(find $path -maxdepth 1 -type f -name "*.log" | wc -l)
	size_log=$(( $(find $path -maxdepth 1 -type f -name "*.log" -exec du -cb {} \+ | tail -1 | cut -f 1) + 0 ))
	count_py=$(find $path -maxdepth 1 -type f -name "*.py" | wc -l)
	size_py=$(( $(find $path -maxdepth 1 -type f -name "*.py" -exec du -cb {} \+ | tail -1 | cut -f 1) + 0 ))

	echo "$count_tmp tmp file(s), with total size of $size_tmp bytes"
	echo "$count_log log flie(s), with total size of $size_log bytes"
	echo "$count_py py file(s), with total size of $size_py bytes"
	
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
	*)
		echo "Type file-janitor.sh help to see available options"
		;;
esac


