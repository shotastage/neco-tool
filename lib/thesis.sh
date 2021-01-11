#!/usr/bin/env bash

push_to_own_git()
{
    if [ -e .git/ ]; then
        git add .
        git commit -m "Auto commited by NECO Review Tool."
    else
        echo "This project is not applied git."
        exit 1
    fi

    git push -u origin master
}


create_new_thesis_proj()
{
    echo "Please enter project name. (Any spaces and special characters not allowd)"
    echo -n Project name:
    read pjname 
    echo $pjname
    git clone https://github.com/chike0905/RG-Thesis-Template.git $pjname >> /dev/null
    echo
    echo "Successfully created a new thesis project."
    echo "Thanks to chike0905"
    echo "https://github.com/chike0905/RG-Thesis-Template"
    echo
}
