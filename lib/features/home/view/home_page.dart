import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/extensions/app_extensions.dart';
import '../../../core/widgets/app_empty_widget.dart';
import '../../../core/widgets/app_loading_widget.dart';
import '../../../core/widgets/app_page.dart';
import '../../../core/widgets/language_switch_widget.dart';
import '../../../generated/l10n.dart';
import '../controller/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppPage(
      confirmExitOnBack: true,
      appBar: AppBar(
        title: Text(s.dashboard),
        actions: [
          const LanguageSwitchWidget(),
          const SizedBox(width: 4),
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            tooltip: s.logout,
            onPressed: () => _confirmLogout(context),
          ),
          const SizedBox(width: 8),
        ],
      ),
      child: Obx(() {
        if (controller.isLoading.value) {
          return AppLoadingWidget(message: s.loading);
        }
        return _buildBody(context);
      }),
    );
  }

  Widget _buildBody(BuildContext context) {
    final s = S.of(context);

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: _buildGreeting(context)),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          sliver: SliverToBoxAdapter(
            child: _buildStatsRow(context),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverToBoxAdapter(
            child: Text(s.recentActivity, style: context.appTextTheme.titleMedium),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 24),
            child: AppEmptyWidget(
              message: s.noRecentActivity,
              icon: Icons.history_rounded,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGreeting(BuildContext context) {
    final s = S.of(context);

    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [context.colors.primary, context.colors.primaryContainer.withValues(alpha: 0.6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  s.helloUser(controller.userName),
                  style: context.appTextTheme.titleLarge?.copyWith(
                    color: context.colors.onPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  controller.userEmail,
                  style: context.appTextTheme.bodySmall?.copyWith(
                    color: context.colors.onPrimary.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
          CircleAvatar(
            radius: 28,
            backgroundColor: context.colors.onPrimary.withValues(alpha: 0.2),
            child: Text(
              controller.userName.isNotEmpty
                  ? controller.userName[0].toUpperCase()
                  : 'U',
              style: context.appTextTheme.titleLarge?.copyWith(
                color: context.colors.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow(BuildContext context) {
    final s = S.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Expanded(child: _statCard(context, s.tasks, '0', Icons.task_alt_rounded)),
          const SizedBox(width: 12),
          Expanded(child: _statCard(context, s.pending, '0', Icons.pending_actions_rounded)),
          const SizedBox(width: 12),
          Expanded(child: _statCard(context, s.done, '0', Icons.check_circle_rounded)),
        ],
      ),
    );
  }

  Widget _statCard(BuildContext context, String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.colors.outlineVariant),
      ),
      child: Column(
        children: [
          Icon(icon, color: context.colors.primary, size: 24),
          const SizedBox(height: 8),
          Text(value, style: context.appTextTheme.titleLarge),
          const SizedBox(height: 2),
          Text(label, style: context.appTextTheme.bodySmall),
        ],
      ),
    );
  }

  void _confirmLogout(BuildContext context) {
    final s = S.of(context);

    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(s.logoutConfirmTitle),
        content: Text(s.logoutConfirmMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(s.cancel),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              controller.logout();
            },
            child: Text(s.logout),
          ),
        ],
      ),
    );
  }
}
