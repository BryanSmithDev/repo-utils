#!/bin/bash
eval BINDIR="~/bin"
eval REPODIR="~/bin/repo-utils"
eval BASHRC="~/.bashrc"
eval PUSHBULLETCONFIG="~/.config/pushbullet"

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
    git clone  https://github.com/BryanSmithDev/repo-utils.git >> /dev/null
    cd "$REPODIR"
else
    cd "$REPODIR"
    echo "- The $REPODIR directory exists. Updating tools if necessary.."
    git stash >> /dev/null
    git pull origin master >> /dev/null
fi

PATH=$REPODIR:$PATH

if ! grep -q "PATH=$(echo $REPODIR)"':$PATH' ~/.bashrc ; then
    echo "- Adding $REPODIR to PATH."
    echo -e "\nPATH=$(echo $REPODIR)"':$PATH' >> ~/.bashrc
else
    echo "- $REPODIR was already in PATH. No need to add it again."
fi

echo "- Downloading most recent Repo script from Google."
curl -silent https://storage.googleapis.com/git-repo-downloads/repo > $REPODIR/repo

echo "- Downloading most recent Pushbullet script."
curl -silent https://raw.githubusercontent.com/Red5d/pushbullet-bash/master/pushbullet > $REPODIR/pushbullet
if [ ! -e "$PUSHBULLETCONFIG" ]; then
    echo "- No Pushbullet API key configured. Add it to $PUSHBULLETCONFIG."
    touch "$PUSHBULLETCONFIG"
    echo "API_KEY=" > $PUSHBULLETCONFIG
else
    echo "- Pushbullet API key already configured."
fi

echo "- Setting script permissions."
chmod -R a+x "$BINDIR"
chmod -R a+x "$REPODIR"

echo "- Reloading Bash Shell"
source "$BASHRC"

echo "===================================================="
echo "Done"
