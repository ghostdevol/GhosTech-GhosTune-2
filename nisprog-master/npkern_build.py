  GNU nano 8.7.1     npkern_build.py.js     Modified
    }

    # Subaru targets
    SUBARU_TARGETS = {
        "ssmk_SH7058": COMMON_SRCS + ["mfg_ssm.c", "s>
        "ssmk_SH7055_18": COMMON_SRCS + ["mfg_ssm.c",>
    }

    LINKERSCRIPTS = {
        "npk_SH7051": "ldscripts/lkr_7051.ld",
        "npk_SH7055_35": "ldscripts/lkr_7055_7058.ld",
        "npk_SH7055_18": "ldscripts/lkr_7055_7058.ld",
        "npk_SH7058": "ldscripts/lkr_7055_7058.ld",
        "ssmk_SH7058": "ldscripts/lkr_subaru_7058.ld",
        "ssmk_SH7055_18": "ldscripts/lkr_subaru_7055_>
    }

    for target, sources in {**NISSAN_TARGETS, **SUBAR>
        compile_target(sources, target, LINKERSCRIPTS>
        print(f"Built {target}")
