#!/usr/bin/env bash

if [ -e .git/ ]; then
    git add .
    git commit -m "Auto commited by NECO Review Tool."
else
    echo "This project is not applied git."
    exit 1
fi

git push -u origin master
