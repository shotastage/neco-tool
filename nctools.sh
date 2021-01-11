#!/usr/bin/env bash

WORKING_DIRECTORY=~/.nctools


splash() {
    echo
}

. $WORKING_DIRECTORY/lib/thesis.sh


splash


for OPT in "$@"
do
    case $OPT in
        s | save )
            push_to_own_git
            exit 0
            ;;
        new )
            create_new_thesis_proj
            exit 0
            ;;
        h | help )
            setuptools-help
            exit 0
            ;;
        v | version )
            echo
            echo "NECO Tools 1.1.0"
            echo "Copyright (C) 2021 Shota Shimazu, All rights reserved."
            echo 
            exit 0
            ;;
    esac
done
