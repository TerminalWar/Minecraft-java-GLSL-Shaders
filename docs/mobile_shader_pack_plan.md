# SLGL Mobile Shader Pack Master Plan

## Vision
Build **SLGL Mobile Vibrant**, a highly optimized Minecraft Java shader pack for Android players using Zalith or Pojav with Iris-compatible shader loading. The final look should feel **brighter, cleaner, and more Minecraft-trailer-like** than vanilla Java: colorful skies, warm sunlight, readable shadows, lively grass, attractive water, and polished color grading. The pack must never become heavy, noisy, or overdone. Performance and stability come first.

The target style is:
- Bright and cheerful like Minecraft promotional/trailer visuals.
- Vibrant like Bedrock Vibrant Visuals, but lighter and safer for mobile GPUs.
- Compatible with vanilla textures and simple packs such as Bare Bones.
- Smooth and readable in survival gameplay, not just good in screenshots.
- Built one pass at a time so every feature can be tested, disabled, or simplified.

## Non-Negotiable Technical Rules
- **Mobile-first:** design for Adreno and Mali GPUs before desktop GPUs.
- **Low RAM:** use as few render targets and intermediate buffers as possible.
- **Low bandwidth:** reduce texture reads, avoid repeated full-screen passes, and avoid high-resolution blur chains unless optional.
- **`mediump` by default:** use `highp` only where precision artifacts are proven and unavoidable.
- **No expensive base effects:** no ray tracing, no path tracing, no voxel GI, no ray-marched volumetrics, and no heavy screen-space reflections in the base profile.
- **Modular files:** implement one shader file or one effect at a time.
- **Debug-first:** every implemented feature needs its own test checklist and fallback setting.
- **Texture-pack safe:** do not crush albedo detail, oversaturate simple textures, or make Bare Bones look radioactive.
- **60 FPS target:** every feature must justify its cost on Android hardware.

## Final Downloadable Output
The repository should eventually produce this user-facing zip:

```text
SLGL-Mobile-Vibrant.zip
```

The zip should be importable as a normal shader pack and should not require users to rearrange folders manually.

## Planned Final Zip Layout

```text
SLGL-Mobile-Vibrant/
├── shaders/
│   ├── gbuffers_basic.vsh
│   ├── gbuffers_basic.fsh
│   ├── gbuffers_textured.vsh
│   ├── gbuffers_textured.fsh
│   ├── gbuffers_terrain.vsh
│   ├── gbuffers_terrain.fsh
│   ├── gbuffers_entities.vsh
│   ├── gbuffers_entities.fsh
│   ├── gbuffers_hand.vsh
│   ├── gbuffers_hand.fsh
│   ├── gbuffers_armor_glint.vsh
│   ├── gbuffers_armor_glint.fsh
│   ├── gbuffers_water.vsh
│   ├── gbuffers_water.fsh
│   ├── gbuffers_skybasic.vsh
│   ├── gbuffers_skybasic.fsh
│   ├── gbuffers_weather.vsh
│   ├── gbuffers_weather.fsh
│   ├── composite.vsh
│   ├── composite.fsh
│   ├── composite1.vsh
│   ├── composite1.fsh
│   ├── final.vsh
│   ├── final.fsh
│   ├── lib/
│   │   ├── common.glsl
│   │   ├── precision_mobile.glsl
│   │   ├── uniforms.glsl
│   │   ├── color_mobile.glsl
│   │   ├── lighting_mobile.glsl
│   │   ├── fog_mobile.glsl
│   │   ├── wind_mobile.glsl
│   │   ├── water_mobile.glsl
│   │   └── debug_views.glsl
│   └── program/
│       └── disabled_optional_passes.md
├── shader.properties
├── block.properties
├── item.properties
├── README.txt
├── CHANGELOG.txt
└── LICENSE.txt
```

This layout is a future target. The first working versions should contain only the minimum files required to boot and render correctly.

## Quality Profiles
The pack should eventually support simple quality presets through shader options. Presets must change only a small set of defines so the code remains maintainable.

### Potato Profile
For very weak phones or thermal-limited sessions.
- Final color grading only.
- Basic directional sunlight.
- Simple fog.
- No bloom.
- No waving plants.
- Static water tint.
- Lowest RAM and bandwidth usage.

### Mobile Balanced Profile
Primary target profile.
- Trailer-like color grade.
- Lightweight sunlight and ambient shading.
- Simple waving grass/leaves.
- Cheap sky gradient and fog.
- Cheap water tint and subtle shimmer.
- Optional very small bloom/glow approximation.

### Mobile Plus Profile
For stronger Android devices.
- Slightly better water animation.
- Slightly smoother fog response.
- Optional lightweight bloom enabled.
- Optional entity/hand lighting polish.
- Still no heavy reflections or volumetrics.

## Visual Design Targets

