import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../models/commission.dart';
import '../theme.dart';
import '../widgets/app_header.dart';

class CommissionScreen extends StatefulWidget {
  const CommissionScreen({super.key});

  @override
  State<CommissionScreen> createState() => _CommissionScreenState();
}

class _CommissionScreenState extends State<CommissionScreen> {
  final CommissionDraft draft = CommissionDraft();
  final ScrollController scrollController = ScrollController();
  int currentStep = 0;

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void update(VoidCallback change) => setState(change);

  void goToStep(int index) {
    setState(
      () => currentStep = index.clamp(0, CommissionStep.values.length - 1),
    );
    if (scrollController.hasClients) scrollController.jumpTo(0);
  }

  Future<void> requestReview() async {
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: WmiColors.paper,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        title: Text(
          'Your design brief is ready.',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        content: Text(
          'A Virasat textile curator will now check the ${draft.lineage.name} construction, redraw the final weave graph, confirm colour sampling and arrange your fitting before the loom begins.\n\nNo artisan work starts until you approve the material swatch, artwork, price and making calendar.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        actions: [
          FilledButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('KEEP REFINING'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WmiAppHeader(
        onBack: () => Navigator.maybePop(context),
        trailing: _EstimatePill(draft: draft),
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            minHeight: 3,
            value: (currentStep + 1) / CommissionStep.values.length,
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final onNext = currentStep == CommissionStep.values.length - 1
                    ? requestReview
                    : () => goToStep(currentStep + 1);
                if (constraints.maxWidth >= 1080) {
                  return _DesktopStudio(
                    draft: draft,
                    currentStep: currentStep,
                    scrollController: scrollController,
                    onStep: goToStep,
                    onChange: update,
                    onBack: () => goToStep(currentStep - 1),
                    onNext: onNext,
                  );
                }
                return _CompactStudio(
                  draft: draft,
                  currentStep: currentStep,
                  scrollController: scrollController,
                  onChange: update,
                  onBack: () => goToStep(currentStep - 1),
                  onNext: onNext,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _EstimatePill extends StatelessWidget {
  const _EstimatePill({required this.draft});

  final CommissionDraft draft;

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width > 560;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
      decoration: BoxDecoration(
        color: WmiColors.kora,
        border: Border.all(color: WmiColors.line),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (wide)
            const Text(
              'INDICATIVE  ',
              style: TextStyle(
                fontSize: 9,
                letterSpacing: 1.2,
                fontWeight: FontWeight.w800,
              ),
            ),
          Text(
            draft.formattedEstimate,
            style: const TextStyle(
              color: WmiColors.lac,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _DesktopStudio extends StatelessWidget {
  const _DesktopStudio({
    required this.draft,
    required this.currentStep,
    required this.scrollController,
    required this.onStep,
    required this.onChange,
    required this.onBack,
    required this.onNext,
  });

  final CommissionDraft draft;
  final int currentStep;
  final ScrollController scrollController;
  final ValueChanged<int> onStep;
  final ValueChanged<VoidCallback> onChange;
  final VoidCallback onBack;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 208,
          child: _StepRail(currentStep: currentStep, onStep: onStep),
        ),
        Expanded(
          flex: 6,
          child: ColoredBox(
            color: WmiColors.deepLac,
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: Center(
                child: _SareePreview(
                  draft: draft,
                  large: true,
                  onChange: onChange,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 7,
          child: _OptionPane(
            draft: draft,
            currentStep: currentStep,
            controller: scrollController,
            onChange: onChange,
            onBack: onBack,
            onNext: onNext,
          ),
        ),
      ],
    );
  }
}

class _CompactStudio extends StatelessWidget {
  const _CompactStudio({
    required this.draft,
    required this.currentStep,
    required this.scrollController,
    required this.onChange,
    required this.onBack,
    required this.onNext,
  });

  final CommissionDraft draft;
  final int currentStep;
  final ScrollController scrollController;
  final ValueChanged<VoidCallback> onChange;
  final VoidCallback onBack;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return _OptionPane(
      draft: draft,
      currentStep: currentStep,
      controller: scrollController,
      onChange: onChange,
      onBack: onBack,
      onNext: onNext,
      preview: ColoredBox(
        color: WmiColors.deepLac,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
          child: Center(
            child: _SareePreview(
              draft: draft,
              large: false,
              onChange: onChange,
            ),
          ),
        ),
      ),
    );
  }
}

class _StepRail extends StatelessWidget {
  const _StepRail({required this.currentStep, required this.onStep});

  final int currentStep;
  final ValueChanged<int> onStep;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: WmiColors.paper,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 12),
        itemCount: CommissionStep.values.length,
        itemBuilder: (context, index) {
          final step = CommissionStep.values[index];
          final selected = currentStep == index;
          return InkWell(
            onTap: () => onStep(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              decoration: BoxDecoration(
                color: selected ? WmiColors.kora : Colors.transparent,
                border: Border(
                  left: BorderSide(
                    color: selected ? WmiColors.lac : Colors.transparent,
                    width: 3,
                  ),
                  bottom: const BorderSide(color: WmiColors.line),
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 27,
                    child: Text(
                      '${index + 1}'.padLeft(2, '0'),
                      style: TextStyle(
                        color: selected ? WmiColors.lac : WmiColors.mutedInk,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          step.title,
                          style: TextStyle(
                            fontWeight: selected
                                ? FontWeight.w800
                                : FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          step.hindi,
                          style: const TextStyle(
                            color: WmiColors.oldGold,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SareePreview extends StatelessWidget {
  const _SareePreview({
    required this.draft,
    required this.large,
    required this.onChange,
  });

  final CommissionDraft draft;
  final bool large;
  final ValueChanged<VoidCallback> onChange;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: large ? 520 : 440),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'LIVE TEXTILE STUDY',
                  style: TextStyle(
                    color: WmiColors.kansa,
                    fontSize: 10,
                    letterSpacing: 1.8,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Text(
                draft.lineage.place.split(' · ').first,
                style: const TextStyle(color: Color(0xFFBFB0A4), fontSize: 10),
              ),
            ],
          ),
          const SizedBox(height: 10),
          AspectRatio(
            aspectRatio: large ? .92 : 1.28,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: const Color(0xFF3A1921),
                border: Border.all(color: const Color(0xFF744254)),
              ),
              child: Padding(
                padding: EdgeInsets.all(large ? 16 : 10),
                child: CustomPaint(
                  painter: SareePainter(draft: draft),
                  child: const SizedBox.expand(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              for (final mode in PreviewMode.values)
                Expanded(
                  child: _PreviewModeButton(
                    mode: mode,
                    selected: draft.previewMode == mode,
                    onTap: () => onChange(() => draft.previewMode = mode),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            '${draft.material.name} · ${draft.composition.name}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: WmiColors.paper,
              fontSize: large ? 19 : 16,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            '${draft.motif.name} · ${draft.border.name}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Color(0xFFBFB0A4), fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class _PreviewModeButton extends StatelessWidget {
  const _PreviewModeButton({
    required this.mode,
    required this.selected,
    required this.onTap,
  });

  final PreviewMode mode;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final label = switch (mode) {
      PreviewMode.drape => 'DRAPE',
      PreviewMode.body => 'BODY',
      PreviewMode.pallu => 'PALLU',
    };
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 9),
        decoration: BoxDecoration(
          color: selected ? WmiColors.kansa : Colors.transparent,
          border: Border.all(
            color: selected ? WmiColors.kansa : const Color(0xFF744254),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: selected ? WmiColors.kajal : const Color(0xFFCFBDB2),
            fontSize: 9,
            letterSpacing: 1.3,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class SareePainter extends CustomPainter {
  SareePainter({required this.draft});

  final CommissionDraft draft;

  @override
  void paint(Canvas canvas, Size size) {
    final outer = Offset.zero & size;
    final cloth = draft.previewMode == PreviewMode.drape
        ? (Path()
            ..moveTo(size.width * .16, size.height * .04)
            ..lineTo(size.width * .91, size.height * .02)
            ..lineTo(size.width * .82, size.height * .98)
            ..lineTo(size.width * .07, size.height * .95)
            ..quadraticBezierTo(
              size.width * .18,
              size.height * .52,
              size.width * .16,
              size.height * .04,
            )
            ..close())
        : (Path()..addRRect(
            RRect.fromRectAndRadius(outer, const Radius.circular(5)),
          ));

    canvas.save();
    canvas.clipPath(cloth);

    final body = draft.fill(DesignLayer.body);
    canvas.drawRect(outer, Paint()..shader = _shader(body, outer));
    _drawMaterial(canvas, size);

    final borderFraction = .055 + draft.borderWidth * .09;
    final borderWidth = size.width * borderFraction;
    final palluHeight = draft.previewMode == PreviewMode.pallu
        ? size.height
        : size.height * (.23 + draft.borderWidth * .08);
    final borderFill = draft.fill(DesignLayer.border);
    final palluFill = draft.fill(DesignLayer.pallu);
    final zari = draft.fill(DesignLayer.zari).start;
    final borderPaint = Paint()..shader = _shader(borderFill, outer);
    final palluRect = Rect.fromLTWH(
      0,
      size.height - palluHeight,
      size.width,
      palluHeight,
    );

    canvas.drawRect(Rect.fromLTWH(0, 0, borderWidth, size.height), borderPaint);
    canvas.drawRect(
      Rect.fromLTWH(size.width - borderWidth, 0, borderWidth, size.height),
      borderPaint,
    );
    canvas.drawRect(palluRect, Paint()..shader = _shader(palluFill, palluRect));

    final linePaint = Paint()
      ..color = zari.withValues(alpha: .9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = math.max(1.2, size.width * .0045);
    _drawBorder(canvas, size, borderWidth, linePaint);

    if (draft.previewMode != PreviewMode.pallu) {
      _drawComposition(canvas, size, borderWidth, palluHeight);
    }
    _drawPallu(canvas, size, palluRect, linePaint);

    if (draft.previewMode == PreviewMode.drape) {
      final fold = Paint()
        ..shader = LinearGradient(
          colors: const [
            Colors.transparent,
            Color(0x33000000),
            Color(0x18FFFFFF),
            Colors.transparent,
          ],
          stops: const [0, .4, .65, 1],
        ).createShader(outer);
      for (var i = 0; i < 6; i++) {
        final x = size.width * (.1 + i * .15);
        final path = Path()
          ..moveTo(x, 0)
          ..quadraticBezierTo(
            x + size.width * .06,
            size.height * .45,
            x - size.width * .01,
            size.height,
          )
          ..lineTo(x + size.width * .12, size.height)
          ..quadraticBezierTo(
            x + size.width * .13,
            size.height * .45,
            x + size.width * .08,
            0,
          )
          ..close();
        canvas.drawPath(path, fold);
      }
    }
    canvas.restore();

    canvas.drawPath(
      cloth,
      Paint()
        ..color = const Color(0x66E5C89A)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.1,
    );
  }

  Shader _shader(LayerFill fill, Rect rect) {
    if (!fill.gradient) {
      return LinearGradient(
        colors: [fill.start, fill.start],
      ).createShader(rect);
    }
    final angle = fill.angle * math.pi * 2;
    return LinearGradient(
      begin: Alignment(math.cos(angle), math.sin(angle)),
      end: Alignment(-math.cos(angle), -math.sin(angle)),
      colors: [fill.start, fill.end],
    ).createShader(rect);
  }

  void _drawMaterial(Canvas canvas, Size size) {
    final texture = Paint()
      ..color = Colors.white.withValues(
        alpha: draft.material.texture == MaterialTexture.tissue ? .13 : .055,
      )
      ..strokeWidth = 1;
    final spacing = switch (draft.material.texture) {
      MaterialTexture.katan => 8.0,
      MaterialTexture.kora => 13.0,
      MaterialTexture.tissue => 5.0,
      MaterialTexture.silkCotton => 10.0,
    };
    for (double x = -size.height; x < size.width + size.height; x += spacing) {
      final slant = draft.material.texture == MaterialTexture.kora
          ? size.height * .16
          : 0.0;
      canvas.drawLine(Offset(x, 0), Offset(x + slant, size.height), texture);
    }
    if (draft.material.texture == MaterialTexture.kora ||
        draft.material.texture == MaterialTexture.silkCotton) {
      final cross = Paint()..color = Colors.black.withValues(alpha: .035);
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawLine(Offset(0, y), Offset(size.width, y), cross);
      }
    }
  }

  void _drawComposition(
    Canvas canvas,
    Size size,
    double borderWidth,
    double palluHeight,
  ) {
    if (draft.composition.kind == CompositionKind.borderLed) return;
    final area = Rect.fromLTRB(
      borderWidth,
      0,
      size.width - borderWidth,
      size.height - palluHeight,
    );
    final density = 3 + (draft.motifDensity * 4).round();
    final rows = draft.composition.kind == CompositionKind.lattice
        ? density + 2
        : density + 1;
    final columns = draft.composition.kind == CompositionKind.lattice
        ? density + 1
        : density;
    for (var row = 0; row < rows; row++) {
      for (var column = 0; column < columns; column++) {
        if (draft.composition.kind == CompositionKind.trail &&
            (row + column) % 3 != 0) {
          continue;
        }
        var x = area.left + (column + .5) * area.width / columns;
        final y = area.top + (row + .55) * area.height / rows;
        if (draft.composition.kind == CompositionKind.lattice && row.isOdd) {
          x += area.width / columns / 2;
        }
        if (x > area.right) continue;
        _drawMotif(
          canvas,
          Offset(x, y),
          size.width * (.012 + draft.motifScale * .026),
        );
      }
    }
    if (draft.composition.kind == CompositionKind.lattice) {
      final latticePaint = Paint()
        ..color = draft.fill(DesignLayer.zari).start.withValues(alpha: .22)
        ..strokeWidth = 1;
      final cellW = area.width / columns;
      final cellH = area.height / rows;
      for (var row = -1; row < rows; row++) {
        canvas.drawLine(
          Offset(area.left, area.top + row * cellH),
          Offset(area.right, area.top + row * cellH + area.width * .7),
          latticePaint,
        );
        canvas.drawLine(
          Offset(area.left, area.top + row * cellH + area.width * .7),
          Offset(area.right, area.top + row * cellH),
          latticePaint,
        );
      }
      if (cellW < 0) return;
    }
  }

  void _drawMotif(Canvas canvas, Offset c, double r) {
    final primary = Paint()
      ..color = draft.fill(DesignLayer.primaryMotif).start
      ..style = PaintingStyle.stroke
      ..strokeWidth = math.max(1, r * .15);
    final accent = Paint()
      ..color = draft.fill(DesignLayer.accent).start.withValues(alpha: .9);
    switch (draft.motif.kind) {
      case MotifKind.buta:
        canvas.drawCircle(c, r * .55, accent);
        canvas.drawCircle(c, r, primary);
        canvas.drawCircle(c, r * 1.35, primary);
      case MotifKind.lotus:
        for (var i = 0; i < 8; i++) {
          final a = i * math.pi / 4;
          canvas.save();
          canvas.translate(c.dx, c.dy);
          canvas.rotate(a);
          canvas.drawOval(
            Rect.fromCenter(
              center: Offset(0, -r * .72),
              width: r * .68,
              height: r * 1.25,
            ),
            primary,
          );
          canvas.restore();
        }
        canvas.drawCircle(c, r * .35, accent);
      case MotifKind.paisley:
        final path = Path()
          ..moveTo(c.dx, c.dy - r * 1.3)
          ..cubicTo(
            c.dx + r * 1.4,
            c.dy - r * .6,
            c.dx + r * 1.1,
            c.dy + r,
            c.dx,
            c.dy + r * 1.2,
          )
          ..cubicTo(
            c.dx - r * .8,
            c.dy + r * .4,
            c.dx - r * .55,
            c.dy - r * .45,
            c.dx,
            c.dy - r * 1.3,
          )
          ..close();
        canvas.drawPath(path, primary);
        canvas.drawCircle(
          Offset(c.dx + r * .15, c.dy + r * .18),
          r * .3,
          accent,
        );
      case MotifKind.peacock:
        canvas.drawCircle(Offset(c.dx, c.dy + r * .2), r * .58, accent);
        canvas.drawArc(
          Rect.fromCenter(
            center: Offset(c.dx, c.dy),
            width: r * 2.5,
            height: r * 2.5,
          ),
          math.pi * 1.05,
          math.pi * .9,
          false,
          primary,
        );
        canvas.drawCircle(
          Offset(c.dx + r * .62, c.dy - r * .55),
          r * .22,
          primary,
        );
      case MotifKind.geometry:
        final path = Path()
          ..moveTo(c.dx, c.dy - r * 1.25)
          ..lineTo(c.dx + r, c.dy)
          ..lineTo(c.dx, c.dy + r * 1.25)
          ..lineTo(c.dx - r, c.dy)
          ..close();
        canvas.drawPath(path, primary);
        canvas.drawRect(
          Rect.fromCenter(center: c, width: r * .65, height: r * .65),
          accent,
        );
    }
  }

  void _drawBorder(Canvas canvas, Size size, double width, Paint zari) {
    final accent = Paint()
      ..color = draft.fill(DesignLayer.accent).start.withValues(alpha: .9);
    final leftX = width * .5;
    final rightX = size.width - width * .5;
    for (double y = width * .45; y < size.height; y += width * .9) {
      if (draft.border.kind == BorderKind.temple) {
        final h = width * .45;
        final triangle = Path()
          ..moveTo(0, y + h)
          ..lineTo(width, y + h)
          ..lineTo(width * .5, y)
          ..close();
        canvas.drawPath(triangle, zari);
        canvas.save();
        canvas.translate(size.width - width, 0);
        canvas.drawPath(triangle, zari);
        canvas.restore();
      } else {
        canvas.drawCircle(Offset(leftX, y), width * .18, accent);
        canvas.drawCircle(Offset(leftX, y), width * .3, zari);
        canvas.drawCircle(Offset(rightX, y), width * .18, accent);
        canvas.drawCircle(Offset(rightX, y), width * .3, zari);
      }
    }
    canvas.drawLine(
      Offset(width * .18, 0),
      Offset(width * .18, size.height),
      zari,
    );
    canvas.drawLine(
      Offset(size.width - width * .18, 0),
      Offset(size.width - width * .18, size.height),
      zari,
    );
  }

  void _drawPallu(Canvas canvas, Size size, Rect rect, Paint zari) {
    final accent = Paint()
      ..color = draft.fill(DesignLayer.accent).start.withValues(alpha: .85);
    final rows = draft.border.kind == BorderKind.tapestry ? 7 : 5;
    for (var i = 1; i < rows; i++) {
      final y = rect.top + rect.height * i / rows;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), zari);
    }
    final count = draft.border.kind == BorderKind.tapestry ? 8 : 6;
    for (var i = 0; i < count; i++) {
      final c = Offset(size.width * (i + .5) / count, rect.center.dy);
      canvas.drawCircle(c, size.width * .015, accent);
      canvas.drawCircle(c, size.width * .027, zari);
    }
  }

  @override
  bool shouldRepaint(covariant SareePainter oldDelegate) => true;
}

class _OptionPane extends StatelessWidget {
  const _OptionPane({
    required this.draft,
    required this.currentStep,
    required this.controller,
    required this.onChange,
    required this.onBack,
    required this.onNext,
    this.preview,
  });

  final CommissionDraft draft;
  final int currentStep;
  final ScrollController controller;
  final ValueChanged<VoidCallback> onChange;
  final VoidCallback onBack;
  final VoidCallback onNext;
  final Widget? preview;

  @override
  Widget build(BuildContext context) {
    final step = CommissionStep.values[currentStep];
    final compact = MediaQuery.sizeOf(context).width < 600;
    return ColoredBox(
      color: WmiColors.paper,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: controller,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ?preview,
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      compact ? 20 : 34,
                      28,
                      compact ? 20 : 34,
                      48,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${(currentStep + 1).toString().padLeft(2, '0')} OF 08 · ${step.hindi}',
                          style: const TextStyle(
                            color: WmiColors.lac,
                            fontSize: 10,
                            letterSpacing: 1.6,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _heading(step),
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _description(step),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 26),
                        _StepOptions(
                          step: step,
                          draft: draft,
                          onChange: onChange,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          _StudioFooter(
            currentStep: currentStep,
            onBack: onBack,
            onNext: onNext,
          ),
        ],
      ),
    );
  }

  String _heading(CommissionStep step) => switch (step) {
    CommissionStep.material => 'Begin with the cloth.',
    CommissionStep.weave => 'Choose its craft lineage.',
    CommissionStep.composition => 'Compose the whole field.',
    CommissionStep.pattern => 'Draw its woven language.',
    CommissionStep.colour => 'Colour every thread layer.',
    CommissionStep.frame => 'Frame the body. Tell the pallu.',
    CommissionStep.blouse => 'Complete the silhouette.',
    CommissionStep.finish => 'Prepare it for one wearer.',
  };

  String _description(CommissionStep step) => switch (step) {
    CommissionStep.material =>
      'Touch comes first. Compare drape, weight, transparency and sheen before deciding how the saree should look.',
    CommissionStep.weave =>
      'The making tradition determines construction, motif grammar, artisan time and what the material can honestly support.',
    CommissionStep.composition =>
      'Choose how pattern occupies the six-yard canvas: open, immersive, directional or led by the border.',
    CommissionStep.pattern =>
      'Select a motif, then tune its scale and density. Every change updates the textile study beside you.',
    CommissionStep.colour =>
      'Select a design layer, then mix its exact colour. Body and pallu can each carry a two-colour gradient.',
    CommissionStep.frame =>
      'Border width and pallu architecture change the balance of the entire drape—not only its edge.',
    CommissionStep.blouse =>
      'Choose a starting form. Neck, sleeve, lining and opening are refined with a master tailor.',
    CommissionStep.finish =>
      'Add atelier finishes, choose how we take measurements and review the complete commission.',
  };
}

class _StepOptions extends StatelessWidget {
  const _StepOptions({
    required this.step,
    required this.draft,
    required this.onChange,
  });

  final CommissionStep step;
  final CommissionDraft draft;
  final ValueChanged<VoidCallback> onChange;

  @override
  Widget build(BuildContext context) {
    return switch (step) {
      CommissionStep.material => _MaterialGrid(
        draft: draft,
        onChange: onChange,
      ),
      CommissionStep.weave => _LineageGrid(draft: draft, onChange: onChange),
      CommissionStep.composition => _CompositionGrid(
        draft: draft,
        onChange: onChange,
      ),
      CommissionStep.pattern => _PatternStudio(
        draft: draft,
        onChange: onChange,
      ),
      CommissionStep.colour => _ColourAtelier(draft: draft, onChange: onChange),
      CommissionStep.frame => _FrameStudio(draft: draft, onChange: onChange),
      CommissionStep.blouse => _BlouseGrid(draft: draft, onChange: onChange),
      CommissionStep.finish => _FinishAndReview(
        draft: draft,
        onChange: onChange,
      ),
    };
  }
}

class _MaterialGrid extends StatelessWidget {
  const _MaterialGrid({required this.draft, required this.onChange});

  final CommissionDraft draft;
  final ValueChanged<VoidCallback> onChange;

  @override
  Widget build(BuildContext context) {
    return _ResponsiveGrid(
      children: [
        for (var i = 0; i < materials.length; i++)
          _VisualCard(
            selected: draft.materialIndex == i,
            onTap: () => onChange(() => draft.materialIndex = i),
            visual: CustomPaint(
              painter: _MaterialPainter(materials[i].texture),
              child: const SizedBox.expand(),
            ),
            title: materials[i].name,
            hindi: materials[i].hindi,
            description: materials[i].description,
            meta:
                '${materials[i].drape} · ${materials[i].sheen} · ${materials[i].weight}',
            priceDelta: materials[i].priceDelta,
          ),
      ],
    );
  }
}

class _LineageGrid extends StatelessWidget {
  const _LineageGrid({required this.draft, required this.onChange});

  final CommissionDraft draft;
  final ValueChanged<VoidCallback> onChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < lineages.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _WideVisualCard(
              selected: draft.lineageIndex == i,
              onTap: () => onChange(() => draft.lineageIndex = i),
              number: '${i + 1}'.padLeft(2, '0'),
              title: lineages[i].name,
              hindi: lineages[i].hindi,
              description: lineages[i].description,
              meta: '${lineages[i].place} · ${lineages[i].timeline}',
              icon: switch (i) {
                0 => Icons.filter_vintage_outlined,
                1 => Icons.account_balance_outlined,
                _ => Icons.colorize_outlined,
              },
            ),
          ),
      ],
    );
  }
}

class _CompositionGrid extends StatelessWidget {
  const _CompositionGrid({required this.draft, required this.onChange});

  final CommissionDraft draft;
  final ValueChanged<VoidCallback> onChange;

  @override
  Widget build(BuildContext context) {
    return _ResponsiveGrid(
      children: [
        for (var i = 0; i < compositions.length; i++)
          _VisualCard(
            selected: draft.compositionIndex == i,
            onTap: () => onChange(() => draft.compositionIndex = i),
            visual: CustomPaint(
              painter: _CompositionPainter(compositions[i].kind),
              child: const SizedBox.expand(),
            ),
            title: compositions[i].name,
            hindi: compositions[i].hindi,
            description: compositions[i].description,
            priceDelta: compositions[i].priceDelta,
          ),
      ],
    );
  }
}

class _PatternStudio extends StatelessWidget {
  const _PatternStudio({required this.draft, required this.onChange});

  final CommissionDraft draft;
  final ValueChanged<VoidCallback> onChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionLabel('MOTIF FAMILY'),
        SizedBox(
          height: 172,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: motifs.length,
            separatorBuilder: (_, _) => const SizedBox(width: 10),
            itemBuilder: (context, i) => SizedBox(
              width: 140,
              child: _MotifCard(
                motif: motifs[i],
                selected: draft.motifIndex == i,
                onTap: () => onChange(() => draft.motifIndex = i),
              ),
            ),
          ),
        ),
        const SizedBox(height: 28),
        _ControlPanel(
          children: [
            _LabeledSlider(
              label: 'MOTIF SCALE',
              value: draft.motifScale,
              low: 'Fine',
              high: 'Statement',
              onChanged: (value) => onChange(() => draft.motifScale = value),
            ),
            const SizedBox(height: 22),
            _LabeledSlider(
              label: 'PATTERN DENSITY',
              value: draft.motifDensity,
              low: 'Airy',
              high: 'Immersive',
              onChanged: (value) => onChange(() => draft.motifDensity = value),
            ),
          ],
        ),
        const SizedBox(height: 14),
        const _AtelierNote(
          icon: Icons.grid_on_outlined,
          text:
              'The final repeat is redrawn as a loom-ready graph and approved with you before weaving.',
        ),
      ],
    );
  }
}

class _ColourAtelier extends StatelessWidget {
  const _ColourAtelier({required this.draft, required this.onChange});

  final CommissionDraft draft;
  final ValueChanged<VoidCallback> onChange;

  @override
  Widget build(BuildContext context) {
    final layer = draft.selectedLayer;
    final fill = draft.fill(layer);
    final editing = draft.editingGradientEnd ? fill.end : fill.start;
    final hsv = HSVColor.fromColor(editing);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionLabel('DESIGN LAYERS'),
        _LayerSelector(draft: draft, onChange: onChange),
        const SizedBox(height: 20),
        _ControlPanel(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        layer.label,
                        style: Theme.of(
                          context,
                        ).textTheme.titleLarge?.copyWith(fontSize: 21),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        layer.hindi,
                        style: const TextStyle(
                          color: WmiColors.oldGold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                if (layer.supportsGradient)
                  _ModeToggle(
                    gradient: fill.gradient,
                    onChanged: (value) => onChange(() {
                      fill.gradient = value;
                      if (!value) draft.editingGradientEnd = false;
                    }),
                  ),
              ],
            ),
            if (layer.supportsGradient && fill.gradient) ...[
              const SizedBox(height: 16),
              _EndpointToggle(
                fill: fill,
                editingEnd: draft.editingGradientEnd,
                onChanged: (end) =>
                    onChange(() => draft.editingGradientEnd = end),
              ),
            ],
            const SizedBox(height: 20),
            const _SectionLabel('CURATED DYE LIBRARY'),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                for (final colour in curatedColours)
                  _ColourSwatch(
                    colour: colour,
                    selected: _sameColour(colour, editing),
                    onTap: () =>
                        onChange(() => _setEditingColour(draft, colour)),
                  ),
              ],
            ),
            const SizedBox(height: 24),
            _ColourSlider(
              label: 'HUE',
              value: hsv.hue / 360,
              gradient: const [
                Colors.red,
                Colors.yellow,
                Colors.green,
                Colors.cyan,
                Colors.blue,
                Colors.purple,
                Colors.red,
              ],
              onChanged: (value) => onChange(
                () => _setEditingColour(
                  draft,
                  hsv.withHue(value * 360).toColor(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _ColourSlider(
              label: 'SATURATION',
              value: hsv.saturation,
              gradient: [
                HSVColor.fromAHSV(1, hsv.hue, 0, hsv.value).toColor(),
                HSVColor.fromAHSV(1, hsv.hue, 1, hsv.value).toColor(),
              ],
              onChanged: (value) => onChange(
                () => _setEditingColour(
                  draft,
                  hsv.withSaturation(value).toColor(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _ColourSlider(
              label: 'DEPTH',
              value: hsv.value,
              gradient: [
                Colors.black,
                HSVColor.fromAHSV(1, hsv.hue, hsv.saturation, 1).toColor(),
              ],
              onChanged: (value) => onChange(
                () => _setEditingColour(
                  draft,
                  hsv.withValue(value.clamp(.08, 1)).toColor(),
                ),
              ),
            ),
            if (layer.supportsGradient && fill.gradient) ...[
              const SizedBox(height: 22),
              const _SectionLabel('GRADIENT DIRECTION'),
              Row(
                children: [
                  for (final angle in [0.0, .125, .25, .375])
                    Expanded(
                      child: _GradientDirection(
                        angle: angle,
                        selected: (fill.angle - angle).abs() < .01,
                        onTap: () => onChange(() => fill.angle = angle),
                      ),
                    ),
                ],
              ),
            ],
          ],
        ),
        const SizedBox(height: 14),
        const _AtelierNote(
          icon: Icons.water_drop_outlined,
          text:
              'Screen colour is directional. Your curator sends a physical yarn or dye sample for approval.',
        ),
      ],
    );
  }

  static bool _sameColour(Color a, Color b) =>
      (a.r - b.r).abs() < .01 &&
      (a.g - b.g).abs() < .01 &&
      (a.b - b.b).abs() < .01;

  static void _setEditingColour(CommissionDraft draft, Color colour) {
    final fill = draft.fill(draft.selectedLayer);
    if (draft.editingGradientEnd && fill.gradient) {
      fill.end = colour;
    } else {
      fill.start = colour;
      if (!fill.gradient) fill.end = colour;
    }
  }
}

class _FrameStudio extends StatelessWidget {
  const _FrameStudio({required this.draft, required this.onChange});

  final CommissionDraft draft;
  final ValueChanged<VoidCallback> onChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ResponsiveGrid(
          children: [
            for (var i = 0; i < borders.length; i++)
              _VisualCard(
                selected: draft.borderIndex == i,
                onTap: () => onChange(() => draft.borderIndex = i),
                visual: CustomPaint(
                  painter: _BorderPainter(borders[i].kind),
                  child: const SizedBox.expand(),
                ),
                title: borders[i].name,
                hindi: borders[i].hindi,
                description: borders[i].description,
                priceDelta: borders[i].priceDelta,
              ),
          ],
        ),
        const SizedBox(height: 22),
        _ControlPanel(
          children: [
            _LabeledSlider(
              label: 'BORDER WIDTH',
              value: draft.borderWidth,
              low: 'Fine',
              high: 'Ceremonial',
              onChanged: (value) => onChange(() => draft.borderWidth = value),
            ),
          ],
        ),
      ],
    );
  }
}

class _BlouseGrid extends StatelessWidget {
  const _BlouseGrid({required this.draft, required this.onChange});

  final CommissionDraft draft;
  final ValueChanged<VoidCallback> onChange;

  @override
  Widget build(BuildContext context) {
    return _ResponsiveGrid(
      children: [
        for (var i = 0; i < blouseStyles.length; i++)
          _VisualCard(
            selected: draft.blouseIndex == i,
            onTap: () => onChange(() => draft.blouseIndex = i),
            visual: CustomPaint(
              painter: _BlousePainter(i, draft.fill(DesignLayer.border).start),
              child: const SizedBox.expand(),
            ),
            title: blouseStyles[i].name,
            hindi: blouseStyles[i].hindi,
            description: blouseStyles[i].description,
            priceDelta: blouseStyles[i].priceDelta,
          ),
      ],
    );
  }
}

class _FinishAndReview extends StatelessWidget {
  const _FinishAndReview({required this.draft, required this.onChange});

  final CommissionDraft draft;
  final ValueChanged<VoidCallback> onChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionLabel('ATELIER FINISHES'),
        _FinishTile(
          icon: Icons.horizontal_rule,
          title: 'Fall & pico',
          price: '+₹1.8k',
          value: draft.addFallPico,
          onChanged: (value) => onChange(() => draft.addFallPico = value),
        ),
        _FinishTile(
          icon: Icons.grain,
          title: 'Handmade tassels',
          price: '+₹2.4k',
          value: draft.addTassels,
          onChanged: (value) => onChange(() => draft.addTassels = value),
        ),
        _FinishTile(
          icon: Icons.checkroom_outlined,
          title: 'Made-to-measure petticoat',
          price: '+₹6.5k',
          value: draft.addPetticoat,
          onChanged: (value) => onChange(() => draft.addPetticoat = value),
        ),
        _FinishTile(
          icon: Icons.auto_awesome_outlined,
          title: 'Hand embroidery consultation',
          price: '+₹18k',
          value: draft.addEmbroidery,
          onChanged: (value) => onChange(() => draft.addEmbroidery = value),
        ),
        const SizedBox(height: 26),
        const _SectionLabel('YOUR FITTING'),
        for (var i = 0; i < measurementMethods.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _SimpleChoice(
              choice: measurementMethods[i],
              selected: draft.measurementIndex == i,
              onTap: () => onChange(() => draft.measurementIndex = i),
            ),
          ),
        const SizedBox(height: 26),
        _ReviewCard(draft: draft),
      ],
    );
  }
}

class _ResponsiveGrid extends StatelessWidget {
  const _ResponsiveGrid({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 520 ? 2 : 1;
        final width = columns == 2
            ? (constraints.maxWidth - 10) / 2
            : constraints.maxWidth;
        return Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (final child in children) SizedBox(width: width, child: child),
          ],
        );
      },
    );
  }
}

class _VisualCard extends StatelessWidget {
  const _VisualCard({
    required this.selected,
    required this.onTap,
    required this.visual,
    required this.title,
    required this.hindi,
    required this.description,
    this.meta,
    this.priceDelta = 0,
  });

  final bool selected;
  final VoidCallback onTap;
  final Widget visual;
  final String title;
  final String hindi;
  final String description;
  final String? meta;
  final int priceDelta;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFF3E8DC) : WmiColors.paper,
          border: Border.all(
            color: selected ? WmiColors.lac : WmiColors.line,
            width: selected ? 1.6 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 104,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  visual,
                  Positioned(
                    top: 10,
                    right: 10,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: selected
                            ? WmiColors.lac
                            : WmiColors.paper.withValues(alpha: .86),
                        border: Border.all(
                          color: selected ? WmiColors.lac : WmiColors.line,
                        ),
                      ),
                      child: selected
                          ? const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 15,
                            )
                          : null,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge?.copyWith(fontSize: 17),
                        ),
                      ),
                      if (priceDelta != 0)
                        Text(
                          _delta(priceDelta),
                          style: const TextStyle(
                            color: WmiColors.lac,
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    hindi,
                    style: const TextStyle(
                      color: WmiColors.oldGold,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  if (meta != null) ...[
                    const SizedBox(height: 9),
                    Text(
                      meta!,
                      style: const TextStyle(
                        color: WmiColors.lac,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WideVisualCard extends StatelessWidget {
  const _WideVisualCard({
    required this.selected,
    required this.onTap,
    required this.number,
    required this.title,
    required this.hindi,
    required this.description,
    required this.meta,
    required this.icon,
  });

  final bool selected;
  final VoidCallback onTap;
  final String number;
  final String title;
  final String hindi;
  final String description;
  final String meta;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.all(17),
        decoration: BoxDecoration(
          color: selected ? WmiColors.neel : WmiColors.paper,
          border: Border.all(color: selected ? WmiColors.neel : WmiColors.line),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 66,
              height: 76,
              decoration: BoxDecoration(
                color: selected ? const Color(0xFF264B55) : WmiColors.kora,
                border: Border.all(
                  color: selected ? const Color(0xFF4D6970) : WmiColors.line,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: selected ? WmiColors.kansa : WmiColors.lac,
                    size: 25,
                  ),
                  const SizedBox(height: 7),
                  Text(
                    number,
                    style: TextStyle(
                      color: selected ? WmiColors.kansa : WmiColors.mutedInk,
                      fontSize: 9,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                color: selected
                                    ? WmiColors.paper
                                    : WmiColors.kajal,
                                fontSize: 18,
                              ),
                        ),
                      ),
                      if (selected)
                        const Icon(
                          Icons.check_circle,
                          color: WmiColors.kansa,
                          size: 20,
                        ),
                    ],
                  ),
                  Text(
                    hindi,
                    style: const TextStyle(
                      color: WmiColors.kansa,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    description,
                    style: TextStyle(
                      color: selected
                          ? const Color(0xFFCBC7BC)
                          : WmiColors.mutedInk,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    meta,
                    style: const TextStyle(
                      color: WmiColors.oldGold,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MotifCard extends StatelessWidget {
  const _MotifCard({
    required this.motif,
    required this.selected,
    required this.onTap,
  });

  final MotifOption motif;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        decoration: BoxDecoration(
          color: selected ? WmiColors.deepLac : const Color(0xFFF3E8DC),
          border: Border.all(
            color: selected ? WmiColors.lac : WmiColors.line,
            width: selected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: CustomPaint(
                painter: _MotifPainter(motif.kind, selected),
                child: const SizedBox.expand(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 4, 10, 11),
              child: Column(
                children: [
                  Text(
                    motif.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: selected ? WmiColors.paper : WmiColors.kajal,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    motif.hindi,
                    style: const TextStyle(
                      color: WmiColors.oldGold,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LayerSelector extends StatelessWidget {
  const _LayerSelector({required this.draft, required this.onChange});

  final CommissionDraft draft;
  final ValueChanged<VoidCallback> onChange;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = (constraints.maxWidth - 10) / 2;
        return Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (final layer in DesignLayer.values)
              SizedBox(
                width: width,
                child: InkWell(
                  onTap: () => onChange(() {
                    draft.selectedLayer = layer;
                    draft.editingGradientEnd = false;
                  }),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    padding: const EdgeInsets.all(11),
                    decoration: BoxDecoration(
                      color: draft.selectedLayer == layer
                          ? WmiColors.neel
                          : WmiColors.paper,
                      border: Border.all(
                        color: draft.selectedLayer == layer
                            ? WmiColors.neel
                            : WmiColors.line,
                      ),
                    ),
                    child: Row(
                      children: [
                        _FillSwatch(fill: draft.fill(layer), size: 34),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                layer.label,
                                style: TextStyle(
                                  color: draft.selectedLayer == layer
                                      ? WmiColors.paper
                                      : WmiColors.kajal,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                layer.hindi,
                                style: const TextStyle(
                                  color: WmiColors.oldGold,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _ControlPanel extends StatelessWidget {
  const _ControlPanel({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFF3E8DC),
        border: Border.all(color: WmiColors.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

class _LabeledSlider extends StatelessWidget {
  const _LabeledSlider({
    required this.label,
    required this.value,
    required this.low,
    required this.high,
    required this.onChanged,
  });

  final String label;
  final double value;
  final String low;
  final String high;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 10,
                  letterSpacing: 1.4,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Text(
              '${(value * 100).round()}%',
              style: const TextStyle(
                color: WmiColors.lac,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        Slider(value: value, onChanged: onChanged),
        Row(
          children: [
            Text(
              low,
              style: const TextStyle(color: WmiColors.mutedInk, fontSize: 10),
            ),
            const Spacer(),
            Text(
              high,
              style: const TextStyle(color: WmiColors.mutedInk, fontSize: 10),
            ),
          ],
        ),
      ],
    );
  }
}

class _ColourSlider extends StatelessWidget {
  const _ColourSlider({
    required this.label,
    required this.value,
    required this.gradient,
    required this.onChanged,
  });

  final String label;
  final double value;
  final List<Color> gradient;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 9,
            letterSpacing: 1.3,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 7),
        Container(
          height: 13,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(colors: gradient),
            border: Border.all(color: WmiColors.line),
          ),
        ),
        Slider(value: value.clamp(0, 1), onChanged: onChanged),
      ],
    );
  }
}

class _ModeToggle extends StatelessWidget {
  const _ModeToggle({required this.gradient, required this.onChanged});

  final bool gradient;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _TinyMode(
          label: 'SOLID',
          selected: !gradient,
          onTap: () => onChanged(false),
        ),
        _TinyMode(
          label: 'GRADIENT',
          selected: gradient,
          onTap: () => onChanged(true),
        ),
      ],
    );
  }
}

class _TinyMode extends StatelessWidget {
  const _TinyMode({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        color: selected ? WmiColors.lac : WmiColors.paper,
        child: Text(
          label,
          style: TextStyle(
            color: selected ? WmiColors.paper : WmiColors.mutedInk,
            fontSize: 8,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class _EndpointToggle extends StatelessWidget {
  const _EndpointToggle({
    required this.fill,
    required this.editingEnd,
    required this.onChanged,
  });

  final LayerFill fill;
  final bool editingEnd;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _Endpoint(
            label: 'COLOUR 1',
            colour: fill.start,
            selected: !editingEnd,
            onTap: () => onChanged(false),
          ),
        ),
        const SizedBox(width: 8),
        const Icon(Icons.arrow_forward, size: 17, color: WmiColors.mutedInk),
        const SizedBox(width: 8),
        Expanded(
          child: _Endpoint(
            label: 'COLOUR 2',
            colour: fill.end,
            selected: editingEnd,
            onTap: () => onChanged(true),
          ),
        ),
      ],
    );
  }
}

class _Endpoint extends StatelessWidget {
  const _Endpoint({
    required this.label,
    required this.colour,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final Color colour;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(
            color: selected ? WmiColors.lac : WmiColors.line,
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(width: 24, height: 24, color: colour),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }
}

class _ColourSwatch extends StatelessWidget {
  const _ColourSwatch({
    required this.colour,
    required this.selected,
    required this.onTap,
  });

  final Color colour;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: const CircleBorder(),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        width: 38,
        height: 38,
        padding: EdgeInsets.all(selected ? 4 : 2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: selected ? WmiColors.lac : WmiColors.line,
            width: selected ? 2 : 1,
          ),
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(shape: BoxShape.circle, color: colour),
        ),
      ),
    );
  }
}

class _GradientDirection extends StatelessWidget {
  const _GradientDirection({
    required this.angle,
    required this.selected,
    required this.onTap,
  });

  final double angle;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 6),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: selected ? WmiColors.lac : WmiColors.paper,
          border: Border.all(color: selected ? WmiColors.lac : WmiColors.line),
        ),
        child: Transform.rotate(
          angle: angle * math.pi * 2,
          child: Icon(
            Icons.arrow_forward,
            color: selected ? WmiColors.paper : WmiColors.mutedInk,
            size: 20,
          ),
        ),
      ),
    );
  }
}

class _FillSwatch extends StatelessWidget {
  const _FillSwatch({required this.fill, required this.size});

  final LayerFill fill;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: fill.gradient
              ? [fill.start, fill.end]
              : [fill.start, fill.start],
        ),
        border: Border.all(color: Colors.white.withValues(alpha: .55)),
      ),
    );
  }
}

class _SimpleChoice extends StatelessWidget {
  const _SimpleChoice({
    required this.choice,
    required this.selected,
    required this.onTap,
  });

  final Choice choice;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFF3E8DC) : WmiColors.paper,
          border: Border.all(color: selected ? WmiColors.lac : WmiColors.line),
        ),
        child: Row(
          children: [
            Icon(
              selected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: selected ? WmiColors.lac : WmiColors.mutedInk,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    choice.name,
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    choice.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FinishTile extends StatelessWidget {
  const _FinishTile({
    required this.icon,
    required this.title,
    required this.price,
    required this.value,
    required this.onChanged,
  });

  final IconData icon;
  final String title;
  final String price;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: WmiColors.line)),
      ),
      child: SwitchListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        secondary: Icon(
          icon,
          color: value ? WmiColors.lac : WmiColors.mutedInk,
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
        subtitle: Text(
          price,
          style: const TextStyle(
            color: WmiColors.oldGold,
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({required this.draft});

  final CommissionDraft draft;

  @override
  Widget build(BuildContext context) {
    final rows = <(String, String)>[
      ('Material', draft.material.name),
      ('Lineage', draft.lineage.name),
      ('Composition', draft.composition.name),
      ('Motif', draft.motif.name),
      ('Border', draft.border.name),
      ('Blouse', draft.blouse.name),
      ('Making time', draft.lineage.timeline),
    ];
    return Container(
      padding: const EdgeInsets.all(18),
      color: WmiColors.neel,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'YOUR VIRASAT BRIEF',
            style: TextStyle(
              color: WmiColors.kansa,
              fontSize: 10,
              letterSpacing: 1.6,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 14),
          for (final row in rows)
            Padding(
              padding: const EdgeInsets.only(bottom: 9),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 92,
                    child: Text(
                      row.$1.toUpperCase(),
                      style: const TextStyle(
                        color: Color(0xFF9DA8A8),
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      row.$2,
                      style: const TextStyle(
                        color: WmiColors.paper,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          const Divider(color: Color(0xFF53696D)),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'INDICATIVE FROM',
                  style: TextStyle(
                    color: WmiColors.kansa,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Text(
                draft.formattedEstimate,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(color: WmiColors.paper),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AtelierNote extends StatelessWidget {
  const _AtelierNote({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(border: Border.all(color: WmiColors.line)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: WmiColors.oldGold, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: const TextStyle(
          color: WmiColors.lac,
          fontSize: 10,
          letterSpacing: 1.5,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _StudioFooter extends StatelessWidget {
  const _StudioFooter({
    required this.currentStep,
    required this.onBack,
    required this.onNext,
  });

  final int currentStep;
  final VoidCallback onBack;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final last = currentStep == CommissionStep.values.length - 1;
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 11, 16, 12),
        decoration: const BoxDecoration(
          color: WmiColors.paper,
          border: Border(top: BorderSide(color: WmiColors.line)),
        ),
        child: Row(
          children: [
            if (currentStep > 0)
              OutlinedButton.icon(
                onPressed: onBack,
                icon: const Icon(Icons.arrow_back, size: 17),
                label: const Text('BACK'),
              )
            else
              const SizedBox(width: 1),
            const Spacer(),
            FilledButton.icon(
              onPressed: onNext,
              icon: Icon(
                last ? Icons.auto_awesome_outlined : Icons.arrow_forward,
                size: 18,
              ),
              label: Text(last ? 'REQUEST ATELIER REVIEW' : 'CONTINUE'),
            ),
          ],
        ),
      ),
    );
  }
}

class _MaterialPainter extends CustomPainter {
  _MaterialPainter(this.texture);

  final MaterialTexture texture;

  @override
  void paint(Canvas canvas, Size size) {
    final base = switch (texture) {
      MaterialTexture.katan => const Color(0xFF8A2947),
      MaterialTexture.kora => const Color(0xFFE4D4B8),
      MaterialTexture.tissue => const Color(0xFFC4A264),
      MaterialTexture.silkCotton => const Color(0xFF345C59),
    };
    canvas.drawRect(Offset.zero & size, Paint()..color = base);
    final spacing = texture == MaterialTexture.tissue ? 5.0 : 9.0;
    for (double x = -size.height; x < size.width + size.height; x += spacing) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x + size.height * .25, size.height),
        Paint()..color = Colors.white.withValues(alpha: .12),
      );
    }
    if (texture == MaterialTexture.kora ||
        texture == MaterialTexture.silkCotton) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawLine(
          Offset(0, y),
          Offset(size.width, y),
          Paint()..color = Colors.black.withValues(alpha: .07),
        );
      }
    }
    canvas.drawRect(
      Offset.zero & size,
      Paint()
        ..shader = const LinearGradient(
          colors: [Colors.transparent, Color(0x55FFFFFF), Colors.transparent],
        ).createShader(Offset.zero & size),
    );
  }

  @override
  bool shouldRepaint(covariant _MaterialPainter oldDelegate) =>
      oldDelegate.texture != texture;
}

class _CompositionPainter extends CustomPainter {
  _CompositionPainter(this.kind);

  final CompositionKind kind;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = const Color(0xFF6E1734),
    );
    final zari = Paint()
      ..color = const Color(0xFFD7B36A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    canvas.drawRect(
      Rect.fromLTWH(0, size.height * .78, size.width, size.height * .22),
      Paint()..color = const Color(0xFF321019),
    );
    if (kind == CompositionKind.borderLed) return;
    for (var row = 0; row < 4; row++) {
      for (var col = 0; col < 7; col++) {
        if (kind == CompositionKind.trail && (row + col) % 3 != 0) continue;
        final x =
            size.width * (col + .5) / 7 +
            (kind == CompositionKind.lattice && row.isOdd
                ? size.width / 14
                : 0);
        final y = size.height * (row + .55) / 5;
        if (x >= size.width) continue;
        canvas.drawCircle(
          Offset(x, y),
          kind == CompositionKind.scattered ? 4 : 3,
          zari,
        );
      }
    }
    if (kind == CompositionKind.lattice) {
      for (double x = -size.height; x < size.width; x += 30) {
        canvas.drawLine(
          Offset(x, 0),
          Offset(x + size.height, size.height),
          Paint()..color = const Color(0x33D7B36A),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _CompositionPainter oldDelegate) =>
      oldDelegate.kind != kind;
}

class _MotifPainter extends CustomPainter {
  _MotifPainter(this.kind, this.selected);

  final MotifKind kind;
  final bool selected;

  @override
  void paint(Canvas canvas, Size size) {
    final c = Offset(size.width / 2, size.height / 2);
    final r = math.min(size.width, size.height) * .22;
    final stroke = Paint()
      ..color = const Color(0xFFD7B36A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final fill = Paint()
      ..color = selected ? const Color(0xFF1D5548) : const Color(0xFF6E1734);
    if (kind == MotifKind.lotus) {
      for (var i = 0; i < 8; i++) {
        canvas.save();
        canvas.translate(c.dx, c.dy);
        canvas.rotate(i * math.pi / 4);
        canvas.drawOval(
          Rect.fromCenter(
            center: Offset(0, -r * .7),
            width: r * .7,
            height: r * 1.2,
          ),
          stroke,
        );
        canvas.restore();
      }
      canvas.drawCircle(c, r * .3, fill);
    } else if (kind == MotifKind.geometry) {
      final p = Path()
        ..moveTo(c.dx, c.dy - r)
        ..lineTo(c.dx + r, c.dy)
        ..lineTo(c.dx, c.dy + r)
        ..lineTo(c.dx - r, c.dy)
        ..close();
      canvas.drawPath(p, stroke);
      canvas.drawRect(
        Rect.fromCenter(center: c, width: r * .7, height: r * .7),
        fill,
      );
    } else if (kind == MotifKind.paisley) {
      final p = Path()
        ..moveTo(c.dx, c.dy - r)
        ..cubicTo(
          c.dx + r * 1.3,
          c.dy - r * .4,
          c.dx + r,
          c.dy + r,
          c.dx,
          c.dy + r,
        )
        ..cubicTo(
          c.dx - r * .7,
          c.dy + r * .3,
          c.dx - r * .45,
          c.dy - r * .5,
          c.dx,
          c.dy - r,
        )
        ..close();
      canvas.drawPath(p, stroke);
      canvas.drawCircle(Offset(c.dx + r * .15, c.dy + r * .2), r * .28, fill);
    } else if (kind == MotifKind.peacock) {
      canvas.drawCircle(c, r * .52, fill);
      canvas.drawArc(
        Rect.fromCenter(center: c, width: r * 2.5, height: r * 2.5),
        math.pi,
        math.pi,
        false,
        stroke,
      );
      canvas.drawCircle(Offset(c.dx + r * .62, c.dy - r * .5), r * .18, stroke);
    } else {
      canvas.drawCircle(c, r * .45, fill);
      canvas.drawCircle(c, r, stroke);
      canvas.drawCircle(c, r * 1.25, stroke);
    }
  }

  @override
  bool shouldRepaint(covariant _MotifPainter oldDelegate) =>
      oldDelegate.kind != kind || oldDelegate.selected != selected;
}

class _BorderPainter extends CustomPainter {
  _BorderPainter(this.kind);

  final BorderKind kind;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = const Color(0xFF6E1734),
    );
    final border = Rect.fromLTWH(
      0,
      size.height * .42,
      size.width,
      size.height * .58,
    );
    canvas.drawRect(border, Paint()..color = const Color(0xFF321019));
    final zari = Paint()
      ..color = const Color(0xFFD7B36A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawLine(
      Offset(0, border.top + 8),
      Offset(size.width, border.top + 8),
      zari,
    );
    final count = kind == BorderKind.tapestry ? 9 : 6;
    for (var i = 0; i < count; i++) {
      final x = size.width * (i + .5) / count;
      if (kind == BorderKind.temple) {
        final p = Path()
          ..moveTo(x - 9, size.height)
          ..lineTo(x + 9, size.height)
          ..lineTo(x, border.top + 17)
          ..close();
        canvas.drawPath(p, zari);
      } else {
        canvas.drawCircle(Offset(x, border.center.dy + 6), 8, zari);
        canvas.drawCircle(
          Offset(x, border.center.dy + 6),
          3,
          Paint()..color = const Color(0xFF1D5548),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _BorderPainter oldDelegate) =>
      oldDelegate.kind != kind;
}

class _BlousePainter extends CustomPainter {
  _BlousePainter(this.style, this.colour);

  final int style;
  final Color colour;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = const Color(0xFFE8D7C2),
    );
    final body = Rect.fromCenter(
      center: Offset(size.width / 2, size.height * .57),
      width: size.width * .44,
      height: size.height * .62,
    );
    final p = Path()
      ..moveTo(body.left, body.top + 12)
      ..lineTo(body.left - size.width * .18, body.top + 25)
      ..lineTo(body.left - size.width * .12, body.bottom * .83)
      ..lineTo(body.left, body.bottom * .78)
      ..lineTo(body.left + 8, body.bottom)
      ..lineTo(body.right - 8, body.bottom)
      ..lineTo(body.right, body.bottom * .78)
      ..lineTo(body.right + size.width * .12, body.bottom * .83)
      ..lineTo(body.right + size.width * .18, body.top + 25)
      ..lineTo(body.right, body.top + 12)
      ..close();
    canvas.drawPath(p, Paint()..color = colour);
    final cutout = Paint()..color = const Color(0xFFE8D7C2);
    if (style == 0) {
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(size.width / 2, body.top),
          width: size.width * .17,
          height: size.height * .16,
        ),
        cutout,
      );
    } else if (style == 1) {
      canvas.drawRect(
        Rect.fromCenter(
          center: Offset(size.width / 2, body.top + 2),
          width: size.width * .18,
          height: size.height * .13,
        ),
        cutout,
      );
    } else {
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(size.width / 2, body.top - 2),
          width: size.width * .1,
          height: size.height * .08,
        ),
        cutout,
      );
    }
    canvas.drawPath(
      p,
      Paint()
        ..color = const Color(0xFFB78D52)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
  }

  @override
  bool shouldRepaint(covariant _BlousePainter oldDelegate) =>
      oldDelegate.style != style || oldDelegate.colour != colour;
}

String _delta(int amount) =>
    '${amount > 0 ? '+' : '−'}₹${amount.abs() ~/ 1000}k';
