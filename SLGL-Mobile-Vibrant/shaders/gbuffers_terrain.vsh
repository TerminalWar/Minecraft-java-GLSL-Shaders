#version 120
#include "/lib/precision_mobile.glsl"
#include "/lib/wind_mobile.glsl"

attribute vec4 mc_Entity;

uniform float frameTimeCounter;

varying vec2 texcoord;
varying vec2 lmcoord;
varying vec4 glcolor;

void main() {
    vec4 pos = gl_Vertex;
    pos.xyz = slglApplyPlantWind(pos.xyz, mc_Entity.x, frameTimeCounter);

    gl_Position = gl_ModelViewProjectionMatrix * pos;
    texcoord = gl_MultiTexCoord0.xy;
    lmcoord = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
    glcolor = gl_Color;
}
