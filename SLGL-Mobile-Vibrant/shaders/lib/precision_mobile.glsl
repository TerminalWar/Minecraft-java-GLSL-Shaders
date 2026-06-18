#ifndef SLGL_PRECISION_MOBILE_GLSL
#define SLGL_PRECISION_MOBILE_GLSL

#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

// Iris/OptiFine shader options. Defaults favor the Balanced mobile profile.
#ifndef COLOR_INTENSITY
#define COLOR_INTENSITY 1.0 //[0.6 0.75 1.0 1.1 1.25]
#endif

#ifndef DEBUG_VIEW
#define DEBUG_VIEW 0 //[0 1 2]
#endif

#define WAVING_PLANTS // Toggle animated grass and foliage.
#define WATER_SHIMMER // Toggle the cheap water UV shimmer.

#endif
