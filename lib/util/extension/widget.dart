import 'package:flutter/material.dart';

import '../../component/loading/loading_effect.dart';

extension WidgetExtension on Widget {
  /// Wraps the widget in a [Center] widget.
  Widget center() => Center(child: this);

  /// Wraps the widget in an [Expanded] widget with the given flex.
  Widget expand([int flex = 1]) => Expanded(flex: flex, child: this);

  /// Wraps the widget in an [Opacity] widget.
  Widget opacity([double opacity = 1.0]) =>
      Opacity(opacity: opacity, child: this);

  /// Wraps the widget in a [Visibility] widget.
  Widget visible([bool visible = true]) =>
      Visibility(visible: visible, child: this);

  /// Wraps the widget in an [Align] widget with the given alignment.
  Widget align([Alignment alignment = Alignment.center]) =>
      Align(alignment: alignment, child: this);

  /// Wraps the widget in a [MyLoadingEffect] widget.
  Widget loadingEffect() => MyLoadingEffect(child: this);

  /// Wraps the widget in a [GestureDetector] for tap detection.
  Widget onTap(void Function()? onTap) =>
      GestureDetector(onTap: onTap, child: this);

  /// Wraps the widget in a [SingleChildScrollView] for horizontal scrolling.
  Widget scrollableX() =>
      SingleChildScrollView(scrollDirection: Axis.horizontal, child: this);

  /// Wraps the widget in a [SingleChildScrollView] for vertical scrolling.
  Widget scrollableY() =>
      SingleChildScrollView(scrollDirection: Axis.vertical, child: this);

  /// Applies padding to all sides of the widget.
  Widget p([double n = 16.0]) =>
      Padding(padding: EdgeInsets.all(n), child: this);

  /// Applies padding to specific sides of the widget.
  Widget pOnly(
          {double l = 0.0, double t = 0.0, double r = 0.0, double b = 0.0}) =>
      Padding(
          padding: EdgeInsets.only(left: l, top: t, right: r, bottom: b),
          child: this);

  /// Applies horizontal padding to the widget.
  Widget px([double x = 16.0]) => pOnly(l: x, r: x);

  /// Applies vertical padding to the widget.
  Widget py([double y = 16.0]) => pOnly(t: y, b: y);

  /// Applies horizontal and vertical padding respectively to the widget.
  Widget pxy([double x = 16.0, double y = 16.0]) =>
      pOnly(l: x, t: y, r: x, b: y);

  /// Applies left padding to the widget.
  Widget pl([double n = 16.0]) => pOnly(l: n);

  /// Applies right padding to the widget.
  Widget pr([double n = 16.0]) => pOnly(r: n);

  /// Applies top padding to the widget.
  Widget pt([double n = 16.0]) => pOnly(t: n);

  /// Applies bottom padding to the widget.
  Widget pb([double n = 16.0]) => pOnly(b: n);

  /// Wraps the widget in a [Container] with margin on all sides.
  Widget m([double n = 16.0]) =>
      Container(margin: EdgeInsets.all(n), child: this);

  /// Applies margin to specific sides of the widget.
  Widget mOnly(
          {double l = 0.0, double t = 0.0, double r = 0.0, double b = 0.0}) =>
      Container(
          margin: EdgeInsets.only(left: l, top: t, right: r, bottom: b),
          child: this);

  /// Applies horizontal margin to the widget.
  Widget mx([double x = 16.0]) => mOnly(l: x, r: x);

  /// Applies vertical margin to the widget.
  Widget my([double y = 16.0]) => mOnly(t: y, b: y);

  /// Applies horizontal and vertical margin respectively to the widget.
  Widget mxy([double x = 16.0, double y = 16.0]) =>
      mOnly(l: x, t: y, r: x, b: y);

  /// Applies left margin to the widget.
  Widget ml([double n = 16.0]) => mOnly(l: n);

  /// Applies right margin to the widget.
  Widget mr([double n = 16.0]) => mOnly(r: n);

