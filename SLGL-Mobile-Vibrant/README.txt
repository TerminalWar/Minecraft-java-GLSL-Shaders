SLGL Mobile Vibrant - First Runnable Build

Goal:
A lightweight, bright, Minecraft-trailer-like shader pack for Minecraft Java on Android launchers such as Zalith/Pojav using Iris-compatible shader loading.

Install:
1. Copy SLGL-Mobile-Vibrant.zip into your Minecraft shaderpacks folder.
2. Enable it from the Iris shader menu.
3. Start with the Potato profile if you get low FPS or heat/thermal throttling.
4. Use Balanced after confirming the world loads correctly.

First test checklist:
- Load a new plains world in daytime.
- Confirm terrain, sky, hand, entities, water, and weather render.
- Test with vanilla textures first, then Bare Bones.
- If the screen is black, turn DEBUG_VIEW to 1 or disable the newest option.
- If grass waving causes visual bugs, set WAVING_PLANTS to false.
- If water shimmers incorrectly, set WATER_SHIMMER to false.

Known limits in this first iteration:
- No shadow maps yet.
- No bloom yet.
- No screen-space reflections.
- No volumetric lighting.
These are intentionally excluded to keep the first build fast and stable on mobile GPUs.
