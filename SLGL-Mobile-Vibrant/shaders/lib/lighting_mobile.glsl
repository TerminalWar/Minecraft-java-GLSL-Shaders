#ifndef SLGL_LIGHTING_MOBILE_GLSL
#define SLGL_LIGHTING_MOBILE_GLSL

vec3 slglMobileLight(vec3 albedo, vec2 lm) {
    float sky = clamp(lm.y, 0.0, 1.0);
    float block = clamp(lm.x, 0.0, 1.0);

    vec3 sunTint = vec3(1.10, 1.035, 0.92);
    vec3 shadeTint = vec3(0.82, 0.90, 1.05);
    vec3 lightTint = mix(shadeTint, sunTint, sky);

    float lightLevel = max(block * 1.18, sky * 0.92 + 0.12);
    lightLevel = clamp(lightLevel, 0.16, 1.18);

    return albedo * lightTint * lightLevel;
}

#endif
