#---
# Modified below program by audin 2022/01
# Original author:  [ zig-opengl-test ]
#   https://github.com/rylmovuk/zig-opengl-test
#---
# OpenGL:
#   https://www.khronos.org/registry/OpenGL/index_gl.php
# OpenGL 3.3:
#   (API Core Profile):
#       https://www.khronos.org/registry/OpenGL/specs/gl/glspec33.core.pdf
#   (API Comaptibility Profile)
#       https://www.khronos.org/registry/OpenGL/specs/gl/glspec33.compatibility.pdf
#   (OpenGL Shading Language 3.30 Specification)
#       https://www.khronos.org/registry/OpenGL/specs/gl/GLSLangSpec.3.30.pdf
#---
# nim-1.6.2 32bit
# gcc-11.2 MinGW 32bit
# glfw3.dll = glfw-3.3.6.bin.WIN32 / gnu  32bit
#   https://www.glfw.org/download.html
#---
# $ nimlbe run
# or
# $ nimlbe speed
# or
# $ nimlbe size

#import glm
import glad/gl
import glfw
import buildShaders
import strformat,os,strutils

const GLSL_VERTEX_SHADER_PROG_PATH = "src/shaders/vertex.glsl"
const GLSL_FRAGMENT_SHADER_PROG_PATH = "src/shaders/fragment.glsl"

# settings
var SCR_WIDTH = 800
var SCR_HEIGHT = 640

var
    gRatio = 1.0
    win: Window
    enableUpdate:bool = true

################
# keyCB() callback
################
proc keyCb(win: Window, key: Key, scanCode: int32, action: KeyAction,
        modKeys: set[ModifierKey]) =
    case action:
        of kaDown:
            case key:
                of keyEscape, keyQ:
                    win.shouldClose = true
                of keyR:
                    win.size = (w: SCR_WIDTH, h: SCR_HEIGHT)
                of keyS, keySpace:
                    enableUpdate = not enableUpdate
                else: discard
        else: discard

################
# resize() callback
################
proc resize(win: Window, size: tuple[w, h: int32]) =
    gRatio = size.w / size.h
    var width, height: int
    (width, height) = glfw.framebufferSize(win)
    glViewport(0, 0, GLsizei(width), GLsizei(height))

################
# Helper procs
################
proc vertexArrayGen(): GLuint = glGenVertexArrays(1, addr result)
proc bufferGen(): GLuint = glGenBuffers(1, addr result)
proc bindArray(arg: GLuint) = glBindVertexArray(arg)
proc bindBuffer(arg: GLuint, kind: GLenum) = glBindBuffer(kind, arg)

################
# cmd params
################
proc cmdParams(width,hight:var int):tuple[w,h:int] =
    case os.paramCount():
        of 1:
            width = parseInt( os.commandLineParams()[0])
            hight = (width * 3 / 4).int
        of 2:
            width = parseInt os.commandLineParams()[0]
            hight = parseInt os.commandLineParams()[1]
        else: discard

    result = (width,hight)

################
# main()
################
proc main() =
    glfw.initialize()
    defer: glfw.terminate()

    var cfg = DefaultOpenglWindowConfig
    cfg.size = cmdParams(SCR_WIDTH, SCR_HEIGHT)
    cfg.title = "By Nim lang"

    win = newWindow(cfg)
    defer: win.destroy()

    win.keyCb = keyCb
    win.windowSizeCb = resize

    if not gladLoadGL(getProcAddress):
        quit "Error initialising OpenGL"

    # Build shader program
    let ghProgram = buildShaders(GLSL_VERTEX_SHADER_PROG_PATH,
                             GLSL_FRAGMENT_SHADER_PROG_PATH)

    var vertices: array[8, GLfloat] = [
        -1.0f, -1.0f,
         1.0f, -1.0f,
         1.0f, 1.0f,
        -1.0f, 1.0f,
    ]

    let vao = vertexArrayGen()
    let vbo = bufferGen()
    vao.bindArray()

    vbo.bindBuffer(GL_ARRAY_BUFFER)
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices).GLsizeiptr, addr vertices, GL_STATIC_DRAW)

    glEnableVertexAttribArray(0)
    glVertexAttribPointer(0.GLuint, 2.GLint, cGL_FLOAT, GL_FALSE.GLboolean, (2 *
            sizeof(GLfloat)).GLsizei, cast[pointer](0))

    let uni_centerOffset = cast[GLint](glGetUniformLocation(ghProgram, "centerOffset"))
    let uni_scaleFactor = cast[GLint](glGetUniformLocation(ghProgram, "scaleFactor"))
    let uni_iters = cast[GLint](glGetUniformLocation(ghProgram, "iters"))

    glBindVertexArray(0)
    glBindBuffer(GL_ARRAY_BUFFER, 0)

    glUseProgram(ghProgram)

    gluniform2f(uni_centerOffset, 0.5.GLfloat, 0.0.GLfloat)
    gluniform2f(uni_scaleFactor, 1.25.GLfloat, 1.GLfloat)
    gluniform1ui(uni_iters, 220.GLuint)

    vao.bindArray()
    var time: GLuint = 0
    var frame:int = 0
    var lastTime = glfw.getTime()

    resize(win, glfw.framebufferSize(win))

    glfw.swapInterval(1)
    var zoom:float
    while not win.shouldClose:
        var curTime = glfw.getTime()

        glClear(GL_COLOR_BUFFER_BIT)

        if enableUpdate:
            zoom = 1 + time.GLfloat / 200
            inc time
        gluniform2f(uni_scaleFactor, gRatio / zoom, 1.0 / zoom)
        gluniform2f(uni_centerOffset, 0.5 * 1.1 * zoom, -0.25 * zoom)
        gldrawArrays(GL_TRIANGLE_FAN, 0.GLint, sizeof(vertices).GLsizei)

        if curTime - lastTime >= 1.0:
            win.title = fmt"FPS={frame:2d}   Fractal Test"
            lastTime = curTime
            frame = 0
        inc frame

        glfw.swapBuffers(win)
        glfw.pollEvents()
main()
