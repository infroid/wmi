import { FormEvent, useEffect, useMemo, useState } from 'react'
import {
  ArrowDownRight,
  ArrowRight,
  ChevronRight,
  HeartHandshake,
  Leaf,
  Menu,
  Search,
  ShoppingBag,
  Sparkles,
  X,
} from 'lucide-react'

type Tier = {
  name: string
  devanagari: string
  descriptor: string
  promise: string
  details: string
  image: string
  href: string
}

const tiers: Tier[] = [
  {
    name: 'Virasat',
    devanagari: 'विरासत',
    descriptor: 'The heirloom collection',
    promise: 'Rare craft. Generational beauty.',
    details:
      'Made-to-order silhouettes, exceptional handwork and regional textiles selected for the pieces you keep, pass on and remember.',
    image: 'images/virasat.svg',
    href: '#virasat',
  },
  {
    name: 'Kriti',
    devanagari: 'कृति',
    descriptor: 'The signature collection',
    promise: 'Considered craft for modern India.',
    details:
      'Distinctive occasion and everyday wear where thoughtful design meets hand-finished detail, honest fabric and lasting construction.',
    image: 'images/kriti.svg',
    href: '#kriti',
  },
  {
    name: 'Sahaj',
    devanagari: 'सहज',
    descriptor: 'The essentials collection',
    promise: 'Indian by nature. Easy by design.',
    details:
      'Well-made, accessible staples designed for frequent wear—local materials, comfortable forms and no compromise on origin.',
    image: 'images/sahaj.svg',
    href: '#sahaj',
  },
]

const regions = [
  'Banaras',
  'Kutch',
  'Chanderi',
  'Kanchipuram',
  'Kashmir',
  'Lucknow',
  'Maheshwar',
  'Assam',
]

