import 'package:flutter/material.dart';

enum CommissionStep {
  material,
  weave,
  composition,
  pattern,
  colour,
  frame,
  blouse,
  finish,
}

extension CommissionStepCopy on CommissionStep {
  String get title => switch (this) {
    CommissionStep.material => 'Material',
    CommissionStep.weave => 'Craft lineage',
    CommissionStep.composition => 'Composition',
    CommissionStep.pattern => 'Pattern',
    CommissionStep.colour => 'Colour atelier',
    CommissionStep.frame => 'Border & pallu',
    CommissionStep.blouse => 'Blouse',
    CommissionStep.finish => 'Fit & finish',
  };

  String get hindi => switch (this) {
    CommissionStep.material => 'वस्त्र',
    CommissionStep.weave => 'बुनाई',
    CommissionStep.composition => 'रचना',
    CommissionStep.pattern => 'अलंकरण',
    CommissionStep.colour => 'रंगशाला',
    CommissionStep.frame => 'किनारा',
    CommissionStep.blouse => 'चोली',
    CommissionStep.finish => 'नाप',
  };
}

enum MaterialTexture { katan, kora, tissue, silkCotton }

enum CompositionKind { scattered, lattice, trail, borderLed }

enum MotifKind { buta, lotus, paisley, peacock, geometry }

enum BorderKind { meenakari, temple, gangaJamuna, tapestry }

enum PreviewMode { drape, body, pallu }

enum DesignLayer { body, primaryMotif, accent, border, zari, pallu }

extension DesignLayerCopy on DesignLayer {
  String get label => switch (this) {
    DesignLayer.body => 'Body ground',
    DesignLayer.primaryMotif => 'Primary motif',
    DesignLayer.accent => 'Motif accent',
    DesignLayer.border => 'Border ground',
    DesignLayer.zari => 'Zari & outline',
    DesignLayer.pallu => 'Pallu ground',
  };

  String get hindi => switch (this) {
    DesignLayer.body => 'आधार',
    DesignLayer.primaryMotif => 'मुख्य बूटी',
    DesignLayer.accent => 'दूसरा रंग',
    DesignLayer.border => 'किनारा',
    DesignLayer.zari => 'ज़री',
    DesignLayer.pallu => 'पल्लू',
  };

  bool get supportsGradient =>
      this == DesignLayer.body || this == DesignLayer.pallu;
}

class Choice {
  const Choice({
    required this.name,
    required this.description,
    this.hindi = '',
    this.note,
    this.priceDelta = 0,
  });

  final String name;
  final String hindi;
  final String description;
  final String? note;
  final int priceDelta;
}

class MaterialOption extends Choice {
  const MaterialOption({
    required super.name,
    required super.hindi,
    required super.description,
    required this.texture,
    required this.drape,
    required this.sheen,
    required this.weight,
    super.note,
    super.priceDelta,
  });

  final MaterialTexture texture;
  final String drape;
  final String sheen;
  final String weight;
}

class CraftLineage extends Choice {
  const CraftLineage({
    required super.name,
    required super.hindi,
    required super.description,
    required this.place,
    required this.technique,
    required this.timeline,
    required this.basePrice,
  });

  final String place;
  final String technique;
  final String timeline;
  final int basePrice;
}

class CompositionOption extends Choice {
  const CompositionOption({
    required super.name,
    required super.hindi,
    required super.description,
    required this.kind,
    super.priceDelta,
  });

  final CompositionKind kind;
}

class MotifOption extends Choice {
  const MotifOption({
    required super.name,
    required super.hindi,
    required super.description,
    required this.kind,
    super.priceDelta,
  });

  final MotifKind kind;
}

class BorderOption extends Choice {
  const BorderOption({
    required super.name,
    required super.hindi,
    required super.description,
    required this.kind,
    super.priceDelta,
  });

  final BorderKind kind;
}

class LayerFill {
  LayerFill({
    required this.start,
    required this.end,
    this.gradient = false,
    this.angle = 0,
  });

  Color start;
  Color end;
  bool gradient;
  double angle;
}

