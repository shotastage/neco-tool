
#!/usr/bin/env bash
set -e


##### Functions ##################################################################

function shell_configure {

    if [ $SHELL == '/bin/zsh' ]; then
        echo "🖊  Adding Zsh path..."
        echo "############### nctools ###############" >> $HOME/.zshenv
        echo "export PATH=\$PATH:~/.nctools/bin/" >> $HOME/.zshenv
        echo "export SETUPTOOLS_BASH_INSTALLATION=OK" >> $HOME/.zshenv
    fi

    if [ $SHELL == '/bin/bash' ]; then
        if [ -e $HOME/.bash_profile ]; then
            echo "🖊  Adding Bash path..."
            echo "############### NECO Tools ###############" >> $HOME/.bash_profile
            echo "export PATH=\$PATH:~/.nctools/bin/" >> $HOME/.bash_profile
            echo "export SETUPTOOLS_BASH_INSTALLATION=OK" >> $HOME/.bash_profile
        else
            echo "🖊  Adding Bash path..."
            echo "############### nctools ###############" >> $HOME/.bashrc
            echo "export PATH=\$PATH:~/.nctools/bin/" >> $HOME/.bashrc
            echo "export SETUPTOOLS_BASH_INSTALLATION=OK" >> $HOME/.bashrc
        fi
    fi

    if [ -e $HOME/.config/fish ]; then
        curl -O https://raw.githubusercontent.com/shotastage/neco-tool/master/tools/fish_utils.fish
        chmod +x fish_utils.fish
        fish fish_utils.fish
    fi
}

function operating_system {
    if [ "$(uname)" == 'Darwin' ]; then
        OS="macOS"
    elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
        OS="Linux"
    else
        OS="Other"
    fi

    echo $OS
}

function before_preparation {
    if [ ${1} = "Linux" ]; then
        if type git > /dev/null 2>&1; then
            :
        else
            sudo apt-get update -y
            sudo apt-get install git -y
        fi
    fi
}


##### Check ######################################################################
if [ -e $HOME/.nctools/bin/ ]; then
    echo "👻 NECO Tools already installed!"
    exit 1
fi


if [ -e $HOME/.nctools_installation ]; then
    echo "👻  Installation directory already exists!"
    echo "👻  Clean existing directory before starting installation."
    rm -rf $HOME/.nctools_installation/
fi




##### Main #######################################################################
cd $HOME

# Prepatation
before_preparation $(operating_system)

# Workspace preparation
mkdir .nctools_installation
cd .nctools_installation
git clone https://github.com/shotastage/neco-tool.git


# Main Install Process
cd neco-tool
mkdir -p $HOME/.nctools/bin/
mkdir -p $HOME/.nctools/lib/
mkdir -p $HOME/.nctools/config/
mv ./lib/ $HOME/.nctools/
cp -f neco.sh $HOME/.nctools/bin/neco
mv neco-update.sh $HOME/.nctools/bin/neco-update

# Shell Configuration
shell_configure


# Cleaning
echo "🧹  Cleaning..."
cd
rm -rf .nctools_installation/

# Completed!
echo "🆗  Installation is completed!"
