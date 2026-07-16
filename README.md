# Wear My India (WMI)

Brand website for **WearMyIndia.com** — a contemporary Indian clothing house built around origin, craft and access.

> Wear your roots. Wear My India.

## Current release

The site now uses a premium editorial system rather than illustrative SVG campaign artwork:

- art-directed desktop and mobile hero photography,
- **Virasat**, **Kriti** and **Sahaj** collection worlds,
- an inclusive wardrobe architecture spanning generations,
- a Made-in-India sourcing manifesto,
- Indian-rooted display typography with restrained modern interface type,
- responsive navigation and collection drawer,
- GitHub Pages output in `web/`.

Collection and audience photography that has not yet passed the image standard is intentionally withheld. Exact casting, crop, lighting, resolution and colour requirements are maintained in [`IMAGE_REQUIREMENTS.md`](IMAGE_REQUIREMENTS.md).

## Development

```bash
npm ci
npm run dev
```

Validation and production build:

```bash
npm run lint
npm run build
```

`npm run build` reconstructs the approved WebP campaign files from checked-in text parts, validates their byte counts and WebP signatures, and writes the deployable site to `web/`.

## GitHub Pages

`.github/workflows/deploy-pages.yml` runs on every push to `master`, installs dependencies, lints, builds, verifies both hero assets, uploads `web/`, and deploys it through the official GitHub Pages actions.

## Image status

The current hero photographs are approved concept campaign assets for the brand prototype. They demonstrate the intended palette and editorial tone, but must not be represented as photographs of actual WMI products, artisans or manufacturing partners. Commercial catalogue and craft imagery must be commissioned from the real collection and supply chain.
