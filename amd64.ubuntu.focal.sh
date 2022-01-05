#!/bin/sh
set -e

mkdir -p build
mkdir -p images

NAME=amd64.ubuntu.focal

# create

echo "[$NAME] Creating ..."

mkdir images/$NAME
debootstrap focal images/$NAME http://archive.ubuntu.com/ubuntu/

# test

echo "[$NAME] Testing ..."

[ "$(chroot images/$NAME uname)" = "Linux" ] || echo "🔴 Something went wrong in $NAME!"

# package

echo "[$NAME] Packaging ..."

cd images/$NAME

tar cf ../../build/$NAME.tar .
cd ../..

xz -9 build/$NAME.tar
mv build/$NAME.tar.xz build/$NAME.txz