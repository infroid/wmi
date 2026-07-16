import { FormEvent, useEffect, useMemo, useState } from 'react'
import {
  ArrowDownRight,
  ArrowRight,
  HeartHandshake,
  Leaf,
  Menu,
  Search,
  ShoppingBag,
  Sparkles,
  X,
} from 'lucide-react'

type Collection = {
  name: string
  devanagari: string
  label: string
  line: string
  detail: string
  tone: string
}

const asset = (name: string) => `${import.meta.env.BASE_URL}images/${name}`

const collections: Collection[] = [
  {
    name: 'Virasat',
    devanagari: 'विरासत',
    label: 'The heirloom collection',
    line: 'Rare craft. Generational beauty.',
    detail:
      'Limited pieces, exceptional handwork and textiles selected for the wardrobe you keep, remember and pass on.',
    tone: 'virasat',
  },
  {
    name: 'Kriti',
    devanagari: 'कृति',
    label: 'The signature collection',
    line: 'Considered craft for modern India.',
    detail:
      'Refined occasion and everyday clothing where intelligent design meets honest material and hand-finished detail.',
    tone: 'kriti',
  },
  {
    name: 'Sahaj',
    devanagari: 'सहज',
    label: 'The essentials collection',
    line: 'Indian by nature. Easy by design.',
    detail:
      'Breathable, useful staples for frequent wear—comfortable forms, local materials and enduring construction.',
    tone: 'sahaj',
  },
]

const audiences = [
  ['Women', 'स्त्री', 'Everyday, occasion and heirloom'],
  ['Men', 'पुरुष', 'Tailoring, layers and ease'],
  ['Girls', 'बालिका', 'Age-appropriate craft and comfort'],
  ['Boys', 'बालक', 'Festive and everyday forms'],
  ['Women 50+', 'गरिमा', 'Grace, authority and personal style'],
  ['Men 50+', 'सहजता', 'Texture, confidence and ease'],
]

const regions = ['Banaras', 'Kutch', 'Chanderi', 'Kanchipuram', 'Kashmir', 'Lucknow', 'Maheshwar', 'Assam']

