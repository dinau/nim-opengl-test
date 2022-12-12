# Package

version       = "0.1.0"
author        = "dinau"
description   = "Nim openGL teset program with Mandelbrot"
license       = "MIT"
srcDir        = "src"
bin           = @["mandelbrot_nim"]

# Dependencies
requires "nim >= 1.0"
requires "glfw >= 3.3"

import std/[strutils,os]

const target = "mandelbrot_nim"
const src = joinPath(["src" ,target])

var opt:seq[string]
opt.add "-d:danger"
opt.add "-d:strip "
opt.add("-o:$#" % target.toExe())
opt.add "--app:gui"

task size, "Compiles with size option":
    opt.add "--opt:size"
    let cmd = "nim c $# $#" % [opt.join(" "),src]
    echo cmd
    echo "--- SIZE ----"
    exec cmd

#task staticlink, "Compiles with static link option":
#    opt.add "-d:glfwStaticLib "
#    let cmd = "nim c $# $#" % [opt.join(" "),src]
#    echo cmd
#    echo "--- STATICK LINK ----"
#    exec cmd
#    exec cmd

task clean,"clean":
    rmFile target.toEXE()
    rmDir ".nimcache"
