#version 120
#include "/lib/precision_mobile.glsl"

varying vec4 glcolor;
varying float skyHeight;

void main() {
    vec3 horizon = vec3(0.62, 0.79, 1.0);
    vec3 zenith = vec3(0.28, 0.55, 1.0);
    vec3 sky = mix(horizon, zenith, skyHeight);
    sky = mix(sky, glcolor.rgb, 0.35);
    gl_FragData[0] = vec4(sky, glcolor.a);
}
