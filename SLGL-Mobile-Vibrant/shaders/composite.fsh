#version 120
#include "/lib/precision_mobile.glsl"

uniform sampler2D colortex0;

varying vec2 texcoord;

void main() {
    vec4 scene = texture2D(colortex0, texcoord);
    gl_FragData[0] = scene;
}
