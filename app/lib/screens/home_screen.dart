import 'package:flutter/material.dart';

import '../models/commission.dart';
import '../theme.dart';
import '../widgets/app_header.dart';
import 'commission_screen.dart';

class VirasatHomeScreen extends StatelessWidget {
  const VirasatHomeScreen({super.key});

  void _openCommission(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute<void>(builder: (_) => const CommissionScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WmiAppHeader(
        trailing: TextButton.icon(
          onPressed: () => _openCommission(context),
          icon: const Icon(Icons.auto_awesome_outlined, size: 18),
          label: const Text('BEGIN'),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _Hero(onBegin: () => _openCommission(context)),
          ),
          const SliverToBoxAdapter(child: _CommissionPromise()),
          SliverToBoxAdapter(
            child: _Journey(onBegin: () => _openCommission(context)),
          ),
          const SliverToBoxAdapter(child: _AfterRequest()),
          SliverToBoxAdapter(
            child: _Closing(onBegin: () => _openCommission(context)),
          ),
        ],
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero({required this.onBegin});

  final VoidCallback onBegin;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 900;
        return SizedBox(
          height: compact ? 760 : 700,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/images/virasat-hero.webp',
                fit: BoxFit.cover,
                alignment: compact ? const Alignment(.38, 0) : Alignment.center,
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: compact
                        ? Alignment.topCenter
                        : Alignment.centerRight,
                    end: compact
                        ? Alignment.bottomCenter
                        : Alignment.centerLeft,
                    colors: compact
                        ? const [
                            Colors.transparent,
                            Color(0x441A080D),
                            Color(0xF2281018),
                          ]
                        : const [
                            Colors.transparent,
                            Color(0x77281018),
                            Color(0xF2281018),
                          ],
                    stops: compact ? const [0, .42, .8] : const [0, .58, 1],
                  ),
                ),
              ),
              Align(
                alignment: compact
                    ? Alignment.bottomLeft
                    : Alignment.centerLeft,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 720),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      compact ? 22 : 72,
                      40,
                      compact ? 22 : 36,
                      compact ? 38 : 48,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'VIRASAT · विरासत',
                          style: TextStyle(
                            color: WmiColors.kansa,
                            fontSize: 12,
                            letterSpacing: 2.2,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 18),
                        Text(
                          'A saree that begins with you.',
                          style: Theme.of(context).textTheme.displayLarge
                              ?.copyWith(
                                color: WmiColors.paper,
                                fontSize: compact ? 48 : 78,
                              ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Choose its loom, silk, colour, motifs and every finishing detail. Our weavers and master tailors make one piece—only for you.',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: const Color(0xFFE8DDD0),
                                fontSize: compact ? 15 : 18,
                              ),
                        ),
                        const SizedBox(height: 28),
                        FilledButton.icon(
                          onPressed: onBegin,
                          icon: const Icon(
                            Icons.arrow_forward_rounded,
                            size: 19,
                          ),
                          label: const Text('BEGIN YOUR COMMISSION'),
                          style: FilledButton.styleFrom(
                            backgroundColor: WmiColors.kansa,
                            foregroundColor: WmiColors.kajal,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Personal artisan review · No instant checkout',
                          style: TextStyle(
                            color: Color(0xFFCDBEAF),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CommissionPromise extends StatelessWidget {
  const _CommissionPromise();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: WmiColors.deepLac,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
      child: Center(
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 30,
          runSpacing: 14,
          children: const [
            _Promise(icon: Icons.gesture_rounded, text: 'Handwoven in India'),
            _Promise(
              icon: Icons.person_outline_rounded,
              text: 'Made for one wearer',
            ),
            _Promise(
              icon: Icons.history_edu_outlined,
              text: 'Named artisan provenance',
            ),
            _Promise(
              icon: Icons.check_circle_outline,
              text: 'Approved before the loom',
            ),
          ],
        ),
      ),
    );
  }
}

class _Promise extends StatelessWidget {
  const _Promise({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: WmiColors.kansa, size: 18),
        const SizedBox(width: 9),
        Flexible(
          child: Text(
            text,
            style: const TextStyle(color: WmiColors.paper, fontSize: 13),
          ),
        ),
      ],
    );
  }
}

