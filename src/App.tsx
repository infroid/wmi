import { FormEvent, useEffect, useMemo, useState } from 'react'
import { ArrowDownRight, ArrowRight, Menu, Sparkles, X } from 'lucide-react'

type CampaignImage = {
  src: string
  alt: string
  label: string
  note: string
}

type Collection = {
  slug: 'virasat' | 'kriti' | 'sahaj'
  number: string
  devanagari: string
  name: string
  role: string
  thought: string
  description: string
  details: string[]
  images: [CampaignImage, CampaignImage]
}

const asset = (path: string) => `${import.meta.env.BASE_URL}images/campaign/${path}`

const collections: Collection[] = [
  {
    slug: 'virasat',
    number: '01',
    devanagari: 'विरासत',
    name: 'Virasat',
    role: 'The heirloom expression',
    thought: 'What we keep.',
    description:
      'Rare textiles, exacting handwork and limited pieces made for ceremonies, memory and the wardrobes that travel through generations.',
    details: ['Exceptional material', 'Intensive handwork', 'Limited making'],
    images: [
      {
        src: 'women/virasat.webp',
        alt: 'Woman in an ivory and deep lac heirloom ensemble',
        label: 'Virasat · Women',
        note: 'Silk, zari, handwork',
      },
      {
        src: 'men/virasat.webp',
        alt: 'Man in an ivory ceremonial sherwani with a deep lac shawl',
        label: 'Virasat · Men',
        note: 'Ceremonial tailoring',
      },
    ],
  },
  {
    slug: 'kriti',
    number: '02',
    devanagari: 'कृति',
    name: 'Kriti',
    role: 'The signature expression',
    thought: 'What we create.',
    description:
      'A considered Indian wardrobe where regional knowledge meets modern proportion, precise detail and the rhythm of life today.',
    details: ['Refined material', 'Considered detail', 'Modern versatility'],
    images: [
      {
        src: 'women/kriti.webp',
        alt: 'Woman in an ivory kurta with a deep lac woven stole',
        label: 'Kriti · Women',
        note: 'Quiet occasion dressing',
      },
      {
        src: 'men/kriti.webp',
        alt: 'Man in a finely worked ivory kurta with a deep lac stole',
        label: 'Kriti · Men',
        note: 'Contemporary Indian form',
      },
    ],
  },
  {
    slug: 'sahaj',
    number: '03',
    devanagari: 'सहज',
    name: 'Sahaj',
    role: 'The essential expression',
    thought: 'What we live in.',
    description:
      'Natural cloth, effortless silhouettes and useful pieces made to bring an Indian point of view into the everyday wardrobe.',
    details: ['Breathable cloth', 'Enduring construction', 'Honest value'],
    images: [
      {
        src: 'women/sahaj.webp',
        alt: 'Woman in a soft ivory sari in natural courtyard light',
        label: 'Sahaj · Women',
        note: 'Unforced everyday grace',
      },
      {
        src: 'men/sahaj.webp',
        alt: 'Man in an understated ivory kurta and woven wrap',
        label: 'Sahaj · Men',
        note: 'Ease in natural cloth',
      },
    ],
  },
]

