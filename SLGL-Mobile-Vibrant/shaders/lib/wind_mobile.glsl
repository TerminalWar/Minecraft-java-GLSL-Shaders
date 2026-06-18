#ifndef SLGL_WIND_MOBILE_GLSL
#define SLGL_WIND_MOBILE_GLSL

vec3 slglApplyPlantWind(vec3 pos, float entityId, float time) {
#ifdef WAVING_PLANTS
    float isGrass = step(10030.5, entityId) * step(entityId, 10031.5);
    float isLeaves = step(10031.5, entityId) * step(entityId, 10032.5);
    float mask = max(isGrass, isLeaves * 0.55);
    float phase = time * 1.55 + pos.x * 0.38 + pos.z * 0.27;
    float wave = sin(phase) * 0.045 * mask;
    pos.x += wave;
    pos.z += wave * 0.35;
#endif
    return pos;
}

#endif
