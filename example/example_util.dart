import 'package:flutter/material.dart';
import 'package:my/my.dart';

/// Utility to demonstrate extension and validator API usage
class ExampleUtilWidget extends StatelessWidget {
  const ExampleUtilWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Example: Extension usage
    final numbers = [1, 2, 3];
    final safe = numbers.safeGet(5); // returns null
    final capitalized = 'hello'.capitalize();

    // Example: Time API
    final now = Time.now();
    final formatted = now.toString();

    // Example: Validator usage
    final validator =
        MyFormFieldValidator().add(RequiredRule(message: 'Required')).add(MinLengthRule(3, message: 'Min 3 chars'));
    final error = validator.getValidator()("");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Safe get: $safe'),
        Text('Capitalized: $capitalized'),
        Text('Now: $formatted'),
        Text('Validation error: $error'),
      ],
    );
  }
}
