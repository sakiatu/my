import 'package:flutter/material.dart';

/// A customized Container widget that wraps the standard [Container].
///
/// Provides convenient parameters for padding, margin, color, alignment,
/// and common [BoxDecoration] properties like borderRadius, border, boxShadow,
/// gradient, etc. Allows for full customization by passing a custom [Decoration].
///
/// The [color] property is always applied as part of the [decoration].
/// If a [decoration] is provided and it is NOT a [BoxDecoration], the exposed
/// [BoxDecoration] properties (like color, border, etc.) will be ignored.
@immutable // Mark as immutable
class MyContainer extends StatelessWidget {
  /// The widget below this widget in the tree.
  final Widget? child;

  /// Empty space to inscribe inside the [decoration]. The child, if any, is placed inside this padding.
  final EdgeInsetsGeometry? padding;

  /// Empty space to surround the [decoration] and [child].
  final EdgeInsetsGeometry? margin;

  /// The color to paint behind the [child].
  ///
  /// This color is always applied as part of the [decoration].
  /// If a [decoration] is provided, this color will be merged into it
  /// if the decoration is a [BoxDecoration]. Ignored otherwise.
  final Color? color;

  /// The decoration to paint behind the [child].
  ///
  /// If a [decoration] is provided, the [color] and other exposed common decoration
  /// properties (like border, borderRadius, etc.) will be merged into it
  /// if the decoration is a [BoxDecoration].
  final Decoration? decoration;

  /// The decoration to paint in front of the [child].
  final Decoration? foregroundDecoration;

  /// Align the [child] within the container.
  final AlignmentGeometry? alignment;

  /// The width of the container.
  final double? width;

  /// The height of the container.
  final double? height;

  /// The constraints to apply to the child.
  final BoxConstraints? constraints;

  /// The transformation matrix to apply before painting the container.
  final Matrix4? transform;

  /// The alignment of the origin for the [transform] argument.
  ///
  /// This is applied after the container has been sized and positioned.
  final AlignmentGeometry? transformAlignment;

  /// The content will be clipped according to this option.
  ///
  /// See the [Clip] enum for possible values.
  final Clip clipBehavior;

  // --- Common BoxDecoration Properties Exposed Directly ---

  /// The border of the box.
  ///
  /// Applied if [decoration] is null or a [BoxDecoration]. Ignored otherwise.
  final BoxBorder? border;

  /// The corners of the box.
  ///
  /// Applied if [decoration] is null or a [BoxDecoration]. Ignored otherwise.
  final BorderRadiusGeometry? borderRadius;

  /// A list of shadows cast by the box behind the box.
  ///
  /// Applied if [decoration] is null or a [BoxDecoration]. Ignored otherwise.
  final List<BoxShadow>? boxShadow;

  /// A gradient to use for the box's background.
  ///
  /// Applied if [decoration] is null or a [BoxDecoration]. Ignored otherwise.
  /// If a gradient is specified, the [color] property will be ignored
  /// within the resulting [BoxDecoration], as per [BoxDecoration] rules.
  final Gradient? gradient;

  /// The shape of the box.
  ///
  /// Applied if [decoration] is null or a [BoxDecoration]. Ignored otherwise.
  final BoxShape shape;

  /// An image to paint into the decoration.
  ///
  /// Applied if [decoration] is null or a [BoxDecoration]. Ignored otherwise.
  final DecorationImage? image;

  /// Creates a customized Container widget.
  const MyContainer({
    super.key,
    this.child,
    this.padding,
    this.margin,
    this.color,
    this.decoration,
    this.foregroundDecoration,
    this.alignment,
    this.width,
    this.height,
    this.constraints,
    this.transform,
    this.transformAlignment,
    this.clipBehavior = Clip.none,
    // Initialize common decoration properties
    this.border,
    this.borderRadius,
    this.boxShadow,
    this.gradient,
    this.shape = BoxShape.rectangle, // Default shape
    this.image,
  }) : assert(shape != BoxShape.circle || borderRadius == null,
            'A borderRadius cannot be given when the shape is BoxShape.circle.');

  @override
  Widget build(BuildContext context) {
    Decoration? effectiveDecoration = decoration;

    if (effectiveDecoration is BoxDecoration) {
      // If provided decoration is BoxDecoration, merge into it
      effectiveDecoration = effectiveDecoration.copyWith(
        color: color,
        border: border,
        borderRadius: borderRadius,
        boxShadow: boxShadow,
        gradient: gradient,
        shape: shape,
        image: image,
      );
    } else if (effectiveDecoration == null &&
        (color != null ||
            border != null ||
            borderRadius != null ||
            boxShadow != null ||
            gradient != null ||
            image != null)) {
      // If no decoration and exposed properties are set, create a new BoxDecoration
      effectiveDecoration = BoxDecoration(
        color: color,
        border: border,
        borderRadius: borderRadius,
        boxShadow: boxShadow,
        gradient: gradient,
        shape: shape,
        image: image,
      );
    }
// If decoration is non-BoxDecoration, or null with no exposed properties,
// effectiveDecoration remains the provided decoration or null.
    return Container(
      key: key,
      alignment: alignment,
      padding: padding,
      decoration: effectiveDecoration,
      foregroundDecoration: foregroundDecoration,
      margin: margin,
      width: width,
      height: height,
      constraints: constraints,
      transform: transform,
      transformAlignment: transformAlignment,
      clipBehavior: clipBehavior,
      child: child,
    );
  }
}
