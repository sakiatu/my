/// Represents a calendar year (AD/CE).
///
/// This class wraps an integer value representing the year number.
/// It includes helpers like leap year checks.
class Year implements Comparable<Year> {
  /// The integer value of the year (e.g., 2024).
  final int value;

  /// Creates a Year instance.
  ///
  /// Throws ArgumentError if the [value] is less than 1 (i.e., BCE years are not supported by default).
  Year(this.value) {
    if (value < 1) {
      throw ArgumentError(
          'Invalid year number: $value. Must be 1 or greater (AD/CE).');
    }
  }

  /// Creates a Year instance from a standard Dart DateTime object.
  factory Year.fromDateTime(DateTime dateTime) => Year(dateTime.year);

  /// Creates a Year instance representing the current year based on the system clock.
  factory Year.now() => Year(DateTime.now().year);

  /// Checks if this year is a leap year.
  ///
  /// A year is a leap year if it is divisible by 4,
  /// except for end-of-century years, which must be divisible by 400.
  bool get isLeapYear =>
      (value % 4 == 0) && ((value % 100 != 0) || (value % 400 == 0));

  /// Returns the next year.
  Year get next => Year(value + 1);

  /// Returns the previous year.
  ///
  /// Throws ArgumentError if called on Year(1), as years less than 1 are not supported.
  Year get previous => Year(value - 1);

  /// Returns the number of days in this year (366 for leap years, 365 otherwise).
  int get daysInYear => isLeapYear ? 366 : 365;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Year && runtimeType == other.runtimeType && value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => value.toString();

  @override
  int compareTo(Year other) => value.compareTo(other.value);

  // --- Operator Overloads for Convenience ---

  /// Checks if this year is strictly before another year.
  bool operator <(Year other) => value < other.value;

  /// Checks if this year is before or the same as another year.
  bool operator <=(Year other) => value <= other.value;

  /// Checks if this year is strictly after another year.
  bool operator >(Year other) => value > other.value;

  /// Checks if this year is after or the same as another year.
  bool operator >=(Year other) => value >= other.value;
}