function App() {
  const [menuOpen, setMenuOpen] = useState(false)
  const [collectionOpen, setCollectionOpen] = useState(false)
  const [email, setEmail] = useState('')
  const [joined, setJoined] = useState(false)
  const year = useMemo(() => new Date().getFullYear(), [])

  useEffect(() => {
    const onKeyDown = (event: KeyboardEvent) => {
      if (event.key === 'Escape') {
        setMenuOpen(false)
        setCollectionOpen(false)
      }
    }
    window.addEventListener('keydown', onKeyDown)
    return () => window.removeEventListener('keydown', onKeyDown)
  }, [])

  useEffect(() => {
    document.body.style.overflow = menuOpen || collectionOpen ? 'hidden' : ''
    return () => {
      document.body.style.overflow = ''
    }
  }, [menuOpen, collectionOpen])

  const submitEmail = (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault()
    if (!email.trim()) return
    setJoined(true)
  }

  return (
    <div className="site-shell">
      <a className="skip-link" href="#main">
        Skip to content
      </a>

      <div className="announcement">
        <span>Born in India. Made by Indian hands.</span>
        <a href="#promise">
          Read our promise <ArrowRight aria-hidden="true" size={14} />
        </a>
      </div>

      <header className="site-header">
        <a className="brand" href="#top" aria-label="Wear My India home">
          <span className="brand-mark" aria-hidden="true">
            W
          </span>
          <span className="brand-copy">
            <strong>Wear My India</strong>
            <small>वियर माय इंडिया</small>
          </span>
        </a>

        <nav className="desktop-nav" aria-label="Primary navigation">
          <a href="#collections">Collections</a>
          <a href="#craft">Our craft</a>
          <a href="#promise">Our promise</a>
          <a href="#journal">Journal</a>
        </nav>

        <div className="header-actions">
          <button className="icon-button desktop-only" aria-label="Search">
            <Search size={19} />
          </button>
          <button className="icon-button desktop-only" aria-label="Shopping bag">
            <ShoppingBag size={19} />
            <span className="bag-count">0</span>
          </button>
          <button
            className="menu-button"
            type="button"
            onClick={() => setMenuOpen(true)}
            aria-label="Open menu"
          >
            <Menu size={22} />
          </button>
        </div>
      </header>

      <main id="main">
        <section className="hero" id="top">
          <img
            className="hero-image"
            src="images/hero.svg"
            alt="Woman wearing a vivid pink Indian sari"
          />
          <div className="hero-overlay" />
          <div className="hero-grain" aria-hidden="true" />
          <div className="hero-content">
            <p className="eyebrow light">Clothing from the many Indias within India</p>
            <h1>
              Wear your roots.
              <span>Wear My India.</span>
            </h1>
            <p className="hero-intro">
              Indian clothing with provenance—traditional, handcrafted and made
              entirely in India, across three thoughtfully curated worlds.
            </p>
            <div className="hero-actions">
              <button
                className="button button-primary"
                type="button"
                onClick={() => setCollectionOpen(true)}
              >
                Explore the collection
                <ArrowDownRight size={18} />
              </button>
              <a className="text-link light" href="#promise">
                Discover our standard <ArrowRight size={17} />
              </a>
            </div>
          </div>
          <div className="hero-footnote">
            <span>01 / India, worn with intent</span>
            <span className="hero-line" />
            <a href="#collections">Scroll to discover</a>
          </div>
        </section>

        <section className="marquee" aria-label="Brand principles">
          <div className="marquee-track">
            {[...regions, ...regions].map((region, index) => (
              <span key={`${region}-${index}`}>
                {region}
                <i aria-hidden="true">✦</i>
              </span>
            ))}
          </div>
        </section>

        <section className="intro section-pad">
          <div className="intro-kicker">
            <span>One country</span>
            <span>Countless traditions</span>
          </div>
          <div className="intro-copy">
            <p className="eyebrow">A wardrobe with a memory</p>
            <h2>Every thread remembers where it came from.</h2>
            <p>
              Wear My India brings regional knowledge, artisan skill and Indian
              material culture into one contemporary house. Not costume. Not a
              trend. Clothing made to belong in real Indian lives.
            </p>
          </div>
        </section>

        <section className="collections section-pad" id="collections">
          <div className="section-heading">
            <div>
              <p className="eyebrow">Three expressions. One standard.</p>
              <h2>Find your India.</h2>
            </div>
            <p>
              Our collections differ in rarity, detail and price—not in origin,
              integrity or respect for the hands that make them.
            </p>
          </div>

          <div className="tier-grid">
            {tiers.map((tier, index) => (
              <article className="tier-card" id={tier.name.toLowerCase()} key={tier.name}>
                <img src={tier.image} alt="" />
                <div className="tier-shade" />
                <div className="tier-number">0{index + 1}</div>
                <div className="tier-content">
                  <div className="tier-title-row">
                    <div>
                      <span>{tier.devanagari}</span>
                      <h3>{tier.name}</h3>
                    </div>
                    <ArrowDownRight size={29} />
                  </div>
                  <p className="tier-descriptor">{tier.descriptor}</p>
                  <p className="tier-promise">{tier.promise}</p>
                  <p className="tier-details">{tier.details}</p>
                  <a href={tier.href} aria-label={`Explore ${tier.name}`}>
                    Enter {tier.name} <ArrowRight size={16} />
                  </a>
                </div>
              </article>
            ))}
          </div>
        </section>

        <section className="craft" id="craft">
          <div className="craft-visual" aria-hidden="true">
            <div className="sun-disc">
              <span>Made</span>
              <strong>भारत</strong>
              <span>in India</span>
            </div>
            <div className="craft-orbit orbit-one" />
            <div className="craft-orbit orbit-two" />
            <div className="craft-petal petal-one" />
            <div className="craft-petal petal-two" />
            <div className="craft-petal petal-three" />
          </div>
          <div className="craft-copy">
            <p className="eyebrow light">The standard behind every label</p>
            <h2>Made here means made here.</h2>
            <p>
              We reject imported garments dressed up as Indian. Our aim is a
              transparent chain—from fibre and fabric to dyeing, tailoring,
              embroidery and finishing—rooted in Indian capability.
            </p>
            <div className="principles">
              <div>
                <Leaf aria-hidden="true" />
                <h3>Local material first</h3>
                <p>Indian fibres, fabrics and regional processes wherever possible.</p>
              </div>
              <div>
                <HeartHandshake aria-hidden="true" />
                <h3>Human craft valued</h3>
                <p>Skill, time and attribution treated as value—not hidden cost.</p>
              </div>
              <div>
                <Sparkles aria-hidden="true" />
                <h3>Built to be kept</h3>
                <p>Construction and design intended to outlast a single season.</p>
              </div>
            </div>
            <a className="button button-cream" href="#promise">
              Read the sourcing charter <ArrowRight size={18} />
            </a>
          </div>
        </section>

        <section className="promise section-pad" id="promise">
          <div className="promise-side">
            <span className="vertical-label">The WMI promise</span>
            <div className="promise-stamp" aria-hidden="true">
              <span>100%</span>
              <small>Made in India</small>
            </div>
          </div>
          <div className="promise-copy">
            <p className="eyebrow">Our non-negotiables</p>
            <h2>Indian in substance, not merely in appearance.</h2>
            <p className="promise-lead">
              Every product entering Wear My India must earn its place through
              provenance, craft relevance, material honesty and useful beauty.
            </p>
            <div className="promise-list">
              {[
                ['01', 'No imported finished garments', 'Products are cut, made and finished in India.'],
                ['02', 'Clear origin and craft notes', 'Know where a piece comes from and what makes it distinct.'],
                ['03', 'Traditional knowledge, contemporary use', 'Heritage respected without freezing it in the past.'],
                ['04', 'Value across every collection', 'Luxury, signature or essentials—each piece must justify its price.'],
              ].map(([number, title, copy]) => (
                <div className="promise-item" key={number}>
                  <span>{number}</span>
                  <h3>{title}</h3>
                  <p>{copy}</p>
                </div>
              ))}
            </div>
          </div>
        </section>

        <section className="journal section-pad" id="journal">
          <div className="section-heading journal-heading">
            <div>
              <p className="eyebrow">The WMI journal</p>
              <h2>Know what you wear.</h2>
            </div>
            <a className="text-link" href="#journal">
              View all stories <ArrowRight size={17} />
            </a>
          </div>
          <div className="journal-grid">
            <article className="journal-feature">
              <div className="journal-pattern pattern-indigo" aria-hidden="true" />
              <div>
                <span>Craft atlas · 8 min</span>
                <h3>Why the same sari is never just the same sari</h3>
                <p>
                  A guide to region, yarn, weave, drape and the details that turn
                  six yards of cloth into living cultural knowledge.
                </p>
                <a href="#journal">
                  Read the story <ArrowRight size={16} />
                </a>
              </div>
            </article>
            <article className="journal-card">
              <div className="journal-pattern pattern-rust" aria-hidden="true" />
              <span>People · 5 min</span>
              <h3>The hands behind the finish</h3>
              <a href="#journal" aria-label="Read The hands behind the finish">
                <ChevronRight size={20} />
              </a>
            </article>
            <article className="journal-card">
              <div className="journal-pattern pattern-mustard" aria-hidden="true" />
              <span>Care · 4 min</span>
              <h3>Keep silk, cotton and zari beautiful for longer</h3>
              <a href="#journal" aria-label="Read garment care guide">
                <ChevronRight size={20} />
              </a>
            </article>
          </div>
        </section>

        <section className="newsletter">
          <div>
            <p className="eyebrow light">The first circle</p>
            <h2>Be first to enter Wear My India.</h2>
            <p>
              Collection previews, craft stories and founding access—sent with
              restraint.
            </p>
          </div>
          {joined ? (
            <div className="success-message" role="status">
              <Sparkles size={20} />
              <span>You are on the founding list.</span>
            </div>
          ) : (
            <form onSubmit={submitEmail}>
              <label className="sr-only" htmlFor="email">
                Email address
              </label>
              <input
                id="email"
                type="email"
                value={email}
                onChange={(event) => setEmail(event.target.value)}
                placeholder="Your email address"
                required
              />
              <button type="submit" aria-label="Join the founding list">
                Join the circle <ArrowRight size={17} />
              </button>
            </form>
          )}
        </section>
      </main>

      <footer className="footer">
        <div className="footer-brand">
          <a className="brand brand-footer" href="#top">
            <span className="brand-mark" aria-hidden="true">
              W
            </span>
            <span className="brand-copy">
              <strong>Wear My India</strong>
              <small>Wear your roots.</small>
            </span>
          </a>
          <p>
            An Indian clothing house built around origin, craft and access.
          </p>
        </div>
        <div className="footer-links">
          <div>
            <h3>Explore</h3>
            <a href="#collections">Collections</a>
            <a href="#craft">Craft</a>
            <a href="#journal">Journal</a>
          </div>
          <div>
            <h3>Information</h3>
            <a href="#promise">Our promise</a>
            <a href="#footer">Shipping & returns</a>
            <a href="#footer">Care guide</a>
          </div>
          <div>
            <h3>Follow</h3>
            <a href="#footer">Instagram</a>
            <a href="#footer">Pinterest</a>
            <a href="#footer">YouTube</a>
          </div>
        </div>
        <div className="footer-base" id="footer">
          <span>© {year} Wear My India. An Infroid venture.</span>
          <span>Designed with respect for Indian craft.</span>
        </div>
      </footer>

      <div className={`mobile-menu ${menuOpen ? 'is-open' : ''}`} aria-hidden={!menuOpen}>
        <div className="mobile-menu-head">
          <span>Menu</span>
          <button type="button" onClick={() => setMenuOpen(false)} aria-label="Close menu">
            <X size={24} />
          </button>
        </div>
        <nav aria-label="Mobile navigation">
          {[
            ['Collections', '#collections'],
            ['Our craft', '#craft'],
            ['Our promise', '#promise'],
            ['Journal', '#journal'],
          ].map(([label, href], index) => (
            <a key={label} href={href} onClick={() => setMenuOpen(false)}>
              <span>0{index + 1}</span>
              {label}
              <ArrowDownRight size={24} />
            </a>
          ))}
        </nav>
        <p>Wear your roots. Wear My India.</p>
      </div>

      <div
        className={`collection-drawer ${collectionOpen ? 'is-open' : ''}`}
        aria-hidden={!collectionOpen}
      >
        <button
          className="drawer-scrim"
          type="button"
          aria-label="Close collection drawer"
          onClick={() => setCollectionOpen(false)}
        />
        <aside role="dialog" aria-modal="true" aria-label="Explore the collection">
          <div className="drawer-head">
            <div>
              <p className="eyebrow">Choose your expression</p>
              <h2>Three ways to wear India.</h2>
            </div>
            <button type="button" onClick={() => setCollectionOpen(false)} aria-label="Close">
              <X size={22} />
            </button>
          </div>
          <div className="drawer-tiers">
            {tiers.map((tier, index) => (
              <a
                key={tier.name}
                href={`#${tier.name.toLowerCase()}`}
                onClick={() => setCollectionOpen(false)}
              >
                <span>0{index + 1}</span>
                <div>
                  <small>{tier.devanagari}</small>
                  <h3>{tier.name}</h3>
                  <p>{tier.descriptor}</p>
                </div>
                <ArrowRight size={20} />
              </a>
            ))}
          </div>
          <p className="drawer-note">
            Every collection is designed and made in India. The difference is
            rarity, handwork and time—not integrity.
          </p>
        </aside>
      </div>
    </div>
  )
}

export default App
