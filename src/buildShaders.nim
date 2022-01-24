import glad/gl

# Read Vertex/Fragment program by GLSL and do compile/link
proc buildShaders*(shaderPathVert,shaderPathFrag:string):GLuint =
    # Vertex program: compile
    var csText = cstring(readFile shaderPathVert)
    let vertexShader = glCreateShader(GL_VERTEX_SHADER)
    var vertexShaderTextArr = [csText]
    glShaderSource(vertexShader, 1,
                   cast[cstringArray](vertexShaderTextArr.addr), nil)
    glCompileShader(vertexShader)

    var success:GLint
    var sInfoLog = newString(512)

    glGetShaderiv(vertexShader, GL_COMPILE_STATUS, addr success)
    if 0 == success:
        glGetShaderInfoLog(vertexShader, 512, nil, sInfoLog.cstring)
        echo "ERROR::SHADER::VERTEX::COMPILATION_FAILED\n",sInfoLog

    # Fragment program: compile
    csText = cstring(readFile shaderPathFrag)
    var fragmentShaderTextArr = [csText]
    let fragmentShader = glCreateShader(GL_FRAGMENT_SHADER)
    glShaderSource(fragmentShader, 1,
                   cast[cstringArray](fragmentShaderTextArr.addr), nil)
    glCompileShader(fragmentShader)

    glGetShaderiv(fragmentShader, GL_COMPILE_STATUS, addr success)
    if 0 == success:
        glGetShaderInfoLog(fragmentShader, 512, nil, sInfoLog.cstring)
        echo "ERROR::SHADER::VERTEX::COMPILATION_FAILED\n",sInfoLog

    # All program: Link
    let hPgm = glCreateProgram() # Used by darw() function
    glAttachShader(hPgm, vertexShader)
    glAttachShader(hPgm, fragmentShader)
    glLinkProgram(hPgm)
    glDeleteShader(vertexShader)
    glDeleteShader(fragmentShader)
    return hPgm

