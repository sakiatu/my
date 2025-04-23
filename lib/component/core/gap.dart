import 'package:flutter/material.dart';

/// A simple spacing widget that provides both horizontal and vertical space.
/// It's a convenient wrapper around [SizedBox].
class Gap extends StatelessWidget {
  /// The amount of horizontal space.
  final double width;

  /// The amount of vertical space.
  final double height;

  /// Creates a Gap widget with specified horizontal and vertical space.
  const Gap([this.width = 16, this.height = 16, Key? key]) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      SizedBox(key: key, width: width, height: height);
}

/// A simple spacing widget that provides horizontal space only.
/// It's a convenient wrapper around [SizedBox].
class GapX extends StatelessWidget {
  /// The amount of horizontal space.
  final double width;

  /// Creates a GapX widget with specified horizontal space.
  const GapX([this.width = 16, Key? key]) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(key: key, width: width);
}

/// A simple spacing widget that provides vertical space only.
/// It's a convenient wrapper around [SizedBox].
class GapY extends StatelessWidget {
  /// The amount of vertical space.
  final double height;

  /// Creates a GapY widget with specified vertical space.
  const GapY([this.height = 16, Key? key]) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(key: key, height: height);
}
