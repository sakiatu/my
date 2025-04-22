/// Represents a day of the week (Monday to Sunday) with associated properties.
///
/// This class provides static instances for each day and helper methods.
/// It uses the standard Dart DateTime weekday numbering (Monday = 1, ..., Sunday = 7).
class Weekday implements Comparable<Weekday> {
  /// The integer value of the weekday (1 for Monday, 7 for Sunday).
  final int value;
  final String name;
  final String shortName;
  final String shortestName;
  final bool isWeekend;
  final bool isWeekday;

  // Private constructor to control instantiation.
  const Weekday._(this.value, this.name, this.shortName, this.shortestName, this.isWeekend, this.isWeekday);

  /// Represents Monday (value: 1).
  static const Weekday monday = Weekday._(1, 'Monday', 'Mon', 'M', false, true);

  /// Represents Tuesday (value: 2).
  static const Weekday tuesday = Weekday._(2, 'Tuesday', 'Tue', 'T', false, true);

  /// Represents Wednesday (value: 3).
  static const Weekday wednesday = Weekday._(3, 'Wednesday', 'Wed', 'W', false, true);

  /// Represents Thursday (value: 4).
  static const Weekday thursday = Weekday._(4, 'Thursday', 'Thu', 'Th', false, true);

  /// Represents Friday (value: 5).
  static const Weekday friday = Weekday._(5, 'Friday', 'Fri', 'F', false, true);

  /// Represents Saturday (value: 6).
  static const Weekday saturday = Weekday._(6, 'Saturday', 'Sat', 'S', true, false);

  /// Represents Sunday (value: 7).
  static const Weekday sunday = Weekday._(7, 'Sunday', 'Sun', 'Su', true, false);

  /// A list of all Weekday instances in order (Monday to Sunday).
  static const values = <Weekday>[
    monday,
    tuesday,
    wednesday,
    thursday,
    friday,
    saturday,
    sunday,
  ];

  /// Creates a Weekday instance from a standard Dart DateTime weekday integer.
  ///
  /// Throws ArgumentError if the input is not between 1 (Monday) and 7 (Sunday).
  factory Weekday.fromDateTime(DateTime dateTime) => values[dateTime.weekday - 1];

  /// Returns the next day of the week. Wraps around from Sunday to Monday.
  Weekday get next => values[value % 7]; // (1%7=1 -> Tue, 7%7=0 -> Mon)

  /// Returns the previous day of the week. Wraps around from Monday to Sunday.
  Weekday get previous => values[(value - 1 + 7 - 1) % 7]; // Need -1 twice for 0-based index and previous day

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Weekday && runtimeType == other.runtimeType && value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => name;

  @override
  int compareTo(Weekday other) => value.compareTo(other.value);
}
