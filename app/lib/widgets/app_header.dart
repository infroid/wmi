import 'package:flutter/material.dart';

import '../theme.dart';
import 'brand_mark.dart';

class WmiAppHeader extends StatelessWidget implements PreferredSizeWidget {
  const WmiAppHeader({super.key, this.onBack, this.trailing});

  final VoidCallback? onBack;
  final Widget? trailing;

  @override
  Size get preferredSize => const Size.fromHeight(72);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: WmiColors.paper,
      child: SafeArea(
        bottom: false,
        child: Container(
          height: 72,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: WmiColors.line)),
          ),
          child: Row(
            children: [
              if (onBack != null) ...[
                IconButton(
                  onPressed: onBack,
                  tooltip: 'Back',
                  icon: const Icon(Icons.arrow_back_rounded),
                ),
                const SizedBox(width: 4),
              ],
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) => BrandMark(
                    size: 42,
                    withWordmark: constraints.maxWidth > 280,
                  ),
                ),
              ),
              ?trailing,
            ],
          ),
        ),
      ),
    );
  }
}
