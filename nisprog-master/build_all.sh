#!/data/data/com.termux/files/usr/bin/bash

echo "=================================="
echo " GhosTune Nissan Build Script"
echo "=================================="

echo ""
echo "[1] Enabling Termux storage..."
termux-setup-storage

sleep 2

echo ""
echo "[2] Copying project folder..."

SRC=~/storage/downloads/nisprog.ghosTune
DEST=~/nisprog.ghosTune

if [ -d "$DEST" ]; then
    echo "Project already exists in Termux."
else
    cp -r $SRC ~/
fi

echo ""
echo "[3] Entering project directory..."
cd ~/nisprog.ghosTune || exit

echo ""
echo "[4] Installing required packages..."
pkg update -y
pkg install -y git cmake clang make python

echo ""
echo "[5] Building project..."
mkdir -p build
cd build

cmake ..
make -j$(nproc)

echo ""
echo "=================================="
echo " BUILD COMPLETE"
echo "=================================="

echo ""
echo "Binaries should now exist in:"
echo "~/nisprog.ghosTune/build"

ls
