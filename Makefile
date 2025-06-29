# 2023/07
# 2022/01
# by audin

TARGET = mandelbrot_nim

# OpenGL
# for static link
OPT += -d:glfwStaticLib

#OPT += --opt:size
OPT += -d:release

ifeq ($(OS),Windows_NT)
    EXE = .exe
		NULL = nul
else
		NULL = /dev/null
endif

.PHYONY: build run clean

all: build

build:
	nimble $(OPT) build --verbose

run: all
	nimble run


clean:
	-@rm $(TARGET)$(EXE)
	-@rm -fr .nimcache
