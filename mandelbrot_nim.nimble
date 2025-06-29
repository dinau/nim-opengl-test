# Package

version       = "0.1.2"
author        = "dinau"
description   = "Nim openGL teset program with Mandelbrot"
license       = "MIT"
srcDir        = "src"
bin           = @["mandelbrot_nim"]

# Dependencies
requires "nim >= 1.6"
requires "glfw >= 3.3"

const target = "mandelbrot_nim"


task clean,"clean":
    rmFile target.toEXE()
    rmDir ".nimcache"