const children: CampaignImage[] = [
  {
    src: 'girls/virasat-lehenga.webp',
    alt: 'Young girl in an ivory and lac festive lehenga',
    label: 'Virasat · Girls',
    note: 'Festive, never fussy',
  },
  {
    src: 'girls/kriti-ivory-waistcoat.webp',
    alt: 'Young girl in an ivory kurta and embroidered waistcoat',
    label: 'Kriti · Girls',
    note: 'Craft in light layers',
  },
  {
    src: 'girls/sahaj-sage-set.webp',
    alt: 'Young girl in a soft sage kurta set',
    label: 'Sahaj · Girls',
    note: 'Made to move',
  },
  {
    src: 'girls/sahaj-blue-set.webp',
    alt: 'Young girl walking in a pale blue kurta set',
    label: 'Sahaj · Girls',
    note: 'Everyday colour',
  },
  {
    src: 'boys/virasat-waistcoat.webp',
    alt: 'Young boy in an ivory kurta and textured waistcoat',
    label: 'Virasat · Boys',
    note: 'A modern heirloom',
  },
  {
    src: 'boys/kriti-embroidered-kurta.webp',
    alt: 'Young boy in a finely embroidered ivory kurta',
    label: 'Kriti · Boys',
    note: 'Detail with ease',
  },
  {
    src: 'boys/sahaj-sage-kurta.webp',
    alt: 'Young boy in a relaxed sage kurta and ivory trousers',
    label: 'Sahaj · Boys',
    note: 'Comfort, considered',
  },
  {
    src: 'boys/sahaj-blue-kurta.webp',
    alt: 'Young boy in a pale blue kurta beside the water',
    label: 'Sahaj · Boys',
    note: 'For days in motion',
  },
]

const matureLeads: CampaignImage[] = [
  {
    src: 'mature-women/hero.webp',
    alt: 'Mature woman in an ivory sari with a deep lac border',
    label: 'Garima · Women',
    note: 'Presence needs no permission',
  },
  {
    src: 'mature-men/hero.webp',
    alt: 'Mature man in an ivory kurta with a deep lac shawl',
    label: 'Garima · Men',
    note: 'Confidence, naturally worn',
  },
]

const matureEdit: CampaignImage[] = [
  {
    src: 'mature-women/virasat.webp',
    alt: 'Mature woman in a deep lac silk sari',
    label: 'Virasat · Women',
    note: 'Ceremonial silk',
  },
  {
    src: 'mature-women/kriti.webp',
    alt: 'Mature woman in a soft sage embroidered kurta set',
    label: 'Kriti · Women',
    note: 'A softer signature',
  },
  {
    src: 'mature-women/sahaj.webp',
    alt: 'Mature woman in a lightly woven ivory sari',
    label: 'Sahaj · Women',
    note: 'Everyday refinement',
  },
  {
    src: 'mature-men/virasat.webp',
    alt: 'Mature man in an ornate ivory sherwani with a deep lac shawl',
    label: 'Virasat · Men',
    note: 'Heirloom tailoring',
  },
  {
    src: 'mature-men/kriti.webp',
    alt: 'Mature man in a pale sage kurta',
    label: 'Kriti · Men',
    note: 'Modern understatement',
  },
  {
    src: 'mature-men/sahaj.webp',
    alt: 'Mature man in a minimal ivory kurta',
    label: 'Sahaj · Men',
    note: 'Ease with intent',
  },
]

const standards = [
  ['01', 'Made in India, without ambiguity', 'Finished garments are cut, made and finished here—not imported and relabelled with an Indian story.'],
  ['02', 'Origin belongs on the label', 'Place, material and meaningful process should be clear enough for the customer to understand.'],
  ['03', 'Craft must serve a real wardrobe', 'Traditional knowledge is respected through contemporary use, not reduced to surface decoration.'],
  ['04', 'One integrity across every expression', 'Virasat, Kriti and Sahaj differ in rarity, time and handwork—never in honesty or dignity.'],
]

