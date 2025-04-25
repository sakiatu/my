import 'package:flutter/material.dart';
import 'package:my/my.dart';

/// Enum to define the type of image source.
enum MyImageSource { network, asset }

/// A customized Image widget that wraps Flutter's [Image].
///
/// Provides convenient parameters for common styling, shape, border radius,
/// and interaction features like showing the image in a full-screen view on click.
@immutable
class MyImage extends StatelessWidget {
  /// The type of image source (network or asset).
  final MyImageSource source;

  /// The image source for network or asset images.
  final String src;

  /// How the image should be inscribed into the space allocated for it.
  final BoxFit? fit;

  /// How to align the image within its bounds.
  final AlignmentGeometry alignment;

  /// The width of this widget.
  final double? width;

  /// The height of this widget.
  final double? height;

  /// The color to blend with the image.
  final Color? color;

  /// The background color to the image container.
  final Color? backgroundColor;

  /// Used to combine the color with the image.
  final BlendMode? colorBlendMode;

  /// How to paint any portions of the box not covered by the image.
  final ImageRepeat repeat;

  /// Whether to paint the image in the direction of the text.
  final bool matchTextDirection;

  /// Whether to enable showing the image in a larger, full-screen view when clicked.
  /// Only applicable when [onTap] is null
  final bool enableFullView;

  /// Whether to enable zooming and panning in the full-screen view.
  /// Only applicable when [enableFullView] is true.
  final bool zoomInFullView;

  /// A callback function to execute when the image is tapped.
  /// [enableFullView] will not work if [onTap] is provided.
  final VoidCallback? onTap;

  /// The shape of the image container.
  /// if [height] and [width] are equal and [shape] is [BoxShape.circle],
  /// but image is not circular then put [MyImage] under a [Column] or [Row]
  /// example:
  /// ```dart
  /// Column(
  ///    children: [
  ///      MyImage.asset(
  ///        'asset/image.png',
  ///        height: 200,
  ///        width: 200,
  ///        fit: BoxFit.cover,
  ///        shape: BoxShape.circle,
  ///        backgroundColor: Colors.grey,
  ///      ),
  ///    ],
  /// )
  /// ```
  final BoxShape shape;

  /// The corners of the image container.
  /// Only applies if [shape] is [BoxShape.rectangle].
  final BorderRadiusGeometry? borderRadius;

  /// The clip behavior for the image.
  final Clip clipBehavior;

  /// The border with for the image container.
  final double? borderWidth;

  /// The border color for the image container.
  /// Only applies if [borderWidth] is not null.
  /// Default border color is [Theme.of(context).colorScheme.outline] if not provided.
  final Color? borderColor;

  final Widget Function(BuildContext context, StackTrace? error)? placeholder;

  /// Creates a customized Image widget from a network URL.
  const MyImage(
    this.src, {
    super.key,
    this.fit,
    this.alignment = Alignment.center,
    this.width,
    this.height,
    this.color,
    this.backgroundColor,
    this.colorBlendMode,
    this.repeat = ImageRepeat.noRepeat,
    this.matchTextDirection = false,
    this.enableFullView = false,
    this.zoomInFullView = false,
    this.onTap,
    this.shape = BoxShape.rectangle,
    this.borderRadius,
    this.clipBehavior = Clip.antiAlias,
    this.placeholder,
    this.borderWidth,
    this.borderColor,
  })  : source = MyImageSource.network,
        assert(
          shape != BoxShape.circle || borderRadius == null,
          'A borderRadius cannot be given when the shape is BoxShape.circle.',
        );

  /// Creates a customized Image widget from an asset path.
  const MyImage.asset(
    this.src, {
    super.key,
    this.fit,
    this.alignment = Alignment.center,
    this.width,
    this.height,
    this.backgroundColor,
    this.color,
    this.colorBlendMode,
    this.repeat = ImageRepeat.noRepeat,
    this.matchTextDirection = false,
    this.enableFullView = false,
    this.zoomInFullView = false,
    this.onTap,
    this.shape = BoxShape.rectangle,
    this.borderRadius,
    this.clipBehavior = Clip.antiAlias, // Use antiAlias for smooth clipping
    this.placeholder,
    this.borderWidth,
    this.borderColor,
  })  : source = MyImageSource.asset,
        assert(
          shape != BoxShape.circle || borderRadius == null,
          'A borderRadius cannot be given when the shape is BoxShape.circle.',
        );

