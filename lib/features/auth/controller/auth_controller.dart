import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/widgets/app_snackbar.dart';
import '../../../routes/app_routes.dart';
import '../model/user_model.dart';
import '../repository/auth_repository.dart';

class AuthController extends GetxController {
  final AuthRepository _repo = AuthRepository();

  final loginEmailCtrl = TextEditingController();
  final loginPasswordCtrl = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();

  final regNameCtrl = TextEditingController();
  final regEmailCtrl = TextEditingController();
  final regMobileCtrl = TextEditingController();
  final regPasswordCtrl = TextEditingController();
  final regConfirmPasswordCtrl = TextEditingController();
  final registerFormKey = GlobalKey<FormState>();

  final isLoginLoading = false.obs;
  final isRegisterLoading = false.obs;
  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;

  final Rxn<UserModel> currentUser = Rxn<UserModel>();

  @override
  void onInit() {
    super.onInit();
    _loadCachedUser();
  }

  Future<void> _loadCachedUser() async {
    final user = await _repo.getCachedUser();
    if (user != null) {
      currentUser.value = user;
    }
  }

  void togglePasswordVisibility() =>
      isPasswordVisible.value = !isPasswordVisible.value;

  void toggleConfirmPasswordVisibility() =>
      isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;

  Future<void> login() async {
    if (!loginFormKey.currentState!.validate()) return;
    isLoginLoading.value = true;

    final result = await _repo.login(
      email: loginEmailCtrl.text.trim(),
      password: loginPasswordCtrl.text,
    );

    isLoginLoading.value = false;

    result.fold(
      (error) => AppSnackbar.error(error),
      (user) {
        currentUser.value = user;
        AppSnackbar.success('Welcome back, ${user.name ?? 'User'}!');
        Get.offAllNamed(AppRoutes.home);
      },
    );
  }

  Future<void> register() async {
    if (!registerFormKey.currentState!.validate()) return;
    isRegisterLoading.value = true;

    final result = await _repo.register(
      name: regNameCtrl.text.trim(),
      email: regEmailCtrl.text.trim(),
      password: regPasswordCtrl.text,
      mobile: regMobileCtrl.text.trim(),
    );

    isRegisterLoading.value = false;

    result.fold(
      (error) => AppSnackbar.error(error),
      (user) {
        AppSnackbar.success('Account created! Please log in.');
        Get.offNamed(AppRoutes.login);
      },
    );
  }

  Future<void> logout() async {
    final result = await _repo.logout();
    result.fold(
      (_) {},
      (_) {},
    );
    currentUser.value = null;
    Get.offAllNamed(AppRoutes.login);
  }

  @override
  void onClose() {
    loginEmailCtrl.dispose();
    loginPasswordCtrl.dispose();
    regNameCtrl.dispose();
    regEmailCtrl.dispose();
    regMobileCtrl.dispose();
    regPasswordCtrl.dispose();
    regConfirmPasswordCtrl.dispose();
    super.onClose();
  }
}

