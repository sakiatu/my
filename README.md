# 🧩 My

[![pub package](https://img.shields.io/pub/v/my.svg)](https://pub.dev/packages/my)
[![GitHub stars](https://img.shields.io/github/stars/sakiatu/my.svg?style=flat)](https://github.com/sakiatu/my)
[![GitHub license](https://img.shields.io/github/license/sakiatu/my.svg)](LICENSE)

**My** is a modern, robust, and developer-friendly Flutter package that streamlines UI development by reducing boilerplate and boosting productivity for contemporary mobile apps.

---

## ✨ Features

- **Custom Text Widgets** – Theme-aware, semantic, and style-friendly via named constructors.
- **Smart Buttons** – Multiple variants (`filled`, `tonal`, `elevated`, `text`, `outlined`, `danger`) with icon, loading, and full-width options.
- **Enhanced Containers** – Cleaner API for `BoxDecoration`, padding, margin, gradients, and more.
- **Gap Widgets** – Cleaner layout spacing with `Gap`, `GapX`, and `GapY`.
- **Form & Input Utilities** – Extended `TextField`/`TextFormField` with built-in validation and decoration helpers.
- **Loading Indicators** – Shimmer effects, skeleton loaders, and customizable spinners.
- **Handy Extensions** – Utilities for collections, strings, context, and date/time.
- **Time API** – Immutable `Time`, `Day`, `Month`, `Year`, and formatting helpers.
- **Validator API** – Chainable, reusable rules for form validation.

---

## 🚀 Getting Started

### 📦 Installation

```sh
flutter pub add my
```

### 📥 Importing

```dart
import 'package:my/my.dart';

// Or import specific modules
import 'package:my/component/core.dart';
import 'package:my/component/loading.dart';
```

---

## 💡 Usage Examples

### UI Components

```dart
MyText(
  'Styled Text',
  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
);

MyContainer(
  padding: EdgeInsets.all(12),
  color: Colors.blue.shade50,
  child: MyText('Inside a styled container'),
);

MyButton.filled(
  label: 'Submit',
  icon: Icons.send,
  onPressed: () {},
);

MyLoader(size: 32, color: Colors.blue);
MySkeleton(height: 24, width: 120);
MyLoadingEffect(child: MyText('Loading...'));

// Spacing helpers
const GapY(16),
const GapX(8),
```

### Extensions

```dart
// List extension
final numbers = [1, 2, 3];
final safe = numbers.safeGet(5); // returns null

// String extension
'hello'.capitalize(); // => "Hello"
'I love #flutter and #dart'.extractHashtags; // => ["#flutter", "#dart"]

// Time API
final now = Time.now();
now.format(TimeFormat.yyyyMMdd); // => "2025-04-26"

// Context extension
context.push(MyPage());
```

### Validator API

```dart
final validator = MyFormFieldValidator()
  ..add(RequiredRule(message: 'Required'))
  ..add(MinLengthRule(3, message: 'Minimum 3 characters'));

final errorText = validator.getValidator();
```

---

## 🧪 API Highlights

- `MyText` – Theme-aware semantic text.
- `MyButton` – Multiple styles, icon support, loading, full-width.
- `MyContainer` – Simplified layout styling.
- `MyLoader`, `MySkeleton`, `MyLoadingEffect` – Modern loading UX.
- `MyTextField` / `MyTextFormField` – Enhanced form controls.
- **Extensions** – `safeGet`, `capitalize`, `extractHashtags`, `isPalindrome`, and more.
- **Time Utilities** – `Time`,`Day`, `Month`, `Year`, `TimeFormat`.
- **Validation** – Chainable, modular rules for flexible form validation.

---

## 🧑‍💻 Example App

Check the [`example/`](example/) directory for a live demo.

```dart
void main() {
  runApp(const MyExampleApp());
}

class MyExampleApp extends StatelessWidget {
  const MyExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Package Example',
      home: Scaffold(
        appBar: AppBar(title: const Text('My Package Example')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Your My widgets here
            ],
          ),
        ),
      ),
    );
  }
}
```

---

## 🤝 Contributing

We welcome contributions! Open an issue or submit a PR for features, bugs, or improvements.  
See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines (if available).

---

## 📄 License

This project is licensed under the MIT License.  
See [LICENSE](LICENSE) for full details.

---

## 🔗 Links

- 📦 [Pub.dev Package](https://pub.dev/packages/my)
- 💻 [GitHub Repository](https://github.com/sakiatu/my)
