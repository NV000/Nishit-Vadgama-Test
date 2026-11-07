import 'package:flutter/material.dart';
import '../extensions/app_extensions.dart';
import '../theme/app_text_styles.dart';

class AppLoadingWidget extends StatelessWidget {
  const AppLoadingWidget({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(color: colors.primary),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              style: AppTextStyles.body,
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