### Brightness and Color
- Make daytime brighter and friendlier than vanilla Java.
- Use a warm sun tint and soft cool shadows.
- Keep caves readable without making them look fullbright.
- Avoid crushed blacks at night.
- Avoid blown-out whites in snow, clouds, quartz, and UI.
- Use gentle saturation, not extreme saturation.

### Minecraft Trailer-Like Feel
- Emphasize clean blue skies, golden sunlight, green grass, and readable terrain silhouettes.
- Use stylized light response rather than physically accurate shading.
- Make blocks look clear at a distance.
- Keep the image stable while moving; no noisy shimmer.
- Prefer broad, cheap gradients over expensive high-frequency detail.

### Texture Pack Compatibility
- Bare Bones should stay simple, flat, and colorful.
- Vanilla should look richer without hiding pixel art.
- Dark texture packs should remain playable.
- Saturation and contrast must be centralized in one color module so they can be tuned quickly.

## Long-Term Feature Coverage
By the time the shader pack is complete, it should cover every major area users expect from a modern lightweight shader while keeping each feature scalable or optional.

### Required Core Features
- Bootable Iris shader-pack structure.
- Terrain rendering.
- Entity rendering.
- Hand/item rendering.
- Sky rendering.
- Fog and distance blending.
- Water rendering.
- Weather rendering.
- Final color grading.
- Debug views and fallback modes.
- Reproducible zip packaging.

### Required Visual Features
- Brighter trailer-style daytime color.
- Warm sun/cool shadow color separation.
- Lightweight directional terrain lighting.
- Ambient fill light that keeps gameplay readable.
- Waving grass and foliage.
- Subtle water movement.
- Clean sky gradient.
- Light atmospheric fog.
- Rain mood adjustment.
- Night readability tuning.
- Nether and End dimension tuning.
- Optional cheap bloom/glow for highlights.

### Optional Future Features
These are future goals only after the base pack is stable and fast.
- Very cheap cloud polish.
- Low-cost emissive enhancement for lava/torches.
- Better underwater color and fog.
- Simple held-torch warmth, if it can be done cheaply and reliably.
- Optional stylized sun/moon treatment.
- Optional lightweight outline/readability helper for entities.

## Performance Budget
Every feature should be reviewed against this rough budget.

### Full-Screen Pass Budget
- Base target: `final` only after gbuffers.
- Balanced target: `composite` plus `final` if needed.
- Avoid long chains of `composite2`, `composite3`, etc. unless an optional profile clearly needs them.

### Texture Read Budget
- Final color grading: 1 scene color read.
- Fog/color combine: ideally no extra reads beyond scene color and depth if depth is necessary.
- Water: keep to the required Minecraft texture read plus minimal math.
- Bloom: only if using a very cheap approximation; avoid wide multi-sample blur in base profiles.

### ALU Budget
- Prefer multiply/add/smoothstep-style math.
- Avoid expensive `pow` unless approximated or used sparingly.
- Avoid repeated `sin`/`cos`; if needed for wind, use low-frequency shared calculations.
- Avoid per-pixel loops in base passes.
- Move calculations to vertex shader when visual quality allows it.

### Memory/Bandwidth Budget
- Do not allocate unnecessary color attachments.
- Avoid high-resolution intermediate effects.
- Avoid storing data that can be cheaply recomputed.
- Prefer one packed value over multiple buffers when possible.

## Implementation Phases

### Phase 0: Repository and Packaging Foundation
**Purpose:** prepare the repo so every future step can produce a clean downloadable shader zip.

Deliverables:
- Final folder name decision: `SLGL-Mobile-Vibrant`.
- Build command or script that creates `SLGL-Mobile-Vibrant.zip`.
- README with install path for Zalith/Pojav/Iris.
- Changelog format.

Acceptance checks:
- A clean clone can produce the zip.
- Zip contains one top-level shader-pack folder.
- User can drop the zip into the shaderpacks folder.

### Phase 1: Minimal Bootable Shader Framework
**Purpose:** get a black-screen-safe base running before adding beauty features.

Deliverables:
- Minimal `shader.properties`.
- Minimal `gbuffers_basic`, `gbuffers_textured`, `gbuffers_terrain`, `gbuffers_skybasic`, `composite`, and `final` files.
- Shared precision and uniform include files.
- Debug color output mode.

Acceptance checks:
- Pack appears in the Iris shader list.
- World loads without black screen.
- Blocks, sky, hand, and UI remain visible.
- FPS is close to vanilla/no shader.

Troubleshooting focus:
- Shader compile errors.
- Missing uniforms.
- Incorrect output targets.
- Android precision issues.

### Phase 2: Trailer-Style Final Color Grade
**Purpose:** establish the core look with the cheapest possible effect.

