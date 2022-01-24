### nim-opengl-test
OpenGL test program with Nim language

This program is referred from this page,  
  * https://github.com/rylmovuk/zig-opengl-test  
    Thank you nice demo.

and converted to Nim language.

<img src="https://github.com/dinau/nim-opengl-test/blob/main/res/movie.gif?raw=true">

Note: I only confirmed on Windows10 enviromnet at this moment. 

#### Build and run

```
nimble run
```


#### Speed optimization

```
nimble speed
```
* Execute

  ```
  > nim_opengl_test.exe
  ```

#### Code size optimization

```
nimble size
```
* Execute

  ```
  > nim_opengl_test.exe
  ```

#### Winodws10 64bit dll

If you are on Windows10 64bit OS,
use `glfw3.dll-64bit/glfw3.dll` instead of default one.

#### Operation

* Pause drawing  
    Press `S` key : toggled
* Quit program  
    Press `Q` key or `Esc` key
* Reset windows size  
    Press `R` key

    
