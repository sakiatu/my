import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// A widget that applies a shimmering loading effect to its child.
///
/// This effect is typically used as a placeholder while content is loading.
class MyLoadingEffect extends StatefulWidget {
  /// The widget to apply the loading effect to.
  final Widget child;

  /// The duration of one cycle of the shimmer animation.
  final Duration period;

  /// The direction of the shimmer effect.
  final GradientDirection direction;

  /// The colors used for the shimmer gradient.
  /// Defaults to a light gray shimmer effect.
  final List<Color> colors;

  /// The stops for the shimmer gradient.
  /// Defaults to stops that create a typical shimmer wave effect.
  final List<double> stops;

  /// Creates a widget that applies a shimmering loading effect.
  const MyLoadingEffect({
    super.key,
    required this.child,
    this.period = const Duration(milliseconds: 1500),
    this.direction = GradientDirection.leftToRight,
    this.colors = const <Color>[
      Color(0x19000000), // Very light gray/black with low opacity
      Color(0x33000000), // Light gray/black with medium opacity
      Color(0x4C000000), // Medium gray/black with higher opacity
      Color(0x33000000), // Light gray/black with medium opacity
      Color(0x19000000), // Very light gray/black with low opacity
    ],
    this.stops = const <double>[0.0, 0.35, 0.5, 0.65, 1.0],
  });

  @override
  MyLoadingEffectState createState() => MyLoadingEffectState();
}

class MyLoadingEffectState extends State<MyLoadingEffect> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.period)
      ..addStatusListener((AnimationStatus status) {
        // Repeat the animation when it completes
        if (status == AnimationStatus.completed) {
          _controller.repeat();
        }
      });
    // Start the animation
    _controller.forward();
  }

  @override
  void didUpdateWidget(MyLoadingEffect oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If the period changes, update the controller's duration
    if (widget.period != oldWidget.period) {
      _controller.duration = widget.period;
    }
    // Restart the animation if the widget updates
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (BuildContext context, Widget? child) {
        // Pass the current animation value and other parameters to the render object widget
        return _LoadingEffectRenderWidget(
          percent: _controller.value,
          direction: widget.direction,
          colors: widget.colors,
          stops: widget.stops,
          child: child,
        );
      },
    );
  }

  @override
  void dispose() {
    // Dispose the animation controller to prevent memory leaks
    _controller.dispose();
    super.dispose();
  }
}

/// Defines the direction of the shimmer gradient animation.
enum GradientDirection {
  /// The gradient animates from left to right.
  leftToRight,
  /// The gradient animates from right to left.
  rightToLeft,
  /// The gradient animates from top to bottom.
  topToBottom,
  /// The gradient animates from bottom to top.
  bottomToTop,
}

/// A [SingleChildRenderObjectWidget] that creates the [_ShimmerFilter] render object.
class _LoadingEffectRenderWidget extends SingleChildRenderObjectWidget {
  final double percent;
  final GradientDirection direction;
  final List<Color> colors;
  final List<double> stops;

  const _LoadingEffectRenderWidget({
    super.child,
    required this.percent,
    required this.direction,
    required this.colors,
    required this.stops,
  });

  @override
  _ShimmerFilter createRenderObject(BuildContext context) {
    // Create the render object with the initial parameters
    return _ShimmerFilter(percent, direction, colors, stops);
  }

  @override
  void updateRenderObject(BuildContext context, _ShimmerFilter shimmer) {
    // Update the render object's parameters when the widget updates
    shimmer.percent = percent;
    shimmer.direction = direction;
    shimmer.colors = colors;
    shimmer.stops = stops;
  }
}

/// A [RenderProxyBox] that applies a shimmering gradient mask to its child.
class _ShimmerFilter extends RenderProxyBox {
  double _percent;
  GradientDirection _direction;
  List<Color> _colors;
  List<double> _stops;

  _ShimmerFilter(this._percent, this._direction, this._colors, this._stops);

  // Getter for the ShaderMaskLayer, ensuring it's the correct type
  @override
  ShaderMaskLayer? get layer => super.layer as ShaderMaskLayer?;

  // We always need compositing to apply the shader mask
  @override
  bool get alwaysNeedsCompositing => child != null;

  // --- Setters to update properties and trigger repaint ---

  set percent(double newValue) {
    if (newValue == _percent) return;
    _percent = newValue;
    markNeedsPaint(); // Request repaint when the animation value changes
  }

  set direction(GradientDirection newValue) {
    if (newValue == _direction) return;
    _direction = newValue;
    markNeedsPaint(); // Request repaint when the direction changes
  }

  set colors(List<Color> newValue) {
    if (newValue == _colors) return; // Basic list equality check
    _colors = newValue;
    markNeedsPaint(); // Request repaint when colors change
  }

  set stops(List<double> newValue) {
    if (newValue == _stops) return; // Basic list equality check
    _stops = newValue;
    markNeedsPaint(); // Request repaint when stops change
  }

  // --- Painting Logic ---

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      // Ensure compositing is enabled
      assert(needsCompositing);

      final Size size = child!.size;
      Rect rect;
      Offset begin, end;

      // Determine the gradient begin and end points based on the direction
      switch (_direction) {
        case GradientDirection.leftToRight:
          begin = Offset(-size.width, 0.0);
          end = Offset(size.width, 0.0);
          rect = Rect.fromLTWH(_offset(begin.dx, end.dx, _percent), 0.0, 3 * size.width, size.height);
          break;
        case GradientDirection.rightToLeft:
          begin = Offset(size.width, 0.0);
          end = Offset(-size.width, 0.0);
          rect = Rect.fromLTWH(_offset(begin.dx, end.dx, _percent) - 2 * size.width, 0.0, 3 * size.width, size.height);
          break;
        case GradientDirection.topToBottom:
          begin = Offset(0.0, -size.height);
          end = Offset(0.0, size.height);
          rect = Rect.fromLTWH(0.0, _offset(begin.dy, end.dy, _percent), size.width, 3 * size.height);
          break;
        case GradientDirection.bottomToTop:
          begin = Offset(0.0, size.height);
          end = Offset(0.0, -size.height);
          rect = Rect.fromLTWH(0.0, _offset(begin.dy, end.dy, _percent) - 2 * size.height, size.width, 3 * size.height);
          break;
      }

      // Create the gradient shader
      final Gradient gradient = LinearGradient(
        colors: _colors,
        stops: _stops,
        begin: Alignment.topLeft, // Alignment is usually fixed for the gradient pattern
        end: Alignment.bottomRight,
      );

      // Get or create the ShaderMaskLayer
      layer ??= ShaderMaskLayer();
      layer!
        ..shader = gradient.createShader(rect)
        ..maskRect = offset & size // Apply the mask over the child's bounds
        ..blendMode = BlendMode.srcIn; // Standard blend mode for shimmer

      // Push the shader mask layer onto the painting context
      context.pushLayer(layer!, super.paint, offset);
    } else {
      // If there's no child, remove the layer
      layer = null;
    }
  }

  // Helper to calculate the animated offset
  double _offset(double start, double end, double percent) {
    return start + (end - start) * percent;
  }
}
