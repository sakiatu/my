import 'package:flutter/material.dart';

/// Abstract base class for all validation rules.
/// All validation rules must implement this class.
@immutable
abstract class MyFormFieldValidationRule {
  /// Validates the given [value].
  /// Returns an error message [String] if validation fails, otherwise returns `null].
  ///
  /// The [context] can optionally be used by rules needing access to localization, etc.
  /// This context is provided by the FieldValidator when getValidator is called.
  String? validate(String? value, {BuildContext? context});
}

/// Validates that a field is not empty.
@immutable
class RequiredRule implements MyFormFieldValidationRule {
  final String message;

  /// Creates a required validation rule.
  /// [message] is the error message displayed if the field is empty.
  const RequiredRule({String? message}) : message = message ?? 'This field is required.';

  @override
  String? validate(String? value, {BuildContext? context}) => (value ?? '').trim().isEmpty ? message : null;
}

/// Validates that a field's value meets a minimum length.
@immutable
class MinLengthRule implements MyFormFieldValidationRule {
  final int minLength;
  final String message;

  /// Creates a minimum length validation rule.
  /// [minLength] is the required minimum number of characters.
  /// [message] is the optional error message.
  const MinLengthRule(this.minLength, {String? message})
      : message = message ?? 'Value must be at least $minLength characters long.';

  @override
  String? validate(String? value, {BuildContext? context}) {
    if ((value ?? '').trim().isEmpty) return null; // Don't validate empty strings

    return value!.length < minLength ? message : null;
  }
}

/// Validates that a field's value does not exceed a maximum length.
@immutable
class MaxLengthRule implements MyFormFieldValidationRule {
  final int maxLength;
  final String message;

  /// Creates a maximum length validation rule.
  /// [maxLength] is the maximum allowed number of characters.
  /// [message] is the optional error message.
  const MaxLengthRule(this.maxLength, {String? message})
      : message = message ?? 'Value cannot exceed $maxLength characters.';

  @override
  String? validate(String? value, {BuildContext? context}) {
    if ((value ?? '').trim().isEmpty) return null; // Don't validate empty strings

    return value!.length > maxLength ? message : null;
  }
}

/// Validates that a field's value is a valid email format.
@immutable
class EmailRule implements MyFormFieldValidationRule {
  final String message;

  /// Creates an email format validation rule.
  /// [message] is the optional error message.
  const EmailRule({String? message}) : message = message ?? 'Enter a valid email address.';

  @override
  String? validate(String? value, {BuildContext? context}) {
    if ((value ?? '').trim().isEmpty) return null; // Don't validate empty strings
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(value!) ? null : message;
  }
}

/// Validates that a field's value is a numeric string.
@immutable
class NumericRule implements MyFormFieldValidationRule {
  final String message;

  /// Creates a numeric validation rule.
  /// [message] is the optional error message.
  const NumericRule({String? message}) : message = message ?? 'Enter a valid number.';

  @override
  String? validate(String? value, {BuildContext? context}) {
    if ((value ?? '').trim().isEmpty) return null; // Don't validate empty strings
    return double.tryParse(value!) == null ? message : null;
  }
}

/// Validates that a field's value is within a specified numeric range.
@immutable
class NumberRangeRule implements MyFormFieldValidationRule {
  final num min;
  final num max;
  final String message;

  /// Creates a number range validation rule.
  /// [min] is the optional minimum value.
  /// [max] is the optional maximum value.
  /// [message] is the optional error message.
  /// At least one of [min] or [max] must be provided.
  const NumberRangeRule({required this.min, required this.max, String? message})
      : message = message ?? 'Value must be between $min and $max.';

  @override
  String? validate(String? value, {BuildContext? context}) {
    if ((value ?? '').trim().isEmpty) return null; // Don't validate empty strings

    final number = num.tryParse(value!);
    if (number == null) return "Not a valid number";

    return number < min || number > max ? message : null;
  }
}

/// Validates that a field's value matches a given regular expression.
@immutable
class RegexRule implements MyFormFieldValidationRule {
  final RegExp regex;
  final String message;

  /// Creates a regex validation rule.
  /// [regex] is the pattern the value must match.
  /// [message] is the error message if the value does not match.
  const RegexRule(this.regex, {required this.message});

  @override
  String? validate(String? value, {BuildContext? context}) {
    if ((value ?? '').trim().isEmpty) return null; // Don't validate empty strings
    return regex.hasMatch(value!) ? null : message;
  }
}

/// Validates that a password meets common complexity requirements
/// (at least one uppercase, one lowercase, one digit, one special character).
@immutable
class PasswordComplexityRule implements MyFormFieldValidationRule {
  final String message;

  /// Creates a password complexity rule.
  /// Checks for at least one uppercase, lowercase, digit, and special character.
  /// [message] is the error message.
  const PasswordComplexityRule({String? message})
      : message = message ?? 'Password must contain uppercase, lowercase, digit, and special character.';

  @override
  String? validate(String? value, {BuildContext? context}) {
    if ((value ?? '').trim().isEmpty) return null; // Don't validate empty strings

    final upperCaseRegex = RegExp(r'[A-Z]');
    final lowerCaseRegex = RegExp(r'[a-z]');
    final digitRegex = RegExp(r'[0-9]');
    final specialCharRegex = RegExp(r'[!@#\$&*~-]'); // Add/remove characters as needed
    if (!upperCaseRegex.hasMatch(value!) ||
        !lowerCaseRegex.hasMatch(value) ||
        !digitRegex.hasMatch(value) ||
        !specialCharRegex.hasMatch(value)) {
      return message;
    }
    return null;
  }
}

/// Validates that this field's value matches the value of another field (e.g., Confirm Password).
@immutable
class ConfirmPasswordRule implements MyFormFieldValidationRule {
  /// A function that returns the value of the password field to compare against.
  final ValueGetter<String?> passwordValueGetter;
  final String message;

  /// Creates a confirm password rule.
  /// [passwordValueGetter] should return the current value of the password field.
  /// [message] is the error message if the values don't match.
  const ConfirmPasswordRule({required this.passwordValueGetter, String? message})
      : message = message ?? 'Passwords do not match.';

  @override
  String? validate(String? value, {BuildContext? context}) {
    if ((value ?? '').trim().isEmpty) return null; // Don't validate empty strings

    return value != passwordValueGetter() ? message : null;
  }
}
