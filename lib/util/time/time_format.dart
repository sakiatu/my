/// A utility class containing common, fixed date and time format strings
/// as static constants.
///
/// These constants are useful for consistent formatting across an application
/// where a specific, non-localized format is required (example: API communication,
/// logging, database storage). Access formats directly via the class name,
/// example: `TimeFormat.yyyyMMdd`.
///
/// Example usage with my package:
/// ```dart
/// Time time = Time.now();
/// final formatted = time.format(TimeFormat.yyyyMMdd);
/// ```
class TimeFormat {
  // --- Date Only Formats ---

  /// example: 2025-04-08 (ISO Date - Common for Database)
  static const String yyyyMMdd = 'yyyy-MM-dd';

  /// example: 04/08/2025 (US Format)
  static const String MMddyyyySlash = 'MM/dd/yyyy';

  /// example: 08/04/2025 (European Format)
  static const String ddMMyyyySlash = 'dd/MM/yyyy';

  /// example: 08-04-2025 (European Format)
  static const String ddMMyyyyDash = 'dd-MM-yyyy';

  /// example: 08 Apr 25 (Short Month, 2-digit year) - Use `yyyy` in string if 4-digit year needed.
  static const String ddMMMyy = 'dd MMM yy';

  /// example: 08 April 2025 (Full Month, 4-digit year)
  static const String ddMMMMyyyy = 'dd MMMM yyyy';

  /// example: Tue, Apr 08, 2025 (Short Day/Month, 4-digit year)
  static const String EEEMMMddyyyy = 'EEE, MMM dd, yyyy';

  /// example: Tuesday, April 08, 2025 (Full Day/Month, 4-digit year)
  static const String EEEEMMMMddyyyy = 'EEEE, MMMM dd, yyyy';

  // --- Time Only Formats ---

  /// example: 13:52:05 (24-hour, seconds)
  static const String HHmmss = 'HH:mm:ss';

  /// example: 13:52 (24-hour, no seconds)
  static const String HHmm = 'HH:mm';

  /// example: 01:52:05 PM (12-hour, seconds, AM/PM)
  static const String hhmmssa = 'hh:mm:ss a';

  /// example: 01:52 PM (12-hour, no seconds, AM/PM)
  static const String hhmma = 'hh:mm a';

  // --- Date and Time Formats ---

  /// example: 2025-04-08 13:52:05 (ISO Date, 24h Time - Common for Logs/DBs)
  static const String yyyyMMddHHmmss = 'yyyy-MM-dd HH:mm:ss';

  /// example: 2025-04-08 01:52:05 PM (ISO Date, 12h Time)
  static const String yyyyMMddhhmmssa = 'yyyy-MM-dd hh:mm:ss a';

  /// example: 04/08/2025 13:52:05 (US Date, 24h Time)
  static const String MMddyyyyHHmmss = 'MM/dd/yyyy HH:mm:ss';

  /// example: 08/04/2025 13:52:05 (EU Date, 24h Time)
  static const String ddMMyyyyHHmmss = 'dd/MM/yyyy HH:mm:ss';

  /// example: Tue, 08 Apr 2025 13:52:05 (Readable, 24h Time)
  static const String EEEddMMMyyyyHHmmss = 'EEE, dd MMM yyyy HH:mm:ss';

  /// example: Tue, 08 Apr 2025 01:52:05 PM (Readable, 12h Time)
  static const String EEEddMMMyyyyhhmmssa = 'EEE, dd MMM yyyy hh:mm:ss a';

  /// example: 2025-04-08T13:52:05Z (UTC)
  static const String iso8601UTC = "yyyy-MM-dd'T'HH:mm:ss'Z'";

  /// example: 2025-04-08T13:52:05.123 (Local, Millis)
  static const String iso8601Millis = "yyyy-MM-dd'T'HH:mm:ss.SSS";

  /// example: 2025-04-08T13:52:05.123+0600 (Local, Millis, Timezone Offset)
  static const String iso8601MillisTimezone = "yyyy-MM-dd'T'HH:mm:ss.SSSZ";

  // --- Other Useful Formats ---

  /// example: Tuesday (Full Day Name)
  static const String dayFullName = 'EEEE';

  /// example: Tue (Short Day Name)
  static const String dayShortName = 'EEE';

  /// example: April (Full Month Name)
  static const String monthFullName = 'MMMM';

  /// example: Apr (Short Month Name)
  static const String monthShortName = 'MMM';

  /// example: 2025 (4-digit Year)
  static const String yearFull = 'yyyy';

  /// example: 25 (2-digit Year)
  static const String yearShort = 'yy';

  /// example: Apr 8 (Short Month, Day)
  static const String MMMd = 'MMM d';

  /// example: 4/8 (Short Month/Day, no leading zeros)
  static const String MdSlash = 'M/d';

  /// Private constructor to prevent instantiation of this utility class.
  TimeFormat._();
}
