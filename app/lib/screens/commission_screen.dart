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

  CommissionStep get step => CommissionStep.values[currentStep];

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void update(VoidCallback change) {
    setState(change);
  }

  void goToStep(int index) {
    setState(
      () => currentStep = index.clamp(0, CommissionStep.values.length - 1),
    );
    if (scrollController.hasClients) {
      scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
      );
    }
  }

  Future<void> requestReview() async {
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: WmiColors.paper,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        titlePadding: const EdgeInsets.fromLTRB(26, 28, 26, 0),
        contentPadding: const EdgeInsets.fromLTRB(26, 18, 26, 10),
        actionsPadding: const EdgeInsets.fromLTRB(26, 8, 26, 24),
        title: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              color: WmiColors.lac,
              child: const Icon(
                Icons.auto_awesome_outlined,
                color: WmiColors.paper,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                'Ready for the atelier.',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ],
        ),
        content: Text(
          'Your ${draft.lineage.name} brief is complete. In production, a WMI textile curator would now confirm craft compatibility, final artwork, price and the making calendar before any payment or weaving begins.\n\nThis first release saves the complete experience locally as a product prototype.',
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
                if (constraints.maxWidth >= 1080) {
                  return _DesktopStudio(
                    draft: draft,
                    currentStep: currentStep,
                    scrollController: scrollController,
                    onStep: goToStep,
                    onChange: update,
                    onBack: () => goToStep(currentStep - 1),
                    onNext: currentStep == CommissionStep.values.length - 1
                        ? requestReview
                        : () => goToStep(currentStep + 1),
                  );
                }
                return _CompactStudio(
                  draft: draft,
                  currentStep: currentStep,
                  scrollController: scrollController,
                  onChange: update,
                  onBack: () => goToStep(currentStep - 1),
                  onNext: currentStep == CommissionStep.values.length - 1
                      ? requestReview
                      : () => goToStep(currentStep + 1),
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
          if (wide) ...[
            const Text(
              'INDICATIVE  ',
              style: TextStyle(
                fontSize: 9,
                letterSpacing: 1.2,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
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
          width: 220,
          child: _StepRail(currentStep: currentStep, onStep: onStep),
        ),
        Expanded(
          flex: 5,
          child: Container(
            color: WmiColors.deepLac,
            padding: const EdgeInsets.all(34),
            child: Center(child: _SareePreview(draft: draft, large: true)),
          ),
        ),
        Expanded(
          flex: 6,
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
      preview: Container(
        width: double.infinity,
        color: WmiColors.deepLac,
        padding: const EdgeInsets.fromLTRB(18, 20, 18, 22),
        child: Center(child: _SareePreview(draft: draft, large: false)),
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
    return Container(
      color: WmiColors.paper,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemCount: CommissionStep.values.length,
        itemBuilder: (context, index) {
          final step = CommissionStep.values[index];
          final selected = currentStep == index;
          return InkWell(
            onTap: () => onStep(index),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 17),
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
                    width: 28,
                    child: Text(
                      '${index + 1}'.padLeft(2, '0'),
                      style: TextStyle(
                        color: selected ? WmiColors.lac : WmiColors.mutedInk,
                        fontSize: 11,
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
                        const SizedBox(height: 3),
                        Text(
                          step.hindi,
                          style: const TextStyle(
                            color: WmiColors.oldGold,
                            fontSize: 12,
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
  const _SareePreview({required this.draft, required this.large});

  final CommissionDraft draft;
  final bool large;

  @override
  Widget build(BuildContext context) {
    final maxWidth = large ? 430.0 : 310.0;
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'YOUR VIRASAT',
                  style: const TextStyle(
                    color: WmiColors.kansa,
                    fontSize: 11,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Text(
                draft.lineage.place.split(' · ').first,
                style: const TextStyle(color: Color(0xFFBFB0A4), fontSize: 11),
              ),
            ],
          ),
          const SizedBox(height: 12),
          AspectRatio(
            aspectRatio: large ? .86 : 1.32,
            child: Container(
              padding: EdgeInsets.all(large ? 20 : 13),
              decoration: BoxDecoration(
                color: const Color(0xFF3A1921),
                border: Border.all(color: const Color(0xFF744254)),
              ),
              child: CustomPaint(
                painter: SareePainter(
                  palette: draft.palette,
                  motifIndex: draft.motifIndex,
                  borderIndex: draft.borderIndex,
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            '${draft.palette.name} · ${draft.motif.name}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: WmiColors.paper,
              fontSize: large ? 20 : 17,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            '${draft.lineage.name} · ${draft.fabric.name}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Color(0xFFBFB0A4), fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class SareePainter extends CustomPainter {
  SareePainter({
    required this.palette,
    required this.motifIndex,
    required this.borderIndex,
  });

  final SareePalette palette;
  final int motifIndex;
  final int borderIndex;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final radius = Radius.circular(math.min(size.width, size.height) * .025);
    canvas.clipRRect(RRect.fromRectAndRadius(rect, radius));
    canvas.drawRect(rect, Paint()..color = palette.body);

    final borderWidth = size.width * (.065 + borderIndex * .018);
    final palluHeight = size.height * (.26 + borderIndex * .035);
    final contrast = Paint()..color = palette.contrast;
    canvas.drawRect(Rect.fromLTWH(0, 0, borderWidth, size.height), contrast);
    canvas.drawRect(
      Rect.fromLTWH(size.width - borderWidth, 0, borderWidth, size.height),
      contrast,
    );
    canvas.drawRect(
      Rect.fromLTWH(0, size.height - palluHeight, size.width, palluHeight),
      contrast,
    );

    final zari = Paint()
      ..color = palette.zari
      ..style = PaintingStyle.stroke
      ..strokeWidth = math.max(1.2, size.width * .006);
    canvas.drawRect(
      Rect.fromLTWH(borderWidth * .38, 0, borderWidth * .28, size.height),
      zari,
    );
    canvas.drawRect(
      Rect.fromLTWH(
        size.width - borderWidth * .66,
        0,
        borderWidth * .28,
        size.height,
      ),
      zari,
    );

    final motifPaint = Paint()
      ..color = palette.zari.withValues(alpha: .88)
      ..style = PaintingStyle.stroke
      ..strokeWidth = math.max(1, size.width * .004);
    final fillPaint = Paint()..color = palette.zari.withValues(alpha: .38);
    final usableBottom = size.height - palluHeight - size.height * .04;
    final columns = motifIndex == 1 ? 5 : 4;
    final rows = motifIndex == 2 ? 6 : 5;
    for (var row = 0; row < rows; row++) {
      for (var column = 0; column < columns; column++) {
        final x =
            borderWidth +
            (column + .65) * ((size.width - 2 * borderWidth) / columns);
        final y = (row + .75) * (usableBottom / rows);
        final r = size.width * (motifIndex == 2 ? .016 : .022);
        if (motifIndex == 0) {
          canvas.drawCircle(Offset(x, y), r, fillPaint);
          canvas.drawCircle(Offset(x, y), r * 1.6, motifPaint);
        } else if (motifIndex == 1) {
          final path = Path()
            ..moveTo(x, y - r * 1.7)
            ..lineTo(x + r, y)
            ..lineTo(x, y + r * 1.7)
            ..lineTo(x - r, y)
            ..close();
          canvas.drawPath(path, motifPaint);
        } else {
          canvas.drawOval(
            Rect.fromCenter(
              center: Offset(x, y),
              width: r * 2.5,
              height: r * 3.5,
            ),
            motifPaint,
          );
          canvas.drawCircle(Offset(x, y), r * .45, fillPaint);
        }
      }
    }

    final palluTop = size.height - palluHeight;
    for (var i = 1; i < 6; i++) {
      final y = palluTop + (palluHeight / 6) * i;
      canvas.drawLine(
        Offset(borderWidth, y),
        Offset(size.width - borderWidth, y),
        zari,
      );
    }
    for (var i = 0; i < 7; i++) {
      final x = borderWidth + (size.width - 2 * borderWidth) * (i + .5) / 7;
      final y = palluTop + palluHeight * .5;
      canvas.drawCircle(Offset(x, y), size.width * .018, fillPaint);
      canvas.drawCircle(Offset(x, y), size.width * .03, motifPaint);
    }
  }

  @override
  bool shouldRepaint(covariant SareePainter oldDelegate) {
    return oldDelegate.palette != palette ||
        oldDelegate.motifIndex != motifIndex ||
        oldDelegate.borderIndex != borderIndex;
  }
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
    return Container(
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
                      MediaQuery.sizeOf(context).width < 600 ? 20 : 34,
                      32,
                      MediaQuery.sizeOf(context).width < 600 ? 20 : 34,
                      48,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${(currentStep + 1).toString().padLeft(2, '0')} OF 08 · ${step.hindi}',
                          style: const TextStyle(
                            color: WmiColors.lac,
                            fontSize: 11,
                            letterSpacing: 1.7,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _stepHeading(step),
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _stepDescription(step),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 30),
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

  String _stepHeading(CommissionStep step) => switch (step) {
    CommissionStep.intention => 'What should this saree remember?',
    CommissionStep.foundation => 'Choose the hands and the loom.',
    CommissionStep.palette => 'Build your colour story.',
    CommissionStep.body => 'Give the body its rhythm.',
    CommissionStep.border => 'Frame it. Then make a pallu.',
    CommissionStep.blouse => 'Complete the silhouette.',
    CommissionStep.finishing => 'The final handwork.',
    CommissionStep.fit => 'Fit, provenance and review.',
  };

  String _stepDescription(CommissionStep step) => switch (step) {
    CommissionStep.intention =>
      'The occasion guides weight, ornamentation and how the piece should live after its first wearing.',
    CommissionStep.foundation =>
      'A lineage is not a surface style. It determines the yarn, construction, motif language and time at the loom.',
    CommissionStep.palette =>
      'These combinations are calibrated for Indian silk and metallic zari. Your curator can tune the exact dye after review.',
    CommissionStep.body =>
      'Motifs are woven—not printed. Density and complexity directly affect the artisan’s time.',
    CommissionStep.border =>
      'The border holds the drape; the pallu carries its fullest expression. Both remain true to the chosen craft.',
    CommissionStep.blouse =>
      'Select a starting silhouette. Neck, sleeve, lining and opening are refined during the fit consultation.',
    CommissionStep.finishing =>
      'Choose what should arrive ready to wear. Every finish is completed in the WMI atelier.',
    CommissionStep.fit =>
      'Choose how we should take your measurements, then read the complete brief before requesting human review.',
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
      CommissionStep.intention => _ChoiceList(
        choices: intentions,
        selected: draft.intentionIndex,
        onSelect: (index) => onChange(() => draft.intentionIndex = index),
      ),
      CommissionStep.foundation => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionLabel('LOOM LINEAGE'),
          _LineageList(draft: draft, onChange: onChange),
          const SizedBox(height: 30),
          const _SectionLabel('FOUNDATION CLOTH'),
          _ChoiceList(
            choices: draft.lineage.fabrics,
            selected: draft.fabricIndex,
            onSelect: (index) => onChange(() => draft.fabricIndex = index),
          ),
        ],
      ),
      CommissionStep.palette => _PaletteList(draft: draft, onChange: onChange),
      CommissionStep.body => _ChoiceList(
        choices: draft.lineage.motifs,
        selected: draft.motifIndex,
        onSelect: (index) => onChange(() => draft.motifIndex = index),
      ),
      CommissionStep.border => _ChoiceList(
        choices: draft.lineage.borders,
        selected: draft.borderIndex,
        onSelect: (index) => onChange(() => draft.borderIndex = index),
      ),
      CommissionStep.blouse => _ChoiceList(
        choices: blouseStyles,
        selected: draft.blouseIndex,
        onSelect: (index) => onChange(() => draft.blouseIndex = index),
      ),
      CommissionStep.finishing => _FinishingOptions(
        draft: draft,
        onChange: onChange,
      ),
      CommissionStep.fit => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionLabel('HOW SHALL WE FIT IT?'),
          _ChoiceList(
            choices: measurementMethods,
            selected: draft.measurementIndex,
            onSelect: (index) => onChange(() => draft.measurementIndex = index),
          ),
          const SizedBox(height: 30),
          _ReviewCard(draft: draft),
        ],
      ),
    };
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        label,
        style: const TextStyle(
          color: WmiColors.oldGold,
          fontSize: 11,
          letterSpacing: 1.6,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _ChoiceList extends StatelessWidget {
  const _ChoiceList({
    required this.choices,
    required this.selected,
    required this.onSelect,
  });

  final List<Choice> choices;
  final int selected;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var index = 0; index < choices.length; index++)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _ChoiceCard(
              choice: choices[index],
              selected: selected == index,
              onTap: () => onSelect(index),
            ),
          ),
      ],
    );
  }
}

class _ChoiceCard extends StatelessWidget {
  const _ChoiceCard({
    required this.choice,
    required this.selected,
    required this.onTap,
  });

  final Choice choice;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      child: InkWell(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          padding: const EdgeInsets.all(17),
          decoration: BoxDecoration(
            color: selected ? const Color(0xFFF1E4D7) : WmiColors.paper,
            border: Border.all(
              color: selected ? WmiColors.lac : WmiColors.line,
              width: selected ? 1.6 : 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selected ? WmiColors.lac : Colors.transparent,
                  border: Border.all(
                    color: selected ? WmiColors.lac : WmiColors.mutedInk,
                  ),
                ),
                child: selected
                    ? const Icon(Icons.check, size: 14, color: Colors.white)
                    : null,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            choice.name,
                            style: Theme.of(
                              context,
                            ).textTheme.titleLarge?.copyWith(fontSize: 18),
                          ),
                        ),
                        if (choice.priceDelta != 0)
                          Text(
                            '${choice.priceDelta > 0 ? '+' : '−'}₹${choice.priceDelta.abs() ~/ 1000}k',
                            style: const TextStyle(
                              color: WmiColors.lac,
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    Text(
                      choice.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    if (choice.note != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        choice.note!,
                        style: const TextStyle(
                          color: WmiColors.oldGold,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LineageList extends StatelessWidget {
  const _LineageList({required this.draft, required this.onChange});

  final CommissionDraft draft;
  final ValueChanged<VoidCallback> onChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var index = 0; index < lineages.length; index++)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: InkWell(
              onTap: () => onChange(() => draft.selectLineage(index)),
              child: Container(
                padding: const EdgeInsets.all(17),
                decoration: BoxDecoration(
                  color: draft.lineageIndex == index
                      ? WmiColors.neel
                      : WmiColors.paper,
                  border: Border.all(
                    color: draft.lineageIndex == index
                        ? WmiColors.neel
                        : WmiColors.line,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: draft.lineageIndex == index
                            ? WmiColors.kansa
                            : WmiColors.kora,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${index + 1}'.padLeft(2, '0'),
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            lineages[index].name,
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  color: draft.lineageIndex == index
                                      ? WmiColors.paper
                                      : WmiColors.kajal,
                                  fontSize: 18,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${lineages[index].place} · ${lineages[index].timeline}',
                            style: TextStyle(
                              color: draft.lineageIndex == index
                                  ? WmiColors.kansa
                                  : WmiColors.oldGold,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            lineages[index].description,
                            style: TextStyle(
                              color: draft.lineageIndex == index
                                  ? const Color(0xFFCBC7BC)
                                  : WmiColors.mutedInk,
                              height: 1.4,
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
  }
}

class _PaletteList extends StatelessWidget {
  const _PaletteList({required this.draft, required this.onChange});

  final CommissionDraft draft;
  final ValueChanged<VoidCallback> onChange;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final twoColumns = constraints.maxWidth >= 500;
        final itemWidth = twoColumns
            ? (constraints.maxWidth - 10) / 2
            : constraints.maxWidth;
        return Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (var index = 0; index < palettes.length; index++)
              SizedBox(
                width: itemWidth,
                child: InkWell(
                  onTap: () => onChange(() => draft.paletteIndex = index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: draft.paletteIndex == index
                          ? const Color(0xFFF1E4D7)
                          : WmiColors.paper,
                      border: Border.all(
                        color: draft.paletteIndex == index
                            ? WmiColors.lac
                            : WmiColors.line,
                        width: draft.paletteIndex == index ? 1.6 : 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: _ColourBand(palette: palettes[index]),
                            ),
                            const SizedBox(width: 10),
                            if (draft.paletteIndex == index)
                              const Icon(
                                Icons.check_circle,
                                color: WmiColors.lac,
                                size: 21,
                              ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '${palettes[index].name} · ${palettes[index].hindi}',
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge?.copyWith(fontSize: 17),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          palettes[index].description,
                          style: Theme.of(context).textTheme.bodyMedium,
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

class _ColourBand extends StatelessWidget {
  const _ColourBand({required this.palette});

  final SareePalette palette;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: SizedBox(
        height: 32,
        child: Row(
          children: [
            Expanded(flex: 3, child: ColoredBox(color: palette.body)),
            Expanded(flex: 2, child: ColoredBox(color: palette.contrast)),
            Expanded(child: ColoredBox(color: palette.zari)),
          ],
        ),
      ),
    );
  }
}

class _FinishingOptions extends StatelessWidget {
  const _FinishingOptions({required this.draft, required this.onChange});

  final CommissionDraft draft;
  final ValueChanged<VoidCallback> onChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _FinishTile(
          title: 'Fall & pico',
          description:
              'Cotton fall protects the lower edge; pico gives the remaining edge a clean rolled finish.',
          price: '+₹1.8k',
          value: draft.addFallPico,
          onChanged: (value) => onChange(() => draft.addFallPico = value),
        ),
        _FinishTile(
          title: 'Handmade tassels',
          description:
              'Tassels are tied and colour-matched to the pallu by hand.',
          price: '+₹2.4k',
          value: draft.addTassels,
          onChanged: (value) => onChange(() => draft.addTassels = value),
        ),
        _FinishTile(
          title: 'Made-to-measure petticoat',
          description:
              'Waist, hip and full length are matched to your measurements and chosen drape.',
          price: '+₹6.5k',
          value: draft.addPetticoat,
          onChanged: (value) => onChange(() => draft.addPetticoat = value),
        ),
        _FinishTile(
          title: 'Blouse hand embroidery',
          description:
              'Aari, zardozi or fine silk work is composed after the artisan review.',
          price: 'from +₹18k',
          value: draft.addEmbroidery,
          onChanged: (value) => onChange(() => draft.addEmbroidery = value),
        ),
      ],
    );
  }
}

class _FinishTile extends StatelessWidget {
  const _FinishTile({
    required this.title,
    required this.description,
    required this.price,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String description;
  final String price;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.fromLTRB(16, 14, 10, 14),
      decoration: BoxDecoration(
        color: value ? const Color(0xFFF1E4D7) : WmiColors.paper,
        border: Border.all(color: value ? WmiColors.lac : WmiColors.line),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: Theme.of(
                          context,
                        ).textTheme.titleLarge?.copyWith(fontSize: 18),
                      ),
                    ),
                    Text(
                      price,
                      style: const TextStyle(
                        color: WmiColors.lac,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Switch(
            value: value,
            onChanged: onChanged,
            activeTrackColor: WmiColors.lac,
          ),
        ],
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({required this.draft});

  final CommissionDraft draft;

  @override
  Widget build(BuildContext context) {
    final rows = [
      ('Purpose', draft.intention.name),
      ('Lineage', draft.lineage.name),
      ('Foundation', draft.fabric.name),
      ('Palette', draft.palette.name),
      ('Body', draft.motif.name),
      ('Border & pallu', draft.border.name),
      ('Blouse', draft.blouse.name),
      ('Making time', draft.lineage.timeline),
    ];
    return Container(
      color: WmiColors.neel,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'YOUR COMMISSION NOTE',
            style: TextStyle(
              color: WmiColors.kansa,
              fontSize: 11,
              letterSpacing: 1.6,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 15),
          for (final row in rows)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 112,
                    child: Text(
                      row.$1,
                      style: const TextStyle(
                        color: Color(0xFFAAA79E),
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      row.$2,
                      style: const TextStyle(
                        color: WmiColors.paper,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          const Divider(color: Color(0x445F7678), height: 28),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Indicative estimate',
                  style: TextStyle(color: Color(0xFFCBC7BC)),
                ),
              ),
              Text(
                draft.formattedEstimate,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(color: WmiColors.kansa),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Final price follows motif graph, yarn and artisan review.',
            style: TextStyle(color: Color(0xFFAAA79E), fontSize: 11),
          ),
        ],
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
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
        decoration: const BoxDecoration(
          color: WmiColors.paper,
          border: Border(top: BorderSide(color: WmiColors.line)),
        ),
        child: Row(
          children: [
            if (currentStep > 0)
              OutlinedButton.icon(
                onPressed: onBack,
                icon: const Icon(Icons.arrow_back_rounded, size: 18),
                label: const Text('BACK'),
              )
            else
              const SizedBox(width: 1),
            const Spacer(),
            FilledButton.icon(
              onPressed: onNext,
              icon: Icon(
                last
                    ? Icons.auto_awesome_outlined
                    : Icons.arrow_forward_rounded,
                size: 18,
              ),
              label: Text(last ? 'REQUEST ARTISAN REVIEW' : 'CONTINUE'),
            ),
          ],
        ),
      ),
    );
  }
}
