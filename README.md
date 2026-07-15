# Wear My India (WMI)

Brand website for **WearMyIndia.com** — an Indian clothing house built around origin, regional craft and access.

> Wear your roots. Wear My India.

## Brand architecture

- **Virasat (विरासत)** — the heirloom collection: rare textiles, exceptional handwork and limited pieces.
- **Kriti (कृति)** — the signature collection: premium craft-led occasion and everyday clothing.
- **Sahaj (सहज)** — the essentials collection: accessible, well-made Indian staples for frequent wear.

Quality, Indian origin and respect for craft apply to every collection. The tiers differ by rarity, handwork and time—not by the dignity of the product or customer.

## Technology

- React + TypeScript
- Vite
- Responsive custom CSS
- Accessible navigation, dialogs, focus states and reduced-motion support
- Original textile-inspired SVG campaign artwork

## Local development

```bash
npm install
npm run dev
```

## Production build

```bash
npm run build
```

Vite writes the deployable site to **`web/`**. This matches the repository's GitHub Pages workflow.

## GitHub Pages

`.github/workflows/deploy-pages.yml` runs on every push to `master`:

1. Installs Node dependencies.
2. Runs lint and the production build.
3. Verifies `web/index.html`.
4. Uploads `web/` using `actions/upload-pages-artifact`.
5. Deploys it with `actions/deploy-pages`.

Repository Pages source must be set to **GitHub Actions**.

## Product principles

1. No imported finished garments.
2. Clear origin and craft notes.
3. Traditional knowledge adapted for contemporary use.
4. Honest value at every price point.
5. Indian material and regional processes wherever practical.

## Before commercial launch

Replace the illustrative campaign artwork with commissioned WMI photography, connect a real catalog and commerce backend, implement product provenance, and complete trademark and origin verification.
