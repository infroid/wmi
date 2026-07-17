import 'package:flutter/material.dart';

enum CommissionStep {
  intention,
  foundation,
  palette,
  body,
  border,
  blouse,
  finishing,
  fit,
}

extension CommissionStepCopy on CommissionStep {
  String get title => switch (this) {
    CommissionStep.intention => 'Intention',
    CommissionStep.foundation => 'Loom & silk',
    CommissionStep.palette => 'Colour story',
    CommissionStep.body => 'Body motifs',
    CommissionStep.border => 'Border & pallu',
    CommissionStep.blouse => 'The blouse',
    CommissionStep.finishing => 'Finishing',
    CommissionStep.fit => 'Fit & review',
  };

  String get hindi => switch (this) {
    CommissionStep.intention => 'अवसर',
    CommissionStep.foundation => 'करघा',
    CommissionStep.palette => 'रंग',
    CommissionStep.body => 'बूटी',
    CommissionStep.border => 'किनारा',
    CommissionStep.blouse => 'चोली',
    CommissionStep.finishing => 'सजावट',
    CommissionStep.fit => 'नाप',
  };
}

class Choice {
  const Choice({
    required this.name,
    required this.description,
    this.note,
    this.priceDelta = 0,
  });

  final String name;
  final String description;
  final String? note;
  final int priceDelta;
}

class CraftLineage {
  const CraftLineage({
    required this.name,
    required this.place,
    required this.technique,
    required this.description,
    required this.timeline,
    required this.basePrice,
    required this.fabrics,
    required this.motifs,
    required this.borders,
  });

  final String name;
  final String place;
  final String technique;
  final String description;
  final String timeline;
  final int basePrice;
  final List<Choice> fabrics;
  final List<Choice> motifs;
  final List<Choice> borders;
}

class SareePalette {
  const SareePalette({
    required this.name,
    required this.hindi,
    required this.body,
    required this.contrast,
    required this.zari,
    required this.description,
  });

  final String name;
  final String hindi;
  final Color body;
  final Color contrast;
  final Color zari;
  final String description;
}

const intentions = <Choice>[
  Choice(
    name: 'Wedding heirloom',
    description:
        'A ceremonial piece designed to pass from one generation to the next.',
    note: 'Rich pallu · full provenance',
    priceDelta: 18000,
  ),
  Choice(
    name: 'Family celebration',
    description: 'Festive presence with considered detail and an easier drape.',
    note: 'Balanced ornamentation',
    priceDelta: 8000,
  ),
  Choice(
    name: 'Quiet ceremony',
    description:
        'Restrained handwork, beautiful material and intimate significance.',
    note: 'Light, refined, personal',
  ),
];

