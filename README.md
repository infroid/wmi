# Wear My India

Brand website for [WearMyIndia.com](https://wearmyindia.com/) — a modern Indian house of clothing built around provenance, craft and access.

> Wear your roots. Wear My India.

## Current release

The site is a mobile-first brand and app landing experience featuring:

- all 24 approved production-candidate campaign images, presented without forced portrait crops;
- a seven-chapter, viewport-sized editorial experience with snap-aligned scrolling on mobile and desktop;
- a prominent Wear My India app proposition with an interactive phone concept and three product-benefit states;
- a consolidated Virasat, Kriti and Sahaj collection carousel with Women/Men controls;
- a single Every Generation carousel for girls, boys and Garima 50+ audiences;
- collection tabs that remain fully inside the viewport down to the narrowest supported phone width;
- a tuned earth-lacquer, kora, aged-kansa, monsoon-neel and neem colour system, with neel reserved for the mobile product world;
- Eczar, Tiro and Anek Devanagari typography;
- the WMI Made-in-India standard;
- accessible navigation, keyboard behaviour and reduced-motion support;
- official App Store and Google Play badge artwork with direct store actions, plus a social sharing image;
- optimized WebP assets totalling under 4 MB.

The campaign images are AI-created concept assets. They establish the desired art direction but must not be presented as photographs of actual WMI products, artisans, locations or suppliers.

Brand strategy is documented in [`BRAND.md`](BRAND.md). Photography and commercial replacement standards are documented in [`IMAGE_REQUIREMENTS.md`](IMAGE_REQUIREMENTS.md).

## Development

```bash
npm ci
npm run dev
```

In the Codex desktop app, use the **Preview WMI** project action. It starts the
site at [http://localhost:5173](http://localhost:5173) for the built-in browser.
The shared action is defined in `.codex/environments/environment.toml`, so it is
also available in Codex worktrees after the automatic dependency setup runs.

Validation and production build:

```bash
npm run lint
npm run build
```

Vite writes the deployable site to `web/` with relative asset paths, so the same artifact works on the GitHub Pages project URL and the custom domain.

## Deployment

`.github/workflows/deploy-pages.yml` runs for every push to `master`. It installs locked dependencies, lints, builds, verifies the 24 campaign assets and social image, then publishes `web/` through the official GitHub Pages actions.