class _Journey extends StatelessWidget {
  const _Journey({required this.onBegin});

  final VoidCallback onBegin;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: WmiColors.paper,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 80),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'THE COMMISSION',
                style: TextStyle(
                  color: WmiColors.lac,
                  letterSpacing: 2,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'Eight passages. One heirloom.',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 16),
              Text(
                'We ask only what changes the cloth, the craft or the way it belongs to you.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 42),
              LayoutBuilder(
                builder: (context, constraints) {
                  final columns = constraints.maxWidth >= 900
                      ? 4
                      : constraints.maxWidth >= 560
                      ? 2
                      : 1;
                  final width =
                      (constraints.maxWidth - ((columns - 1) * 12)) / columns;
                  return Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      for (var i = 0; i < CommissionStep.values.length; i++)
                        SizedBox(
                          width: width,
                          child: _JourneyCard(
                            step: CommissionStep.values[i],
                            index: i,
                          ),
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 34),
              FilledButton(
                onPressed: onBegin,
                child: const Text('START WITH YOUR OCCASION'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _JourneyCard extends StatelessWidget {
  const _JourneyCard({required this.step, required this.index});

  final CommissionStep step;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 150),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: index == 1 ? WmiColors.neel : WmiColors.kora,
        border: Border.all(color: index == 1 ? WmiColors.neel : WmiColors.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '${index + 1}'.padLeft(2, '0'),
                style: TextStyle(
                  color: index == 1 ? WmiColors.kansa : WmiColors.oldGold,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              Text(
                step.hindi,
                style: TextStyle(
                  color: index == 1 ? const Color(0xFFD3C8BA) : WmiColors.lac,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Text(
            step.title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: index == 1 ? WmiColors.paper : WmiColors.kajal,
            ),
          ),
        ],
      ),
    );
  }
}

class _AfterRequest extends StatelessWidget {
  const _AfterRequest();

  @override
  Widget build(BuildContext context) {
    const steps = [
      (
        '01',
        'Craft review',
        'A textile curator and master weaver check that every choice belongs to the selected tradition.',
      ),
      (
        '02',
        'Design approval',
        'You receive a final palette, motif graph, price and making calendar before work begins.',
      ),
      (
        '03',
        'The making',
        'Yarn is sourced and dyed, the warp prepared, and your saree woven by named artisans.',
      ),
      (
        '04',
        'Fit & finishing',
        'The blouse is fitted, fall and pico finished, tassels tied and the full piece inspected.',
      ),
    ];
    return Container(
      color: WmiColors.neel,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 80),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final compact = constraints.maxWidth < 760;
              final copy = Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'AFTER YOU REQUEST',
                    style: TextStyle(
                      color: WmiColors.kansa,
                      letterSpacing: 2,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Human hands remain in the loop.',
                    style: Theme.of(
                      context,
                    ).textTheme.displayMedium?.copyWith(color: WmiColors.paper),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'A Virasat commission is never sent straight to production. Craft compatibility, comfort and feasibility are reviewed with you first.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: const Color(0xFFCDC8BD),
                    ),
                  ),
                ],
              );
              final list = Column(
                children: [
                  for (final step in steps)
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Color(0x445F7678)),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 44,
                            child: Text(
                              step.$1,
                              style: const TextStyle(
                                color: WmiColors.kansa,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  step.$2,
                                  style: Theme.of(context).textTheme.titleLarge
                                      ?.copyWith(color: WmiColors.paper),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  step.$3,
                                  style: const TextStyle(
                                    color: Color(0xFFBDB7AC),
                                    height: 1.45,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              );
              if (compact) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [copy, const SizedBox(height: 36), list],
                );
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: copy),
                  const SizedBox(width: 72),
                  Expanded(child: list),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _Closing extends StatelessWidget {
  const _Closing({required this.onBegin});

  final VoidCallback onBegin;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: WmiColors.mitti,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 76),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 820),
          child: Column(
            children: [
              Text(
                'Your saree. Your story.\nMade in India.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: onBegin,
                icon: const Icon(Icons.auto_awesome_outlined),
                label: const Text('BEGIN A VIRASAT COMMISSION'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
