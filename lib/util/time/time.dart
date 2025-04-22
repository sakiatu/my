import 'package:intl/intl.dart';

import 'day.dart';
import 'month.dart';
import 'time_format.dart';
import 'weekday.dart';
import 'year.dart';

/// Represents an immutable point in time, wrapping Dart's [DateTime].
///
/// Provides convenience methods for comparison, manipulation, formatting,
/// and integration with custom date/time part types ([Year], [Month], [Day], [Weekday]).
/// All operations that modify the time return a new [Time] instance.
class Time implements Comparable<Time> {
  /// The underlying Dart DateTime object. Kept private to ensure immutability.
  final DateTime _dateTime;

  // --- Constructors and Factories ---

  /// Creates a Time instance directly from a [DateTime] object.
  const Time(DateTime dateTime) : _dateTime = dateTime;

  /// Creates a Time instance representing the current moment.
  factory Time.now() => Time(DateTime.now());

  /// Creates a Time instance for today's date at the specified time.
  ///
  /// [hour]: The hour (0-23).
  /// [minute]: The minute (0-59).
  /// [second]: The second (0-59), defaults to 0.
  /// [millisecond]: The millisecond (0-999), defaults to 0.
  /// [microsecond]: The microsecond (0-999), defaults to 0.
  factory Time.todayAt(
    int hour,
    int minute, [
    int second = 0,
    int millisecond = 0,
    int microsecond = 0,
  ]) =>
      Time(DateTime.now().copyWith(
        hour: hour,
        minute: minute,
        second: second,
        millisecond: millisecond,
        microsecond: microsecond,
      ));

  /// Parses a string into a [Time] object.
  ///
  /// Supports standard [DateTime] parsable formats (like ISO 8601).
  /// Both UTC ('Z' suffix) and local strings are parsed into local time.
  ///
  /// Also supports time-only strings like 'HH:mm', 'HH:mm:ss', or 'HH:mm:ss.ffffff'.
  /// **Important:** For time-only strings, the date component is set to the *current date*.
  ///
  /// Returns `null` if the input string cannot be parsed.
  static Time? parse(String input) {
    final trimmedInput = input.trim(); // Trim whitespace

    // Try standard DateTime parsing first
    final dateTime = DateTime.tryParse(trimmedInput)?.toLocal();
    if (dateTime != null) return Time(dateTime);

    // Handle time-only ('HH:mm', 'HH:mm:ss' or 'HH:mm:ss.ffffff')
    try {
      final dotSeparated = trimmedInput.split('.');
      final timeParts = dotSeparated[0].split(':');

      // Must have hour and minute, optionally seconds
      if (timeParts.length < 2 || timeParts.length > 3) return null;

      final hour = int.parse(timeParts[0]);
      final minute = int.parse(timeParts[1]);
      final second = timeParts.length > 2 ? int.parse(timeParts[2]) : 0;

      int millisecond = 0;
      int microsecond = 0;
      if (dotSeparated.length > 1) {
        // Correctly parse milliseconds and microseconds
        final fractional = dotSeparated[1].padRight(6, '0'); // Ensure 6 digits
        final millisStr = fractional.substring(0, 3);
        final microsStr = fractional.substring(3, 6);
        millisecond = int.parse(millisStr);
        microsecond = int.parse(microsStr);
      }

      // Use today's date with the parsed time components
      return Time(DateTime.now().copyWith(
        hour: hour,
        minute: minute,
        second: second,
        millisecond: millisecond,
        microsecond: microsecond,
      ));
    } catch (e) {
      // Catch potential parsing errors (e.g., non-integer parts)
      return null;
    }
  }

  // --- Getters for Date/Time Components ---

  /// Returns the underlying [DateTime] object.
  /// Use with caution if mutability is a concern elsewhere.
  DateTime get dateTime => _dateTime;

  /// Gets the hour of the day (0-23).
  int get hour => _dateTime.hour;

  /// Gets the minute of the hour (0-59).
  int get minute => _dateTime.minute;

  /// Gets the second of the minute (0-59).
  int get second => _dateTime.second;

  /// Gets the millisecond of the second (0-999).
  int get millisecond => _dateTime.millisecond;

  /// Gets the microsecond of the second (0-999).
  int get microsecond => _dateTime.microsecond;

  /// Gets the number of milliseconds since the Unix epoch (January 1, 1970, UTC).
  int get millisecondsSinceEpoch => _dateTime.millisecondsSinceEpoch;

  /// Gets the number of microseconds since the Unix epoch (January 1, 1970, UTC).
  int get microsecondsSinceEpoch => _dateTime.microsecondsSinceEpoch;

  /// Gets the [Year] part of this time instance.
  Year get year => Year.fromDateTime(_dateTime);

