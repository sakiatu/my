# My

A modern, flexible, and developer-friendly collection of UI components for Flutter, designed to accelerate your app development with clean and customizable widgets.

## Features
- **Custom Text Widgets**: Easily apply theme-based or custom styles.
- **Advanced Buttons**: Multiple variants, loading, and disabled states.
- **Enhanced Containers**: Simplified BoxDecoration and layout options.
- **Convenient Gaps**: Spacing widgets for clean layouts.
- **Text Fields & Forms**: Extended input widgets with validation.
- **Loading Indicators**: Shimmer, skeleton, and loader widgets.
- **Handy Extensions**: Utilities for collections, strings, time, and more.

## Getting Started

Run the following command:
```sh
flutter pub add my
```

## Usage
Import the components you need:

```dart
import 'my/component/core.dart';
import 'my/component/loading.dart';
```

Example usage:
```dart
MyText('Hello World', color: Colors.red);

MyButton.filled(label: 'Submit',onPressed: () {});

MyLoader();
```

## Customization
All widgets are highly customizable via parameters. See API docs for details.

## Contributing
Contributions are welcome! Please open issues or submit pull requests for bug fixes, features, or improvements.

## License
This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.
