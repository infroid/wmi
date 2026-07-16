import { FormEvent, useEffect, useMemo, useState } from 'react'
import {
  ArrowDownRight,
  ArrowRight,
  ChevronLeft,
  ChevronRight,
  Menu,
  Sparkles,
  X,
} from 'lucide-react'

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

type GenerationGroup = {
  id: 'young' | 'garima'
  number: string
  label: string
  devanagari: string
  title: string
  description: string
  images: CampaignImage[]
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
    src: 'boys/virasat-waistcoat.webp',
    alt: 'Young boy in an ivory kurta and textured waistcoat',
    label: 'Virasat · Boys',
    note: 'A modern heirloom',
  },
  {
    src: 'girls/kriti-ivory-waistcoat.webp',
    alt: 'Young girl in an ivory kurta and embroidered waistcoat',
    label: 'Kriti · Girls',
    note: 'Craft in light layers',
  },
  {
    src: 'boys/kriti-embroidered-kurta.webp',
    alt: 'Young boy in a finely embroidered ivory kurta',
    label: 'Kriti · Boys',
    note: 'Detail with ease',
  },
  {
    src: 'girls/sahaj-sage-set.webp',
    alt: 'Young girl in a soft sage kurta set',
    label: 'Sahaj · Girls',
    note: 'Made to move',
  },
  {
    src: 'boys/sahaj-sage-kurta.webp',
    alt: 'Young boy in a relaxed sage kurta and ivory trousers',
    label: 'Sahaj · Boys',
    note: 'Comfort, considered',
  },
  {
    src: 'girls/sahaj-blue-set.webp',
    alt: 'Young girl walking in a pale blue kurta set',
    label: 'Sahaj · Girls',
    note: 'Everyday colour',
  },
  {
    src: 'boys/sahaj-blue-kurta.webp',
    alt: 'Young boy in a pale blue kurta beside the water',
    label: 'Sahaj · Boys',
    note: 'For days in motion',
  },
]

const matureCampaign: CampaignImage[] = [
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
  {
    src: 'mature-women/virasat.webp',
    alt: 'Mature woman in a deep lac silk sari',
    label: 'Virasat · Women',
    note: 'Ceremonial silk',
  },
  {
    src: 'mature-men/virasat.webp',
    alt: 'Mature man in an ornate ivory sherwani with a deep lac shawl',
    label: 'Virasat · Men',
    note: 'Heirloom tailoring',
  },
  {
    src: 'mature-women/kriti.webp',
    alt: 'Mature woman in a soft sage embroidered kurta set',
    label: 'Kriti · Women',
    note: 'A softer signature',
  },
  {
    src: 'mature-men/kriti.webp',
    alt: 'Mature man in a pale sage kurta',
    label: 'Kriti · Men',
    note: 'Modern understatement',
  },
  {
    src: 'mature-women/sahaj.webp',
    alt: 'Mature woman in a lightly woven ivory sari',
    label: 'Sahaj · Women',
    note: 'Everyday refinement',
  },
  {
    src: 'mature-men/sahaj.webp',
    alt: 'Mature man in a minimal ivory kurta',
    label: 'Sahaj · Men',
    note: 'Ease with intent',
  },
]

const generationGroups: GenerationGroup[] = [
  {
    id: 'young',
    number: '01',
    label: 'Young India',
    devanagari: 'बाल · उत्सव · सहजता',
    title: 'Made for childhood. Remembered for longer.',
    description:
      'Age-appropriate Indian clothing with room to play, move and become—never miniature adult costume.',
    images: children,
  },
  {
    id: 'garima',
    number: '02',
    label: 'Garima 50+',
    devanagari: 'गरिमा · आत्मविश्वास',
    title: 'Style does not age out. It gathers character.',
    description:
      'A campaign chapter centred on presence, individuality and the confidence of knowing what belongs in your wardrobe.',
    images: matureCampaign,
  },
]

const standards = [
  ['01', 'Made in India, without ambiguity', 'Finished garments are cut, made and finished here—not imported and relabelled with an Indian story.'],
  ['02', 'Origin belongs on the label', 'Place, material and meaningful process should be clear enough for the customer to understand.'],
  ['03', 'Craft must serve a real wardrobe', 'Traditional knowledge is respected through contemporary use, not reduced to surface decoration.'],
  ['04', 'One integrity across every expression', 'Virasat, Kriti and Sahaj differ in rarity, time and handwork—never in honesty or dignity.'],
]