function App() {
  const [menuOpen, setMenuOpen] = useState(false)
  const [drawerOpen, setDrawerOpen] = useState(false)
  const [email, setEmail] = useState('')
  const [joined, setJoined] = useState(false)
  const year = useMemo(() => new Date().getFullYear(), [])

  useEffect(() => {
    const close = (event: KeyboardEvent) => {
      if (event.key === 'Escape') {
        setMenuOpen(false)
        setDrawerOpen(false)
      }
    }
    window.addEventListener('keydown', close)
    return () => window.removeEventListener('keydown', close)
  }, [])

  useEffect(() => {
    document.body.style.overflow = menuOpen || drawerOpen ? 'hidden' : ''
    return () => {
      document.body.style.overflow = ''
    }
  }, [menuOpen, drawerOpen])

  const join = (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault()
    if (!email.trim()) return
    setJoined(true)
  }

  return (
    <div className="site-shell">
      <a className="skip-link" href="#main">Skip to content</a>

      <div className="announcement">
        <span>Born in India. Made by Indian hands.</span>
        <a href="#standard">Read our promise <ArrowRight size={14} aria-hidden="true" /></a>
      </div>

      <header className="site-header">
        <a className="brand" href="#top" aria-label="Wear My India home">
          <span className="brand-monogram" aria-hidden="true">WMI</span>
          <span className="brand-name">
            <strong>Wear My India</strong>
            <small lang="hi">वेयर माय इंडिया</small>
          </span>
        </a>

        <nav className="desktop-nav" aria-label="Primary navigation">
          <a href="#collections">Collections</a>
          <a href="#for-everyone">For every India</a>
          <a href="#craft">Our craft</a>
          <a href="#journal">Journal</a>
        </nav>

        <div className="header-actions">
          <button className="icon-button desktop-only" type="button" aria-label="Search"><Search size={19} /></button>
          <button className="icon-button desktop-only" type="button" aria-label="Shopping bag">
            <ShoppingBag size={19} /><span className="bag-count">0</span>
          </button>
          <button className="menu-button" type="button" onClick={() => setMenuOpen(true)} aria-label="Open menu">
            <Menu size={22} />
          </button>
        </div>
      </header>

      <main id="main">
        <section className="hero" id="top">
          <picture className="hero-picture">
            <source media="(max-width: 720px)" srcSet={asset('hero-mobile.webp')} />
            <img
              className="hero-image"
              src={asset('hero-desktop.webp')}
              alt="Woman in an ivory and maroon sari in a carved Indian heritage interior"
              fetchPriority="high"
            />
          </picture>
          <div className="hero-overlay" />
          <div className="hero-content">
            <p className="eyebrow light">A modern Indian house of clothing</p>
            <h1>Wear your roots.<span>Wear My India.</span></h1>
            <p className="hero-intro">
              A refined Indian wardrobe rooted in provenance—traditional in knowledge,
              contemporary in expression and made entirely in India.
            </p>
            <div className="hero-actions">
              <button className="button button-primary" type="button" onClick={() => setDrawerOpen(true)}>
                See our collection <ArrowDownRight size={18} />
              </button>
              <a className="text-link light" href="#standard">Discover our standard <ArrowRight size={17} /></a>
            </div>
          </div>
          <div className="hero-caption">
            <span>India, worn with intent</span><span aria-hidden="true" /><a href="#collections">Scroll to discover</a>
          </div>
        </section>

        <section className="region-marquee" aria-label="Regional craft traditions">
          <div className="marquee-track">
            {[...regions, ...regions].map((region, index) => (
              <span key={`${region}-${index}`}>{region}<i aria-hidden="true">✦</i></span>
            ))}
          </div>
        </section>

        <section className="manifesto section-pad">
          <div className="manifesto-index"><span>One country</span><span>Countless traditions</span></div>
          <div className="manifesto-copy">
            <p className="eyebrow">A house with a memory</p>
            <h2>Every thread remembers where it came from.</h2>
            <p>
              Wear My India brings regional knowledge, artisan skill and Indian material culture
              into one contemporary house. Not costume. Not trend theatre. Clothing designed to
              feel timeless, rooted and quietly luxurious in real Indian lives.
            </p>
          </div>
        </section>

        <section className="collections section-pad" id="collections">
          <div className="section-heading">
            <div><p className="eyebrow">Three expressions. One standard.</p><h2>Find your India.</h2></div>
            <p>Rarity, detail and time change across the collections. Origin, integrity and respect for craft do not.</p>
          </div>

          <div className="collection-grid">
            {collections.map((collection, index) => (
              <article className={`collection-card ${collection.tone}`} id={collection.name.toLowerCase()} key={collection.name}>
                <span className="collection-number">0{index + 1}</span>
                <div className="collection-motif" aria-hidden="true" />
                <div className="collection-copy">
                  <p lang="hi">{collection.devanagari}</p>
                  <h3>{collection.name}</h3>
                  <span>{collection.label}</span>
                  <strong>{collection.line}</strong>
                  <small>{collection.detail}</small>
                  <a href="#first-circle">Enter {collection.name} <ArrowRight size={16} /></a>
                </div>
              </article>
            ))}
          </div>
          <p className="production-note">Collection campaign photography is being art-directed to the standards documented in IMAGE_REQUIREMENTS.md.</p>
        </section>

        <section className="audience section-pad" id="for-everyone">
          <div className="audience-intro">
            <p className="eyebrow light">For every India</p>
            <h2>One house. Every generation.</h2>
            <p>Indian clothing should not belong to one age, one price or one moment. WMI is being built for the full Indian wardrobe.</p>
          </div>
          <div className="audience-grid">
            {audiences.map(([title, hindi, subtitle], index) => (
              <article key={title}>
                <span>0{index + 1}</span>
                <p lang="hi">{hindi}</p>
                <h3>{title}</h3>
                <small>{subtitle}</small>
              </article>
            ))}
          </div>
        </section>

        <section className="craft" id="craft">
          <div className="craft-art" aria-hidden="true">
            <div className="craft-seal"><span>Made</span><strong lang="hi">भारत</strong><span>in India</span></div>
          </div>
          <div className="craft-copy">
            <p className="eyebrow light">The standard behind every label</p>
            <h2>Made here means made here.</h2>
            <p>
              We reject imported finished garments dressed up as Indian. The ambition is a transparent chain—from fibre and fabric to dyeing, tailoring, embroidery and finishing—rooted in Indian capability.
            </p>
            <div className="principles">
              <div><Leaf /><h3>Local material first</h3><p>Indian fibres, fabrics and regional processes wherever practical.</p></div>
              <div><HeartHandshake /><h3>Human craft valued</h3><p>Skill, time and attribution treated as value—not hidden cost.</p></div>
              <div><Sparkles /><h3>Built to be kept</h3><p>Construction and design intended to outlast a single season.</p></div>
            </div>
            <a className="button button-ivory" href="#standard">Read the WMI standard <ArrowRight size={18} /></a>
          </div>
        </section>

        <section className="standard section-pad" id="standard">
          <div className="standard-title">
            <p className="eyebrow">Our non-negotiables</p>
            <h2>Indian in substance, not merely in appearance.</h2>
          </div>
          <div className="standard-list">
            {[
              ['01', 'No imported finished garments', 'Products are cut, made and finished in India.'],
              ['02', 'Clear origin and craft notes', 'Know where a piece comes from and what makes it distinct.'],
              ['03', 'Traditional knowledge, contemporary use', 'Heritage respected without freezing it in the past.'],
              ['04', 'Honest value across every collection', 'Every piece must justify its material, work and price.'],
            ].map(([number, title, copy]) => (
              <article key={number}><span>{number}</span><h3>{title}</h3><p>{copy}</p></article>
            ))}
          </div>
        </section>

        <section className="journal section-pad" id="journal">
          <div className="journal-lead">
            <p className="eyebrow">The WMI journal</p>
            <h2>Know what you wear.</h2>
            <p>Stories of cloth, place, process and people—written to make Indian craft legible without reducing it to decoration.</p>
            <a className="text-link" href="#first-circle">Enter the journal <ArrowRight size={17} /></a>
          </div>
          <div className="journal-cards">
            <article><span>Craft atlas · 8 min</span><h3>Why the same sari is never just the same sari</h3></article>
            <article><span>People · 5 min</span><h3>The hands behind the finish</h3></article>
            <article><span>Care · 4 min</span><h3>Keep silk, cotton and zari beautiful for longer</h3></article>
          </div>
        </section>

        <section className="newsletter" id="first-circle">
          <div><p className="eyebrow light">The first circle</p><h2>Be first to enter Wear My India.</h2><p>Collection previews, craft stories and founding access—sent with restraint.</p></div>
          {joined ? (
            <div className="success" role="status"><Sparkles size={20} />You are on the founding list.</div>
          ) : (
            <form onSubmit={join}>
              <label className="sr-only" htmlFor="email">Email address</label>
              <input id="email" type="email" value={email} onChange={(event) => setEmail(event.target.value)} placeholder="Your email address" required />
              <button type="submit">Join the circle <ArrowRight size={17} /></button>
            </form>
          )}
        </section>
      </main>

      <footer className="footer">
        <div className="footer-brand"><strong>Wear My India</strong><span lang="hi">वेयर माय इंडिया</span><p>An Indian clothing house built around origin, craft and access.</p></div>
        <div className="footer-links">
          <div><h3>Explore</h3><a href="#collections">Collections</a><a href="#craft">Craft</a><a href="#journal">Journal</a></div>
          <div><h3>Information</h3><a href="#standard">Our promise</a><a href="#first-circle">Founding circle</a><a href="#top">Care guide</a></div>
          <div><h3>Follow</h3><a href="#top">Instagram</a><a href="#top">Pinterest</a><a href="#top">YouTube</a></div>
        </div>
        <div className="footer-base"><span>© {year} Wear My India. An Infroid venture.</span><span>Wear your roots.</span></div>
      </footer>

      <div className={`mobile-menu ${menuOpen ? 'is-open' : ''}`} aria-hidden={!menuOpen}>
        <div><span>Menu</span><button type="button" onClick={() => setMenuOpen(false)} aria-label="Close menu"><X size={24} /></button></div>
        <nav>
          {[['Collections', '#collections'], ['For every India', '#for-everyone'], ['Our craft', '#craft'], ['Journal', '#journal']].map(([label, href], index) => (
            <a key={label} href={href} onClick={() => setMenuOpen(false)}><span>0{index + 1}</span>{label}<ArrowDownRight size={24} /></a>
          ))}
        </nav>
        <p>Wear your roots. Wear My India.</p>
      </div>

      <div className={`drawer ${drawerOpen ? 'is-open' : ''}`} aria-hidden={!drawerOpen}>
        <button className="drawer-scrim" type="button" onClick={() => setDrawerOpen(false)} aria-label="Close collection drawer" />
        <aside role="dialog" aria-modal="true" aria-label="Explore collections">
          <div className="drawer-head"><div><p className="eyebrow">Choose your expression</p><h2>Three ways to wear India.</h2></div><button type="button" onClick={() => setDrawerOpen(false)} aria-label="Close"><X size={22} /></button></div>
          {collections.map((collection, index) => (
            <a key={collection.name} href={`#${collection.name.toLowerCase()}`} onClick={() => setDrawerOpen(false)}>
              <span>0{index + 1}</span><div><small lang="hi">{collection.devanagari}</small><h3>{collection.name}</h3><p>{collection.label}</p></div><ArrowRight size={20} />
            </a>
          ))}
          <p className="drawer-note">Every collection is designed and made in India. The difference is rarity, handwork and time—not integrity.</p>
        </aside>
      </div>
    </div>
  )
}

export default App
