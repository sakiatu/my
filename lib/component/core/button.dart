import 'package:flutter/material.dart';

enum _Variant {
  normal,
  filled,
  elevated,
  tonal,
  text,
  outlined,
  danger,
  tonalDanger,
  textDanger,
  outlinedDanger,
}

class MyButton extends StatelessWidget {
  final String? label;
  final double height;
  final double stroke;
  final TextStyle? labelStyle;
  final IconData? icon;
  final Color? iconColor;
  final VoidCallback? onPressed;
  final _Variant _variant;
  final bool loading;
  final bool disabled;
  final bool fullWidth;
  final bool iconOnly;
  final bool labelOnly;
  final bool iconWithLabel;

  const MyButton._({
    super.key,
    this.label,
    this.labelStyle,
    this.icon,
    this.iconColor,
    this.onPressed,
    double? height,
    double? stroke,
    required _Variant variant,
    this.loading = false,
    this.disabled = false,
    this.fullWidth = true,
  })  : _variant = variant,
        height = height ?? 48,
        stroke = stroke ?? 1.5,
        iconWithLabel = icon != null && label != null,
        iconOnly = icon != null && label == null,
        labelOnly = label != null && icon == null;

  factory MyButton({
    Key? key,
    String? label,
    TextStyle? labelStyle,
    IconData? icon,
    Color? iconColor,
    VoidCallback? onPressed,
    bool loading = false,
    bool disabled = false,
    bool fullWidth = true,
  }) =>
      MyButton._(
        key: key,
        label: label,
        labelStyle: labelStyle,
        icon: icon,
        iconColor: iconColor,
        onPressed: onPressed,
        variant: _Variant.normal,
        loading: loading,
        disabled: disabled,
        fullWidth: fullWidth,
      );

  factory MyButton.filled({
    Key? key,
    String? label,
    TextStyle? labelStyle,
    IconData? icon,
    Color? iconColor,
    VoidCallback? onPressed,
    bool loading = false,
    bool disabled = false,
    bool fullWidth = true,
  }) =>
      MyButton._(
        key: key,
        label: label,
        labelStyle: labelStyle,
        icon: icon,
        iconColor: iconColor,
        onPressed: onPressed,
        variant: _Variant.filled,
        loading: loading,
        disabled: disabled,
        fullWidth: fullWidth,
      );

  factory MyButton.elevated({
    Key? key,
    String? label,
    TextStyle? labelStyle,
    IconData? icon,
    Color? iconColor,
    VoidCallback? onPressed,
    bool loading = false,
    bool disabled = false,
    bool fullWidth = true,
  }) =>
      MyButton._(
        key: key,
        label: label,
        labelStyle: labelStyle,
        icon: icon,
        iconColor: iconColor,
        onPressed: onPressed,
        variant: _Variant.elevated,
        loading: loading,
        disabled: disabled,
        fullWidth: fullWidth,
      );

  factory MyButton.tonal({
    Key? key,
    String? label,
    TextStyle? labelStyle,
    IconData? icon,
    Color? iconColor,
    VoidCallback? onPressed,
    bool loading = false,
    bool disabled = false,
    bool fullWidth = true,
  }) =>
      MyButton._(
        key: key,
        label: label,
        labelStyle: labelStyle,
        icon: icon,
        iconColor: iconColor,
        onPressed: onPressed,
        variant: _Variant.tonal,
        loading: loading,
        disabled: disabled,
        fullWidth: fullWidth,
      );

  factory MyButton.text({
    Key? key,
    String? label,
    TextStyle? labelStyle,
    IconData? icon,
    Color? iconColor,
    VoidCallback? onPressed,
    bool loading = false,
    bool disabled = false,
    bool fullWidth = true,
  }) =>
      MyButton._(
        key: key,
        label: label,
        labelStyle: labelStyle,
        icon: icon,
        iconColor: iconColor,
        onPressed: onPressed,
        variant: _Variant.text,
        loading: loading,
        disabled: disabled,
        fullWidth: fullWidth,
      );

  factory MyButton.outlined({
    Key? key,
    String? label,
    TextStyle? labelStyle,
    IconData? icon,
    Color? iconColor,
    double? stroke,
    VoidCallback? onPressed,
    bool loading = false,
    bool disabled = false,
    bool fullWidth = true,
  }) =>
      MyButton._(
        key: key,
        label: label,
        labelStyle: labelStyle,
        icon: icon,
        iconColor: iconColor,
        stroke: stroke,
        onPressed: onPressed,
        variant: _Variant.outlined,
        loading: loading,
        disabled: disabled,
        fullWidth: fullWidth,
      );

  factory MyButton.danger({
    Key? key,
    String? label,
    TextStyle? labelStyle,
    IconData? icon,
    Color? iconColor,
    VoidCallback? onPressed,
    bool loading = false,
    bool disabled = false,
    bool fullWidth = true,
  }) =>
      MyButton._(
        key: key,
        label: label,
        labelStyle: labelStyle,
        icon: icon,
        iconColor: iconColor,
        onPressed: onPressed,
        variant: _Variant.danger,
        loading: loading,
        disabled: disabled,
        fullWidth: fullWidth,
      );

