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
		if [ ! -e "$1"  ]; then
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



welcome
case "${1}" in 
	"help")
		cat file-janitor-help.txt
		;;

	"list")
		lister "${2}"
		;;
	*)
		echo "Type file-janitor.sh help to see available options"
		;;
esac


