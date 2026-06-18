#version 120
#include "/lib/precision_mobile.glsl"
#include "/lib/color_mobile.glsl"
#include "/lib/debug_views.glsl"

#ifndef COLOR_INTENSITY
#define COLOR_INTENSITY 1.0
#endif

uniform sampler2D colortex0;

varying vec2 texcoord;

void main() {
    vec4 scene = texture2D(colortex0, texcoord);
    vec3 color = slglTrailerGrade(scene.rgb, COLOR_INTENSITY);
    color = slglDebugView(color, texcoord);
    gl_FragColor = vec4(color, scene.a);
}