  factory MyButton.tonalDanger({
    Key? key,
    String? label,
    TextStyle? labelStyle,
    IconData? icon,
    Color? iconColor,
    VoidCallback? onPressed,
    bool loading = false,
    bool disabled = false,
    bool fullWidth = true,
  }) =>
      MyButton._(
        key: key,
        label: label,
        labelStyle: labelStyle,
        icon: icon,
        iconColor: iconColor,
        onPressed: onPressed,
        variant: _Variant.tonalDanger,
        loading: loading,
        disabled: disabled,
        fullWidth: fullWidth,
      );

  factory MyButton.textDanger({
    Key? key,
    String? label,
    TextStyle? labelStyle,
    IconData? icon,
    Color? iconColor,
    VoidCallback? onPressed,
    bool loading = false,
    bool disabled = false,
    bool fullWidth = true,
  }) =>
      MyButton._(
        key: key,
        label: label,
        labelStyle: labelStyle,
        icon: icon,
        iconColor: iconColor,
        onPressed: onPressed,
        variant: _Variant.textDanger,
        loading: loading,
        disabled: disabled,
        fullWidth: fullWidth,
      );

  factory MyButton.outlinedDanger({
    Key? key,
    String? label,
    TextStyle? labelStyle,
    IconData? icon,
    Color? iconColor,
    double? stroke,
    VoidCallback? onPressed,
    bool loading = false,
    bool disabled = false,
    bool fullWidth = true,
  }) =>
      MyButton._(
        key: key,
        label: label,
        labelStyle: labelStyle,
        icon: icon,
        iconColor: iconColor,
        stroke: stroke,
        onPressed: onPressed,
        variant: _Variant.outlinedDanger,
        loading: loading,
        disabled: disabled,
        fullWidth: fullWidth,
      );

  Widget _buildContent(BuildContext context) {
    if (loading) return _buildLoader(context);
    if (iconWithLabel) {
      return Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_buildIcon(context), const SizedBox(width: 8), _buildLabel(context)]);
    }
    return iconOnly ? _buildIcon(context) : _buildLabel(context);
  }

  Widget _buildLoader(BuildContext context) {
    final Color color;
    if (_variant case _Variant.danger || _Variant.tonalDanger || _Variant.outlinedDanger || _Variant.textDanger) {
      color = Theme.of(context).colorScheme.error;
    } else {
      color = Theme.of(context).colorScheme.primary;
    }
    return SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2.5, color: color));
  }

  Widget _buildIcon(BuildContext context) => Icon(icon, color: iconColor);

  Widget _buildLabel(BuildContext context) => Text(label ?? 'Button Text Here', style: labelStyle);

  ButtonStyle _getButtonStyle(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final size = fullWidth ? Size.fromHeight(height) : null;

    switch (_variant) {
      case _Variant.normal || _Variant.filled:
        return FilledButton.styleFrom(minimumSize: size);

      case _Variant.elevated:
        return ElevatedButton.styleFrom(minimumSize: size);
      case _Variant.tonal:
        return FilledButton.styleFrom(minimumSize: size);

      case _Variant.text:
        return TextButton.styleFrom(
            foregroundColor: color.primary, backgroundColor: Colors.transparent, minimumSize: size);

      case _Variant.outlined:
        return OutlinedButton.styleFrom(
            foregroundColor: color.primary,
            side: BorderSide(color: color.primary, width: stroke),
            backgroundColor: Colors.transparent,
            minimumSize: size);

      case _Variant.danger:
        return FilledButton.styleFrom(foregroundColor: color.onError, backgroundColor: color.error, minimumSize: size);

      case _Variant.tonalDanger:
        return FilledButton.styleFrom(
            foregroundColor: color.onErrorContainer, backgroundColor: color.errorContainer, minimumSize: size);

      case _Variant.textDanger:
        return TextButton.styleFrom(
            foregroundColor: color.error, backgroundColor: Colors.transparent, minimumSize: size);

      case _Variant.outlinedDanger:
        return OutlinedButton.styleFrom(
            foregroundColor: color.error,
            side: BorderSide(color: color.error, width: 1.5),
            backgroundColor: Colors.transparent,
            minimumSize: size);
    }
  }

  @override
  Widget build(BuildContext context) {
    final action = (disabled || loading) ? null : onPressed;
    final content = _buildContent(context);
    final style = _getButtonStyle(context);

    if (iconOnly) {
      return switch (_variant) {
        _Variant.elevated => ElevatedButton(onPressed: action, style: style, child: content),
        _Variant.filled || _Variant.danger => IconButton.filled(onPressed: action, style: style, icon: content),
        _Variant.tonal ||
        _Variant.tonalDanger =>
          IconButton.filledTonal(onPressed: action, style: style, icon: content),
        _Variant.outlined ||
        _Variant.outlinedDanger =>
          IconButton.outlined(onPressed: action, style: style, icon: content),
        _Variant.text ||
        _Variant.textDanger =>
          TextButton.icon(onPressed: action, style: style, icon: content, label: _buildLabel(context)),
        _ => IconButton(onPressed: action, style: style, icon: content),
      };
    }

    return switch (_variant) {
      _Variant.elevated => ElevatedButton(onPressed: action, style: style, child: content),
      _Variant.text || _Variant.textDanger => TextButton(onPressed: action, style: style, child: content),
      _Variant.tonal || _Variant.tonalDanger => FilledButton.tonal(onPressed: action, style: style, child: content),
      _Variant.outlined || _Variant.outlinedDanger => OutlinedButton(onPressed: action, style: style, child: content),
      _ => FilledButton(onPressed: action, style: style, child: content),
    };
  }
}