const materials = <MaterialOption>[
  MaterialOption(
    name: 'Pure Katan silk',
    hindi: 'कतान',
    description: 'Fine twisted silk with a smooth face and ceremonial fall.',
    texture: MaterialTexture.katan,
    drape: 'Structured',
    sheen: 'Soft lustre',
    weight: 'Medium',
  ),
  MaterialOption(
    name: 'Kora silk',
    hindi: 'कोरा',
    description:
        'Air-light silk organza with transparency and sculptural volume.',
    texture: MaterialTexture.kora,
    drape: 'Architectural',
    sheen: 'Translucent',
    weight: 'Light',
    priceDelta: 9000,
  ),
  MaterialOption(
    name: 'Tissue silk',
    hindi: 'टिशू',
    description: 'Metallic silk ground that catches light like a quiet jewel.',
    texture: MaterialTexture.tissue,
    drape: 'Fluid',
    sheen: 'Luminous',
    weight: 'Light',
    priceDelta: 18000,
  ),
  MaterialOption(
    name: 'Silk–cotton',
    hindi: 'रेशम सूती',
    description: 'Breathable cotton clarity softened by a measured silk glow.',
    texture: MaterialTexture.silkCotton,
    drape: 'Easy',
    sheen: 'Matte glow',
    weight: 'Medium',
    priceDelta: -12000,
  ),
];

const lineages = <CraftLineage>[
  CraftLineage(
    name: 'Banaras Kadhwa',
    hindi: 'बनारस कढ़वा',
    description:
        'Each motif is woven independently for clean detail and lasting definition.',
    place: 'Varanasi · Uttar Pradesh',
    technique: 'Individually woven motifs',
    timeline: '10–14 weeks',
    basePrice: 92000,
  ),
  CraftLineage(
    name: 'Kanchipuram Korvai',
    hindi: 'कांचीपुरम कोरवई',
    description:
        'Body and contrast border are interlocked on the loom with three shuttles.',
    place: 'Kanchipuram · Tamil Nadu',
    technique: 'Three-shuttle interlocking',
    timeline: '8–12 weeks',
    basePrice: 98000,
  ),
  CraftLineage(
    name: 'Paithani Tapestry',
    hindi: 'पैठणी',
    description:
        'Colour is built thread by thread in a discontinuous-weft tapestry pallu.',
    place: 'Paithan · Maharashtra',
    technique: 'Discontinuous-weft tapestry',
    timeline: '12–18 weeks',
    basePrice: 118000,
  ),
];

const compositions = <CompositionOption>[
  CompositionOption(
    name: 'Open buti field',
    hindi: 'बूटी',
    description: 'Measured motifs with generous quiet space between them.',
    kind: CompositionKind.scattered,
  ),
  CompositionOption(
    name: 'Jaal lattice',
    hindi: 'जाल',
    description: 'An immersive all-over network of flowering forms.',
    kind: CompositionKind.lattice,
    priceDelta: 18000,
  ),
  CompositionOption(
    name: 'Leher trail',
    hindi: 'लहर',
    description: 'Motifs move diagonally across the body in a lyrical rhythm.',
    kind: CompositionKind.trail,
    priceDelta: 9000,
  ),
  CompositionOption(
    name: 'Quiet centre',
    hindi: 'शांत',
    description:
        'A nearly plain body that gives the border and pallu full voice.',
    kind: CompositionKind.borderLed,
  ),
];

const motifs = <MotifOption>[
  MotifOption(
    name: 'Asharfi buta',
    hindi: 'अशर्फ़ी',
    description: 'Coin-like medallions with a small enamelled centre.',
    kind: MotifKind.buta,
  ),
  MotifOption(
    name: 'Kamal',
    hindi: 'कमल',
    description: 'An eight-petal lotus redrawn with restrained geometry.',
    kind: MotifKind.lotus,
  ),
  MotifOption(
    name: 'Ambi',
    hindi: 'अंबी',
    description: 'A fine mango form with a curling inner vine.',
    kind: MotifKind.paisley,
    priceDelta: 6000,
  ),
  MotifOption(
    name: 'Mayur',
    hindi: 'मयूर',
    description: 'A composed peacock form for a more expressive heirloom.',
    kind: MotifKind.peacock,
    priceDelta: 14000,
  ),
  MotifOption(
    name: 'Vanki',
    hindi: 'वांकी',
    description: 'A graphic diamond language inspired by temple jewellery.',
    kind: MotifKind.geometry,
    priceDelta: 4000,
  ),
];

