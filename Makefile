# 2022/01
#
TARGET = mandelbrot_nim
# OpenGL
# for static link
#OPT += -d:glfwStaticLib

#TC = clang
TC = gcc
#TC = vcc
#TC = tcc

#DEBUG = true
FLTO = true

ifeq ($(OS),Windows_NT)
    EXE = .exe
endif


OPT += --cc:$(TC)

ifeq ($(DEBUG),true)
    OPT += -d:debug
else
    OPT += -d:danger
    #OPT += --opt:size
endif

OPT += -d:strip
#OPT += --app:gui


# for TCC
ifneq ($(TC),tcc)
    ifneq ($(TC),vcc)
        OPT +=--passC:-ffunction-sections --passC:-fdata-sections
        OPT +=--passL:-Wl,--gc-sections
        ifneq ($(TC),clang)
            ifeq ($(FLTO),true)
                OPT += --passC:-flto --passL:-flto
            endif
        endif
    endif
endif


all:$(TARGET)$(EXE)
	@./$(<)

NIMCACHE=.nimcache_$(TC)

$(TARGET)$(EXE): src/$(TARGET).nim Makefile
	nim c $(OPT) -o:$@ --nimcache:$(NIMCACHE) $(<)
	@size $(@)

run: all
	$(TARGET)$(EXE)

clean:
	-@rm $(TARGET)$(EXE)
	-@rm -fr .nimcache_*
	-@rm -fr .nimcache

