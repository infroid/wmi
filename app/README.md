# Wear My India · Virasat app

A responsive Flutter prototype for commissioning a made-to-order Virasat saree.

The product is deliberately not a conventional catalogue or instant checkout. A customer creates a coherent brief; a WMI textile curator, master weaver and tailor review it before yarn is sourced or work begins.

## Experience included

- Editorial Virasat home and commissioning story
- Responsive mobile, tablet and desktop layouts
- A GPU-rendered material study with separate drape, body and pallu views
- Procedural warp/weft, material-specific sheen, translucency and fold lighting for Katan, Kora, tissue and silk-cotton
- Eight guided commissioning passages:
  1. visual material and drape selection;
  2. regional craft lineage;
  3. body composition;
  4. motif family, scale and density;
  5. per-layer colour and gradient atelier;
  6. border and pallu architecture;
  7. blouse silhouette;
  8. finishing, measurement and artisan review;
- Six independently colourable textile layers: body, primary motif, motif accent, border, zari and pallu
- Solid and two-colour gradient treatments with hue, saturation, depth and direction controls
- Visual material, composition, motif, border and blouse cards instead of text-only selectors
- Craft-compatible options for Banaras Kadhwa, Kanchipuram Korvai and Paithani tapestry
- Indicative price and making-time guidance
- Final commission note and human review handoff
- WMI imagery, colour system, launcher icons, Tiro display type and Anek Devanagari interface type

This release is an interaction prototype. It does not yet include accounts, cloud persistence, payments, inventory, appointments or atelier operations.

The current renderer is an interim 2.5D material study rather than a dye or finished-product guarantee. The shared CLO3D/glTF/Three.js and approval-render architecture is specified in [`docs/RENDERING_PIPELINE.md`](docs/RENDERING_PIPELINE.md).

## Commission model

The flow separates two kinds of decisions that should not be collapsed:

1. **The woven saree** — lineage, yarn/fabric, body colour, contrast, motifs, border, pallu and zari language.
2. **The finished ensemble** — blouse design and measurements, fall and pico, tassels, petticoat, embroidery, fitting and final inspection.

After a request, the intended production sequence is:

1. curator and master-weaver feasibility review;
2. dye palette, motif graph, estimate and calendar approval;
3. yarn sourcing, dyeing, winding and warping;
4. handweaving with documented artisan attribution;
5. blouse pattern, fitting and handwork;
6. fall/pico, tassels, pressing and quality inspection;
7. provenance record and delivery.

The app avoids treating regional techniques as interchangeable visual filters. A physical swatch, loom-ready motif graph and craft feasibility review are explicit production gates before weaving.

## Run and validate

```bash
cd app
flutter pub get
flutter run
```

For web:

```bash
flutter run -d chrome
```

Quality checks:

```bash
flutter analyze
flutter test
flutter build web --release --no-wasm-dry-run
```

## Research basis

The interaction model draws from:

- [Development Commissioner (Handlooms), Sustainability in the Handloom Traditions of India](https://handlooms.nic.in/assets/img/EBOOK/Sustainability%20in%20the%20Handloom%20Traditions%20of%20India.pdf), including Kanchipuram Korvai/Petni construction, yarn preparation and multi-artisan production;
- [Development Commissioner (Handlooms), Uttar Pradesh weavers documentation](https://handlooms.nic.in/assets/img/Weavers%20Database/UP637322666574917584.pdf), covering Banaras brocade, zari, jaal and meenakari characteristics;
- [Development Commissioner (Handlooms), Paithani study](https://handlooms.nic.in/assets/img/Publications/Paithani%20sarees%20and%20Dress%20Materials635701517283000941.pdf), documenting Paithani motifs, borders, pallu and colour construction;
- [Katansi saree add-on and measurement guide](https://katansi.com/pages/add-ons), for the practical separation of blouse measurements, petticoat measurements, fall/pico and tassels.

The configurator interaction also takes cues from official custom-product experiences:

- [Nike By You](https://www.nike.com/help/a/what-is-nike-by-you), for part-by-part customisation with immediate visual feedback;
- [Suitsupply Custom Made](https://suitsupply.com/en-in/custom-made), for beginning with material and retaining specialist review for fit and construction.

Prices, timelines and option names in the prototype are product assumptions for WMI and require validation with the actual artisan network before commercial release.

## Fonts and image note

Tiro Devanagari Hindi and Anek Devanagari are bundled under the SIL Open Font License; license texts are in `assets/fonts/`. Campaign photographs are WMI concept assets and must not be represented as photographs of actual commissioned products or artisans.
