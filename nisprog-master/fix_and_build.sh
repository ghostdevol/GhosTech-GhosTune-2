#!/data/data/com.termux/files/usr/bin/bash
set -e

PROJECT_DIR="$HOME/GhosTech-GhosTune-2/nisprog-master"
cd "$PROJECT_DIR"

echo "[*] Fixing bad nislib.h include paths..."
for f in nis_backend.c np_backend.c ssm_backend.c; do
  if grep -q 'nissutils/cli_utils/nislib.h' "$f"; then
    sed -i 's#nissutils/cli_utils/nislib.h#nissutils/nislib.h#' "$f"
    echo "    patched $f"
  fi
done

echo "[*] Writing Makefile..."
cat > Makefile << 'EOF'
CC      := clang
CFLAGS  := -O2 -Wall -Wextra -I. -Ifreediag/scantool -Inissutils -DTERMUX_BUILD -Dnpk -DSH7058

NISSUTILS_SRCS := \
    nissutils/nislib.c \
    nissutils/nislib_shtools.c \
    nissutils/nisdec1.c \
    nissutils/nisenc1.c \
    nissutils/nisguess.c \
    nissutils/nisguess2.c \
    nissutils/nisckfix1.c \
    nissutils/nisckfix2.c \
    nissutils/nisrom.c \
    nissutils/nisrom_finders.c \
    nissutils/nisrom_keyfinders.c \
    nissutils/ecuid_list.c \
    nissutils/unpackdat.c \
    nissutils/nis_romdb.c \
    nissutils/nis_algo1.c \
    nissutils/nis_algo2.c \
    nissutils/md5.c

SRCS := \
    nisprog.c \
    nis_backend.c \
    np_backend.c \
    ssm_backend.c \
    mfg_nissan.c \
    mfg_ssm.c \
    crc.c

OBJS := $(SRCS:.c=.o) $(NISSUTILS_SRCS:.c=.o)

all: nisprog

nisprog: $(OBJS)
	$(CC) $(CFLAGS) -o $@ $(OBJS)

clean:
	rm -f $(OBJS) nisprog
EOF

echo "[*] Cleaning and building..."
make clean
make -j"$(nproc)"

echo "[*] Done. Binary: $PROJECT_DIR/nisprog"
