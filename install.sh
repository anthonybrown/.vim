#!/bin/sh
set -e

cd ~

if [ ".vim/vimrc" != `stat -f '%Y' ~/.vimrc` ]
then
    mv .vimrc .vimrc-
    ln -sf .vim/vimrc .vimrc
fi

if [ ".vim/gvimrc" != `stat -f '%Y' ~/.gvimrc` ]
then
    mv .gvimrc .gvimrc-
    ln -sf .vim/gvimrc .gvimrc
fi

cd ~/.vim

# make sure that submodules are correctly configured
git submodule init
git submodule sync
git submodule update

# set up snippets
mkdir -p snippets/javascript
cd snippets/javascript
for snippet in ../../resources/snipmate-nodejs/snippets/javascript/*.snippet
do
    if [ ! -e `basename $snippet` ]
    then
        ln -s $snippet .
    fi
done
