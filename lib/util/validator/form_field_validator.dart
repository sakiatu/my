import 'package:flutter/material.dart';

import 'form_filed_validation_rule.dart';

/// A class that holds a list of [MyFormFieldValidationRule]s and generates a
/// [FormFieldValidator<String>] function to be used with [TextFormField].
///
/// This class provides a chainable API to easily build validation rules
/// for a field.
@immutable
class MyFormFieldValidator {
  final List<MyFormFieldValidationRule> rules;

  /// Private constructor to build a FieldValidator with a list of rules.
  const MyFormFieldValidator._(this.rules);

  /// Creates an empty FieldValidator to start building a chain of rules.
  const MyFormFieldValidator() : rules = const [];

  /// Creates a FieldValidator from an existing list of rules.
  factory MyFormFieldValidator.fromRules(
      List<MyFormFieldValidationRule> rules) {
    return MyFormFieldValidator._(
        [...rules]); // Create a copy to ensure immutability
  }

  /// Adds a [RequiredRule] to the validator chain.
  MyFormFieldValidator required({String? message}) {
    return MyFormFieldValidator._([...rules, RequiredRule(message: message)]);
  }

  /// Adds a [MinLengthRule] to the validator chain.
  MyFormFieldValidator minLength(int minLength, {String? message}) {
    return MyFormFieldValidator._(
        [...rules, MinLengthRule(minLength, message: message)]);
  }

  /// Adds a [MaxLengthRule] to the validator chain.
  MyFormFieldValidator maxLength(int maxLength, {String? message}) {
    return MyFormFieldValidator._(
        [...rules, MaxLengthRule(maxLength, message: message)]);
  }

  /// Adds an [EmailRule] to the validator chain.
  MyFormFieldValidator email({String? message}) {
    return MyFormFieldValidator._([...rules, EmailRule(message: message)]);
  }

  /// Adds a [NumericRule] to the validator chain.
  MyFormFieldValidator isNumeric({String? message}) {
    return MyFormFieldValidator._([...rules, NumericRule(message: message)]);
  }

  /// Adds a [NumberRangeRule] to the validator chain.
  MyFormFieldValidator numberRange(
      {required num min, required num max, String? message}) {
    return MyFormFieldValidator._(
        [...rules, NumberRangeRule(min: min, max: max, message: message)]);
  }

  /// Adds a [RegexRule] to the validator chain.
  MyFormFieldValidator matchesRegex(RegExp regex, {required String message}) {
    return MyFormFieldValidator._(
        [...rules, RegexRule(regex, message: message)]);
  }

  /// Adds a [PasswordComplexityRule] to the validator chain.
  MyFormFieldValidator passwordComplexity({String? message}) {
    return MyFormFieldValidator._(
        [...rules, PasswordComplexityRule(message: message)]);
  }

  /// Adds a [ConfirmPasswordRule] to the validator chain.
  /// Requires a getter for the value of the password field to compare against.
  MyFormFieldValidator confirmsPassword(
      ValueGetter<String?> passwordValueGetter,
      {String? message}) {
    return MyFormFieldValidator._([
      ...rules,
      ConfirmPasswordRule(
          passwordValueGetter: passwordValueGetter, message: message)
    ]);
  }

  /// Adds a custom [MyFormFieldValidationRule] to the validator chain.
  MyFormFieldValidator add(MyFormFieldValidationRule rule) =>
      MyFormFieldValidator._([...rules, rule]);

  /// Generates the validator function compatible with [TextFormField].
  /// It iterates through the provided rules and returns the first error found.
  ///
  /// This function is synchronous as it calls synchronous `MyValidationRule.validate` methods.
  ///
  /// [context] is passed to individual rules that might need it (e.g., for localization).
  FormFieldValidator<String> getValidator({BuildContext? context}) =>
      (String? value) {
        for (final rule in rules) {
          final error = rule.validate(value, context: context);
          if (error != null) return error;
        }
        return null; // All validators passed
      };
}
