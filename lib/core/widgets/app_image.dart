import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../extensions/app_extensions.dart';

class AppImage extends StatelessWidget {
  const AppImage({
    super.key,
    this.path,
    this.bytes,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.color,
    this.colorBlendMode,
    this.borderRadius,
    this.isCircle = false,
    this.border,
    this.placeholder,
    this.errorWidget,
    this.fallbackIcon = Icons.image_not_supported_outlined,
    this.semanticLabel,
    this.headers,
    this.package,
  });

  final String? path;
  final Uint8List? bytes;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Alignment alignment;
  final Color? color;
  final BlendMode? colorBlendMode;
  final BorderRadius? borderRadius;
  final bool isCircle;
  final BoxBorder? border;
  final Widget? placeholder;
  final Widget? errorWidget;
  final IconData fallbackIcon;
  final String? semanticLabel;
  final Map<String, String>? headers;
  final String? package;

  String _cleanPath(String p) {
    final s = p.trim().replaceAll(r'\', '/');
    if (s.startsWith('http://')) {
      return 'http://${s.substring(7).replaceAll(RegExp(r'/+'), '/')}';
    } else if (s.startsWith('https://')) {
      return 'https://${s.substring(8).replaceAll(RegExp(r'/+'), '/')}';
    }
    return s.replaceAll(RegExp(r'/+'), '/');
  }

  bool _isNetwork(String p) =>
      p.startsWith('http://') || p.startsWith('https://');

  bool _isSvg(String p) =>
      p.toLowerCase().split('?').first.endsWith('.svg');

  bool _isBase64(String p) =>
      p.startsWith('data:image') ||
      (!p.contains('/') && !p.contains('\\') && p.length > 100);

  Uint8List? _parseBase64(String p) {
    try {
      final clean = p.contains(',') ? p.split(',').last : p;
      return base64Decode(clean);
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (bytes != null) {
      content = Image.memory(
        bytes!,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
        color: color,
        colorBlendMode: colorBlendMode,
        semanticLabel: semanticLabel,
        errorBuilder: (_, __, ___) => _buildError(context),
      );
    } else if (path == null || path!.trim().isEmpty) {
      content = _buildError(context);
    } else {
      final rawPath = _cleanPath(path!);

      if (_isSvg(rawPath)) {
        content = _buildSvg(context, rawPath);
      } else if (_isBase64(rawPath)) {
        final decoded = _parseBase64(rawPath);
        if (decoded != null) {
          content = Image.memory(
            decoded,
            width: width,
            height: height,
            fit: fit,
            alignment: alignment,
            color: color,
            colorBlendMode: colorBlendMode,
            semanticLabel: semanticLabel,
            errorBuilder: (_, __, ___) => _buildError(context),
          );
        } else {
          content = _buildError(context);
        }
      } else if (_isNetwork(rawPath)) {
        content = Image.network(
          rawPath,
          width: width,
          height: height,
          fit: fit,
          alignment: alignment,
          color: color,
          colorBlendMode: colorBlendMode,
          headers: headers,
          semanticLabel: semanticLabel,
          loadingBuilder: (ctx, child, progress) {
            if (progress == null) return child;
            return _buildPlaceholder(context);
          },
          errorBuilder: (_, __, ___) => _buildError(context),
        );
      } else if (rawPath.startsWith('assets/')) {
        content = Image.asset(
          rawPath,
          width: width,
          height: height,
          fit: fit,
          alignment: alignment,
          color: color,
          colorBlendMode: colorBlendMode,
          package: package,
          semanticLabel: semanticLabel,
          errorBuilder: (_, __, ___) => _buildError(context),
        );
      } else {
        final file = File(rawPath);
        if (file.existsSync()) {
          content = Image.file(
            file,
            width: width,
            height: height,
            fit: fit,
            alignment: alignment,
            color: color,
            colorBlendMode: colorBlendMode,
            semanticLabel: semanticLabel,
            errorBuilder: (_, __, ___) => _buildError(context),
          );
        } else {
          content = Image.asset(
            rawPath,
            width: width,
            height: height,
            fit: fit,
            alignment: alignment,
            color: color,
            colorBlendMode: colorBlendMode,
            package: package,
            semanticLabel: semanticLabel,
            errorBuilder: (_, __, ___) => _buildError(context),
          );
        }
      }
    }

    if (isCircle) {
      content = ClipOval(child: content);
    } else if (borderRadius != null) {
      content = ClipRRect(borderRadius: borderRadius!, child: content);
    }

    if (border != null) {
      content = Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: border,
          shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: isCircle ? null : borderRadius,
        ),
        child: content,
      );
    }

    return SizedBox(
      width: width,
      height: height,
      child: content,
    );
  }

  Widget _buildSvg(BuildContext context, String rawPath) {
    if (_isNetwork(rawPath)) {
      return SvgPicture.network(
        rawPath,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
        colorFilter:
            color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
        headers: headers,
        semanticsLabel: semanticLabel,
        placeholderBuilder: (_) => _buildPlaceholder(context),
        errorBuilder: (_, __, ___) => _buildError(context),
      );
    } else if (rawPath.startsWith('assets/')) {
      return SvgPicture.asset(
        rawPath,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
        package: package,
        colorFilter:
            color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
        semanticsLabel: semanticLabel,
        placeholderBuilder: (_) => _buildPlaceholder(context),
        errorBuilder: (_, __, ___) => _buildError(context),
      );
    }

    final file = File(rawPath);
    if (file.existsSync()) {
      return SvgPicture.file(
        file,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
        colorFilter:
            color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
        semanticsLabel: semanticLabel,
        placeholderBuilder: (_) => _buildPlaceholder(context),
        errorBuilder: (_, __, ___) => _buildError(context),
      );
    }

    return SvgPicture.asset(
      rawPath,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      package: package,
      colorFilter:
          color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
      semanticsLabel: semanticLabel,
      placeholderBuilder: (_) => _buildPlaceholder(context),
      errorBuilder: (_, __, ___) => _buildError(context),
    );
  }

  Widget _buildPlaceholder(BuildContext context) {
    if (placeholder != null) return placeholder!;
    final colors = context.colors;

    return Container(
      width: width,
      height: height,
      color: colors.surfaceContainerHighest,
      child: Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(colors.primary),
          ),
        ),
      ),
    );
  }

  Widget _buildError(BuildContext context) {
    if (errorWidget != null) return errorWidget!;
    final colors = context.colors;

    final iconSize = width != null && height != null
        ? (width! < height! ? width! : height!) * 0.4
        : 28.0;

    return Container(
      width: width,
      height: height,
      color: colors.surfaceContainerHighest,
      child: Center(
        child: Icon(
          fallbackIcon,
          color: colors.outlineVariant,
          size: iconSize,
        ),
      ),
    );
  }
}
