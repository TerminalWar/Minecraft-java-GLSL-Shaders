#version 120
#include "/lib/precision_mobile.glsl"

uniform float frameTimeCounter;

varying vec2 texcoord;
varying vec2 lmcoord;
varying vec4 glcolor;
varying float waterTime;

void main() {
    gl_Position = ftransform();
    texcoord = gl_MultiTexCoord0.xy;
    lmcoord = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
    glcolor = gl_Color;
    waterTime = frameTimeCounter;
}
