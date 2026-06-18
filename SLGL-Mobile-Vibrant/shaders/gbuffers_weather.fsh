#version 120
#include "/lib/precision_mobile.glsl"

uniform sampler2D texture;

varying vec2 texcoord;
varying vec4 glcolor;

void main() {
    vec4 rain = texture2D(texture, texcoord) * glcolor;
    rain.rgb *= vec3(0.86, 0.91, 1.0);
    gl_FragData[0] = rain;
}
