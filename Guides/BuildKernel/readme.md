# rules binary subprocess returned exit status 2

https://gitlab.com/CalcProgrammer1/OpenRGB/-/issues/950

In the kernel folder open .config and set:

'''CONFIG_SYSTEM_REVOCATION_KEYS=""'''
'''SYSTEM_BLACKLIST_KEYRING=N'''
'''CONFIG_SYSTEM_TRUSTED_KEYS = ""'''
