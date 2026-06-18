#ifndef SLGL_DEBUG_VIEWS_GLSL
#define SLGL_DEBUG_VIEWS_GLSL

vec3 slglDebugView(vec3 color, vec2 uv) {
#if DEBUG_VIEW == 1
    return vec3(uv, 0.0);
#elif DEBUG_VIEW == 2
    float luma = dot(color, vec3(0.299, 0.587, 0.114));
    return vec3(luma);
#else
    return color;
#endif
}

#endif
