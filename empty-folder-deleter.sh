#!/bin/bash

# A function that checks if a given directory is empty or not
function checkEmptines() {
    if [[ "$(ls -a $1 | wc -c)" -le 5 ]];
    then
        if [ $verbose -eq 1 ]; then echo "This directory is empty and will be deleted [$(pwd)/$1]"; fi
        if [ $ask -eq 1 ]
        then
            read -p "Do you want to remove $(pwd)/$1? (It's an empty folder) [Y/n]" answere
            if [[ $answere == "Y"* ]] || [[ $answere == "y"* ]]; then rmdir $(pwd)/$1; fi
        else
            rmdir $(pwd)/$1
        fi

        isEmpty=1
    else
        isEmpty=0
    fi
}

# A recursive function to go through files in dir
function throughDir(){
    cd $1
    for f in $(ls -a);
    do
        if [ $f != "." ] && [ $f != ".." ]
        then
            if [ -d $f ];
            then
                checkEmptines $f
                if [ $isEmpty -eq 0 ]
                then
                    throughDir $f
                fi
            fi
        fi
    done
    cd ..
}

# Check if user has entered a directory as a parameter
if [ -z "$1"  ] || [ ! -z "$3" ];
then
    echo "Use: ./empty-folder-deleter.sh path/to/directory [-va]"
    exit 1
else
    BASE_DIR=$1
fi

# Check if user wants verbose mode
if [[ "$2" == *"v"* ]]
then
    verbose=1
else
    verbose=0
fi

# Check if user wants to be asked before deletion
if [[ "$2" == *"a"* ]]
then
    ask=1
else
    ask=0
fi

# Check if the provided directory exists and is a folder
if [ ! -d $BASE_DIR ];
then
    echo "The provided string is not a folder or the provided path is not correct."
    exit 1
fi

# If the provided directory is empty, we can delete it
if [[ "$(ls -a $BASE_DIR | wc -c)" -le 5 ]];
then
    if [ $verbose -eq 1 ]; then echo "This directory is empty and will be deleted [$BASE_DIR]"; fi
    if [ $ask -eq 1 ]
    then
        read -p "Do you want to remove $BASE_DIR? (It's an empty folder) [Y/n]" answere
        if [[ $answere == "Y"* ]] || [[ $answere == "y"* ]]; then cd .. && rmdir $BASE_DIR; fi
    else
        cd .. && rmdir $BASE_DIR
    fi
    exit 0
fi

# Loop over the directories inside the base directory
isEmpty=0
throughDir $BASE_DIR