function App() {
  const [menuOpen, setMenuOpen] = useState(false)
  const [email, setEmail] = useState('')
  const [joined, setJoined] = useState(false)
  const year = useMemo(() => new Date().getFullYear(), [])

  useEffect(() => {
    const closeMenu = (event: KeyboardEvent) => {
      if (event.key === 'Escape') setMenuOpen(false)
    }
    window.addEventListener('keydown', closeMenu)
    return () => window.removeEventListener('keydown', closeMenu)
  }, [])

  useEffect(() => {
    document.body.style.overflow = menuOpen ? 'hidden' : ''
    return () => {
      document.body.style.overflow = ''
    }
  }, [menuOpen])

  const joinCircle = (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault()
    if (!email.trim()) return
    setJoined(true)
  }

  const closeMenu = () => setMenuOpen(false)

  return (
    <div className="site-shell" id="top">
      <a className="skip-link" href="#main">Skip to content</a>

      <div className="announcement">
        <span>A new Indian house is taking form</span>
        <span lang="hi">भारत के लिए · भारत से</span>
      </div>

      <header className="site-header">
        <a className="wordmark" href="#top" aria-label="Wear My India home">
          <span className="wordmark-name">Wear My India</span>
          <span className="wordmark-hindi" lang="hi">वेयर माय इंडिया</span>
        </a>

        <nav className="desktop-nav" aria-label="Primary navigation">
          <a href="#house">The house</a>
          <a href="#collections">Collections</a>
          <a href="#generations">Generations</a>
          <a href="#standard">Our standard</a>
        </nav>

        <div className="header-end">
          <a className="header-cta" href="#founding-circle">Join the founding circle</a>
          <button
            className="menu-toggle"
            type="button"
            onClick={() => setMenuOpen(true)}
            aria-label="Open menu"
            aria-expanded={menuOpen}
          >
            <Menu size={22} strokeWidth={1.5} />
          </button>
        </div>
      </header>

      <main id="main">
        <section className="hero" aria-labelledby="hero-title">
          <picture className="hero-picture">
            <source media="(max-width: 720px)" srcSet={asset('women/virasat.webp')} />
            <img
              src={asset('women/hero-wide.webp')}
              alt="Woman in an ivory and deep lac sari in a warm heritage interior"
              width="1672"
              height="941"
              fetchPriority="high"
            />
          </picture>
          <div className="hero-shade" />
          <div className="hero-content">
            <p className="eyebrow eyebrow-light">A modern Indian house of clothing</p>
            <h1 id="hero-title">Wear your roots.<span>Wear My India.</span></h1>
            <p className="hero-copy">
              Indian in substance, global in expression. A wardrobe of provenance, quiet beauty and uncompromised making.
            </p>
            <div className="hero-actions">
              <a className="button button-gold" href="#collections">Discover the house <ArrowDownRight size={18} /></a>
              <a className="underlined-link underlined-link-light" href="#standard">Read our promise <ArrowRight size={17} /></a>
            </div>
          </div>
          <div className="hero-folio">
            <span>Founding campaign · Chapter 01</span>
            <span>India, worn with intent</span>
          </div>
        </section>

        <section className="manifesto section-pad" id="house">
          <div className="manifesto-mark" aria-hidden="true">
            <span>WMI</span>
            <i />
            <strong lang="hi">एक भारत<br />अनेक शिल्प</strong>
          </div>
          <div className="manifesto-copy">
            <p className="eyebrow">The house philosophy</p>
            <h2>Not “ethnic wear” for an occasion. An Indian wardrobe for a lifetime.</h2>
            <div className="manifesto-columns">
              <p>
                Wear My India brings regional knowledge, Indian material culture and modern design into one house—made for celebrations, ordinary mornings and every meaningful moment between them.
              </p>
              <p>
                We believe access and aspiration can coexist. The handwork may change. The rarity may change. The integrity never does.
              </p>
            </div>
          </div>
        </section>

        <section className="campaign-break" aria-label="Menswear campaign">
          <img
            src={asset('men/hero-wide.webp')}
            alt="Man in an ivory kurta with a deep lac stole in a heritage room"
            width="1672"
            height="941"
            loading="lazy"
            decoding="async"
          />
          <div className="campaign-break-shade" />
          <div className="campaign-break-copy">
            <p className="eyebrow eyebrow-light">For the India you inherit</p>
            <h2>And the India<br />you make your own.</h2>
            <p>Clothing with a memory, designed for life now.</p>
          </div>
          <span className="campaign-break-caption">The modern Indian wardrobe · Men</span>
        </section>

        <section className="collection-house" id="collections">
          <div className="collection-intro section-pad">
            <div>
              <p className="eyebrow">Three expressions · One house</p>
              <h2>Find your India.</h2>
            </div>
            <p>
              A clear collection architecture for every aspiration: heirloom Virasat, signature Kriti and essential Sahaj. Each one proudly designed and made in India.
            </p>
          </div>

          {collections.map((collection) => (
            <article className={`collection-story collection-${collection.slug}`} id={collection.slug} key={collection.slug}>
              <div className="collection-copy">
                <span className="collection-number">{collection.number}</span>
                <p className="collection-hindi" lang="hi">{collection.devanagari}</p>
                <h3>{collection.name}</h3>
                <p className="collection-role">{collection.role}</p>
                <strong>{collection.thought}</strong>
                <p className="collection-description">{collection.description}</p>
                <div className="collection-details" aria-label={`${collection.name} qualities`}>
                  {collection.details.map((detail) => <span key={detail}>{detail}</span>)}
                </div>
                <a className="underlined-link" href="#founding-circle">Preview {collection.name} <ArrowRight size={17} /></a>
              </div>
              <div className="collection-visuals">
                {collection.images.map((image, index) => (
                  <figure className={index === 0 ? 'collection-figure collection-figure-primary' : 'collection-figure'} key={image.src}>
                    <img src={asset(image.src)} alt={image.alt} width="1122" height="1402" loading="lazy" decoding="async" />
                    <figcaption><span>{image.label}</span><span>{image.note}</span></figcaption>
                  </figure>
                ))}
              </div>
            </article>
          ))}
        </section>

        <section className="children-edit section-pad" id="generations">
          <div className="editorial-heading">
            <div>
              <p className="eyebrow">The next inheritance</p>
              <h2>Made for childhood.<br />Remembered for longer.</h2>
            </div>
            <div className="editorial-sidecopy">
              <span lang="hi">बाल · उत्सव · सहजता</span>
              <p>Age-appropriate Indian clothing with room to play, move and become—never miniature adult costume.</p>
            </div>
          </div>
          <div className="children-grid">
            {children.map((image) => (
              <figure className="editorial-card" key={image.src}>
                <div className="editorial-image-wrap">
                  <img src={asset(image.src)} alt={image.alt} width="1122" height="1402" loading="lazy" decoding="async" />
                </div>
                <figcaption><span>{image.label}</span><small>{image.note}</small></figcaption>
              </figure>
            ))}
          </div>
        </section>

        <section className="mature-edit">
          <div className="mature-heading section-pad">
            <p className="eyebrow eyebrow-light">Garima · गरिमा</p>
            <h2>Style does not age out.<br />It gathers character.</h2>
            <p>A campaign chapter centred on presence, individuality and the confidence of knowing what belongs in your wardrobe.</p>
          </div>

          <div className="mature-leads">
            {matureLeads.map((image) => (
              <figure key={image.src}>
                <img src={asset(image.src)} alt={image.alt} width="1122" height="1402" loading="lazy" decoding="async" />
                <figcaption><span>{image.label}</span><strong>{image.note}</strong></figcaption>
              </figure>
            ))}
          </div>

          <div className="mature-grid section-pad">
            {matureEdit.map((image) => (
              <figure className="mature-card" key={image.src}>
                <img src={asset(image.src)} alt={image.alt} width="1122" height="1402" loading="lazy" decoding="async" />
                <figcaption><span>{image.label}</span><small>{image.note}</small></figcaption>
              </figure>
            ))}
          </div>
        </section>

        <section className="standard section-pad" id="standard">
          <div className="standard-intro">
            <p className="eyebrow eyebrow-light">The WMI standard</p>
            <h2>Made here must mean made here.</h2>
            <p>
              Indian identity is not a styling layer. It is a chain of material, skill, decision and accountability that the customer should be able to see.
            </p>
            <div className="origin-seal" aria-hidden="true">
              <span>Proudly</span>
              <strong lang="hi">भारत</strong>
              <span>Made in India</span>
            </div>
          </div>
          <div className="standard-list">
            {standards.map(([number, title, description]) => (
              <article key={number}>
                <span>{number}</span>
                <h3>{title}</h3>
                <p>{description}</p>
              </article>
            ))}
          </div>
        </section>

        <section className="founding-letter section-pad">
          <div className="founding-letter-title">
            <p className="eyebrow">A house with a point of view</p>
            <h2>Quietly Indian.<br />Unmistakably ours.</h2>
          </div>
          <div className="point-grid">
            <article><span>01 · Material</span><h3>Fibre before ornament.</h3><p>Begin with how cloth breathes, drapes, ages and belongs to the climate.</p></article>
            <article><span>02 · Making</span><h3>Place before mythology.</h3><p>Name the region and process. Let real knowledge be more powerful than vague heritage language.</p></article>
            <article><span>03 · Use</span><h3>Life before spectacle.</h3><p>Design Indian clothing people can truly inhabit—at work, at home and in celebration.</p></article>
          </div>
        </section>

        <section className="founding-circle" id="founding-circle">
          <div>
            <p className="eyebrow eyebrow-light">The founding circle</p>
            <h2>Enter the house<br />before the doors open.</h2>
          </div>
          <div className="circle-action">
            <p>Receive collection previews, craft notes and founding access. Thoughtful letters, sent with restraint.</p>
            {joined ? (
              <div className="join-success" role="status"><Sparkles size={19} /> You are part of the founding circle.</div>
            ) : (
              <form onSubmit={joinCircle}>
                <label className="sr-only" htmlFor="founding-email">Email address</label>
                <input
                  id="founding-email"
                  type="email"
                  value={email}
                  onChange={(event) => setEmail(event.target.value)}
                  placeholder="Your email address"
                  autoComplete="email"
                  required
                />
                <button type="submit">Join the circle <ArrowRight size={17} /></button>
              </form>
            )}
          </div>
        </section>
      </main>

      <footer className="footer">
        <div className="footer-wordmark">
          <strong>Wear My India</strong>
          <span lang="hi">वेयर माय इंडिया</span>
          <p>Wear your roots.</p>
        </div>
        <div className="footer-nav">
          <div><span>The house</span><a href="#house">Our philosophy</a><a href="#standard">Our standard</a></div>
          <div><span>Collections</span><a href="#virasat">Virasat</a><a href="#kriti">Kriti</a><a href="#sahaj">Sahaj</a></div>
          <div><span>For everyone</span><a href="#generations">Children</a><a href="#generations">Every generation</a></div>
        </div>
        <div className="footer-base">
          <span>© {year} Wear My India · An Infroid venture</span>
          <span>Campaign visuals are concept imagery for the founding collection.</span>
        </div>
      </footer>

      {menuOpen && (
        <div className="mobile-menu" role="dialog" aria-modal="true" aria-label="Site menu">
          <div className="mobile-menu-head">
            <a className="wordmark wordmark-light" href="#top" onClick={closeMenu}>
              <span className="wordmark-name">Wear My India</span>
              <span className="wordmark-hindi" lang="hi">वेयर माय इंडिया</span>
            </a>
            <button type="button" onClick={closeMenu} aria-label="Close menu"><X size={24} strokeWidth={1.4} /></button>
          </div>
          <nav aria-label="Mobile navigation">
            {[
              ['01', 'The house', '#house'],
              ['02', 'Collections', '#collections'],
              ['03', 'Generations', '#generations'],
              ['04', 'Our standard', '#standard'],
            ].map(([number, label, href]) => (
              <a href={href} key={href} onClick={closeMenu}><span>{number}</span>{label}<ArrowDownRight size={25} /></a>
            ))}
          </nav>
          <a className="button button-gold" href="#founding-circle" onClick={closeMenu}>Join the founding circle <ArrowRight size={18} /></a>
        </div>
      )}
    </div>
  )
}

export default App
