import 'package:flutter/material.dart';

/// A customized text form field widget that wraps [TextFormField] with common styling options and validation.
///
/// Provides convenient parameters for label, hint, icons, border, validation, etc.,
/// while allowing for full customization by passing a custom [InputDecoration].
class MyTextFormField extends StatelessWidget {
  /// Creates a customized text form field.
  const MyTextFormField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.iconData,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixWidget,
    this.onClick,
    this.onChanged,
    this.onSubmitted,
    this.onSaved,
    this.validator,
    this.border = true, // Default to having an outline border
    this.enabled = true, // Default to enabled
    this.readOnly = false,
    this.obscureText = false,
    this.autofocus = false,
    this.minLines,
    this.maxLines = 1, // Default to single line like TextField
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.sentences, // Sensible default
    this.inputDecoration, // Allow providing a full custom decoration
    this.hintStyle, // Allow overriding hint style
  })  : assert(prefixIcon == null || iconData == null,
            'Cannot provide both prefixIcon and iconData'),
        assert(suffixIcon == null || suffixWidget == null,
            'Cannot provide both suffixIcon and suffixWidget');

  /// Controls the text being edited.
  final TextEditingController? controller;

  /// Optional text to display above the text field.
  final String? label;

  /// Text that suggests what sort of input the field accepts.
  final String? hint;

  /// Optional icon to display before the input field and outside the border.
  /// Use this OR [prefixIcon], not both.
  final IconData? iconData;

  /// Optional widget to display before the input field and inside the border.
  /// Use this OR [iconData], not both.
  final Widget? prefixIcon;

  /// Optional widget to display after the input field and inside the border.
  /// Use this OR [suffixWidget], not both.
  final Widget? suffixIcon;

  /// Optional widget to display inline at the end of the text field.
  /// Use this OR [suffixIcon], not both.
  final Widget? suffixWidget;

  /// Called when the user taps this text field.
  final VoidCallback? onClick;

  /// Called when the text being edited changes. Added for TextFormField.
  final ValueChanged<String>? onChanged;

  /// Called when the user indicates that they are done editing the text in the field.
  final ValueChanged<String>? onSubmitted;

  /// Called when the form is saved. Added for TextFormField.
  final FormFieldSetter<String>? onSaved;

  /// An optional method that validates the input. Added for TextFormField.
  final FormFieldValidator<String>? validator;

  /// Whether to show an `OutlineInputBorder` or `InputBorder.none`.
  final bool border;

  /// Whether the text can be changed. Defaults to true.
  final bool enabled;

  /// Whether the text field is read-only. Defaults to false.
  final bool readOnly;

  /// Whether to hide the text being edited (e.g., for passwords). Defaults to false.
  final bool obscureText;

  /// Whether this text field should focus itself if nothing else is already focused. Defaults to false.
  final bool autofocus;

  /// The minimum number of lines to occupy. Null means default behavior (usually 1).
  final int? minLines;

  /// The maximum number of lines to occupy. Defaults to 1.
  final int? maxLines;

  /// The type of keyboard to use for editing the text.
  final TextInputType? keyboardType;

  /// The type of action button to use for the keyboard.
  final TextInputAction? textInputAction;

  /// Configures how the platform keyboard behaves regarding capitalization.
  final TextCapitalization textCapitalization;

  /// Overrides the default generated [InputDecoration].
  /// If provided, parameters like [label], [hint], [iconData], [prefixIcon],
  /// [suffixIcon], [suffixWidget], and [border] are ignored.
  final InputDecoration? inputDecoration;

  /// Overrides the hint style. If not provided, merges a default
  /// font variation with the theme's hint style.
  final TextStyle? hintStyle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final inputDecorationTheme = theme.inputDecorationTheme;

    // Determine the final decoration
    final effectiveDecoration = inputDecoration ??
        InputDecoration(
          labelText: label,
          hintText: hint,
          hintStyle: hintStyle ??
              inputDecorationTheme.hintStyle?.copyWith(
                  fontVariations: const [FontVariation.weight(450)]) ??
              const TextStyle(fontVariations: [FontVariation.weight(450)]),
          prefixIcon: prefixIcon ?? (iconData != null ? Icon(iconData) : null),
          suffixIcon: suffixIcon,
          suffix: suffixWidget,
          border: border ? const OutlineInputBorder() : InputBorder.none,
          floatingLabelAlignment: FloatingLabelAlignment.start,
          alignLabelWithHint: true,
        );

    return TextFormField(
      key: key,
      controller: controller,
      decoration: effectiveDecoration,
      enabled: enabled,
      readOnly: readOnly,
      obscureText: obscureText,
      autofocus: autofocus,
      minLines: minLines,
      maxLines: maxLines,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      onTap: onClick,
      onFieldSubmitted: onSubmitted,
      onChanged: onChanged,
      onSaved: onSaved,
      validator: validator,
    );
  }
}
