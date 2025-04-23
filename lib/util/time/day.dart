import 'month.dart';
import 'year.dart';

/// Represents a day of the month (1 to 31).
///
/// This class primarily wraps an integer value, ensuring it falls within
/// the valid range for a day component of a date.
class Day implements Comparable<Day> {
  /// The integer value of the day (1 to 31).
  final int value;

  /// Creates a Day instance.
  ///
  /// Throws ArgumentError if the [value] is not between 1 and 31.
  Day(this.value) {
    if (value < 1 || value > 31) {
      throw ArgumentError(
          'Invalid day number: $value. Must be between 1 and 31.');
    }
  }

  /// Creates a Day instance from a standard Dart DateTime object.
  factory Day.fromDateTime(DateTime dateTime) => Day(dateTime.day);

  Day clamp(Year year, Month month) =>
      Day(value.clamp(1, month.daysCount(year)));

  @override
  int get hashCode => value.hashCode;

  /// formatted two-digit string (e.g., "01", "15").
  String twoDigit() => value.toString().padLeft(2, '0');

  @override
  String toString() => value.toString();

  @override
  int compareTo(Day other) => value.compareTo(other.value);

  // --- Operator Overloads for Convenience ---

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Day && runtimeType == other.runtimeType && value == other.value;

  /// Checks if this day is strictly before another day.
  bool operator <(Day other) => value < other.value;

  /// Checks if this day is before or the same as another day.
  bool operator <=(Day other) => value <= other.value;

  /// Checks if this day is strictly after another day.
  bool operator >(Day other) => value > other.value;

  /// Checks if this day is after or the same as another day.
  bool operator >=(Day other) => value >= other.value;
}
