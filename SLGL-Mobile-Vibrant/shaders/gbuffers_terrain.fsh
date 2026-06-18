#version 120
#include "/lib/precision_mobile.glsl"
#include "/lib/lighting_mobile.glsl"

uniform sampler2D texture;

varying vec2 texcoord;
varying vec2 lmcoord;
varying vec4 glcolor;

void main() {
    vec4 base = texture2D(texture, texcoord) * glcolor;
    if (base.a < 0.1) discard;

    vec3 lit = slglMobileLight(base.rgb, lmcoord);
    gl_FragData[0] = vec4(lit, base.a);
}
