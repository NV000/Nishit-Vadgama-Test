import 'package:flutter/material.dart';
import '../../generated/l10n.dart';

extension AppContextExtensions on BuildContext {
  S get l10n => S.of(this);
  ColorScheme get colors => Theme.of(this).colorScheme;
  TextTheme get appTextTheme => Theme.of(this).textTheme;
  ThemeData get appTheme => Theme.of(this);

  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;

  EdgeInsets get viewPadding => MediaQuery.paddingOf(this);
  EdgeInsets get viewInsets => MediaQuery.viewInsetsOf(this);

  bool get isKeyboardOpen => MediaQuery.viewInsetsOf(this).bottom > 0;

  void dismissKeyboard() => FocusScope.of(this).unfocus();
}

extension AppStringExtensions on String {
  String get capitalize => isEmpty ? '' : '${this[0].toUpperCase()}${substring(1)}';

  String get titleCase => split(' ').map((w) => w.capitalize).join(' ');

  bool get isValidEmail => RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);

  bool get isValidPhone => RegExp(r'^[6-9]\d{9}$').hasMatch(this);

  bool get isValidPassword => length >= 6;
}

extension AppDateTimeExtensions on DateTime {
  String get formatted => '${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}/$year';

  String get formattedWithTime {
    final h = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    final m = minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';
    return '${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}/$year $h:$m $period';
  }

  String get timeAgo {
    final now = DateTime.now();
    final diff = now.difference(this);
    if (diff.inDays > 365) return '${(diff.inDays / 365).floor()}y ago';
    if (diff.inDays > 30) return '${(diff.inDays / 30).floor()}mo ago';
    if (diff.inDays > 0) return '${diff.inDays}d ago';
    if (diff.inHours > 0) return '${diff.inHours}h ago';
    if (diff.inMinutes > 0) return '${diff.inMinutes}m ago';
    return 'Just now';
  }
}

extension AppNullableStringExtensions on String? {
  String get orEmpty => this ?? '';

  bool get isNullOrEmpty => this == null || this!.isEmpty;
}

extension AppListExtensions<T> on List<T> {
  List<T> get safeList => this;

  T? get firstOrNull => isEmpty ? null : first;
}
