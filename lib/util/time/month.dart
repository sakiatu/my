import 'year.dart';

/// Represents a month of the year (January to December) with associated properties.
///
/// This class provides static instances for each month and helper methods.
/// It uses the standard month numbering (January = 1, ..., December = 12).
class Month implements Comparable<Month> {
  /// The integer value of the month (1 for January, 12 for December).
  final int value;

  /// The full name of the month (e.g., "January").
  final String name;

  /// The common abbreviated name of the month (e.g., "Jan").
  final String shortName;

  // Private constructor to control instantiation.
  const Month._(this.value, this.name, this.shortName);

  /// Represents January (value: 1).
  static const Month january = Month._(1, 'January', 'Jan');

  /// Represents February (value: 2).
  static const Month february = Month._(2, 'February', 'Feb');

  /// Represents March (value: 3).
  static const Month march = Month._(3, 'March', 'Mar');

  /// Represents April (value: 4).
  static const Month april = Month._(4, 'April', 'Apr');

  /// Represents May (value: 5).
  static const Month may = Month._(5, 'May', 'May');

  /// Represents June (value: 6).
  static const Month june = Month._(6, 'June', 'Jun');

  /// Represents July (value: 7).
  static const Month july = Month._(7, 'July', 'Jul');

  /// Represents August (value: 8).
  static const Month august = Month._(8, 'August', 'Aug');

  /// Represents September (value: 9).
  static const Month september = Month._(9, 'September', 'Sep');

  /// Represents October (value: 10).
  static const Month october = Month._(10, 'October', 'Oct');

  /// Represents November (value: 11).
  static const Month november = Month._(11, 'November', 'Nov');

  /// Represents December (value: 12).
  static const Month december = Month._(12, 'December', 'Dec');

  /// A list of all Month instances in order (January to December).
  static const List<Month> values = [
    january,
    february,
    march,
    april,
    may,
    june,
    july,
    august,
    september,
    october,
    november,
    december,
  ];

  /// Creates a Month instance from a standard Dart DateTime object.
  factory Month.fromDateTime(DateTime dateTime) => values[dateTime.month - 1];

  /// Creates a Month instance from an integer value (1-12).
  ///
  /// Throws ArgumentError if the input is not between 1 and 12.
  factory Month(int value) {
    if (value < 1 || value > 12) {
      throw ArgumentError(
          'Invalid month number: $value. Must be between 1 (January) and 12 (December).');
    }
    return values[value - 1];
  }

  /// Returns the next month. Wraps around from December to January.
  Month get next => values[value % 12]; // 1%12=1 (Feb), 12%12=0 (Jan)

  /// Returns the previous month. Wraps around from January to December.
  Month get previous => values[
      (value - 2 + 12) % 12]; // (1-2+12)%12 = 11 (Dec), (12-2+12)%12 = 10 (Nov)

  /// Returns the number of days in this month for the given [year].
  /// Accounts for leap years for February.

  /// Returns the number of days in this month for the current year.
  /// Accounts for leap years for February.
  /// Note: This uses the system's current year at the time of calling.
  int get daysCountThisYear => daysInMonth(Year.now(), this);

  int daysCount(Year year) => daysInMonth(year, this);

  static const _daysInMonth = [
    0,
    31,
    28,
    31,
    30,
    31,
    30,
    31,
    31,
    30,
    31,
    30,
    31
  ];

  static int daysInMonth(Year year, Month month) =>
      month == february && year.isLeapYear ? 29 : _daysInMonth[month.value];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Month &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => name;

  @override
  int compareTo(Month other) => value.compareTo(other.value);
}