  /// Applies top margin to the widget.
  Widget mt([double n = 16.0]) => mOnly(t: n);

  /// Applies bottom margin to the widget.
  Widget mb([double n = 16.0]) => mOnly(b: n);

  /// Wraps the widget in a [SizedBox] to set its width.
  Widget width([double value = double.infinity]) =>
      SizedBox(width: value, child: this);

  /// Wraps the widget in a [SizedBox] to set its height.
  Widget height([double value = double.infinity]) =>
      SizedBox(height: value, child: this);

  /// Wraps the widget in a [SizedBox] to set its size (width and height).
  Widget size([double value = double.infinity]) =>
      SizedBox(width: value, height: value, child: this);

  /// Wraps the widget in a [ConstrainedBox] to apply constraints.
  Widget constrained({
    double minWidth = 0.0,
    double maxWidth = double.infinity,
    double minHeight = 0.0,
    double maxHeight = double.infinity,
  }) =>
      ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: minWidth,
          maxWidth: maxWidth,
          minHeight: minHeight,
          maxHeight: maxHeight,
        ),
        child: this,
      );

  /// Wraps the widget in a [DecoratedBox] with the given decoration.
  Widget decorated({required Decoration decoration}) =>
      DecoratedBox(decoration: decoration, child: this);

  /// Wraps the widget in a [ClipRRect] with the given border radius.
  Widget clippedRRect(
          {required BorderRadiusGeometry borderRadius,
          Clip clipBehavior = Clip.antiAlias}) =>
      ClipRRect(
          borderRadius: borderRadius, clipBehavior: clipBehavior, child: this);

  /// Wraps the widget in a [ClipOval] for an oval or circular clip.
  Widget clippedOval({Clip clipBehavior = Clip.antiAlias}) =>
      ClipOval(clipBehavior: clipBehavior, child: this);

  /// Wraps the widget in a [Tooltip] to display a message on long press or hover.
  Widget tooltip(String message) => Tooltip(message: message, child: this);

  /// Wraps the widget in a [RotatedBox] to rotate it by a quarter turn.
  Widget rotated({required int quarterTurns}) =>
      RotatedBox(quarterTurns: quarterTurns, child: this);

  /// Wraps the widget in an [AspectRatio] widget.
  Widget withAspectRatio({required double aspectRatio}) =>
      AspectRatio(aspectRatio: aspectRatio, child: this);

  /// Wraps the widget in a [Flexible] widget with the given flex and fit.
  Widget flexible({int flex = 1, FlexFit fit = FlexFit.loose}) =>
      Flexible(flex: flex, fit: fit, child: this);

  /// Wraps the widget in a [Positioned] widget for use in a [Stack].
  Widget positioned({
    double? left,
    double? top,
    double? right,
    double? bottom,
    double? width,
    double? height,
  }) =>
      Positioned(
        left: left,
        top: top,
        right: right,
        bottom: bottom,
        width: width,
        height: height,
        child: this,
      );

  /// Wraps the widget in a [SliverToBoxAdapter] for use in a CustomScrollView.
  Widget asSliver() => SliverToBoxAdapter(child: this);

  /// Wraps the widget in a [Hero] widget for animated transitions.
  Widget hero({required String tag}) => Hero(tag: tag, child: this);

  /// Wraps the widget in an [AnimatedOpacity] for animated opacity changes.
  Widget animatedOpacity(
          {required double opacity,
          required Duration duration,
          Curve curve = Curves.linear}) =>
      AnimatedOpacity(
          opacity: opacity, duration: duration, curve: curve, child: this);

  /// Wraps the widget in an [AnimatedSize] for animated size changes.
  Widget animatedSize(
          {required Duration duration,
          Curve curve = Curves.linear,
          AlignmentGeometry alignment = Alignment.center}) =>
      AnimatedSize(
          duration: duration, curve: curve, alignment: alignment, child: this);
}
