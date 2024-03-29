# for statick link, if you would like to dynamic link,
# comemt out below.
#switch "define","glfwStaticLib"

# Eliminate back end console
switch "app","gui"

var TC = "gcc"
#var TC = "clang"
#var TC = "vcc"
#var TC = "tcc"

if "" == findExe(TC): # GCC is default compiler if TC dosn't exist on the PATH
    TC = "gcc"

const LTO = true
#const LTO = false

#switch "opt", "size"

switch "verbosity","0"

proc commonOpt() =
    switch "passL", "-s"
    switch "passC", "-ffunction-sections"
    switch "passC", "-fdata-sections"
    switch "passC", "-Wl,--gc-sections"
    switch "passL", "-Wl,--gc-sections"

#switch "nimcache", ".nimcache_" & TC
switch "nimcache", ".nimcache"

case TC
    of "gcc":
        commonOpt()
        when LTO: # These options let linking time slow instead of reducing code size.
            switch "passC", "-flto"
            switch "passL", "-flto"
    of "clang":
        commonOpt()
        #switch "passC","-flto=auto"
        #switch "passL","-flto"

switch "cc", TC

echo ""
echo "#### Compiler: [ ",TC," ] ####"
echo ""

