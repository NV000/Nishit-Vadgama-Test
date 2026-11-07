import 'package:flutter/material.dart';

import '../../../core/extensions/app_extensions.dart';
import '../../../core/theme/app_text_styles.dart';

class QuantityStepper extends StatelessWidget {
  const QuantityStepper({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
    this.backgroundColor,
  });

  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final bg = backgroundColor ?? colors.secondary;

    return Container(
      height: 38,
      width: 120,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(Icons.remove, color: colors.onSecondary, size: 18),
            onPressed: onDecrement,
          ),
          Text(
            '$quantity',
            style: AppTextStyles.title.copyWith(color: colors.onSecondary),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(Icons.add, color: colors.onSecondary, size: 18),
            onPressed: onIncrement,
          ),
        ],
      ),
    );
  }
}
