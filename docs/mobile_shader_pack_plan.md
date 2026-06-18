# SLGL Mobile Shader Pack Plan

## Goal
Build a lightweight Minecraft Java shader pack for Android launchers such as Zalith and Pojav, targeting Iris-compatible shader loading while keeping RAM, bandwidth, and ALU cost low on Adreno and Mali GPUs. The visual target is a polished, vibrant Minecraft Bedrock Vibrant Visuals-inspired style that still works well with simple texture packs such as Bare Bones.

## Core Constraints
- **Modular implementation:** add and test one shader pass or one file at a time.
- **Mobile-first GLSL:** use `mediump` by default, avoid expensive loops, avoid high-frequency noise, avoid unnecessary dependent texture reads, and keep render targets minimal.
- **Debug-first workflow:** every implemented pass must include a test checklist and troubleshooting notes before moving to the next pass.
- **Iris compatibility:** package the result as a standard shader pack zip with shader files under `shaders/` and configuration files at the pack root as needed.
- **Texture-pack friendly:** lighting and color grading must preserve albedo readability so packs like Bare Bones remain clean instead of becoming over-saturated or crushed.
- **60 FPS priority:** visual features are accepted only if they fit the mobile performance budget.

## Planned Final Repository Output
The repository should produce a downloadable zip file:

```text
SLGL-Mobile-Vibrant.zip
```

The zip should contain this shader-pack layout:

```text
SLGL-Mobile-Vibrant/
├── shaders/
│   ├── gbuffers_basic.vsh
│   ├── gbuffers_basic.fsh
│   ├── gbuffers_textured.vsh
│   ├── gbuffers_textured.fsh
│   ├── gbuffers_terrain.vsh
│   ├── gbuffers_terrain.fsh
│   ├── gbuffers_water.vsh
│   ├── gbuffers_water.fsh
│   ├── gbuffers_skybasic.vsh
│   ├── gbuffers_skybasic.fsh
│   ├── composite.vsh
│   ├── composite.fsh
│   ├── final.vsh
│   ├── final.fsh
│   └── lib/
│       ├── common.glsl
│       ├── lighting_mobile.glsl
│       └── color_mobile.glsl
├── shader.properties
├── block.properties
├── item.properties
└── README.txt
```

No shader code should be added until each pass is implemented in a focused step.

## Build Phases

### Phase 1: Minimal Bootable Framework
**Purpose:** prove Iris/Zalith/Pojav can load the pack reliably.

Deliverables:
- Minimal `shader.properties`.
- Pass-through vertex/fragment structure for basic, textured, terrain, sky, composite, and final stages.
- README installation instructions.
- Zip build script or documented command to create `SLGL-Mobile-Vibrant.zip`.

Acceptance checks:
- Pack appears in Iris shader list.
- World loads without black screen.
- UI and terrain render normally.
- Baseline FPS is close to vanilla/no-shader performance.

### Phase 2: Mobile Color Foundation
**Purpose:** create the Vibrant Visuals-like identity without heavy effects.

Deliverables:
- Lightweight saturation and contrast curve in `final.fsh` or `composite.fsh`.
- Low-cost warm sunlight/cool shadow tint.
- Optional per-dimension tuning only if cheap and stable.

Performance rules:
- One color texture read for final color.
- No bloom yet.
- No dynamic branching for quality modes unless Iris options require it.

Acceptance checks:
- Bare Bones textures remain readable.
- Grass, sky, and water look richer without color clipping.
- Night and caves are not crushed to black.

### Phase 3: Terrain Lighting Pass
**Purpose:** improve terrain depth and atmosphere while preserving FPS.

Deliverables:
- Mobile Lambert-style directional light using Minecraft uniforms such as `sunPosition`.
- Simple ambient term and rain/darkness handling.
- Conservative brightness response for emissive-looking blocks.

Performance rules:
- Avoid normal reconstruction from depth in early builds.
- Prefer existing varying data when available.
- Keep calculations branch-light and mediump-friendly.

Acceptance checks:
- Terrain has clearer sunlight direction.
- Shadows are stylized, not physically accurate.
- FPS remains stable while walking through villages and forests.

### Phase 4: Sky and Fog Styling
**Purpose:** add atmosphere similar to Bedrock-style presentation at low cost.

Deliverables:
- Smooth sky gradient in `gbuffers_skybasic`.
- Distance fog tuning in terrain/composite path.
- Rain/desaturation adjustment if stable.

Performance rules:
- No volumetric lighting.
- No ray marching.
- Use simple gradients and Minecraft fog inputs where available.

Acceptance checks:
- Horizon looks smoother.
- Far terrain blends naturally.
- Nether and End remain readable.

### Phase 5: Water Pass
**Purpose:** create attractive but cheap water.

Deliverables:
- Slight blue/green tint compatible with texture packs.
- Low-cost animated UV wobble or normal-like shimmer in `gbuffers_water`.
- Optional Fresnel approximation only if it is visually worth the cost.

Performance rules:
- No screen-space reflections in the base version.
- No multi-sample refraction.
- Use a tiny number of arithmetic ops and avoid expensive trigonometry where practical.

Acceptance checks:
- Water movement is visible but not noisy.
- Underwater visibility remains playable.
- FPS does not spike near oceans or rivers.

### Phase 6: Optional Lightweight Bloom
**Purpose:** add a subtle premium look only after the base is stable.

Deliverables:
- Single-pass cheap bloom or glow approximation if Iris buffers allow it cleanly.
- Brightness threshold tuned for torches, lava, and sky highlights.

Performance rules:
- Disable by default on low-end devices if needed.
- Avoid multi-pass wide blur for the base mobile profile.

Acceptance checks:
- Torches and sunset feel warmer.
- UI is not blurred or over-bright.
- FPS cost is measurable and acceptable.

### Phase 7: Packaging and Release
**Purpose:** create the downloadable zip requested for end users.

Deliverables:
- `SLGL-Mobile-Vibrant.zip` generated from the shader-pack folder.
- Installation instructions for Zalith/Pojav/Iris.
- Versioned release notes.
- Known-issues list for common Android GPU problems.

Acceptance checks:
- Zip imports without manual folder restructuring.
- Shader list displays the pack name correctly.
- Clean clone of the repo can reproduce the zip.

## Recommended Implementation Order
1. `shader.properties` and empty boot framework.
2. `final` color pass.
3. `gbuffers_terrain` lighting.
4. `gbuffers_skybasic` sky gradient.
5. `gbuffers_water` mobile water.
6. Optional bloom only after 60 FPS validation.
7. Zip packaging.

## Device Test Matrix
- **Low-end target:** 2-4 GB RAM Android device, Adreno 6xx or Mali G-series.
- **Launcher:** Zalith first, Pojav second.
- **Renderer stack:** Minecraft Java with Iris-compatible shader support.
- **Texture packs:** vanilla and Bare Bones.
- **World tests:** plains village, forest, ocean, cave, Nether, End.

## Common Failure Plan
- **Black screen:** disable latest pass, check compile log, verify precision qualifiers and uniforms.
- **Pink/missing textures:** verify sampler names and shader-stage outputs.
- **Huge FPS drop:** count texture reads first, then simplify branches and remove optional effects.
- **Over-saturated textures:** reduce final saturation before touching terrain lighting.
- **Water artifacts:** disable UV animation and retest static tint first.
