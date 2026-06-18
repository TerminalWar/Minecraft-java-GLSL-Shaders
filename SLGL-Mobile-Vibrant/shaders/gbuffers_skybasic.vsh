#version 120
#include "/lib/precision_mobile.glsl"

varying vec4 glcolor;
varying float skyHeight;

void main() {
    gl_Position = ftransform();
    glcolor = gl_Color;
    skyHeight = clamp(gl_Vertex.y * 0.5 + 0.5, 0.0, 1.0);
}
