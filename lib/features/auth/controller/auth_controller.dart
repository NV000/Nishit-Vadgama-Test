import 'package:get/get.dart';
import '../../../core/widgets/app_snackbar.dart';
import '../../../routes/app_routes.dart';
import '../model/user_model.dart';
import '../repository/auth_repository.dart';

class AuthController extends GetxController {
  final AuthRepository _repo = AuthRepository();

  final isGoogleLoading = false.obs;
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
      if (Get.currentRoute == AppRoutes.auth) {
        Get.offAllNamed(AppRoutes.home);
      }
    }
  }

  Future<void> loginWithGoogle() async {
    isGoogleLoading.value = true;
    final result = await _repo.signInWithGoogle();
    isGoogleLoading.value = false;

    result.fold(
      (error) => AppSnackbar.error(error),
      (user) {
        currentUser.value = user;
        AppSnackbar.success('Welcome, ${user.name ?? 'User'}!');
        Get.offAllNamed(AppRoutes.home);
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
    Get.offAllNamed(AppRoutes.auth);
  }
}