Deliverables:
- `color_mobile.glsl` module.
- Brighter daytime tone curve.
- Gentle saturation lift.
- Soft highlight protection.
- Night/cave readability controls.

Acceptance checks:
- Bare Bones is colorful but not blown out.
- Snow and clouds retain detail.
- Caves are readable.
- UI remains unaffected or minimally affected depending on pass behavior.

Performance target:
- One full-screen color read.
- No bloom.
- No depth dependency unless absolutely needed.

### Phase 3: Terrain Lighting Foundation
**Purpose:** give terrain more shape without heavy shadows.

Deliverables:
- Mobile directional lighting using `sunPosition` where available.
- Ambient fill term.
- Rain and time-of-day brightness response.
- Simple block readability protection.

Acceptance checks:
- Plains, forests, and villages look sunny and bright.
- Shadowed terrain is still playable.
- No flickering when rotating camera.
- Performance remains stable in dense terrain.

Performance target:
- No shadow maps in the initial mobile base.
- No depth-normal reconstruction.
- Branch-light code path.

### Phase 4: Waving Grass and Foliage
**Purpose:** add life and shader-pack feel while keeping cost tiny.

Deliverables:
- `wind_mobile.glsl` module.
- Vertex-stage waving grass.
- Optional vertex-stage leaf sway.
- Block-ID based control through `block.properties` where practical.
- Low/medium/off settings.

Acceptance checks:
- Grass movement is visible but subtle.
- Leaves do not shimmer aggressively.
- Crops and flowers do not stretch unnaturally.
- FPS remains stable in forests and plains.

Performance target:
- Vertex shader animation only.
- No texture noise.
- Minimal `sin` use; share wind phase where possible.
- Disable option for low-end devices.

### Phase 5: Sky and Atmosphere
**Purpose:** make the world feel brighter and more cinematic without volumetrics.

Deliverables:
- Clean sky gradient.
- Warm horizon at sunrise/sunset.
- Simple day/night sky tuning.
- Light distance fog.
- Rain desaturation and mist tuning.

Acceptance checks:
- Horizon looks smooth.
- Distant terrain blends nicely.
- Rain is moodier but not too dark.
- Night remains playable.

Performance target:
- No ray marching.
- No volumetric clouds.
- No expensive atmospheric scattering.

### Phase 6: Water Pass
**Purpose:** create appealing mobile water that feels alive but remains cheap.

Deliverables:
- `water_mobile.glsl` module.
- Blue/green water tint.
- Subtle animated shimmer.
- Optional cheap Fresnel approximation.
- Underwater color/fog tuning.

Acceptance checks:
- Water looks better than vanilla but not like glass/plastic.
- Ocean and river FPS remains stable.
- Underwater visibility is playable.
- No noisy artifacts on Mali/Adreno.

Performance target:
- No screen-space reflections in base profiles.
- No multi-sample refraction.
- No high-frequency normal maps.

### Phase 7: Entities, Hand, and Items
**Purpose:** ensure the shader pack feels complete in gameplay, not just landscapes.

Deliverables:
- Entity color consistency with terrain.
- Hand/item brightness correction.
- Armor glint compatibility.
- Held items readable in caves and at night.

Acceptance checks:
- Mobs are visible in daylight and night.
- Player hand does not become too saturated.
- Enchanted armor/glint does not break.
- Items match the world lighting style.

Performance target:
- Reuse color and lighting functions.
- Avoid separate expensive effects for entities.

### Phase 8: Weather and Dimension Tuning
**Purpose:** make all normal gameplay environments usable.

Deliverables:
- Rain brightness and fog changes.
- Thunderstorm darkening that remains playable.
- Nether warm haze tuning.
- End cooler/alien tone tuning.
- Snow biome brightness protection.

Acceptance checks:
- Rain looks atmospheric, not muddy.
- Nether lava areas are vibrant but not clipped.
- End remains readable.
- Snow is not overexposed.

Performance target:
- Mostly color/fog constants and simple conditionals.
- Avoid extra passes per dimension.

### Phase 9: Optional Lightweight Glow/Bloom
**Purpose:** add premium polish only after the base is stable.

Deliverables:
- Optional small glow approximation for lava, torches, sun highlights, and bright sky.
- Quality toggle: off/low.
- Highlight clamp to protect UI and white blocks.

Acceptance checks:
- Torches and sunset feel warmer.
- Glow is subtle, not blurry or smeared.
- FPS impact is acceptable.
- Turning bloom off returns near-base performance.

Performance target:
- Avoid wide blur kernels.
- Avoid multiple downsample/upsample passes on the base mobile profile.
- Prefer a cheap single-pass approximation if visually acceptable.

### Phase 10: Debug, Options, and Fallbacks
**Purpose:** make the pack maintainable and easy to troubleshoot on Android.

