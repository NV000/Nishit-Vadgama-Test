import 'package:get/get.dart';
import '../../auth/controller/auth_controller.dart';

class HomeController extends GetxController {
  AuthController get _auth => Get.find<AuthController>();

  String get userName => _auth.currentUser.value?.name ?? 'User';
  String get userEmail => _auth.currentUser.value?.email ?? '';
  String get userRole => _auth.currentUser.value?.role ?? '';

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  Future<void> _loadData() async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 500));
    isLoading.value = false;
  }

  Future<void> logout() async {
    await _auth.logout();
  }
}