const principles = [
  ['01 · Material', 'Fibre before ornament.', 'Begin with how cloth breathes, drapes, ages and belongs to the climate.'],
  ['02 · Making', 'Place before mythology.', 'Name the region and process. Let real knowledge be more powerful than vague heritage language.'],
  ['03 · Use', 'Life before spectacle.', 'Design Indian clothing people can truly inhabit—at work, at home and in celebration.'],
]

function App() {
  const [menuOpen, setMenuOpen] = useState(false)
  const [activeCollection, setActiveCollection] = useState(0)
  const [activeGender, setActiveGender] = useState(0)
  const [activeGenerationGroup, setActiveGenerationGroup] = useState(0)
  const [activeGeneration, setActiveGeneration] = useState(0)
  const [email, setEmail] = useState('')
  const [joined, setJoined] = useState(false)
  const year = useMemo(() => new Date().getFullYear(), [])

  const collection = collections[activeCollection]
  const collectionImage = collection.images[activeGender]
  const generationGroup = generationGroups[activeGenerationGroup]
  const generationImage = generationGroup.images[activeGeneration]

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

  const chooseGenerationGroup = (index: number) => {
    setActiveGenerationGroup(index)
    setActiveGeneration(0)
  }

  const moveGeneration = (direction: number) => {
    setActiveGeneration((index) =>
      (index + direction + generationGroup.images.length) % generationGroup.images.length,
    )
  }

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
          <button className="menu-toggle" type="button" onClick={() => setMenuOpen(true)} aria-label="Open menu" aria-expanded={menuOpen}>
            <Menu size={22} strokeWidth={1.5} />
          </button>
        </div>
      </header>

      <main id="main">
        <section className="hero" aria-labelledby="hero-title">
          <picture className="hero-picture">
            <source media="(max-width: 720px)" srcSet={asset('women/virasat.webp')} />
            <img src={asset('women/hero-wide.webp')} alt="Woman in an ivory and deep lac sari in a warm heritage interior" width="1672" height="941" fetchPriority="high" />
          </picture>
          <div className="hero-shade" />
          <div className="hero-content">
            <p className="eyebrow eyebrow-light">A modern Indian house of clothing</p>
            <h1 id="hero-title">Wear your roots.<span>Wear My India.</span></h1>
            <p className="hero-copy">Indian in substance, global in expression. A wardrobe of provenance, quiet beauty and uncompromised making.</p>
            <div className="hero-actions">
              <a className="button button-gold" href="#collections">Discover the house <ArrowDownRight size={18} /></a>
              <a className="underlined-link underlined-link-light" href="#standard">Read our promise <ArrowRight size={17} /></a>
            </div>
          </div>
          <div className="hero-folio"><span>Founding campaign · Chapter 01</span><span>India, worn with intent</span></div>
        </section>

        <section className="house" id="house">
          <figure className="house-image">
            <img src={asset('men/hero-wide.webp')} alt="Man in an ivory kurta with a deep lac stole in a heritage room" width="1672" height="941" loading="lazy" decoding="async" />
            <figcaption>The modern Indian wardrobe · Men</figcaption>
          </figure>
          <div className="house-copy">
            <p className="eyebrow">The house philosophy</p>
            <h2>Not “ethnic wear” for an occasion. An Indian wardrobe for a lifetime.</h2>
            <div className="house-columns">
              <p>Wear My India brings regional knowledge, Indian material culture and modern design into one house—made for celebrations, ordinary mornings and every meaningful moment between them.</p>
              <p>We believe access and aspiration can coexist. The handwork may change. The rarity may change. The integrity never does.</p>
            </div>
            <div className="house-mark" aria-hidden="true"><span>WMI</span><i /><strong lang="hi">एक भारत · अनेक शिल्प</strong></div>
          </div>
        </section>

        <section className={`collection-house is-${collection.slug}`} id="collections">
          <div className="collection-intro section-pad">
            <div><p className="eyebrow">Three expressions · One house</p><h2>Find your India.</h2></div>
            <p>A clear collection architecture for every aspiration: heirloom Virasat, signature Kriti and essential Sahaj. Each one proudly designed and made in India.</p>
          </div>

          <div className="collection-tabs" role="tablist" aria-label="Wear My India collections">
            {collections.map((item, index) => (
              <button
                type="button"
                role="tab"
                aria-selected={activeCollection === index}
                aria-controls="collection-panel"
                className={activeCollection === index ? 'is-active' : ''}
                onClick={() => setActiveCollection(index)}
                key={item.slug}
              >
                <span>{item.number}</span><strong>{item.name}</strong><small lang="hi">{item.devanagari}</small>
              </button>
            ))}
          </div>

          <div className="collection-panel" id="collection-panel" role="tabpanel" key={`${collection.slug}-${activeGender}`}>
            <figure className="collection-frame">
              <img src={asset(collectionImage.src)} alt={collectionImage.alt} width="1122" height="1402" loading="eager" decoding="async" />
              <figcaption><span>{collectionImage.label}</span><span>{collectionImage.note}</span></figcaption>
            </figure>

            <div className="collection-copy">
              <span className="collection-number">{collection.number} / 03</span>
              <p className="collection-hindi" lang="hi">{collection.devanagari}</p>
              <h3>{collection.name}</h3>
              <p className="collection-role">{collection.role}</p>
              <strong>{collection.thought}</strong>
              <p className="collection-description">{collection.description}</p>
              <div className="collection-details" aria-label={`${collection.name} qualities`}>
                {collection.details.map((detail) => <span key={detail}>{detail}</span>)}
              </div>

              <div className="look-selector" role="group" aria-label={`${collection.name} campaign audience`}>
                {['Women', 'Men'].map((label, index) => (
                  <button type="button" className={activeGender === index ? 'is-active' : ''} onClick={() => setActiveGender(index)} aria-pressed={activeGender === index} key={label}>
                    <span>0{index + 1}</span>{label}
                  </button>
                ))}
              </div>
              <div className="carousel-actions">
                <button type="button" onClick={() => setActiveGender((activeGender + 1) % 2)} aria-label="Previous collection look"><ChevronLeft /></button>
                <span>{activeGender + 1} / 2</span>
                <button type="button" onClick={() => setActiveGender((activeGender + 1) % 2)} aria-label="Next collection look"><ChevronRight /></button>
              </div>
            </div>
          </div>
        </section>

        <section className="generations" id="generations">
          <div className="generations-heading section-pad">
            <div><p className="eyebrow eyebrow-light">One house · Every generation</p><h2>Clothing for a life in motion.</h2></div>
            <p>Childhood ease and the authority of experience belong in the same Indian wardrobe—represented with dignity, character and room to be entirely oneself.</p>
          </div>

          <div className="generation-groups" role="tablist" aria-label="Generation campaigns">
            {generationGroups.map((group, index) => (
              <button type="button" role="tab" aria-selected={activeGenerationGroup === index} className={activeGenerationGroup === index ? 'is-active' : ''} onClick={() => chooseGenerationGroup(index)} key={group.id}>
                <span>{group.number}</span>{group.label}<small lang="hi">{group.devanagari}</small>
              </button>
            ))}
          </div>

          <div className="generation-panel" role="tabpanel" key={`${generationGroup.id}-${activeGeneration}`}>
            <figure className="generation-frame">
              <img src={asset(generationImage.src)} alt={generationImage.alt} width="1122" height="1402" loading="lazy" decoding="async" />
              <figcaption><span>{generationImage.label}</span><span>{generationImage.note}</span></figcaption>
            </figure>
            <div className="generation-copy">
              <p lang="hi">{generationGroup.devanagari}</p>
              <h3>{generationGroup.title}</h3>
              <p>{generationGroup.description}</p>
              <div className="generation-current"><span>{generationImage.label}</span><strong>{generationImage.note}</strong></div>
              <div className="carousel-actions carousel-actions-light">
                <button type="button" onClick={() => moveGeneration(-1)} aria-label="Previous generation look"><ChevronLeft /></button>
                <span>{String(activeGeneration + 1).padStart(2, '0')} / {String(generationGroup.images.length).padStart(2, '0')}</span>
                <button type="button" onClick={() => moveGeneration(1)} aria-label="Next generation look"><ChevronRight /></button>
              </div>
              <div className="generation-dots" aria-label="Choose a campaign look">
                {generationGroup.images.map((image, index) => (
                  <button type="button" className={activeGeneration === index ? 'is-active' : ''} onClick={() => setActiveGeneration(index)} aria-label={`Show ${image.label}: ${image.note}`} aria-pressed={activeGeneration === index} key={image.src}><span /></button>
                ))}
              </div>
            </div>
          </div>
        </section>

        <section className="standard section-pad" id="standard">
          <div className="standard-intro">
            <p className="eyebrow eyebrow-light">The WMI standard</p>
            <h2>Made here must mean made here.</h2>
            <p>Indian identity is not a styling layer. It is a chain of material, skill, decision and accountability that the customer should be able to see.</p>
            <div className="origin-seal" aria-hidden="true"><span>Proudly</span><strong lang="hi">भारत</strong><span>Made in India</span></div>
          </div>
          <div className="standard-list">
            {standards.map(([number, title, description]) => <article key={number}><span>{number}</span><h3>{title}</h3><p>{description}</p></article>)}
          </div>
          <div className="principle-grid">
            {principles.map(([number, title, description]) => <article key={number}><span>{number}</span><h3>{title}</h3><p>{description}</p></article>)}
          </div>
        </section>

        <section className="founding-circle" id="founding-circle">
          <div><p className="eyebrow eyebrow-light">The founding circle</p><h2>Enter the house<br />before the doors open.</h2></div>
          <div className="circle-action">
            <p>Receive collection previews, craft notes and founding access. Thoughtful letters, sent with restraint.</p>
            {joined ? (
              <div className="join-success" role="status"><Sparkles size={19} /> You are part of the founding circle.</div>
            ) : (
              <form onSubmit={joinCircle}>
                <label className="sr-only" htmlFor="founding-email">Email address</label>
                <input id="founding-email" type="email" value={email} onChange={(event) => setEmail(event.target.value)} placeholder="Your email address" autoComplete="email" required />
                <button type="submit">Join the circle <ArrowRight size={17} /></button>
              </form>
            )}
          </div>
        </section>
      </main>

      <footer className="footer">
        <div className="footer-wordmark"><strong>Wear My India</strong><span lang="hi">वेयर माय इंडिया</span><p>Wear your roots.</p></div>
        <div className="footer-nav">
          <div><span>The house</span><a href="#house">Our philosophy</a><a href="#standard">Our standard</a></div>
          <div><span>Collections</span><a href="#collections">The collection book</a><a href="#collections">Virasat · Kriti · Sahaj</a></div>
          <div><span>For everyone</span><a href="#generations">Young India</a><a href="#generations">Garima 50+</a></div>
        </div>
        <div className="footer-base"><span>© {year} Wear My India · An Infroid venture</span><span>Campaign visuals are concept imagery for the founding collection.</span></div>
      </footer>

      {menuOpen && (
        <div className="mobile-menu" role="dialog" aria-modal="true" aria-label="Site menu">
          <div className="mobile-menu-head">
            <a className="wordmark wordmark-light" href="#top" onClick={closeMenu}><span className="wordmark-name">Wear My India</span><span className="wordmark-hindi" lang="hi">वेयर माय इंडिया</span></a>
            <button type="button" onClick={closeMenu} aria-label="Close menu"><X size={24} strokeWidth={1.4} /></button>
          </div>
          <nav aria-label="Mobile navigation">
            {[
              ['01', 'The house', '#house'],
              ['02', 'Collections', '#collections'],
              ['03', 'Generations', '#generations'],
              ['04', 'Our standard', '#standard'],
            ].map(([number, label, href]) => <a href={href} key={href} onClick={closeMenu}><span>{number}</span>{label}<ArrowDownRight size={25} /></a>)}
          </nav>
          <a className="button button-gold" href="#founding-circle" onClick={closeMenu}>Join the founding circle <ArrowRight size={18} /></a>
        </div>
      )}
    </div>
  )
}

export default App
