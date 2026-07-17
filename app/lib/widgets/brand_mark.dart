import 'package:flutter/material.dart';

import '../theme.dart';

class BrandMark extends StatelessWidget {
  const BrandMark({super.key, this.size = 48, this.withWordmark = true});

  final double size;
  final bool withWordmark;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Wear My India',
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/wmi-monogram.webp',
            width: size,
            height: size,
            fit: BoxFit.contain,
          ),
          if (withWordmark) ...[
            const SizedBox(width: 12),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Wear My India',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: WmiColors.kajal,
                    fontSize: 19,
                  ),
                ),
                const Text(
                  'विरासत · A PERSONAL COMMISSION',
                  style: TextStyle(
                    color: WmiColors.lac,
                    fontSize: 9,
                    height: 1.4,
                    letterSpacing: 1.15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
