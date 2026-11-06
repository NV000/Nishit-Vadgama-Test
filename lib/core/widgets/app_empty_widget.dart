import 'package:flutter/material.dart';

class AppEmptyWidget extends StatelessWidget {
  const AppEmptyWidget({
    super.key,
    this.message = 'No data found',
    this.icon = Icons.inbox_outlined,
    this.onRetry,
    this.retryLabel = 'Retry',
  });

  final String message;
  final IconData icon;
  final VoidCallback? onRetry;
  final String retryLabel;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 56, color: scheme.outline),
            const SizedBox(height: 16),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: scheme.outline,
                  ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 20),
              FilledButton.tonal(
                onPressed: onRetry,
                child: Text(retryLabel),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