const lineages = <CraftLineage>[
  CraftLineage(
    name: 'Banaras Kadhwa',
    place: 'Varanasi · Uttar Pradesh',
    technique: 'कढ़वा · individually woven motifs',
    description:
        'Every motif is woven separately so the reverse remains clean and the detail endures.',
    timeline: '10–14 weeks',
    basePrice: 92000,
    fabrics: [
      Choice(
        name: 'Pure Katan silk',
        description:
            'Smooth, lustrous and structured with a classic ceremonial fall.',
      ),
      Choice(
        name: 'Kora silk',
        description:
            'Airy organza-like silk with transparency and architectural volume.',
        priceDelta: 9000,
      ),
      Choice(
        name: 'Tissue silk',
        description: 'A luminous metallic ground for a rare, evening heirloom.',
        priceDelta: 18000,
      ),
    ],
    motifs: [
      Choice(
        name: 'Asharfi buta',
        description:
            'Fine coin-like butis, spaciously placed for quiet opulence.',
      ),
      Choice(
        name: 'Gul bel jaal',
        description:
            'A flowing floral lattice inspired by Mughal garden forms.',
        priceDelta: 14000,
      ),
      Choice(
        name: 'Shikargah',
        description:
            'Narrative forest, animal and bird motifs for a collector’s piece.',
        priceDelta: 32000,
      ),
    ],
    borders: [
      Choice(
        name: 'Meenakari bel',
        description:
            'A floral vine in gold zari with restrained coloured silk accents.',
      ),
      Choice(
        name: 'Jangla frame',
        description:
            'A broader botanical border with an immersive woven pallu.',
        priceDelta: 16000,
      ),
      Choice(
        name: 'Paan kinar',
        description:
            'A crisp leaf-edged border with a composed geometric pallu.',
        priceDelta: 6000,
      ),
    ],
  ),
  CraftLineage(
    name: 'Kanchipuram Korvai',
    place: 'Kanchipuram · Tamil Nadu',
    technique: 'கோர்வை · three-shuttle interlocking',
    description:
        'The contrasting body and border are interlocked on the loom for strength and definition.',
    timeline: '8–12 weeks',
    basePrice: 98000,
    fabrics: [
      Choice(
        name: 'Three-ply mulberry silk',
        description:
            'Traditional weight, pronounced structure and enduring lustre.',
      ),
      Choice(
        name: 'Lightweight mulberry silk',
        description:
            'A softer modern drape while retaining the Korvai construction.',
        priceDelta: 7000,
      ),
      Choice(
        name: 'Silk-cotton',
        description: 'A breathable body with the clarity of a silk border.',
        priceDelta: -12000,
      ),
    ],
    motifs: [
      Choice(
        name: 'Rudraksha',
        description: 'Rhythmic sacred-seed forms woven with graphic restraint.',
      ),
      Choice(
        name: 'Mayil',
        description:
            'Peacock motifs across the body, expressive and auspicious.',
        priceDelta: 12000,
      ),
      Choice(
        name: 'Yazhi',
        description:
            'Mythic temple guardians rendered as an exceptional statement.',
        priceDelta: 26000,
      ),
    ],
    borders: [
      Choice(
        name: 'Temple reku',
        description: 'A serrated temple border and traditional striped pallu.',
      ),
      Choice(
        name: 'Ganga–Jamuna',
        description:
            'Two border colours frame the body with ceremonial contrast.',
        priceDelta: 9000,
      ),
      Choice(
        name: 'Vanki diamond',
        description: 'A bold geometric border with a dense zari pallu.',
        priceDelta: 15000,
      ),
    ],
  ),
  CraftLineage(
    name: 'Paithani Tapestry',
    place: 'Paithan · Maharashtra',
    technique: 'पैठणी · discontinuous-weft tapestry',
    description:
        'The pallu is built colour by colour, like a miniature tapestry made directly on the loom.',
    timeline: '12–18 weeks',
    basePrice: 118000,
    fabrics: [
      Choice(
        name: 'Pure mulberry silk',
        description:
            'The traditional foundation: fluid, saturated and durable.',
      ),
      Choice(
        name: 'Shot-colour silk',
        description: 'Two yarn colours create a changing, iridescent body.',
        priceDelta: 10000,
      ),
      Choice(
        name: 'Fine-count silk',
        description:
            'A lighter, exceptionally supple body for an elegant drape.',
        priceDelta: 16000,
      ),
    ],
    motifs: [
      Choice(
        name: 'Muniya',
        description: 'Small green parrots punctuate the body and border.',
      ),
      Choice(
        name: 'Bangadi mor',
        description:
            'Peacocks in a bangle form create a celebrated Paithani signature.',
        priceDelta: 19000,
      ),
      Choice(
        name: 'Asawali',
        description: 'A flowering vine composition with finely built colour.',
        priceDelta: 24000,
      ),
    ],
    borders: [
      Choice(
        name: 'Narali kinar',
        description: 'A coconut-form border with a classic tapestry pallu.',
      ),
      Choice(
        name: 'Ajanta lotus',
        description:
            'Lotus forms inspired by Ajanta, arranged across a rich pallu.',
        priceDelta: 18000,
      ),
      Choice(
        name: 'Mor bangadi',
        description:
            'Peacock medallions and floral geometry for a grand heirloom.',
        priceDelta: 28000,
      ),
    ],
  ),
];

