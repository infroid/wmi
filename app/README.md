# Wear My India · Virasat app

A responsive Flutter prototype for commissioning a made-to-order Virasat saree.

The product is deliberately not a conventional catalogue or instant checkout. A customer creates a coherent brief; a WMI textile curator, master weaver and tailor review it before yarn is sourced or work begins.

## Experience included

- Editorial Virasat home and commissioning story
- Responsive mobile, tablet and desktop layouts
- Live saree visualisation as colour, motif and border decisions change
- Eight guided commissioning passages:
  1. intention and occasion;
  2. loom lineage and foundation cloth;
  3. colour story;
  4. body motif;
  5. border and pallu;
  6. blouse silhouette;
  7. fall/pico, tassels, petticoat and embroidery;
  8. measurement method and artisan review;
- Craft-compatible options for Banaras Kadhwa, Kanchipuram Korvai and Paithani tapestry
- Indicative price and making-time guidance
- Final commission note and human review handoff
- WMI imagery, colour system, launcher icons, Tiro display type and Anek Devanagari interface type

This release is an interaction prototype. It does not yet include accounts, cloud persistence, payments, inventory, appointments or atelier operations.

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

The app avoids treating regional techniques as interchangeable visual filters. Selecting a loom lineage changes its compatible fabrics, motifs, borders, estimated price and making time.

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

Prices, timelines and option names in the prototype are product assumptions for WMI and require validation with the actual artisan network before commercial release.

## Fonts and image note

Tiro Devanagari Hindi and Anek Devanagari are bundled under the SIL Open Font License; license texts are in `assets/fonts/`. Campaign photographs are WMI concept assets and must not be represented as photographs of actual commissioned products or artisans.
