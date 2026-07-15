# Wear My India (WMI)

Brand website for **WearMyIndia.com** — a contemporary Indian clothing house built around origin, craft and access.

> Wear your roots. Wear My India.

## Current website

The responsive React and TypeScript experience includes:

- purpose-built desktop and mobile campaign heroes,
- Virasat, Kriti and Sahaj collection worlds,
- campaign representation for women, men, girls, boys, women 50+ and men 50+,
- a Made-in-India sourcing manifesto,
- brand standards and editorial storytelling,
- accessible navigation and a collection drawer,
- a GitHub Pages build that outputs to `web/`.

## Technology

- React
- TypeScript
- Vite
- Lucide icons
- Responsive CSS without a UI framework

## Development

The optimized WebP campaign assets are reconstructed from the checked-in text parts before development or production builds.

```bash
npm install
npm run dev
```

Validation and production build:

```bash
npm run lint
npm run build
npm run preview
```

The Vite build output is `web/`, which is uploaded by `.github/workflows/deploy-pages.yml` using the official GitHub Pages actions.

## Brand and image documentation

- [`BRAND.md`](BRAND.md) — positioning, collection architecture, palette, typography and voice.
- [`IMAGE_REQUIREMENTS.md`](IMAGE_REQUIREMENTS.md) — approved assets, rejected imagery, exact export standards and remaining production requirements.

## Image status

The current WebP files are approved concept campaign assets for the brand prototype. They demonstrate the intended palette, casting breadth and editorial rhythm, but must not be represented as photographs of actual WMI products, artisans or manufacturing partners. Commercial catalogue and craft imagery must be commissioned from the real collection and supply chain.
