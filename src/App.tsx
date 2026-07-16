import { useEffect, useMemo, useState } from 'react'
import {
  ArrowDownRight,
  ArrowRight,
  Bookmark,
  ChevronLeft,
  ChevronRight,
  Compass,
  MapPin,
  Menu,
  Search,
  ShieldCheck,
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
const brandAsset = (path: string) => `${import.meta.env.BASE_URL}images/brand/${path}`
const storeAsset = (path: string) => `${import.meta.env.BASE_URL}images/store/${path}`
const prefersReducedMotion = () => window.matchMedia('(prefers-reduced-motion: reduce)').matches
const appStoreUrl = 'https://apps.apple.com/in/search?term=Wear%20My%20India'
const playStoreUrl = 'https://play.google.com/store/search?q=Wear%20My%20India&c=apps'

const heroSlides = [
  {
    id: 'women',
    label: 'Women',
    desktop: 'women/hero-wide.webp',
    mobile: 'women/virasat.webp',
  },
  {
    id: 'men',
    label: 'Men',
    desktop: 'men/hero-wide.webp',
    mobile: 'men/virasat.webp',
  },
] as const

const collections: Collection[] = [
  {
    slug: 'virasat',
    number: '01',
    devanagari: 'विरासत',
    name: 'Virasat',
    role: 'The heirloom expression',
    thought: 'What we keep.',
    description: 'Rare textiles and exacting handwork for pieces meant to be kept.',
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
    description: 'Regional knowledge shaped into a modern, versatile wardrobe.',
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
    description: 'Natural cloth and effortless silhouettes for every day.',
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
    label: 'Ankur',
    devanagari: 'अंकुर · बालपन',
    title: 'Made to move. Made to remember.',
    description: 'Indian clothing with room to play and grow.',
    images: children,
  },
  {
    id: 'garima',
    number: '02',
    label: 'Garima',
    devanagari: 'गरिमा · अनुभव',
    title: 'Style gathers character.',
    description: 'Clothing shaped for presence, ease and self-possession.',
    images: matureCampaign,
  },
]

const standards = [
  ['01', 'Made in India', 'Cut, made and finished here.'],
  ['02', 'Origin, made visible', 'Material, place and process on the label.'],
  ['03', 'Craft for real life', 'Tradition shaped for contemporary use.'],
]

const appFeatures = [
  {
    id: 'discover',
    icon: Compass,
    label: 'Discover',
    title: 'An edited house.',
    description: 'Find Indian clothing through taste, not endless scrolling.',
    screenTitle: 'Made for your India',
    screenNote: 'Today’s edit · Kriti',
    image: 'women/kriti.webp',
    imageAlt: 'Kriti ivory ensemble shown inside the Wear My India app concept',
    origin: 'Signature Indian wardrobe',
  },
  {
    id: 'provenance',
    icon: ShieldCheck,
    label: 'Understand',
    title: 'Origin, made visible.',
    description: 'See the material, place and process behind every piece.',
    screenTitle: 'The story in the cloth',
    screenNote: 'Virasat · Provenance',
    image: 'men/virasat.webp',
    imageAlt: 'Virasat menswear shown inside the Wear My India app concept',
    origin: 'Material · Place · Process',
  },
  {
    id: 'wardrobe',
    icon: Bookmark,
    label: 'Remember',
    title: 'A wardrobe with memory.',
    description: 'Keep pieces, craft notes and pairings in one quiet place.',
    screenTitle: 'Your WMI wardrobe',
    screenNote: 'Saved · Sahaj',
    image: 'women/sahaj.webp',
    imageAlt: 'Sahaj sari shown inside the Wear My India app concept',
    origin: 'Saved for everyday grace',
  },
]

function StoreBadges({ className = '' }: { className?: string }) {
  return (
    <div className={`store-badges ${className}`.trim()}>
      <a href={appStoreUrl} target="_blank" rel="noreferrer" aria-label="Find Wear My India on the App Store">
        <img src={storeAsset('app-store-badge.svg')} alt="Download on the App Store" width="120" height="40" />
      </a>
      <a className="google-play-badge" href={playStoreUrl} target="_blank" rel="noreferrer" aria-label="Find Wear My India on Google Play">
        <img src={storeAsset('google-play-badge.png')} alt="Get it on Google Play" width="646" height="250" />
      </a>
    </div>
  )
}

function App() {
  const [menuOpen, setMenuOpen] = useState(false)
  const [activeHero, setActiveHero] = useState(0)
  const [activeCollection, setActiveCollection] = useState(0)
  const [activeGender, setActiveGender] = useState(0)
  const [activeAppFeature, setActiveAppFeature] = useState(0)
  const [activeGenerationGroup, setActiveGenerationGroup] = useState(0)
  const [activeGeneration, setActiveGeneration] = useState(0)
  const year = useMemo(() => new Date().getFullYear(), [])

  const collection = collections[activeCollection]
  const collectionImage = collection.images[activeGender]
  const appFeature = appFeatures[activeAppFeature]
  const AppFeatureIcon = appFeature.icon
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
    const moveByChapter = (event: KeyboardEvent) => {
      if (event.key !== 'PageDown' && event.key !== 'PageUp') return
      if (event.metaKey || event.ctrlKey || event.altKey) return
      if (event.target instanceof HTMLInputElement || event.target instanceof HTMLTextAreaElement || event.target instanceof HTMLSelectElement) return

      const chapters = Array.from(document.querySelectorAll<HTMLElement>('main > section'))
      if (!chapters.length) return
      const readingLine = window.scrollY + window.innerHeight * 0.35
      const current = chapters.reduce((found, chapter, index) =>
        chapter.offsetTop <= readingLine ? index : found, 0)
      const direction = event.key === 'PageDown' ? 1 : -1
      const next = Math.max(0, Math.min(chapters.length - 1, current + direction))

      event.preventDefault()
      chapters[next].scrollIntoView({
        behavior: prefersReducedMotion() ? 'auto' : 'smooth',
        block: 'start',
      })
    }

    window.addEventListener('keydown', moveByChapter)
    return () => window.removeEventListener('keydown', moveByChapter)
  }, [])

  useEffect(() => {
    let settleTimer = 0
    let wheelUnlockTimer = 0
    let wheelGestureActive = false

    const chapterDestinations = () => {
      const chapters = Array.from(document.querySelectorAll<HTMLElement>('main > section'))
      if (!chapters.length) return []

      const headerHeight = Number.parseFloat(getComputedStyle(document.documentElement).getPropertyValue('--header-h')) || 0
      const destinations = chapters.map((chapter) => Math.max(0, chapter.offsetTop - headerHeight))
      const footer = document.querySelector<HTMLElement>('footer')
      if (footer) destinations.push(Math.max(0, document.documentElement.scrollHeight - window.innerHeight))
      return destinations
    }

    const settleOnChapter = () => {
      const destinations = chapterDestinations()
      if (!destinations.length) return
      const current = window.scrollY
      const nearest = destinations.reduce((best, destination) =>
        Math.abs(destination - current) < Math.abs(best - current) ? destination : best, destinations[0])

      if (Math.abs(nearest - current) < 2) return
      window.scrollTo({
        top: nearest,
        behavior: prefersReducedMotion() ? 'auto' : 'smooth',
      })
    }

    const queueChapterSettle = () => {
      window.clearTimeout(settleTimer)
      settleTimer = window.setTimeout(settleOnChapter, 240)
    }

    const moveByWheel = (event: WheelEvent) => {
      if (event.ctrlKey || Math.abs(event.deltaX) > Math.abs(event.deltaY)) return
      if (event.target instanceof Element && event.target.closest('.mobile-menu')) return

      event.preventDefault()
      window.clearTimeout(wheelUnlockTimer)
      wheelUnlockTimer = window.setTimeout(() => {
        wheelGestureActive = false
      }, 240)

      if (wheelGestureActive || Math.abs(event.deltaY) < 2) return
      const destinations = chapterDestinations()
      if (!destinations.length) return

      wheelGestureActive = true
      const current = window.scrollY
      const currentIndex = destinations.reduce((bestIndex, destination, index) =>
        Math.abs(destination - current) < Math.abs(destinations[bestIndex] - current) ? index : bestIndex, 0)
      const direction = event.deltaY > 0 ? 1 : -1
      const nextIndex = Math.max(0, Math.min(destinations.length - 1, currentIndex + direction))

      window.scrollTo({
        top: destinations[nextIndex],
        behavior: prefersReducedMotion() ? 'auto' : 'smooth',
      })
    }

    window.addEventListener('scroll', queueChapterSettle, { passive: true })
    window.addEventListener('wheel', moveByWheel, { passive: false })
    return () => {
      window.removeEventListener('scroll', queueChapterSettle)
      window.removeEventListener('wheel', moveByWheel)
      window.clearTimeout(settleTimer)
      window.clearTimeout(wheelUnlockTimer)
    }
  }, [])

  useEffect(() => {
    document.body.style.overflow = menuOpen ? 'hidden' : ''
    return () => {
      document.body.style.overflow = ''
    }
  }, [menuOpen])

  useEffect(() => {
    if (prefersReducedMotion()) return
    const rotation = window.setInterval(() => {
      setActiveHero((index) => (index + 1) % heroSlides.length)
    }, 10_000)
    return () => window.clearInterval(rotation)
  }, [activeHero])

  useEffect(() => {
    if (prefersReducedMotion()) return
    const rotation = window.setInterval(() => {
      setActiveGender((index) => (index + 1) % 2)
    }, 5_000)
    return () => window.clearInterval(rotation)
  }, [activeCollection, activeGender])

  useEffect(() => {
    if (prefersReducedMotion()) return
    const rotation = window.setInterval(() => {
      setActiveAppFeature((index) => (index + 1) % appFeatures.length)
    }, 5_000)
    return () => window.clearInterval(rotation)
  }, [activeAppFeature])

  useEffect(() => {
    if (prefersReducedMotion()) return
    const rotation = window.setInterval(() => {
      setActiveGeneration((index) =>
        (index + 1) % generationGroups[activeGenerationGroup].images.length,
      )
    }, 5_000)
    return () => window.clearInterval(rotation)
  }, [activeGeneration, activeGenerationGroup])

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

      <header className="site-header">
        <a className="wordmark wordmark-mark" href="#top" aria-label="Wear My India home">
          <img className="wordmark-logo" src={brandAsset('wmi-monogram-v3.webp')} alt="" width="1254" height="1254" />
          <span className="sr-only">Wear My India · वेयर माय इंडिया</span>
        </a>

        <nav className="desktop-nav" aria-label="Primary navigation">
          <a href="#app">The app</a>
          <a href="#house">The house</a>
          <a href="#collections">Collections</a>
          <a href="#standard">Our standard</a>
        </nav>

        <div className="header-end">
          <a className="header-cta" href="#download">Get the app</a>
          <button className="menu-toggle" type="button" onClick={() => setMenuOpen(true)} aria-label="Open menu" aria-expanded={menuOpen}>
            <Menu size={22} strokeWidth={1.5} />
          </button>
        </div>
      </header>

      <main id="main">
        <section className="hero" aria-labelledby="hero-title">
          {heroSlides.map((slide, index) => (
            <picture className={`hero-picture is-${slide.id}${activeHero === index ? ' is-active' : ''}`} aria-hidden="true" key={slide.id}>
              <source media="(max-width: 720px)" srcSet={asset(slide.mobile)} />
              <img src={asset(slide.desktop)} alt="" width="1672" height="941" fetchPriority={index === 0 ? 'high' : 'auto'} />
            </picture>
          ))}
          <div className="hero-shade" />
          <div className="hero-content">
            <h1 id="hero-title">Wear your roots.<span>Wear My India.</span></h1>
            <p className="hero-copy">Indian clothing, made in India. Crafted for every generation.</p>
            <StoreBadges className="hero-store-badges" />
          </div>
        </section>

        <section className="app-experience" id="app">
          <div className="app-copy">
            <p className="eyebrow eyebrow-light">The Wear My India app</p>
            <h2>Your India.<br /><em>In your hand.</em></h2>
            <p className="app-lede">A considered home for Indian clothing, provenance and personal style.</p>

            <div className="app-feature-tabs" role="tablist" aria-label="Wear My India app features">
              {appFeatures.map((feature, index) => {
                const FeatureIcon = feature.icon
                return (
                  <button type="button" role="tab" aria-selected={activeAppFeature === index} className={activeAppFeature === index ? 'is-active' : ''} onClick={() => setActiveAppFeature(index)} key={feature.id}>
                    <FeatureIcon size={19} strokeWidth={1.45} />
                    <span><strong>{feature.label}</strong></span>
                  </button>
                )
              })}
            </div>

            <div className="app-active-copy" role="tabpanel" key={appFeature.id}>
              <AppFeatureIcon size={22} strokeWidth={1.35} />
              <div><h3>{appFeature.title}</h3><p>{appFeature.description}</p></div>
            </div>

            <StoreBadges className="store-badges-app" />
          </div>

          <div className="phone-stage" aria-label="Concept preview of the Wear My India mobile app">
            <div className="phone-halo" aria-hidden="true" />
            <div className="phone-shell">
              <div className="phone-hardware" aria-hidden="true"><span /></div>
              <div className="phone-screen">
                <div className="app-bar"><span className="mini-wordmark">WMI</span><button type="button" aria-label="Saved pieces"><Bookmark size={17} /></button></div>
                <p className="app-greeting">Namaste · <span lang="hi">नमस्ते</span></p>
                <h3>{appFeature.screenTitle}</h3>
                <div className="app-search"><Search size={15} /><span>Search cloth, craft, occasion</span></div>
                <figure className="app-card" key={appFeature.id}>
                  <img src={asset(appFeature.image)} alt={appFeature.imageAlt} width="1122" height="1402" />
                  <figcaption><span>{appFeature.screenNote}</span><button type="button" aria-label="Save this concept look"><Bookmark size={15} /></button></figcaption>
                </figure>
                <div className="app-origin"><MapPin size={15} /><span>{appFeature.origin}</span><ArrowRight size={15} /></div>
                <nav className="app-bottom-nav" aria-label="Concept app navigation"><span className="is-active"><Compass size={17} />Discover</span><span><Search size={17} />Explore</span><span><Bookmark size={17} />Wardrobe</span></nav>
              </div>
            </div>
          </div>
        </section>

        <section className="house" id="house">
          <div className="house-copy">
            <p className="eyebrow">The house philosophy</p>
            <h2>One India.<br />Many ways to wear it.</h2>
            <div className="house-columns">
              <p>Regional knowledge, Indian materials and modern form—for ordinary days and meaningful occasions.</p>
            </div>
            <div className="house-mark" aria-hidden="true"><span>WMI</span><i /><strong lang="hi">एक भारत · अनेक शिल्प</strong></div>
            <div className="house-pillars" aria-label="Wear My India principles">
              <article><span>01</span><strong>Made in India</strong><p>Cut, made and finished here.</p></article>
              <article><span>02</span><strong>Origin, visible</strong><p>Material, place and process made clear.</p></article>
              <article><span>03</span><strong>For every generation</strong><p>One house, many lives.</p></article>
            </div>
          </div>
        </section>

        <section className={`collection-house is-${collection.slug}`} id="collections">
          <div className="collection-intro section-pad">
            <div><p className="eyebrow">Virasat · Kriti · Sahaj</p><h2>Three expressions. One India.</h2></div>
            <p>Heirloom. Signature. Everyday.</p>
          </div>

          <div className="collection-tabs" role="tablist" aria-label="Wear My India collections">
            {collections.map((item, index) => (
              <button type="button" role="tab" aria-selected={activeCollection === index} aria-controls="collection-panel" className={activeCollection === index ? 'is-active' : ''} onClick={() => setActiveCollection(index)} key={item.slug}>
                <span>{item.number}</span><strong>{item.name}</strong><small lang="hi">{item.devanagari}</small>
              </button>
            ))}
          </div>

          <div className="collection-panel" id="collection-panel" role="tabpanel">
            <figure className="collection-frame">
              <div className="collection-image-mat carousel-image-stack">
                {collection.images.map((image, index) => (
                  <img
                    className={activeGender === index ? 'is-active' : ''}
                    src={asset(image.src)}
                    alt={activeGender === index ? image.alt : ''}
                    aria-hidden={activeGender !== index}
                    width="1122"
                    height="1402"
                    loading="eager"
                    decoding="async"
                    key={image.src}
                  />
                ))}
              </div>
              <figcaption className="carousel-caption" key={collectionImage.src}><span>{collectionImage.label}</span><span>{collectionImage.note}</span></figcaption>
            </figure>

            <div className="collection-copy">
              <span className="collection-number">{collection.number} / 03</span>
              <p className="collection-hindi" lang="hi">{collection.devanagari}</p>
              <h3>{collection.name}</h3>
              <p className="collection-role">{collection.role}</p>
              <strong>{collection.thought}</strong>
              <p className="collection-description">{collection.description}</p>
              <div className="collection-details" aria-label={`${collection.name} qualities`}>{collection.details.map((detail) => <span key={detail}>{detail}</span>)}</div>
              <div className="look-selector" role="group" aria-label={`${collection.name} campaign audience`}>
                {['Women', 'Men'].map((label, index) => (
                  <button type="button" className={activeGender === index ? 'is-active' : ''} onClick={() => setActiveGender(index)} aria-pressed={activeGender === index} key={label}><span>0{index + 1}</span>{label}</button>
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
            <div><p className="eyebrow eyebrow-light">One house · Every generation</p><h2>Made for every age.</h2></div>
            <p>Play, presence and personal style—without costume.</p>
          </div>

          <div className="generation-groups" role="tablist" aria-label="Generation campaigns">
            {generationGroups.map((group, index) => (
              <button type="button" role="tab" aria-selected={activeGenerationGroup === index} className={activeGenerationGroup === index ? 'is-active' : ''} onClick={() => chooseGenerationGroup(index)} key={group.id}>
                <span>{group.number}</span>{group.label}<small lang="hi">{group.devanagari}</small>
              </button>
            ))}
          </div>

          <div className="generation-panel" role="tabpanel">
            <figure className="generation-frame">
              <div className="generation-image-mat carousel-image-stack">
                {generationGroup.images.map((image, index) => (
                  <img
                    className={activeGeneration === index ? 'is-active' : ''}
                    src={asset(image.src)}
                    alt={activeGeneration === index ? image.alt : ''}
                    aria-hidden={activeGeneration !== index}
                    width="1122"
                    height="1402"
                    loading={index < 2 ? 'eager' : 'lazy'}
                    decoding="async"
                    key={image.src}
                  />
                ))}
              </div>
              <figcaption className="carousel-caption" key={generationImage.src}><span>{generationImage.label}</span><span>{generationImage.note}</span></figcaption>
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
            <div><p className="eyebrow eyebrow-light">The WMI standard</p><h2>Made in India.<br />Shown clearly.</h2></div>
            <p>Indian origin should be visible in material, place and process.</p>
            <div className="origin-seal" role="img" aria-label="Proudly भारत — Made in India">
              <img src={brandAsset('wmi-wax-seal.webp')} alt="" width="1254" height="1254" aria-hidden="true" />
              <div className="origin-seal-copy" aria-hidden="true">
                <span>Proudly</span>
                <strong lang="hi">भारत</strong>
                <span>Made in India</span>
              </div>
            </div>
          </div>
          <div className="standard-list">
            {standards.map(([number, title, description]) => <article key={number}><span>{number}</span><h3>{title}</h3><p>{description}</p></article>)}
          </div>
        </section>

        <section className="store-download" id="download">
          <figure className="store-download-image">
            <img src={asset('mature-women/hero.webp')} alt="Mature woman in a timeless ivory sari with a deep lac border" width="1122" height="1402" loading="lazy" />
          </figure>
          <div className="store-download-copy">
            <img className="download-seal" src={brandAsset('wmi-monogram-v3.webp')} alt="" width="1254" height="1254" />
            <p className="eyebrow">Wear My India · वेयर माय इंडिया</p>
            <h2>Carry your India.</h2>
            <p>Discover clothing with origin, craft and purpose made clear.</p>
            <StoreBadges className="store-badges-download" />
          </div>
        </section>
      </main>

      <footer className="footer">
        <div className="footer-wordmark"><strong>Wear My India</strong><span lang="hi">वेयर माय इंडिया</span><p>Wear your roots.</p></div>
        <div className="footer-nav">
          <div><span>The app</span><a href={appStoreUrl} target="_blank" rel="noreferrer">App Store</a><a href={playStoreUrl} target="_blank" rel="noreferrer">Google Play</a></div>
          <div><span>The house</span><a href="#house">Our philosophy</a><a href="#standard">Our standard</a></div>
          <div><span>Collections</span><a href="#collections">Virasat · Kriti · Sahaj</a><a href="#generations">Every generation</a></div>
        </div>
        <div className="footer-base"><span>© {year} Wear My India · An Infroid venture</span></div>
      </footer>

      {menuOpen && (
        <div className="mobile-menu" role="dialog" aria-modal="true" aria-label="Site menu">
          <div className="mobile-menu-head">
            <a className="wordmark wordmark-light" href="#top" onClick={closeMenu}><span className="wordmark-name">Wear My India</span><span className="wordmark-hindi" lang="hi">वेयर माय इंडिया</span></a>
            <button type="button" onClick={closeMenu} aria-label="Close menu"><X size={24} strokeWidth={1.4} /></button>
          </div>
          <nav aria-label="Mobile navigation">
            {[
              ['01', 'The app', '#app'],
              ['02', 'The house', '#house'],
              ['03', 'Collections', '#collections'],
              ['04', 'Every generation', '#generations'],
              ['05', 'Our standard', '#standard'],
            ].map(([number, label, href]) => <a href={href} key={href} onClick={closeMenu}><span>{number}</span>{label}<ArrowDownRight size={25} /></a>)}
          </nav>
          <div className="mobile-store-links">
            <StoreBadges />
          </div>
        </div>
      )}
    </div>
  )
}

export default App
