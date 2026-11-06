import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../core/extensions/app_extensions.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_page.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/language_switch_widget.dart';
import '../../../generated/l10n.dart';
import '../controller/auth_controller.dart';

class RegisterPage extends GetView<AuthController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppPage(
      appBar: AppBar(
        title: Text(s.createAccount),
        leading: const BackButton(),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(child: LanguageSwitchWidget()),
          ),
        ],
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Form(
            key: controller.registerFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  s.fillInYourDetails,
                  style: context.appTextTheme.bodyMedium?.copyWith(
                    color: context.colors.outline,
                  ),
                ),
                const SizedBox(height: 24),
                AppTextField(
                  controller: controller.regNameCtrl,
                  label: s.fullName,
                  hint: s.enterYourFullName,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  prefixIcon: const Icon(Icons.person_outline_rounded, size: 20),
                  autofillHints: const [AutofillHints.name],
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) return s.nameRequired;
                    if (val.trim().length < 2) return s.nameTooShort;
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: controller.regEmailCtrl,
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
                AppTextField(
                  controller: controller.regMobileCtrl,
                  label: s.mobileNumber,
                  hint: s.mobileHint,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  prefixIcon: const Icon(Icons.phone_outlined, size: 20),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  autofillHints: const [AutofillHints.telephoneNumber],
                  validator: (val) {
                    if (val == null || val.isEmpty) return s.mobileRequired;
                    if (!val.isValidPhone) return s.validMobile;
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Obx(
                  () => AppTextField(
                    controller: controller.regPasswordCtrl,
                    label: s.password,
                    hint: s.passwordMinLength,
                    obscureText: !controller.isPasswordVisible.value,
                    textInputAction: TextInputAction.next,
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
                    autofillHints: const [AutofillHints.newPassword],
                    validator: (val) {
                      if (val == null || val.isEmpty) return s.passwordRequired;
                      if (!val.isValidPassword) return s.passwordMinLength;
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Obx(
                  () => AppTextField(
                    controller: controller.regConfirmPasswordCtrl,
                    label: s.confirmPassword,
                    hint: s.reEnterPassword,
                    obscureText: !controller.isConfirmPasswordVisible.value,
                    textInputAction: TextInputAction.done,
                    prefixIcon: const Icon(Icons.lock_outline_rounded, size: 20),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isConfirmPasswordVisible.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 20,
                      ),
                      onPressed: controller.toggleConfirmPasswordVisibility,
                    ),
                    onFieldSubmitted: (_) => controller.register(),
                    validator: (val) {
                      if (val == null || val.isEmpty) return s.confirmPasswordRequired;
                      if (val != controller.regPasswordCtrl.text) {
                        return s.passwordsDoNotMatch;
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 32),
                Obx(
                  () => AppButton(
                    label: s.createAccount,
                    isLoading: controller.isRegisterLoading.value,
                    onPressed: controller.register,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      s.alreadyHaveAccount,
                      style: context.appTextTheme.bodyMedium,
                    ),
                    TextButton(
                      onPressed: () => Get.back(),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        s.signIn,
                        style: context.appTextTheme.bodyMedium?.copyWith(
                          color: context.colors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
