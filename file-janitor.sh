#! /bin/bash


welcome() {
	echo "File Janitor, 2024"
	echo "Powered by Bash"
}



case "${1}" in 
	"help")
		welcome
		echo ""
		cat file-janitor-help.txt
		;;
	*)
		welcome
		;;
esac


