#version 120
#include "/lib/precision_mobile.glsl"

varying vec2 texcoord;

void main() {
    gl_Position = ftransform();
    texcoord = gl_MultiTexCoord0.xy;
}
