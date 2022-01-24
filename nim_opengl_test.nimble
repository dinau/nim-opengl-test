# Package

version       = "0.1.0"
author        = "dinau"
description   = "A new awesome nimble package"
license       = "MIT"
srcDir        = "src"
bin           = @["nim_opengl_test"]

# Dependencies
requires "nim >= 1.6"
requires "glfw >= 3.3"

import strformat
const src =  "src/nim_opengl_test"

var opt =""
var opt_com = " -d:danger -d:strip "
var opt_size = " --opt:size "
opt_size &= " --passC:-ffunction-sections "
opt_size &= " --passC:-fdata-sections "
opt_size &= " --passL:-Wl,--gc-sections "
opt_size &= " --passC:-flto "
opt_size &= " --passL:-flto "

var opt_speed = " --opt:speed "

opt_com &= "-o:./nim_opengl_test"
opt_com &= " --app:gui"

task speed, "Compiles with speed option":
    opt &= opt_com & opt_speed
    echo fmt"nim c {opt} {src}"
    exec fmt"nim c {opt} {src}"

task size, "Compiles with size option":
    opt &= opt_com & opt_size
    echo fmt"nim c {opt} {src}"
    exec fmt"nim c {opt} {src}"




