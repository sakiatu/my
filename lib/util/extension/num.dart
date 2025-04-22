import 'dart:async';
import 'dart:math';
import 'dart:math' as math; // Import for sqrt and pow

/// Provides convenient properties and methods for num (int and double).
extension NumExtension on num {
  /// Returns true if the number is even.
  bool get isEven => this % 2 == 0;

  /// Returns true if the number is odd.
  bool get isOdd => this % 2 != 0;

  /// Returns true if the number is positive (greater than 0).
  bool get isPositive => this > 0;

  /// Returns true if the number is negative (less than 0).
  bool get isNegative => this < 0;

  /// Returns true if the number is zero.
  bool get isZero => this == 0;

  /// Returns true if the number has no fractional part.
  bool get isWhole => this % 1 == 0;

  /// Returns true if the number has a fractional part.
  bool get isFraction => this % 1 != 0;

  /// Returns the absolute value of the number.
  num get abs => this < 0 ? -this : this;

  /// Returns the smallest integer greater than or equal to the number.
  num get ceil => ceilToDouble();

  /// Returns the largest integer less than or equal to the number.
  num get floor => floorToDouble();

  /// Returns the closest integer to the number.
  num get round => roundToDouble();

  /// Returns the integer part of the number.
  num get truncate => truncateToDouble();

  /// Returns the reciprocal of the number (1 / this).
  num get reciprocal => 1 / this;

  /// Returns the square of the number (this * this).
  num get square => this * this;

  /// Returns the cube of the number (this * this * this).
  num get cube => this * this * this;

  /// Returns the square root of the number.
  num get sqrt => math.sqrt(this);

  /// Returns this number raised to the power of [exponent].
  num pow(num exponent) => math.pow(this, exponent);
}

/// Provides convenient getters for creating Duration objects from int.
extension IntDurationExtension on int {
  /// Returns a Duration representing this integer in microseconds.
  Duration get microseconds => Duration(microseconds: this);

  /// Returns a Duration representing this integer in milliseconds.
  Duration get milliseconds => Duration(milliseconds: this);

  /// Returns a Duration representing this integer in seconds.
  Duration get seconds => Duration(seconds: this);

  /// Returns a Duration representing this integer in minutes.
  Duration get minutes => Duration(minutes: this);

  /// Returns a Duration representing this integer in hours.
  Duration get hours => Duration(hours: this);

  /// Returns a Duration representing this integer in days.
  Duration get days => Duration(days: this);
}
