import 'package:flutter/material.dart';

import '../../../core/extensions/app_extensions.dart';

class VegNonVegIndicator extends StatelessWidget {
  const VegNonVegIndicator({super.key, required this.isVeg, this.size = 14});

  final bool isVeg;
  final double size;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final color = isVeg ? colors.secondary : colors.error;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 1.5),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Center(
        child: Container(
          width: size * 0.45,
          height: size * 0.45,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
