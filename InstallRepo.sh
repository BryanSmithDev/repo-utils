#!/bin/bash
eval BINDIR="~/bin"
eval REPODIR="~/bin/repo-utils"
eval BASHRC="~/.bashrc"

echo "===================================================="
echo "              Installing/Updating Repo           "
echo "===================================================="


echo "- Checking if ~/bin directory exists..."
if [ ! -d "$BINDIR" ]; then
    echo "- The $BINDIR directory did not exist. Creating.."
    mkdir "$BINDIR"
else
    echo "- The $BINDIR directory exists, no need to create it."
fi

PATH=$BINDIR:$PATH

if ! grep -q "PATH=$(echo $BINDIR)"':$PATH' ~/.bashrc ; then
    echo "- Adding $BINDIR to PATH."
    echo -e "\nPATH=$(echo $BINDIR)"':$PATH' >> ~/.bashrc
else
    echo "- $BINDIR was already in PATH. No need to add it again."
fi

cd "$BINDIR"

echo "- Checking if $REPODIR directory exists..."
if [ ! -d "$REPODIR" ]; then
    echo "- The $REPODIR directory did not exist. Creating.."
    git clone  https://github.com/BryanSmithDev/repo-utils.git
    cd "$REPODIR"
else
    cd "$REPODIR"
    git pull origin/master
fi

PATH=$REPODIR:$PATH

if ! grep -q "PATH=$(echo $REPODIR)"':$PATH' ~/.bashrc ; then
    echo "- Adding $REPODIR to PATH."
    echo -e "\nPATH=$(echo $REPODIR)"':$PATH' >> ~/.bashrc
else
    echo "- $REPODIR was already in PATH. No need to add it again."
fi

curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo-utils/repo
chmod -R a+x "$BINDIR"
chmod -R a+x "$REPODIR"
source "$BASHRC"
echo "===================================================="
echo "Done"
