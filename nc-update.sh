#!/usr/bin/env bash

WORKSPACE=~/.nctools_update_tmp

preapre_tmp() {
    cd $HOME

    if [ -e $WORKSPACE ]; then
        rm -rf $WORKSPACE
    fi

    mkdir $WORKSPACE
}

download() {
    echo "⬇️  Downloading latest package..."
    git clone --quiet https://github.com/shotastage/neco-tool.git $WORKSPACE/netinst/ >> /dev/null
}

destory_old() {
    rm -rf $HOME/.nctools/lib/
    rm -rf $HOME/.nctools/bin/
}

install_new() {
    cp -rf $WORKSPACE/netinst/lib/ $HOME/.nctools/lib/
    mkdir -p $HOME/.nctools/bin/
    cp -f $WORKSPACE/netinst/nctools.sh $HOME/.nctools/bin/nctools
    cp -f $WORKSPACE/netinst/nc-update.sh $HOME/.nctools/bin/nc-update
}

# PREPARE
cd $HOME

preapre_tmp
download
echo "🔄  Updating NECO Tools..."
destory_old
install_new


cd $HOME
rm -rf .nctools_update_tmp/
echo "🆗  Update completed!"
