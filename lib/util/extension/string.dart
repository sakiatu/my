import 'dart:convert';

/// Provides convenient methods and properties for String.
extension StringExtension on String {
  /// This primarily checks if the trimmed string is empty.
  bool get isOnlyWhiteSpace => trim().isEmpty;

  /// Returns the string with the first character capitalized.
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Returns the string with the first character of each word capitalized.
  String capitalizeWords() {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize()).join(' ');
  }

  /// Returns the string reversed.
  String reverse() {
    if (isEmpty) return this;
    return split('').reversed.join();
  }

  /// Returns true if the string is a valid email format.
  /// Note: This is a basic regex check. For robust validation, consider a dedicated package.
  bool get isValidEmail {
    // Basic regex for demonstration.
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(this);
  }

  /// Returns true if the string is a valid URL format.
  /// Note: This is a basic check. For robust validation, consider a dedicated package.
  bool get isValidUrl {
    try {
      final uri = Uri.parse(this);
      return uri.hasScheme && uri.host.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  /// Returns true if the string contains only digits.
  bool get isNumeric {
    if (isEmpty) return false;
    return RegExp(r'^-?\d+(\.\d+)?$').hasMatch(this);
  }

  /// Returns the string truncated to a specified length, optionally adding ellipsis.
  String truncate(int maxLength, {String ellipsis = '...'}) {
    if (isEmpty) return this;
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}$ellipsis';
  }

  /// Returns the string with all whitespace characters removed.
  String removeAllWhitespace() {
    return replaceAll(RegExp(r'\s+'), '');
  }

  /// Repeats the string [count] times.
  String repeat(int count) {
    if (count <= 0) return '';
    return List.generate(count, (index) => this).join();
  }

  /// Parses the string as an integer. Returns null if parsing fails.
  int? tryInt() => int.tryParse(this);

  /// Parses the string as a double. Returns null if parsing fails.
  double? tryDouble() => double.tryParse(this);

  /// Returns true if the string contains the given [other] string, ignoring case.
  bool containsIgnoreCase(String other) {
    return toLowerCase().contains(other.toLowerCase());
  }

  /// Returns true if the string starts with the given [other] string, ignoring case.
  bool startsWithIgnoreCase(String other) {
    return toLowerCase().startsWith(other.toLowerCase());
  }

  /// Returns true if the string ends with the given [other] string, ignoring case.
  bool endsWithIgnoreCase(String other) {
    return toLowerCase().endsWith(other.toLowerCase());
  }

  /// Converts the string to snake_case (e.g., "Hello World" -> "hello_world").
  ///
  /// Replaces spaces and special characters with underscores and converts to lowercase.
  ///
  /// Example:
  /// ```dart
  /// "Hello World".toSnakeCase(); // Returns "hello_world"
  /// "camelCaseText".toSnakeCase(); // Returns "camel_case_text"
  /// ```
  String toSnakeCase() {
    if (isEmpty) return this;
    final buffer = StringBuffer();
    final trimmed = trim();
    bool isFirst = true;

    for (int i = 0; i < trimmed.length; i++) {
      final char = trimmed[i];
      if (RegExp(r'[A-Z]').hasMatch(char)) {
        if (!isFirst) buffer.write('_');
        buffer.write(char.toLowerCase());
      } else if (RegExp(r'\s+').hasMatch(char)) {
        buffer.write('_');
      } else if (RegExp(r'[a-z0-9]').hasMatch(char)) {
        buffer.write(char.toLowerCase());
      }
      isFirst = false;
    }
    return buffer.toString();
  }

  /// Converts the string to kebab-case (e.g., "Hello World" -> "hello-world").
  ///
  /// Replaces spaces and special characters with hyphens and converts to lowercase.
  ///
  /// Example:
  /// ```dart
  /// "Hello World".toKebabCase(); // Returns "hello-world"
  /// "camelCaseText".toKebabCase(); // Returns "camel-case-text"
  /// ```
  String toKebabCase() => toSnakeCase().replaceAll('_', '-');

  /// Converts the string to PascalCase (e.g., "hello world" -> "HelloWorld").
  ///
  /// Capitalizes the first letter of each word and removes spaces.
  ///
  /// Example:
  /// ```dart
  /// "hello world".toPascalCase(); // Returns "HelloWorld"
  /// "snake_case".toPascalCase(); // Returns "SnakeCase"
  /// ```
  String toPascalCase() {
    if (isEmpty) return this;
    return trim().split(RegExp(r'[\s_]+')).map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join();
  }

  /// Converts the string to camelCase (e.g., "hello world" -> "helloWorld").
  ///
  /// Capitalizes the first letter of each word after the first and removes spaces.
  ///
  /// Example:
  /// ```dart
  /// "hello world".toCamelCase(); // Returns "helloWorld"
  /// "snake_case".toCamelCase(); // Returns "snakeCase"
  /// ```
  String toCamelCase() {
    if (isEmpty) return this;
    final words = trim().split(RegExp(r'[\s_]+'));
    return words.first.toLowerCase() +
        words.skip(1).map((word) {
          if (word.isEmpty) return word;
          return word[0].toUpperCase() + word.substring(1).toLowerCase();
        }).join();
  }

  /// Converts the string to sentence case (e.g., "hello world" -> "Hello world").
  ///
  /// Capitalizes the first letter of the string and keeps the rest unchanged.
  ///
  /// Example:
  /// ```dart
  /// "hello world".toSentenceCase(); // Returns "Hello world"
  /// "".toSentenceCase(); // Returns ""
  /// ```
  String toSentenceCase() {
    if (isEmpty) return this;
    final trimmed = trim();
    return trimmed[0].toUpperCase() + trimmed.substring(1);
  }

  /// Encodes the string to Base64.
  ///
  /// Example:
  /// ```dart
  /// "Hello".toBase64(); // Returns "SGVsbG8="
  /// ```
  String toBase64() {
    if (isEmpty) return this;
    return base64Encode(utf8.encode(this));
  }

  /// Decodes the string from Base64.
  ///
  /// Returns null if the string is not a valid Base64 string.
  ///
  /// Example:
  /// ```dart
  /// "SGVsbG8=".fromBase64(); // Returns "Hello"
  /// "invalid".fromBase64(); // Returns null
  /// ```
  String fromBase64() {
    if (isEmpty) return '';
    try {
      return utf8.decode(base64Decode(this));
    } catch (_) {
      return '';
    }
  }

  /// Checks if string is a palindrome (reads the same forwards and backwards)
  ///
  /// Example:
  /// ```dart
  /// "racecar".isPalindrome; // Returns true
  /// "hello".isPalindrome; // Returns false
  /// ```
  bool get isPalindrome => this == split('').reversed.join();

  /// Removes special characters from string, leaving only alphanumeric characters and spaces
  ///
  /// Example:
  /// ```dart
  /// "Hello, World!".removeSpecialCharacters(); // Returns "Hello World"
  /// "user@example.com".removeSpecialCharacters(); // Returns "userexamplecom"
  /// ```
  String removeSpecialCharacters() => replaceAll(RegExp(r'[^\w\s]+'), '');

  /// Gets the count of words in a string
  ///
  /// Example:
  /// ```dart
  /// "Hello world".wordCount; // Returns 2
  /// "  Multiple   spaces   between  ".wordCount; // Returns 3
  /// ```
  int get wordCount =>
      trim().split(RegExp(r'\s+')).where((word) => word.isNotEmpty).length;

  /// Converts a string into a URL-friendly slug
  ///
  /// Example:
  /// ```dart
  /// "Hello World!".toSlug(); // Returns "hello-world"
  /// "Product Name (2023)".toSlug(); // Returns "product-name-2023"
  /// ```
  String toSlug() => toLowerCase()
      .trim()
      .replaceAll(RegExp(r'[^\w\s-]'), '')
      .replaceAll(RegExp(r'\s+'), '-');

  /// Extracts hashtags from text
  ///
  /// Example:
  /// ```dart
  /// "I love #flutter and #dart programming".extractHashtags; // Returns ["#flutter", "#dart"]
  /// "No hashtags here".extractHashtags; // Returns []
  /// ```
  List<String> get extractHashtags =>
      RegExp(r'#(\w+)').allMatches(this).map((m) => m.group(0)!).toList();

  /// Safely accesses a character by index, returns null if index is out of bounds
  ///
  /// Example:
  /// ```dart
  /// "hello".charAt(1); // Returns "e"
  /// "hello".charAt(10); // Returns null
  /// ```
  String? charAt(int index) =>
      (index >= 0 && index < length) ? this[index] : null;

  /// Converts string to proper title case handling articles, conjunctions, and prepositions
  ///
  /// Example:
  /// ```dart
  /// "the lord of the rings".toTitleCase(); // Returns "The Lord of the Rings"
  /// "a tale of two cities".toTitleCase(); // Returns "A Tale of Two Cities"
  /// ```
  String toTitleCase() {
    if (isEmpty) return this;
    final smallWords = {
      'a',
      'an',
      'and',
      'as',
      'at',
      'but',
      'by',
      'for',
      'if',
      'in',
      'nor',
      'of',
      'on',
      'or',
      'the',
      'to',
      'up',
      'yet'
    };

    final words = split(' ');
    return words.asMap().entries.map((entry) {
      final index = entry.key;
      final word = entry.value;

      if (word.isEmpty) return word;
      // Always capitalize first and last word
      if (index == 0 || index == words.length - 1) {
        return word.capitalize();
      }
      // Use lowercase for small words
      if (smallWords.contains(word.toLowerCase())) {
        return word.toLowerCase();
      }
      return word.capitalize();
    }).join(' ');
  }

  /// Counts occurrences of a substring within the string
  ///
  /// Example:
  /// ```dart
  /// "banana".countOccurrences("a"); // Returns 3
  /// "hello world".countOccurrences("o"); // Returns 2
  /// ```
  int countOccurrences(String substring) {
    if (isEmpty || substring.isEmpty) return 0;

    int count = 0;
    int startIndex = 0;
    while (true) {
      startIndex = indexOf(substring, startIndex);
      if (startIndex == -1) break;
      count++;
      startIndex += substring.length;
    }
    return count;
  }

  /// Masks a portion of the string, useful for sensitive data
  ///
  /// Example:
  /// ```dart
  /// "1234567890".mask(4, 4, '*'); // Returns "1234******"
  /// "johndoe@example.com".mask(3, 10, '*'); // Returns "joh**********@example.com"
  /// ```
  String mask(int keepStart, int keepEnd, [String maskChar = '*']) {
    if (isEmpty) return this;
    if (keepStart < 0) keepStart = 0;
    if (keepEnd < 0) keepEnd = 0;
    if (keepStart + keepEnd >= length) return this;

    final visibleStart = substring(0, keepStart);
    final visibleEnd = keepEnd > 0 ? substring(length - keepEnd) : '';
    final masked = maskChar * (length - keepStart - keepEnd);

    return '$visibleStart$masked$visibleEnd';
  }

  /// Extracts all email addresses from text
  ///
  /// Example:
  /// ```dart
  /// "Contact us at support@example.com or info@example.com".extractEmails;
  /// // Returns ["support@example.com", "info@example.com"]
  /// ```
  List<String> get extractEmails {
    final regex = RegExp(r'\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b',
        caseSensitive: false);
    return regex.allMatches(this).map((m) => m.group(0)!).toList();
  }

  /// Checks if string contains only alphabetic characters
  ///
  /// Example:
  /// ```dart
  /// "HelloWorld".isAlpha; // Returns true
  /// "Hello123".isAlpha; // Returns false
  /// ```
  bool get isAlpha => isNotEmpty && RegExp(r'^[a-zA-Z]+$').hasMatch(this);

  /// Checks if string contains only alphanumeric characters
  ///
  /// Example:
  /// ```dart
  /// "HelloWorld123".isAlphanumeric; // Returns true
  /// "Hello_123".isAlphanumeric; // Returns false
  /// ```
  bool get isAlphanumeric =>
      isNotEmpty && RegExp(r'^[a-zA-Z0-9]+$').hasMatch(this);

  /// Formats string as a phone number based on length
  ///
  /// Example:
  /// ```dart
  /// "1234567890".formatAsPhoneNumber(); // Returns "(123) 456-7890"
  /// "123456".formatAsPhoneNumber(); // Returns "12-34-56"
  /// ```
  String formatAsPhoneNumber() {
    if (isEmpty) return this;
    final digitsOnly = replaceAll(RegExp(r'\D'), '');

    if (digitsOnly.length == 10) {
      return "(${digitsOnly.substring(0, 3)}) ${digitsOnly.substring(3, 6)}-${digitsOnly.substring(6)}";
    } else if (digitsOnly.length > 6) {
      // Format as international number or custom format for different lengths
      return "${digitsOnly.substring(0, 3)}-${digitsOnly.substring(3, 6)}-${digitsOnly.substring(6)}";
    } else if (digitsOnly.length > 4) {
      return "${digitsOnly.substring(0, 2)}-${digitsOnly.substring(2, 4)}-${digitsOnly.substring(4)}";
    }
    return digitsOnly;
  }
}
