import 'package:flutter/material.dart';

/// Provides basic getters for accessing fundamental properties from BuildContext.
extension ContextBasicExtension on BuildContext {
  /// Returns the width of the screen.
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Returns the height of the screen.
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Returns the size of the screen.
  Size get screenSize => MediaQuery.of(this).size;

  /// Returns the current Theme data.
  ThemeData get theme => Theme.of(this);

  /// Returns the current TextTheme.
  TextTheme get styles => theme.textTheme;

  /// Returns the current ColorScheme.
  ColorScheme get colors => theme.colorScheme;

  /// Returns true if the current theme is dark.
  bool get isDarkMode => theme.brightness == Brightness.dark;

  /// Returns the current screen orientation.
  Orientation get orientation => MediaQuery.of(this).orientation;

  /// Returns true if the screen orientation is portrait.
  bool get isPortrait => orientation == Orientation.portrait;

  /// Returns true if the screen orientation is landscape.
  bool get isLandscape => orientation == Orientation.landscape;

  /// Returns the current device locale.
  Locale get locale => Localizations.localeOf(this);

  /// Returns the current FocusScopeNode.
  FocusScopeNode get focusScope => FocusScope.of(this);
}

/// Provides shortcuts for common navigation operations using Navigator.
extension ContextNavigationExtension on BuildContext {
  /// Pops the current route off the navigator.
  void back() => Navigator.of(this).pop();

  /// Pushes a new page onto the navigator.
  Future<T?> to<T extends Object?>(Widget page) => Navigator.of(this).push<T>(MaterialPageRoute(builder: (_) => page));

  /// Replaces the current route with a new page.
  Future<T?> toReplace<T extends Object?, TO extends Object?>(Widget page) =>
      Navigator.of(this).pushReplacement<T, TO>(MaterialPageRoute(builder: (_) => page));

  /// Pushes a new page onto the navigator and removes all the previous routes.
  /// Using `(route) => false` removes all routes below the new one.
  Future<T?> toRemoveUntil<T extends Object?>(Widget page) =>
      Navigator.of(this).pushAndRemoveUntil<T>(MaterialPageRoute(builder: (_) => page), (route) => false);

  /// Pushes a new named route onto the navigator.
  Future<T?> toNamed<T extends Object?>(String routeName, {Object? arguments}) =>
      Navigator.of(this).pushNamed<T>(routeName, arguments: arguments);

  /// Pushes a new named route onto the navigator and removes all the previous routes.
  /// Using `(route) => false` removes all routes below the new one.
  Future<T?> toNamedRemoveUntil<T extends Object?>(String routeName, {Object? arguments}) =>
      Navigator.of(this).pushNamedAndRemoveUntil<T>(routeName, (route) => false, arguments: arguments);

  /// Replaces the current route with a new named route.
  Future<T?> toNamedReplace<T extends Object?, TO extends Object?>(String routeName, {Object? arguments}) =>
      Navigator.of(this).pushReplacementNamed<T, TO>(routeName, arguments: arguments);

  void toNamedRemoveUntilReplace(String route) => Navigator.of(this).pushNamedAndRemoveUntil(route, (route) => false);
}

/// Provides convenient methods for showing snackbars.
extension ContextSnackBar on BuildContext {
  /// Hides the current snackbar.
  void hideSnackBar() => ScaffoldMessenger.of(this).hideCurrentSnackBar();

  /// Shows a success snackbar with a default message and colors.
  void showSuccess([String msg = 'Success']) =>
      showSnackBar(msg, foreground: colors.onPrimary, background: colors.primary);

  /// Shows an error snackbar with a default message and colors.
  void showError([String msg = 'Error']) =>
      showSnackBar(msg, foreground: colors.onError, background: colors.error); // Use colorScheme getter

  /// Shows a customizable snackbar.
  /// [msg] is the text content of the snackbar.
  /// [foreground] is the color of the text and close icon.
  /// [background] is the background color of the snackbar.
  /// [behavior] controls how the snackbar is displayed (floating or fixed).
  /// [duration] is the duration the snackbar is visible (in milliseconds).
  /// [closeIcon] shows or hides the close icon.
  /// [action] is an optional action button for the snackbar.
  /// [hideCurrent] determines if the current snackbar should be hidden before showing a new one.
  void showSnackBar(
    String msg, {
    Color? foreground,
    Color? background,
    SnackBarBehavior? behavior = SnackBarBehavior.floating,
    int durationMilliseconds = 2000,
    bool closeIcon = false,
    SnackBarAction? action,
    bool hideCurrent = true,
    TextStyle? textStyle,
    EdgeInsets? margin,
  }) {
    final scaffoldMessenger = ScaffoldMessenger.of(this);

    if (hideCurrent) scaffoldMessenger.hideCurrentSnackBar();


    scaffoldMessenger.showSnackBar(SnackBar(
      behavior: behavior,
      closeIconColor: foreground,
      action: action,
      showCloseIcon: closeIcon,
      backgroundColor: background,
      duration: Duration(milliseconds: durationMilliseconds),
      margin: margin,
      content: Text(msg, style: textStyle ?? styles.labelLarge?.copyWith(color: foreground)),
    ));
  }
}

/// Provides convenient methods related to focus and keyboard.
extension ContextFocusExtension on BuildContext {
  /// Requests focus for this context's node.
  void requestFocus() => focusScope.requestFocus();

  /// Unfocuses the currently focused node.
  void unfocus() => focusScope.unfocus();

  /// Requests focus for the next focusable node.
  void nextFocus() => focusScope.nextFocus();

  /// Requests focus for the previous focusable node.
  void previousFocus() => focusScope.previousFocus();

  /// Returns true if the software keyboard is currently visible.
  bool get isKeyboardVisible => MediaQuery.of(this).viewInsets.bottom > 0;

  /// Hides the software keyboard.
  void hideKeyboard() => FocusManager.instance.primaryFocus?.unfocus();
}

