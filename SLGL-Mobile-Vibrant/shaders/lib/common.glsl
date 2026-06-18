#ifndef SLGL_COMMON_GLSL
#define SLGL_COMMON_GLSL

float slgl_saturate(float v) { return clamp(v, 0.0, 1.0); }
vec3 slgl_saturate3(vec3 v) { return clamp(v, vec3(0.0), vec3(1.0)); }

#endif
