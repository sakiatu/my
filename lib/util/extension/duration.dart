import 'dart:async';

/// Provides convenient methods and properties for Duration.
extension DurationExtension on Duration {
  /// Creates a Future that completes after this duration.
  /// An optional [callback] can be executed when the future completes.
  Future<void> delay([FutureOr<void> Function()? callback]) async =>
      Future.delayed(this, callback);

  /// Returns true if this duration is shorter than [other].
  bool isShorterThan(Duration other) => this < other;

  /// Returns true if this duration is longer than [other].
  bool isLongerThan(Duration other) => this > other;

  /// Returns true if this duration is equal to [other].
  bool isEqualTo(Duration other) => this == other;

  /// Returns a new Duration that is the sum of this duration and [other].
  Duration add(Duration other) => this + other;

  /// Returns a new Duration that is the difference between this duration and [other].
  Duration subtract(Duration other) => this - other;

  /// Returns a new Duration that is this duration multiplied by [factor].
  Duration multiplyBy(int factor) => this * factor;

  /// Returns a new Duration that is this duration divided by [factor].
  Duration divideBy(double factor) =>
      Duration(microseconds: (inMicroseconds / factor).round());
}
