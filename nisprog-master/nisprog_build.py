import os
from pathlib import Path
import subprocess

# Directories
SRC_DIR = Path(__file__).parent
BUILD_DIR = SRC_DIR / "build"

# Compiler
CC = os.environ.get("CC", "gcc")

# Compiler flags
CFLAGS = [
    "-Wall",
    "-Wextra",
    "-Wformat",
    "-std=gnu99",
    "-Wstrict-prototypes",
    "-Wsign-compare",
    "-Wredundant-decls",
]

# Include directories (add everything needed for headers)
INCLUDE_DIRS = [
    SRC_DIR / "freediag" / "scantool",
    SRC_DIR / "nissutils",
    BUILD_DIR,
    BUILD_DIR / "external",
]

# Add -I flags for GCC
for inc in INCLUDE_DIRS:
    CFLAGS.extend(["-I", str(inc)])

# You can keep the rest of the script below unchanged
