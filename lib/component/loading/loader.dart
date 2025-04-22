import 'package:flutter/material.dart';

/// A customized loading indicator widget that wraps [CircularProgressIndicator].
///
/// Provides convenient parameters for color, size, and stroke width.
@immutable
class MyLoader extends StatelessWidget {
  /// The color of the progress indicator.
  ///
  /// If null, the [ProgressIndicatorThemeData.color] or [ThemeData.colorScheme.primary]
  /// will be used.
  final Color? color;

  /// The size of the progress indicator.
  ///
  /// If provided, this sets both the width and height of the [SizedBox]
  /// that wraps the indicator.
  final double? size;

  /// The width of the line used to draw the circle.
  final double strokeWidth;

  /// The value of the progress indicator.
  ///
  /// If null, the indicator is indeterminate (shows a continuous animation).
  /// If non-null, the indicator is determinate and shows the progress from 0.0 to 1.0.
  final double? value;

  /// The color of the track below the progress indicator.
  ///
  /// If null, the [ProgressIndicatorThemeData.backgroundColor] or
  /// [ThemeData.colorScheme.primaryContainer] will be used.
  final Color? backgroundColor;

  /// Creates a customized loading indicator.
  const MyLoader({
    super.key,
    this.color,
    this.size,
    this.strokeWidth = 4.0,
    this.value,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    Widget loader = CircularProgressIndicator(
      key: key,
      valueColor: AlwaysStoppedAnimation<Color>(color ?? primaryColor),
      strokeWidth: strokeWidth,
      value: value,
      backgroundColor: backgroundColor ?? primaryColor.withAlpha((0.3 * 255).toInt()),
    );

    return size == null ? loader : SizedBox(width: size, height: size, child: loader);
  }
}
