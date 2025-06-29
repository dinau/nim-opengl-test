<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [nim-opengl-test](#nim-opengl-test)
  - [Draw Mandelbrot](#draw-mandelbrot)
  - [Build and run](#build-and-run)
  - [Static link](#static-link)
  - [Operation](#operation)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

### nim-opengl-test

---

OpenGL test program with Nim language

This program is referred from this page,  
  * https://github.com/rylmovuk/zig-opengl-test  
    Thank you nice demo.

and converted to Nim language.

#### Draw Mandelbrot

---

<img src="https://github.com/dinau/nim-opengl-test/blob/main/res/movie.gif?raw=true">

#### Build and run

---

```sh
git clone http://github.com/dinau/nim-opengl-test.git
cd nim-opengl-test
nimble run

or 

make run
```

#### Static link

---

If you'd like to statically link glfw3 library,  
enable below line, 

```
switch "define","glfwStaticLib"`
```

in `config.nims`

#### Operation

---

* Pause drawing: Press `S` or `Space` key : toggled
* Reset windows size: Press `R` key
* Quit program: Press `Q` key or `Esc` key
