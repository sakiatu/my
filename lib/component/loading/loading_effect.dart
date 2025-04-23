import 'package:flutter/material.dart';

/// A widget that applies a shimmer effect animation to its child.
///
/// This widget wraps a child widget and adds a shimmering effect that moves
/// from topLeft to bottomRight, useful for indicating loading states. The shimmer effect
/// is applied as an overlay on the child widget, preserving its content. The
/// colors adapt to the theme's brightness (light or dark mode).
class MyLoadingEffect extends StatefulWidget {
  /// The child widget to which the shimmer effect is applied.
  final Widget child;

  /// The base color of the shimmer effect (optional, defaults to theme-based).
  final Color? baseColor;

  /// The highlight color that moves across the shimmer effect (optional, defaults to theme-based).
  final Color? highlightColor;

  /// The duration of one complete shimmer animation cycle.
  final Duration duration;

  /// Creates a [MyLoadingEffect] widget.
  ///
  /// Parameters:
  /// - [child]: The widget to which the shimmer effect is applied (required).
  /// - [baseColor]: The base color of the shimmer (optional, defaults to light gray in light mode, dark gray in dark mode).
  /// - [highlightColor]: The highlight color of the shimmer (optional, defaults to lighter gray in light mode, lighter dark gray in dark mode).
  /// - [duration]: The duration of the animation cycle (default: 800ms).
  /// - [key]: An optional key to control the widget's identity.
  const MyLoadingEffect({
    super.key,
    required this.child,
    this.baseColor,
    this.highlightColor,
    this.duration = const Duration(milliseconds: 800),
  });

  @override
  _MyLoadingEffectState createState() => _MyLoadingEffectState();
}

/// The state class for [MyLoadingEffect] that manages the animation.
class _MyLoadingEffectState extends State<MyLoadingEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    /// Initializes the animation controller and sets it to repeat.
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat(reverse: true);

    /// Creates a tween animation for the shimmer effect.
    _animation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    /// Disposes the animation controller to free resources.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Determine if the theme is dark or light
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Set default colors based on theme
    final effectiveBaseColor = widget.baseColor ??
        (isDarkMode ? Colors.grey[800]! : Colors.grey[300]!);
    final effectiveHighlightColor = widget.highlightColor ??
        (isDarkMode ? Colors.grey[600]! : Colors.grey[100]!);

    return ShaderMask(
        shaderCallback: (bounds) {
          return LinearGradient(
            colors: [
              effectiveBaseColor,
              effectiveHighlightColor,
              effectiveBaseColor
            ],
            stops: [0.0, _animation.value, 1.0],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds);
        },
        blendMode: BlendMode.srcATop,
        child: widget.child);
  }
}
