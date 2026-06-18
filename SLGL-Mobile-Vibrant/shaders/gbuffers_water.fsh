#version 120
#include "/lib/precision_mobile.glsl"
#include "/lib/lighting_mobile.glsl"
#include "/lib/water_mobile.glsl"

uniform sampler2D texture;

varying vec2 texcoord;
varying vec2 lmcoord;
varying vec4 glcolor;
varying float waterTime;

void main() {
    vec2 uv = slglWaterUV(texcoord, waterTime);
    vec4 base = texture2D(texture, uv) * glcolor;
    if (base.a < 0.05) discard;

    vec3 water = slglWaterColor(base.rgb);
    water = slglMobileLight(water, lmcoord);
    gl_FragData[0] = vec4(water, base.a);
}
