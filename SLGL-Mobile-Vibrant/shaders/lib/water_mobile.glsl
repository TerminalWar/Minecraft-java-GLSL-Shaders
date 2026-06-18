#ifndef SLGL_WATER_MOBILE_GLSL
#define SLGL_WATER_MOBILE_GLSL

vec2 slglWaterUV(vec2 uv, float time) {
#ifdef WATER_SHIMMER
    float wave = sin((uv.x + uv.y) * 42.0 + time * 1.7) * 0.0018;
    uv += vec2(wave, -wave * 0.7);
#endif
    return uv;
}

vec3 slglWaterColor(vec3 base) {
    vec3 tint = vec3(0.62, 0.86, 1.0);
    return mix(base, base * tint + vec3(0.02, 0.05, 0.06), 0.42);
}

#endif