  /// Gets the [Month] part of this time instance.
  Month get month => Month.fromDateTime(_dateTime);

  /// Gets the [Day] part of this time instance.
  Day get day => Day.fromDateTime(_dateTime);

  /// Gets the [Weekday] part of this time instance.
  Weekday get weekday => Weekday.fromDateTime(_dateTime);

  // --- Boolean Checks ---

  /// Checks if this time instance falls on the current date.
  bool get isToday {
    // Capture now once for comparison
    final now = Time.now();
    return isSameDay(now);
  }

  /// Checks if this time instance falls on the date after the current date.
  bool get isTomorrow {
    final tomorrow = Time.now().addDays(1);
    return isSameDay(tomorrow);
  }

  /// Checks if this time instance falls on the date before the current date.
  bool get isYesterday {
    final yesterday = Time.now().subtractDays(1);
    return isSameDay(yesterday);
  }

  /// Checks if this time instance is before the current moment.
  bool get isBeforeNow => _dateTime.isBefore(DateTime.now());

  /// Checks if this time instance is after the current moment.
  bool get isAfterNow => _dateTime.isAfter(DateTime.now());

  // --- Start/End of Day ---

  /// Returns a new [Time] instance representing the start of the day (00:00:00.000000).
  Time get startOfDay => Time(_dateTime.copyWith(hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0));

  /// Returns a new [Time] instance representing the very end of the day (23:59:59.999999).
  Time get endOfDay => Time(_dateTime.copyWith(hour: 23, minute: 59, second: 59, millisecond: 999, microsecond: 999));

  // --- Comparison Methods ---

  /// Checks if this [Time] instance represents the same calendar day as [other].
  /// Ignores the time part.
  bool isSameDay(Time other) => year == other.year && month == other.month && day == other.day;

  /// Checks if this [Time] instance is in the same calendar month as [other].
  /// Ignores day and time parts.
  bool isSameMonth(Time other) => year == other.year && month == other.month;

  /// Checks if this [Time] instance is in the same calendar year as [other].
  bool isSameYear(Time other) => year == other.year;

  /// Checks if this time instance is chronologically after [other].
  bool isAfter(Time other) => _dateTime.isAfter(other._dateTime);

  /// Checks if this time instance is chronologically before [other].
  bool isBefore(Time other) => _dateTime.isBefore(other._dateTime);

  /// Checks if this time instance falls within the specified range.
  ///
  /// By default, the range is inclusive of the start time and exclusive of the end time.
  /// Use [inclusiveStart] and [inclusiveEnd] to control boundary behavior.
  bool isInRange(Time start, Time end, {bool inclusiveStart = true, bool inclusiveEnd = true}) {
    bool afterStart = inclusiveStart ? !isBefore(start) : isAfter(start); // !isBefore includes same moment
    bool beforeEnd = inclusiveEnd ? !isAfter(end) : isBefore(end); // !isAfter includes same moment
    return afterStart && beforeEnd;
  }

  /// Checks if this time instance represents the exact same moment as [other].
  bool isAtSameMomentAs(Time other) => _dateTime.isAtSameMomentAs(other._dateTime);

  // --- Duration & Manipulation Methods ---

  /// Returns a new [Time] instance with the given [duration] added.
  Time add(Duration duration) => Time(_dateTime.add(duration));

  /// Returns a new [Time] instance with the specified number of [days] added.
  Time addDays(int days) => Time(_dateTime.add(Duration(days: days)));

  /// Returns a new [Time] instance with the specified number of [hours] added.
  Time addHours(int hours) => Time(_dateTime.add(Duration(hours: hours)));

  /// Returns a new [Time] instance with the specified number of [minutes] added.
  Time addMinutes(int minutes) => Time(_dateTime.add(Duration(minutes: minutes)));

  /// Returns a new [Time] instance with the specified number of [seconds] added.
  Time addSeconds(int seconds) => Time(_dateTime.add(Duration(seconds: seconds)));

  /// Returns a new [Time] instance with the given [duration] subtracted.
  Time subtract(Duration duration) => Time(_dateTime.subtract(duration));

  /// Returns a new [Time] instance with the specified number of [days] subtracted.
  Time subtractDays(int days) => Time(_dateTime.subtract(Duration(days: days)));

  /// Returns a new [Time] instance with the specified number of [hours] subtracted.
  Time subtractHours(int hours) => Time(_dateTime.subtract(Duration(hours: hours)));

  /// Returns a new [Time] instance with the specified number of [minutes] subtracted.
  Time subtractMinutes(int minutes) => Time(_dateTime.subtract(Duration(minutes: minutes)));

