#version 120
#include "/lib/precision_mobile.glsl"
#include "/lib/common.glsl"

uniform sampler2D texture;

varying vec2 texcoord;
varying vec4 glcolor;

void main() {
    vec4 base = texture2D(texture, texcoord) * glcolor;
    if (base.a < 0.1) discard;
    gl_FragData[0] = base;
}
