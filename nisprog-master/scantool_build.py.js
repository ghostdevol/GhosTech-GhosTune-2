#!/usr/bin/env python3
"""
Python build script for freediag/scantool
- Compiles all .c files in scantool/
- Links pthreads if required
"""

import os
import subprocess
from pathlib import Path
import glob

# ---------------- CONFIG ----------------
SRC_DIR = Path.cwd()
BUILD_DIR = SRC_DIR / "build"
BUILD_DIR.mkdir(exist_ok=True)

SCANTOOL_DIR = SRC_DIR / "scantool"
OUTPUT_EXE = "scantool"

CC = os.environ.get("CC", "gcc")

CFLAGS = [
    "-Wall",
    "-Wno-strict-prototypes",
    "-std=c11",
]

INCLUDE_DIRS = [SCANTOOL_DIR]

SCANTOOL_SOURCES = glob.glob(str(SCANTOOL_DIR / "*.c"))

THREAD_LIB = "-lpthread" if os.name != "nt" else ""  # Use MSVC defaults on Windows

# ---------------- HELPER ----------------
def compile_sources(sources, output_exe):
    obj_files = []
    for src in sources:
        src_path = Path(src)
        obj_file = BUILD_DIR / (src_path.stem + ".o")
        cmd = [CC, "-c", str(src_path), "-o", str(obj_file)] + CFLAGS
        for inc in INCLUDE_DIRS:
            cmd.extend(["-I", str(inc)])
        print("Compiling:", " ".join(cmd))
        subprocess.check_call(cmd)
        obj_files.append(obj_file)

    # Link
    link_cmd = [CC, "-o", str(BUILD_DIR / output_exe)] + [str(o) for o in obj_files]
    if THREAD_LIB:
        link_cmd.append(THREAD_LIB)
    print("Linking:", " ".join(link_cmd))
    subprocess.check_call(link_cmd)

# ---------------- MAIN ----------------
if __name__ == "__main__":
    compile_sources(SCANTOOL_SOURCES, OUTPUT_EXE)
    print(f"Build finished: {BUILD_DIR / OUTPUT_EXE}")

