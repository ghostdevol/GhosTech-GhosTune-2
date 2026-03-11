#!/bin/bash
# build_ghostune.sh - fixed version for Termux

set -e

echo "=== Starting GhosTune build ==="

# Update Termux packages
echo "=== Updating Termux packages ==="
pkg update -y
pkg upgrade -y

# Install dependencies
echo "=== Installing dependencies ==="
pkg install -y clang make cmake git python libusb nano

# Paths
WORKDIR="$HOME/GhosTech-GhosTune-2"
FREEDIAG="$WORKDIR/freediag-master"

# Create working directory
mkdir -p "$WORKDIR"
cd "$WORKDIR"

# Clone freediag if missing
if [ ! -d "$FREEDIAG" ]; then
    echo "=== Cloning freediag repository ==="
    git clone https://github.com/jms10wsl/freediag.git freediag-master
else
    echo "=== freediag folder exists, pulling latest changes ==="
    cd "$FREEDIAG"
    git pull
    cd "$WORKDIR"
fi

# Fix CMakeLists.txt for Termux (CURFILE + strict prototypes)
echo "=== Writing fixed CMakeLists.txt ==="
cat > "$FREEDIAG/CMakeLists.txt" << 'EOF'
cmake_minimum_required(VERSION 3.10)
project(freediag C CXX)

set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -Wno-strict-prototypes -DCURFILE=\"unknown\"")
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Include directories
include_directories(
    ${PROJECT_SOURCE_DIR}/scantool
)

# Source files
file(GLOB SCANTOOL_SRC
    "scantool/*.c"
)

# Create executable
add_executable(scantool ${SCANTOOL_SRC})

# Link libraries
find_package(Threads REQUIRED)
target_link_libraries(scantool ${CMAKE_THREAD_LIBS_INIT} usb-1.0)
EOF

# Build freediag
echo "=== Building freediag ==="
cd "$FREEDIAG"
rm -rf build
mkdir build
cd build
cmake ..
make -j4

echo "=== Build complete! ==="
echo "Executable located at: $FREEDIAG/build/scantool"