  @override
  Widget build(BuildContext context) {
    final image = _buildImageContainer();

    // Apply shape and border radius if specified
    final clippedImage = _shapeClipper(image);

    // Apply border if width is not null and also positive
    if ((borderWidth ?? 0) > 0) return _applyBorder(borderWidth!, borderColor ?? context.colors.outline, clippedImage);

    return clippedImage;
  }

  /// Builds the appropriate Image widget ([Image.network] or [Image.asset])
  /// based on the [source].
  Widget _buildImageContainer() {
    final imageWidget = switch (source) {
      MyImageSource.network => Image.network(
          src,
          key: key,
          fit: fit,
          alignment: alignment,
          width: width,
          height: height,
          color: color,
          colorBlendMode: colorBlendMode,
          repeat: repeat,
          matchTextDirection: matchTextDirection,
          loadingBuilder: (context, tappableImage, event) {
            if (event == null) return tappableImage;
            return _placeholderWidget(context);
          },
          // enable tap here to ensure only image could be clickable not the placeholder
          frameBuilder: (context, image, _, __) => _enableTap(context, image),
          errorBuilder: (context, _, error) => _placeholderWidget(context, error),
        ),
      MyImageSource.asset => Image.asset(
          src,
          key: key,
          fit: fit,
          alignment: alignment,
          width: width,
          height: height,
          color: color,
          colorBlendMode: colorBlendMode,
          repeat: repeat,
          matchTextDirection: matchTextDirection,
          // enable tap here to ensure only image could be clickable not the placeholder
          frameBuilder: (context, image, _, __) => _enableTap(context, image),
          errorBuilder: (context, _, error) => _placeholderWidget(context, error),
        ),
    };

    //wrap with container to set background and ensure placeholder container
    //transparent png image may need background color
    return MyContainer(height: height, width: width, color: backgroundColor, child: imageWidget);
  }

  /// Applies the shape and border radius to the image container.
  Widget _shapeClipper(Widget child) {
    if (shape == BoxShape.circle) {
      return ClipOval(clipBehavior: clipBehavior, child: child);
    } else if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius!, clipBehavior: clipBehavior, child: child);
    }
    return child;
  }

  /// Apply border to widget
  Widget _applyBorder(double width, Color color, Widget child) => MyContainer(
        decoration: shape == BoxShape.circle
            ? ShapeDecoration(shape: OvalBorder(side: BorderSide(color: color, width: width)), color: backgroundColor)
            : BoxDecoration(
                border: Border.all(color: color, width: width),
                borderRadius: borderRadius,
                color: backgroundColor,
              ),
        child: child,
      );

  /// Enables tap on image
  Widget _enableTap(BuildContext context, Widget child) {
    if (onTap != null) return child.onTap(onTap);
    if (enableFullView) return child.onTap(() => _showImageDialog(context));
    return child;
  }

  /// Builds the placeholder widget whether error or loading.
  Widget _placeholderWidget(BuildContext context, [StackTrace? error]) {
    if (placeholder != null) return placeholder!(context, error);

    double? size = width ?? context.screenWidth;
    if (height != null && size > height!) size = height!;
    size = size == 0 ? null : size / 2;

    return Icon(Icons.image_not_supported_outlined, size: size, color: context.colors.outline);
  }

  /// Builds image for dialog view
  /// loading or error builder not needed as dialog view only shows real image
  Widget _buildDialogImage(BuildContext context) => switch (source) {
        MyImageSource.network => Image.network(
            src,
            key: key,
            fit: BoxFit.contain,
            color: color,
            colorBlendMode: colorBlendMode,
          ),
        MyImageSource.asset => Image.asset(
            src,
            key: key,
            fit: BoxFit.contain,
            color: color,
            colorBlendMode: colorBlendMode,
          ),
      };

  /// Shows the full-screen image dialog.
  ///
  /// The dialog contains the image wrapped in an [InteractiveViewer] for zoom/pan.
  void _showImageDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withAlpha(50),
      builder: (context) {
        final image = _buildDialogImage(context);

        if (zoomInFullView) {
          return Dialog.fullscreen(
            backgroundColor: Colors.transparent,
            child: Scaffold(
              appBar: AppBar(),
              body: InteractiveViewer(
                maxScale: 4,
                child: SizedBox(height: context.screenHeight, width: context.screenWidth, child: image),
              ),
            ),
          );
        }

        return Dialog(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(8),
          child: image,
        );
      },
    );
  }
}
