import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../generated/l10n.dart';
import '../theme/app_colors.dart';

class AppPage extends StatelessWidget {
  const AppPage({
    super.key,
    required this.child,
    this.appBar,
    this.backgroundColor,
    this.padding,
    this.resizeToAvoidBottomInset = true,
    this.floatingActionButton,
    this.confirmExitOnBack = false,
  });

  final Widget child;
  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final bool resizeToAvoidBottomInset;
  final Widget? floatingActionButton;
  final bool confirmExitOnBack;

  Future<void> _handlePopScope(BuildContext context, bool didPop) async {
    if (didPop) return;

    if (!confirmExitOnBack) {
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
      return;
    }

    final bool? shouldExit = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          S.current.exitAppTitle,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        content: Text(S.current.exitAppMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(S.current.cancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: AppColors.white,
            ),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(S.current.exit),
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
          backgroundColor: backgroundColor,
          appBar: appBar,
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
