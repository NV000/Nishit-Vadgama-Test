import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../extensions/app_extensions.dart';
import '../theme/app_text_styles.dart';

class AppPage extends StatelessWidget {
  const AppPage({
    super.key,
    required this.child,
    this.appBar,
    this.backgroundColor,
    this.padding,
    this.resizeToAvoidBottomInset = true,
    this.floatingActionButton,
    this.drawer,
    this.confirmExitOnBack = false,
  });

  final Widget child;
  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final bool resizeToAvoidBottomInset;
  final Widget? floatingActionButton;
  final Widget? drawer;
  final bool confirmExitOnBack;

  Future<void> _handlePopScope(BuildContext context, bool didPop) async {
    if (didPop) return;

    if (!confirmExitOnBack) {
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
      return;
    }

    final colors = context.colors;
    final l10n = context.l10n;

    final bool? shouldExit = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: colors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          l10n.exitAppTitle,
          style: AppTextStyles.title,
        ),
        content: Text(
          l10n.exitAppMessage,
          style: AppTextStyles.body,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(l10n.cancel, style: AppTextStyles.subtitle),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: colors.error,
              foregroundColor: colors.onError,
            ),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(l10n.exit, style: AppTextStyles.subtitle),
          ),
        ],
      ),
    );

    if (shouldExit == true) {
      SystemNavigator.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !confirmExitOnBack && Navigator.of(context).canPop(),
      onPopInvokedWithResult: (didPop, _) => _handlePopScope(context, didPop),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: backgroundColor ?? context.colors.surface,
          appBar: appBar,
          drawer: drawer,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          floatingActionButton: floatingActionButton,
          body: padding != null
              ? Padding(padding: padding!, child: child)
              : child,
        ),
      ),
    );
  }
}
