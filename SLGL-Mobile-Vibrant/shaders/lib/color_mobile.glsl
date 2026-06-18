#ifndef SLGL_COLOR_MOBILE_GLSL
#define SLGL_COLOR_MOBILE_GLSL

vec3 slglTrailerGrade(vec3 color, float intensity) {
    color = max(color, vec3(0.0));

    // Cheap exposure lift with highlight protection for snow/clouds/UI-like whites.
    vec3 lifted = color * (1.06 + 0.08 * intensity) + vec3(0.015 * intensity);
    lifted = lifted / (vec3(1.0) + lifted * 0.18);

    float luma = dot(lifted, vec3(0.299, 0.587, 0.114));
    float sat = 1.0 + 0.16 * intensity;
    lifted = mix(vec3(luma), lifted, sat);

    // Very gentle trailer warmth: warmer highlights, slightly cleaner shadows.
    vec3 warm = vec3(1.035, 1.012, 0.965);
    vec3 cool = vec3(0.965, 0.985, 1.035);
    float hi = clamp(luma * 1.25, 0.0, 1.0);
    lifted *= mix(cool, warm, hi * 0.35);

    return clamp(lifted, 0.0, 1.0);
}

#endif
