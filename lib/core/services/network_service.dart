import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../generated/l10n.dart';
import '../theme/app_colors.dart';

class NetworkService extends GetxService {
  static NetworkService get to => Get.find();

  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  final RxBool isConnected = true.obs;
  bool _isDialogShowing = false;

  @override
  void onInit() {
    super.onInit();
    _checkInitialConnection();
    _subscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> _checkInitialConnection() async {
    try {
      final results = await _connectivity.checkConnectivity();
      _updateConnectionStatus(results);
    } catch (_) {}
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    final bool hasConnection = results.any(
      (result) =>
          result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi ||
          result == ConnectivityResult.ethernet,
    );

    isConnected.value = hasConnection;

    if (!hasConnection) {
      _showNoInternetDialog();
    } else {
      _hideNoInternetDialog();
    }
  }

  void _showNoInternetDialog() {
    if (_isDialogShowing) return;
    _isDialogShowing = true;

    Get.dialog(
      PopScope(
        canPop: false,
        child: Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: AppColors.pastelBlue.withValues(alpha: 0.3),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.wifi_off_rounded,
                    size: 32,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  S.current.noInternetTitle,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  S.current.noInternetMessage,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  void _hideNoInternetDialog() {
    if (_isDialogShowing) {
      _isDialogShowing = false;
      if (Get.isDialogOpen == true) {
        Get.back();
      }
    }
  }

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }
}

