# Virasat rendering pipeline

The Flutter material study is the first layer of a two-stage rendering system. It gives immediate, deterministic feedback while the customer designs. A future shared 3D renderer will provide a physically based drape preview and the atelier will produce calibrated final renders before weaving.

## Current 2.5D renderer

`shaders/virasat_silk.frag` models:

- warp and weft frequency;
- Katan, Kora, tissue and silk-cotton surface response;
- broad drape folds and fine fold variation;
- directional, anisotropic silk sheen;
- material-specific translucency and micro-contrast;
- independent body, border and pallu colour or gradient.

The shader is procedural and receives only configuration values. Devices that cannot compile the GPU program retain the Canvas material fallback.

## Shared design contract

The Flutter model should remain renderer-independent. A saved design is represented as a versioned specification:

```json
{
  "schema": "wmi.virasat.saree/1",
  "material": "katan",
  "lineage": "banaras-kadhwa",
  "composition": "open-buti",
  "motif": { "id": "asharfi", "scale": 0.48, "density": 0.48 },
  "layers": {
    "body": { "start": "#6E1734", "end": "#321019", "gradient": true, "angle": 0.18 },
    "primaryMotif": { "colour": "#D7B36A" },
    "accent": { "colour": "#1D5548" },
    "border": { "colour": "#321019", "width": 0.48 },
    "zari": { "colour": "#D7B36A" },
    "pallu": { "start": "#321019", "end": "#6E1734", "gradient": true, "angle": 0.5 }
  }
}
```

Flutter, the website, the future 3D viewer and offline approval renderer must consume this same document.

## Production 3D assets

Each approved drape should be authored and simulated in CLO3D, then exported as an optimised GLB with:

- separate material slots for body, lower border, inner border, pallu, zari and blouse;
- stable UVs shared by all drape poses;
- baked high-resolution normal and ambient-occlusion maps;
- named camera positions for drape, body, border, pallu and blouse views;
- optional morph targets for pleat and pallu presentation, not continuous cloth simulation;
- explicit real-world scale and colour-management metadata.

Each fabric requires tileable albedo/weave, normal, roughness, sheen, opacity and anisotropy-direction maps. Zari additionally requires a metallic mask. These maps should be captured from approved physical samples under controlled light.

## Rendering stages

1. **Interactive** — Flutter or Three.js applies the design specification in real time.
2. **Saved design** — the specification and renderer version are stored together.
3. **Approval render** — Blender Cycles renders calibrated drape and macro views from the same specification.
4. **Physical approval** — the customer approves yarn/dye samples and the loom-ready motif graph.
5. **Provenance** — the final design specification, approvals and artisan attribution become part of the garment record.

The real-time view is a design aid. It must never be presented as an exact dye or finished-product guarantee.
