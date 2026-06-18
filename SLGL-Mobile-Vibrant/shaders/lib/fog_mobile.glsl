#ifndef SLGL_FOG_MOBILE_GLSL
#define SLGL_FOG_MOBILE_GLSL

vec3 slglSoftFog(vec3 color, vec3 fogColor, float amount) {
    return mix(color, fogColor, clamp(amount, 0.0, 1.0));
}

#endif
