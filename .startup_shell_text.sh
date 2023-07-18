#!/bin/bash

cat ~/.font.txt

if [ $( rosnode list ) ]
then
	printf "\033[92mRoscore is working ;) \033[0m\n\r"
else
	printf "\033[91mRoscore is not working :´( \033[0m\n\r"
fi

echo ""