const borders = <BorderOption>[
  BorderOption(
    name: 'Meenakari bel',
    hindi: 'मीनाकारी बेल',
    description: 'A fine floral vine with coloured silk accents inside zari.',
    kind: BorderKind.meenakari,
  ),
  BorderOption(
    name: 'Temple reku',
    hindi: 'मंदिर रेखा',
    description: 'A rhythmic temple edge with an architectural striped pallu.',
    kind: BorderKind.temple,
    priceDelta: 7000,
  ),
  BorderOption(
    name: 'Ganga–Jamuna',
    hindi: 'गंगा–जमुना',
    description: 'Two differently coloured edges frame the saree in balance.',
    kind: BorderKind.gangaJamuna,
    priceDelta: 9000,
  ),
  BorderOption(
    name: 'Tapestry pallu',
    hindi: 'चित्र पल्लू',
    description: 'A broad collector’s pallu with layered geometry and motifs.',
    kind: BorderKind.tapestry,
    priceDelta: 22000,
  ),
];

const blouseStyles = <Choice>[
  Choice(
    name: 'Classic elbow sleeve',
    hindi: 'परंपरा',
    description: 'A composed round neck, elbow sleeve and concealed opening.',
  ),
  Choice(
    name: 'Heritage square neck',
    hindi: 'चौकोर',
    description: 'A framed neckline, deep back and hand-finished tie detail.',
    priceDelta: 4500,
  ),
  Choice(
    name: 'High-neck angiya',
    hindi: 'अंगिया',
    description:
        'A structured, jewellery-friendly silhouette inspired by the angiya.',
    priceDelta: 6500,
  ),
];

const measurementMethods = <Choice>[
  Choice(
    name: 'Guided video fitting',
    description: 'A WMI fit specialist takes every measurement with you live.',
  ),
  Choice(
    name: 'Send a favourite blouse',
    description: 'Our master tailor studies a blouse you already love wearing.',
  ),
  Choice(
    name: 'Enter measurements',
    description:
        'Use an illustrated guide for body, shoulder, armhole and lengths.',
  ),
];

const curatedColours = <Color>[
  Color(0xFF6E1734),
  Color(0xFF321019),
  Color(0xFFA33C32),
  Color(0xFFD0713F),
  Color(0xFFE0B55D),
  Color(0xFFEADCC2),
  Color(0xFF153D4A),
  Color(0xFF1D5260),
  Color(0xFF1D5548),
  Color(0xFF6E7644),
  Color(0xFF56345E),
  Color(0xFFB78D52),
];

class CommissionDraft {
  int materialIndex = 0;
  int lineageIndex = 0;
  int compositionIndex = 0;
  int motifIndex = 0;
  int borderIndex = 0;
  int blouseIndex = 0;
  int measurementIndex = 0;
  double motifScale = .48;
  double motifDensity = .48;
  double borderWidth = .48;
  bool addFallPico = true;
  bool addTassels = true;
  bool addPetticoat = false;
  bool addEmbroidery = false;
  DesignLayer selectedLayer = DesignLayer.body;
  bool editingGradientEnd = false;
  PreviewMode previewMode = PreviewMode.drape;

  final Map<DesignLayer, LayerFill> fills = {
    DesignLayer.body: LayerFill(
      start: const Color(0xFF6E1734),
      end: const Color(0xFF321019),
      gradient: true,
      angle: .18,
    ),
    DesignLayer.primaryMotif: LayerFill(
      start: const Color(0xFFD7B36A),
      end: const Color(0xFFD7B36A),
    ),
    DesignLayer.accent: LayerFill(
      start: const Color(0xFF1D5548),
      end: const Color(0xFF1D5548),
    ),
    DesignLayer.border: LayerFill(
      start: const Color(0xFF321019),
      end: const Color(0xFF321019),
    ),
    DesignLayer.zari: LayerFill(
      start: const Color(0xFFD7B36A),
      end: const Color(0xFFD7B36A),
    ),
    DesignLayer.pallu: LayerFill(
      start: const Color(0xFF321019),
      end: const Color(0xFF6E1734),
      gradient: true,
      angle: .5,
    ),
  };

  MaterialOption get material => materials[materialIndex];
  CraftLineage get lineage => lineages[lineageIndex];
  CompositionOption get composition => compositions[compositionIndex];
  MotifOption get motif => motifs[motifIndex];
  BorderOption get border => borders[borderIndex];
  Choice get blouse => blouseStyles[blouseIndex];
  Choice get measurement => measurementMethods[measurementIndex];
  LayerFill fill(DesignLayer layer) => fills[layer]!;

  int get estimate {
    var total =
        lineage.basePrice +
        material.priceDelta +
        composition.priceDelta +
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
}