Deliverables:
- Debug views for albedo, lighting, fog, water, and final grade.
- Shader options for quality profile, waving plants, water shimmer, color intensity, and bloom.
- Safe defaults for low-end devices.
- Known-problem notes for Adreno/Mali.

Acceptance checks:
- User can disable the newest risky feature quickly.
- Debug views help isolate black screens or broken passes.
- Options do not create too many hard-to-test permutations.

### Phase 11: Final Packaging and Release
**Purpose:** ship a clean downloadable zip.

Deliverables:
- `SLGL-Mobile-Vibrant.zip`.
- README install guide.
- Settings guide for Potato, Balanced, and Plus profiles.
- Known issues and recommended Minecraft/Iris/Zalith/Pojav settings.
- Release checklist.

Acceptance checks:
- Zip imports directly.
- Shader list displays correctly.
- Vanilla and Bare Bones both look good.
- Pack can be reproduced from the repo.

## Recommended Development Order
1. Packaging foundation.
2. Minimal boot framework.
3. Final color grade.
4. Terrain lighting.
5. Waving grass.
6. Sky and fog.
7. Water.
8. Entities, hand, and items.
9. Weather and dimensions.
10. Optional glow/bloom.
11. Debug views and release polish.
12. Final downloadable zip.

## Feature Risk Table

| Feature | Visual Value | Mobile Cost | Base Decision |
| --- | --- | --- | --- |
| Final color grade | Very high | Very low | Required |
| Directional sunlight | High | Low | Required |
| Ambient fill | High | Very low | Required |
| Waving grass | High | Low vertex cost | Required with off toggle |
| Leaf sway | Medium | Low vertex cost | Optional/Balanced |
| Sky gradient | High | Low | Required |
| Simple fog | High | Low | Required |
| Water tint | High | Low | Required |
| Water shimmer | Medium | Low/medium | Required with low setting |
| Entity lighting | Medium | Low | Required |
| Weather tint | Medium | Very low | Required |
| Nether/End tuning | Medium | Very low | Required |
| Bloom/glow | Medium/high | Medium | Optional |
| Screen-space reflections | High | High | Not in base |
| Volumetric lighting | High | Very high | Not in base |
| Shadow maps | High | Medium/high | Future only if cheap enough |

## Device Test Matrix
- **Low-end target:** 2-4 GB RAM Android device.
- **GPU target:** Adreno 6xx, Adreno 7xx, Mali G-series, and weaker fallback devices where possible.
- **Launcher priority:** Zalith first, Pojav second.
- **Shader loader:** Iris-compatible stack.
- **Minecraft scenes:** plains village, dense forest, jungle edge, ocean, river, cave, Nether fortress, End island, snowy biome, rainy overworld.
- **Texture packs:** vanilla, Bare Bones, and at least one darker pack.
- **Gameplay tests:** walking, sprinting, swimming, fighting mobs, mining, building, sleeping through night, entering Nether/End.

## Per-Pass Debug Checklist Template
Every future shader pass should be implemented with this checklist:

1. Confirm the game loads with the pass enabled.
2. Confirm compile log has no precision or uniform errors.
3. Test in plains daylight.
4. Test in cave/night lighting.
5. Test in rain if the pass affects sky/fog/color.
6. Test with Bare Bones.
7. Compare FPS against the previous commit.
8. Add an off/low fallback if the feature is risky.
9. Document common artifacts and fixes.

## Common Failure Plan
- **Black screen:** disable the newest pass, check compile log, verify precision qualifiers, verify output target names, and test a flat debug color.
- **Pink or missing textures:** verify sampler names, texture coordinates, and gbuffer output compatibility.
- **Huge FPS drop:** count texture reads first, then remove branches, reduce full-screen passes, and disable optional effects.
- **Over-bright image:** reduce exposure before reducing saturation.
- **Over-saturated image:** tune `color_mobile.glsl` globally instead of changing every pass.
- **Dark caves:** raise ambient floor carefully and avoid fullbright behavior.
- **Noisy water:** disable shimmer and return to static tint.
- **Waving plant bugs:** disable wind for suspicious block IDs and verify vertex offsets are not applied to full blocks.
- **Mali artifacts:** reduce precision-sensitive math and avoid relying on undefined behavior.
- **Adreno artifacts:** simplify dependent texture reads and avoid unstable derivatives in mobile profiles.

## Final Success Definition
The shader pack is complete when:
- It ships as `SLGL-Mobile-Vibrant.zip`.
- It loads on Zalith/Pojav with Iris-compatible shader support.
- It runs smoothly on the selected Android test devices.
- It makes Minecraft brighter, cleaner, and more trailer-like without going overboard.
- It supports vanilla and Bare Bones textures.
- It includes terrain, sky, fog, water, entities, hand/items, weather, dimensions, waving grass, final color grading, options, debug modes, and packaging.
- Every expensive feature is optional or excluded from the base mobile profile.
