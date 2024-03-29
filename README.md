<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [nim-opengl-test](#nim-opengl-test)
  - [Draw Mandelbrot](#draw-mandelbrot)
  - [Build and run](#build-and-run)
  - [Nim Verson and make](#nim-verson-and-make)
  - [Winodws10 64bit dll](#winodws10-64bit-dll)
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

Note: I only confirmed on Windows10 32bit enviromnet at this moment. 


#### Build and run

---

```sh
git clone http://github.com/dinau/nim-opengl-test.git
cd nim-opengl-test
nimble run
```

#### Nim Verson and make

---

If you'd like to use `nimble build/run` or etc,  
Nim version must be `nim-1.6.0` or later.  
Because GFLW-3.3 warpper depends on nim-1.6.0 or later.

However if you'd like to use `nim-1.0.0` or later,  
use to build,

   ```sh
   make
   ```
#### Winodws10 64bit dll

---

If you are on Windows10 64bit OS,  
replace `glfw3.dll` with `glfw3.dll-64bit/glfw3.dll`.

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

* Pause drawing: Press `S` key : toggled
* Quit program: Press `Q` key or `Esc` key
* Reset windows size: Press `R` key

    
