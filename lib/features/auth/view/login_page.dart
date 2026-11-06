import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/extensions/app_extensions.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_page.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/language_switch_widget.dart';
import '../../../generated/l10n.dart';
import '../../../routes/app_routes.dart';
import '../controller/auth_controller.dart';

class LoginPage extends GetView<AuthController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      confirmExitOnBack: true,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Form(
            key: controller.loginFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Align(
                  alignment: Alignment.topRight,
                  child: LanguageSwitchWidget(),
                ),
                const SizedBox(height: 16),
                _buildHeader(context),
                const SizedBox(height: 36),
                _buildForm(context),
                const SizedBox(height: 32),
                _buildLoginButton(),
                const SizedBox(height: 20),
                _buildFooter(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: context.colors.primaryContainer,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            Icons.lock_outline_rounded,
            color: context.colors.primary,
            size: 28,
          ),
        ),
        const SizedBox(height: 20),
        Text(S.of(context).welcomeBack, style: context.appTextTheme.displayLarge),
        const SizedBox(height: 6),
        Text(
          S.of(context).signInToContinue,
          style: context.appTextTheme.bodyMedium?.copyWith(
            color: context.colors.outline,
          ),
        ),
      ],
    );
  }

  Widget _buildForm(BuildContext context) {
    final s = S.of(context);
    return Column(
      children: [
        AppTextField(
          controller: controller.loginEmailCtrl,
          label: s.email,
          hint: s.enterYourEmail,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          prefixIcon: const Icon(Icons.email_outlined, size: 20),
          autofillHints: const [AutofillHints.email],
          validator: (val) {
            if (val == null || val.trim().isEmpty) return s.emailRequired;
            if (!val.trim().isValidEmail) return s.validEmail;
            return null;
          },
        ),
        const SizedBox(height: 16),
        Obx(
          () => AppTextField(
            controller: controller.loginPasswordCtrl,
            label: s.password,
            hint: s.enterYourPassword,
            obscureText: !controller.isPasswordVisible.value,
            textInputAction: TextInputAction.done,
            prefixIcon: const Icon(Icons.lock_outline_rounded, size: 20),
            suffixIcon: IconButton(
              icon: Icon(
                controller.isPasswordVisible.value
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                size: 20,
              ),
              onPressed: controller.togglePasswordVisibility,
            ),
            autofillHints: const [AutofillHints.password],
            onFieldSubmitted: (_) => controller.login(),
            validator: (val) {
              if (val == null || val.isEmpty) return s.passwordRequired;
              if (!val.isValidPassword) return s.passwordMinLength;
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return Obx(
      () => AppButton(
        label: S.current.signIn,
        isLoading: controller.isLoginLoading.value,
        onPressed: controller.login,
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    final s = S.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          s.dontHaveAccount,
          style: context.appTextTheme.bodyMedium,
        ),
        TextButton(
          onPressed: () => Get.toNamed(AppRoutes.register),
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            s.register,
            style: context.appTextTheme.bodyMedium?.copyWith(
              color: context.colors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