  /// Returns a new [Time] instance with the specified number of [seconds] subtracted.
  Time subtractSeconds(int seconds) => Time(_dateTime.subtract(Duration(seconds: seconds)));

  // --- Time Zone Methods ---

  /// Returns a new [Time] instance representing the same moment in UTC.
  Time toUtc() => Time(_dateTime.toUtc());

  /// Returns a new [Time] instance representing the same moment in the local time zone.
  Time toLocal() => Time(_dateTime.toLocal());

  // --- Difference Methods ---

  /// Returns the [Duration] between this time instance and [other].
  /// The duration is positive if this time is later than [other].
  Duration difference(Time other) => _dateTime.difference(other._dateTime);

  /// Returns the [Duration] between this time instance and the current moment.
  Duration differenceFromNow() => difference(Time.now());

  /// Returns the difference in whole seconds between this time and [other].
  int secondDifference(Time other) => difference(other).inSeconds;

  /// Returns the difference in whole minutes between this time and [other].
  int minuteDifference(Time other) => difference(other).inMinutes;

  /// Returns the difference in whole hours between this time and [other].
  int hourDifference(Time other) => difference(other).inHours;

  /// Returns the difference in whole days between this time and [other].
  int dayDifference(Time other) => difference(other).inDays;

  // --- Formatting Methods ---

  /// Formats this time instance using the provided [format] string.
  ///
  /// `TimeFormat` class provides static format strings.
  /// If [utc] is true, formats the time in UTC.
  String format(String formatPattern, [bool utc = false]) =>
      DateFormat(formatPattern).format(utc ? _dateTime.toUtc() : _dateTime);

  /// Formats the time using the 12-hour clock with AM/PM (e.g., "01:52 PM").
  /// `TimeFormat.hhmma` provides the pattern 'hh:mm a'.
  String format12h() => format(TimeFormat.hhmma);

  /// Formats the time using the 24-hour clock with seconds (e.g., "13:52:05").
  /// `TimeFormat.HHmmss` provides the pattern 'HH:mm:ss'.
  String format24h() => format(TimeFormat.HHmmss);

  /// Formats the time in UTC using the 12-hour clock with AM/PM.
  String format12hUtc() => format(TimeFormat.hhmma, true);

  /// Formats the time in UTC using the 24-hour clock with seconds.
  String format24hUtc() => format(TimeFormat.HHmmss, true);

  /// Formats the date part as YYYY-MM-DD (e.g., "2025-04-09").
  /// `TimeFormat.yyyyMMdd` provides the pattern 'yyyy-MM-dd'.
  String formatDate() => format(TimeFormat.yyyyMMdd);

  /// Formats the date part readably (e.g., "09 April 2025").
  /// `TimeFormat.ddMMMMyyyy` provides the pattern 'dd MMMM yyyy'.
  String formatReadableDate() => format(TimeFormat.ddMMMMyyyy);

  /// Formats the date and time (e.g., "2025-04-09 00:11:00").
  /// `TimeFormat.yyyyMMddHHmmss` provides the pattern 'yyyy-MM-dd HH:mm:ss'.
  String formatTime() => format(TimeFormat.yyyyMMddHHmmss);

  /// Formats the date and time readably (e.g., "Wed, 09 Apr 2025 12:11:00 AM").
  /// `TimeFormat.EEEddMMMyyyyhhmmssa` provides 'EEE, dd MMM yyyy hh:mm:ss a'.
  String formatReadableTime() => format(TimeFormat.EEEddMMMyyyyhhmmssa);

  /// Returns an ISO 8601 representation of this time instance.
  String toIso8601String() => _dateTime.toIso8601String();

  /// Returns a string representation of the UTC equivalent of this time instance.
  String toUtcString() => _dateTime.toUtc().toString();

  // --- Comparison and Equality ---

  /// Compares this time instance to [other].
  /// Returns < 0 if this is earlier, 0 if same moment, > 0 if this is later.
  @override
  int compareTo(Time other) => _dateTime.compareTo(other._dateTime);

  /// Creates a copy of this [Time] instance but with the given fields updated.
  Time copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) =>
      Time(_dateTime.copyWith(
        year: year,
        month: month,
        day: day,
        hour: hour,
        minute: minute,
        second: second,
        millisecond: millisecond,
        microsecond: microsecond,
      ));

  /// Returns true if this [Time] instance represents the same moment as [other].
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Time && runtimeType == other.runtimeType && _dateTime == other._dateTime; // Compare underlying DateTime

  /// Returns the hash code for this time instance.
  @override
  int get hashCode => _dateTime.hashCode; // Delegate hashCode

  /// Returns a string representation of the underlying [DateTime] object.
  @override
  String toString() => _dateTime.toString();
}