const palettes = <SareePalette>[
  SareePalette(
    name: 'Rani & old gold',
    hindi: 'रानी',
    body: Color(0xFF781F3B),
    contrast: Color(0xFF35141E),
    zari: Color(0xFFD5AD63),
    description: 'Deep lacquered rose with burnished gold.',
  ),
  SareePalette(
    name: 'Neel & kesar',
    hindi: 'नील',
    body: Color(0xFF173B4A),
    contrast: Color(0xFFB7642B),
    zari: Color(0xFFD3B374),
    description: 'Indigo depth lifted with saffron warmth.',
  ),
  SareePalette(
    name: 'Panna & sindoor',
    hindi: 'पन्ना',
    body: Color(0xFF1D5548),
    contrast: Color(0xFF8B2E2A),
    zari: Color(0xFFC7A35D),
    description: 'Jewel green framed by a ceremonial red.',
  ),
  SareePalette(
    name: 'Kora & wine',
    hindi: 'कोरा',
    body: Color(0xFFE6D7BC),
    contrast: Color(0xFF5F2134),
    zari: Color(0xFFB98A45),
    description: 'Unbleached ivory grounded in wine and antique gold.',
  ),
];

const blouseStyles = <Choice>[
  Choice(
    name: 'Classic elbow sleeve',
    description:
        'A composed round neck with elbow-length sleeves and concealed opening.',
  ),
  Choice(
    name: 'Heritage square neck',
    description: 'A framed neckline, deep back and hand-finished tie detail.',
    priceDelta: 4500,
  ),
  Choice(
    name: 'High-neck angiya',
    description:
        'A structured, jewellery-friendly silhouette inspired by the angiya.',
    priceDelta: 6500,
  ),
];

const measurementMethods = <Choice>[
  Choice(
    name: 'Guided video consultation',
    description:
        'A WMI fit specialist takes you through every measurement live.',
  ),
  Choice(
    name: 'Send a favourite blouse',
    description:
        'Our master tailor studies an existing blouse and confirms refinements.',
  ),
  Choice(
    name: 'Enter measurements',
    description:
        'Use the illustrated guide for bust, underbust, shoulder, armhole and lengths.',
  ),
];

class CommissionDraft {
  int intentionIndex = 0;
  int lineageIndex = 0;
  int fabricIndex = 0;
  int paletteIndex = 0;
  int motifIndex = 0;
  int borderIndex = 0;
  int blouseIndex = 0;
  int measurementIndex = 0;
  bool addFallPico = true;
  bool addTassels = true;
  bool addPetticoat = false;
  bool addEmbroidery = false;

  CraftLineage get lineage => lineages[lineageIndex];
  Choice get intention => intentions[intentionIndex];
  Choice get fabric => lineage.fabrics[fabricIndex];
  SareePalette get palette => palettes[paletteIndex];
  Choice get motif => lineage.motifs[motifIndex];
  Choice get border => lineage.borders[borderIndex];
  Choice get blouse => blouseStyles[blouseIndex];
  Choice get measurement => measurementMethods[measurementIndex];

  int get estimate {
    var total =
        lineage.basePrice +
        intention.priceDelta +
        fabric.priceDelta +
        motif.priceDelta +
        border.priceDelta +
        blouse.priceDelta;
    if (addFallPico) total += 1800;
    if (addTassels) total += 2400;
    if (addPetticoat) total += 6500;
    if (addEmbroidery) total += 18000;
    return total;
  }

  String get formattedEstimate {
    final digits = estimate.toString();
    if (digits.length <= 3) return '₹$digits';
    final lastThree = digits.substring(digits.length - 3);
    var rest = digits.substring(0, digits.length - 3);
    final parts = <String>[];
    while (rest.length > 2) {
      parts.insert(0, rest.substring(rest.length - 2));
      rest = rest.substring(0, rest.length - 2);
    }
    if (rest.isNotEmpty) parts.insert(0, rest);
    return '₹${parts.join(',')},$lastThree';
  }

  void selectLineage(int index) {
    lineageIndex = index;
    fabricIndex = 0;
    motifIndex = 0;
    borderIndex = 0;
  }
}
