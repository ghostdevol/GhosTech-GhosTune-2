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
