import 'package:flutter/material.dart';

class MySkeleton extends StatelessWidget {
  final double? height;
  final double? width;
  final double cornerRadius;
  final Widget? child;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Color? color;

  const MySkeleton({
    this.height,
    this.width,
    this.color,
    this.margin,
    this.padding,
    this.cornerRadius = 8.0,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Container(
      margin: margin,
      padding: padding,
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: color ?? Theme.of(context).colorScheme.onSurface.withAlpha((0.38*255).toInt()),
          borderRadius: BorderRadius.circular(cornerRadius)),
      child: child);
}
