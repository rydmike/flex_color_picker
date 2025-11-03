import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/color_extensions.dart';
import 'if_wrapper.dart';

// ignore_for_file: comment_references

// Material dark default surface color
const Color _kMaterialDarkSurface = Color(0xff121212);

/// The [FlexAppBar] has the same features as a normal [AppBar], but provides
/// additional custom styling properties.
///
/// An app bar consists of a toolbar and potentially other widgets, such as a
/// [TabBar] and a [FlexibleSpaceBar]. App bars typically expose one or more
/// common [actions] with [IconButton]s which are optionally followed by a
/// [PopupMenuButton] for less common operations (sometimes called the "overflow
/// menu").
///
/// App bars are typically used in the [Scaffold.appBar] property, which places
/// the app bar as a fixed-height widget at the top of the screen. For a
/// scrollable app bar, see [SliverAppBar], which embeds an [AppBar] in a
/// sliver for use in a [CustomScrollView].
///
/// The AppBar displays the toolbar widgets, [leading], [title], and [actions],
/// above the [bottom] (if any). The [bottom] is usually used for a [TabBar]. If
/// a [flexibleSpace] widget is specified then it is stacked behind the toolbar
/// and the bottom widget. The following diagram shows where each of these slots
/// appears in the toolbar when the writing language is left-to-right (e.g.
/// English):
///
/// The [AppBar] insets its content based on the ambient [MediaQuery]'s padding,
/// to avoid system UI intrusions. It's taken care of by [Scaffold] when used in
/// the [Scaffold.appBar] property. When animating an [AppBar], unexpected
/// [MediaQuery] changes (as is common in [Hero] animations) may cause the
/// content to suddenly jump. Wrap the [AppBar] in a [MediaQuery] widget, and
/// adjust its padding such that the animation is smooth.
///
/// The leading widget is in the top left, the actions are in the top right,
/// the title is between them. The bottom is, naturally, at the bottom, and the
/// flexibleSpace is behind all of them.
/// (https://flutter.github.io/assets-for-api-docs/assets/material/app_bar.png)
///
/// If the [leading] widget is omitted, but the [AppBar] is in a [Scaffold] with
/// a [Drawer], then a button will be inserted to open the drawer. Otherwise, if
/// the nearest [Navigator] has any previous routes, a [BackButton] is inserted
/// instead. This behavior can be turned off by setting the
/// [automaticallyImplyLeading] to false. In that case a null leading widget
/// will result in the middle/title widget stretching to start.

@immutable
class FlexAppBar {
  /// Creates a property holder for a Material design app bar that will be
  /// constructed by [Flexfold].
  ///
  /// The arguments [primary], [toolbarOpacity], [bottomOpacity]
  /// and [automaticallyImplyLeading] must not be null. Additionally, if
  /// [elevation] is specified, it must be non-negative.
  ///
  /// If [backgroundColor], [elevation], [shadowColor], [brightness],
  /// [iconTheme], [actionsIconTheme], [textTheme] or [centerTitle] are null,
  /// then their [AppBarTheme] values will be used. If the corresponding
  /// [AppBarTheme] property is null, then the default specified in the
  /// property's documentation will be used.
  ///
  /// Typically used in the [Scaffold.appBar] property.
  const FlexAppBar({
    this.key,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.title,
    this.actions,
    this.flexibleSpace,
    this.bottom,
    this.elevation,
    this.shadowColor,
    this.shape,
    this.backgroundColor,
    this.foregroundColor,
    this.iconTheme,
    this.actionsIconTheme,
    this.primary = true,
    this.centerTitle,
    this.excludeHeaderSemantics = false,
    this.titleSpacing,
    this.toolbarOpacity = 1.0,
    this.bottomOpacity = 1.0,
    this.toolbarHeight,
    this.leadingWidth,
    this.toolbarTextStyle,
    this.titleTextStyle,
    this.systemOverlayStyle,
    // ignore: prefer_asserts_with_message
  }) : assert(elevation == null || elevation >= 0.0);

  /// Key that gets passed to super key, when converted to an actual app bar.
  final Key? key;

  /// A widget to display before the toolbar's [title].
  ///
  /// Typically the [leading] widget is an [Icon] or an [IconButton].
  ///
  /// Becomes the leading component of the [NavigationToolbar] built
  /// by this widget. The [leading] widget's width and height are constrained to
  /// be no bigger than [leadingWidth] and [toolbarHeight] respectively.
  ///
  /// If this is null and [automaticallyImplyLeading] is set to true, the
  /// [AppBar] will imply an appropriate widget. For example, if the [AppBar] is
  /// in a [Scaffold] that also has a [Drawer], the [Scaffold] will fill this
  /// widget with an [IconButton] that opens the drawer (using [Icons.menu]). If
  /// there's no [Drawer] and the parent [Navigator] can go back, the [AppBar]
  /// will use a [BackButton] that calls [Navigator.maybePop].
  ///
  /// See also:
  ///
  ///  * [Scaffold.appBar], in which an [AppBar] is usually placed.
  ///  * [Scaffold.drawer], in which the [Drawer] is usually placed.
  final Widget? leading;

  /// Controls whether we should try to imply the leading widget if null.
  ///
  /// If true and [leading] is null, automatically try to deduce what the
  /// leading widget should be. If false and [leading] is null, leading space
  /// is given to [title]. If leading widget is not null, this parameter has
  /// no effect.
  ///
  /// The parameter has no effect when [FlexAppBar] is consumed by [Flexfold].
  /// Flexfold will create leading and action widget as needed based on its
  /// current navigation. In effect one could say that it always uses a form
  /// of advanced [automaticallyImplyLeading] and imply last actions widget.
  final bool automaticallyImplyLeading;

  /// The primary widget displayed in the app bar.
  ///
  /// Becomes the middle component of the [NavigationToolbar] built by this
  /// widget. Typically a [Text] widget that contains a description of the
  /// current contents of the app.
  ///
  /// The [title]'s width is constrained to fit within the remaining space
  /// between the toolbar's [leading] and [actions] widgets. Its height is
  /// _not_ constrained. The [title] is vertically centered and clipped to fit
  /// within the toolbar, whose height is [toolbarHeight]. Typically this
  /// isn't noticeable because a simple [Text] [title] will fit within the
  /// toolbar by default. On the other hand, it is noticeable when a
  /// widget with an intrinsic height that is greater than [toolbarHeight]
  /// is used as the [title]. For example, when the height of an Image used
  /// as the [title] exceeds [toolbarHeight], it will be centered and
  /// clipped (top and bottom), which may be undesirable. In cases like this
  /// the height of the [title] widget can be constrained.
  final Widget? title;

  /// A list of Widgets to display in a row after the [title] widget.
  ///
  /// Typically these widgets are [IconButton]s representing common operations.
  /// For less common operations, consider using a [PopupMenuButton] as the
  /// last action.
  ///
  /// The [actions] become the trailing component of the [NavigationToolbar]
  /// built by this widget. The height of each action is constrained to be no
  /// bigger than the [toolbarHeight].
  final List<Widget>? actions;

  /// This widget is stacked behind the toolbar and the tab bar. Its height
  /// will be the same as the app bar's overall height.
  ///
  /// A flexible space isn't actually flexible unless the [AppBar]'s container
  /// changes the [AppBar]'s size. A [SliverAppBar] in a [CustomScrollView]
  /// changes the [AppBar]'s height when scrolled.
  ///
  /// Typically a [FlexibleSpaceBar]. See [FlexibleSpaceBar] for details.
  final Widget? flexibleSpace;

  /// This widget appears across the bottom of the app bar.
  ///
  /// Typically a [TabBar]. Only widgets that implement [PreferredSizeWidget]
  /// can be used at the bottom of an app bar.
  ///
  /// See also:
  ///
  ///  * [PreferredSize], which can be used to give an arbitrary widget a
  ///    preferred size.
  final PreferredSizeWidget? bottom;

  /// The z-coordinate at which to place this app bar relative to its parent.
  ///
  /// This property controls the size of the shadow below the app bar.
  ///
  /// The value must be non-negative.
  ///
  /// If this property is null, then [AppBarTheme.elevation] of
  /// [ThemeData.appBarTheme] is used. If that is also null, the
  /// default value is 0.
  ///
  /// See also:
  ///
  ///  * [shadowColor], which is the color of the shadow below the app bar.
  ///  * [shape], which defines the shape of the app bar's [Material] and its
  ///    shadow.
  final double? elevation;

  /// The color of the shadow below the app bar.
  ///
  /// If this property is null, then [AppBarTheme.shadowColor] of
  /// [ThemeData.appBarTheme] is used. If that is also null, the default value
  /// is fully opaque black.
  ///
  /// See also:
  ///
  ///  * [elevation], which defines the size of the shadow below the app bar.
  ///  * [shape], which defines the shape of the app bar and its shadow.
  final Color? shadowColor;

  /// The shape of the app bar's material's shape as well as its shadow.
  ///
  /// A shadow is only displayed if the [elevation] is greater than
  /// zero.
  ///
  /// See also:
  ///
  ///  * [elevation], which defines the size of the shadow below the app bar.
  ///  * [shadowColor], which is the color of the shadow below the app bar.
  final ShapeBorder? shape;

  /// The fill color to use for an app bar's [Material].
  ///
  /// If null, then the [AppBarTheme.backgroundColor] is used. If that value is
  /// also null, then [AppBar] uses the overall theme's [ColorScheme.primary]
  /// if the overall theme's brightness is [Brightness.light], and
  /// [ColorScheme.surface] if the overall theme's [brightness] is
  /// [Brightness.dark].
  ///
  /// See also:
  ///
  ///  * [foregroundColor], which specifies the color for icons and text within
  ///    the app bar.
  ///  * [Theme.of], which returns the current overall Material theme as
  ///    a [ThemeData].
  ///  * [ThemeData.colorScheme], the thirteen colors that most Material widget
  ///    default colors are based on.
  ///  * [ColorScheme.brightness], which indicates if the overall [Theme]
  ///    is light or dark.
  final Color? backgroundColor;

  /// The default color for [Text] and [Icon]s within the app bar.
  ///
  /// If null, then [AppBarTheme.foregroundColor] is used. If that
  /// value is also null, then [AppBar] uses the overall theme's
  /// [ColorScheme.onPrimary] if the overall theme's brightness is
  /// [Brightness.light], and [ColorScheme.onSurface] if the overall
  /// theme's [brightness] is [Brightness.dark].
  ///
  /// This color is used to configure [DefaultTextStyle] that contains
  /// the toolbar's children, and the default [IconTheme] widgets that
  /// are created if [iconTheme] and [actionsIconTheme] are null.
  ///
  /// See also:
  ///
  ///  * [backgroundColor], which specifies the app bar's background color.
  ///  * [Theme.of], which returns the current overall Material theme as
  ///    a [ThemeData].
  ///  * [ThemeData.colorScheme], the thirteen colors that most Material widget
  ///    default colors are based on.
  ///  * [ColorScheme.brightness], which indicates if the overall [Theme]
  ///    is light or dark.
  final Color? foregroundColor;

  /// The color, opacity, and size to use for toolbar icons.
  ///
  /// If this property is null, then a copy of [ThemeData.iconTheme]
  /// is used, with the [IconThemeData.color] set to the
  /// app bar's [foregroundColor].
  ///
  /// See also:
  ///
  ///  * [actionsIconTheme], which defines the appearance of icons in
  ///    in the [actions] list.
  final IconThemeData? iconTheme;

  /// The color, opacity, and size to use for the icons that appear in the app
  /// bar's [actions].
  ///
  /// This property should only be used when the [actions] should be
  /// themed differently than the icon that appears in the app bar's [leading]
  /// widget.
  ///
  /// If this property is null, then [AppBarTheme.actionsIconTheme] of
  /// [ThemeData.appBarTheme] is used. If that is also null, then the value of
  /// [iconTheme] is used.
  ///
  /// See also:
  ///
  ///  * [iconTheme], which defines the appearance of all of the toolbar icons.
  final IconThemeData? actionsIconTheme;

  /// Whether this app bar is being displayed at the top of the screen.
  ///
  /// If true, the app bar's toolbar elements and [bottom] widget will be
  /// padded on top by the height of the system status bar. The layout
  /// of the [flexibleSpace] is not affected by the [primary] property.
  final bool primary;

  /// Whether the title should be centered.
  ///
  /// If this property is null, then [AppBarTheme.centerTitle] of
  /// [ThemeData.appBarTheme] is used. If that is also null, then value is
  /// adapted to the current [TargetPlatform].
  final bool? centerTitle;

  /// Whether the title should be wrapped with header [Semantics].
  ///
  /// Defaults to false.
  final bool excludeHeaderSemantics;

  /// The spacing around [title] content on the horizontal axis. This spacing is
  /// applied even if there is no [leading] content or [actions]. If you want
  /// [title] to take all the space available, set this value to 0.0.
  ///
  /// If this property is null, then [AppBarTheme.titleSpacing] of
  /// [ThemeData.appBarTheme] is used. If that is also null, then the
  /// default value is [NavigationToolbar.kMiddleSpacing].
  final double? titleSpacing;

  /// How opaque the toolbar part of the app bar is.
  ///
  /// A value of 1.0 is fully opaque, and a value of 0.0 is fully transparent.
  ///
  /// Typically, this value is not changed from its default value (1.0). It is
  /// used by [SliverAppBar] to animate the opacity of the toolbar when the app
  /// bar is scrolled.
  final double toolbarOpacity;

  /// How opaque the bottom part of the app bar is.
  ///
  /// A value of 1.0 is fully opaque, and a value of 0.0 is fully transparent.
  ///
  /// Typically, this value is not changed from its default value (1.0). It is
  /// used by [SliverAppBar] to animate the opacity of the toolbar when the app
  /// bar is scrolled.
  final double bottomOpacity;

  /// Defines the height of the toolbar component of an [AppBar].
  ///
  /// By default, the value of `toolbarHeight` is [kToolbarHeight].
  final double? toolbarHeight;

  /// Defines the width of [leading] widget.
  ///
  /// By default, the value of `leadingWidth` is 56.0.
  final double? leadingWidth;

  /// The default text style for the AppBar's [leading], and
  /// [actions] widgets, but not its [title].
  ///
  /// If this property is null, then [AppBarTheme.toolbarTextStyle] of
  /// [ThemeData.appBarTheme] is used. If that is also null, the default
  /// value is a copy of the overall theme's [TextTheme.bodyMedium]
  /// [TextStyle], with color set to the app bar's [foregroundColor].
  ///
  /// See also:
  ///
  ///  * [titleTextStyle], which overrides the default text style for
  ///    the [title].
  ///  * [DefaultTextStyle], which overrides the default text style for all of
  ///    the widgets in a subtree.
  final TextStyle? toolbarTextStyle;

  /// The default text style for the AppBar's [title] widget.
  ///
  /// If this property is null, then [AppBarTheme.titleTextStyle] of
  /// [ThemeData.appBarTheme] is used. If that is also null, the default
  /// value is a copy of the overall theme's [TextTheme.titleLarge]
  /// [TextStyle], with color set to the app bar's [foregroundColor].
  ///
  /// See also:
  ///
  ///  * [toolbarTextStyle], which is the default text style for the AppBar's
  ///    [title], [leading], and [actions] widgets, also known as the
  ///    AppBar's "toolbar".
  ///  * [DefaultTextStyle], which overrides the default text style for all of
  ///    the widgets in a subtree.
  final TextStyle? titleTextStyle;

  /// Specifies the style to use for the system overlays that overlap the
  /// AppBar.
  ///
  /// If this property is null, then [SystemUiOverlayStyle.light] is used if
  /// the overall theme is dark, [SystemUiOverlayStyle.dark] otherwise. Theme
  /// brightness is defined by [ColorScheme.brightness] for
  /// [ThemeData.colorScheme].
  ///
  /// The AppBar's descendants are built within a
  /// `AnnotatedRegion<SystemUiOverlayStyle>` widget, which causes
  /// [SystemChrome.setSystemUIOverlayStyle] to be called
  /// automatically.  Apps should not enclose an AppBar with their
  /// own [AnnotatedRegion].
  //
  /// See also:
  ///  * [SystemChrome.setSystemUIOverlayStyle]
  final SystemUiOverlayStyle? systemOverlayStyle;

  //  **************************************************************************
  //  **************************************************************************
  //  The Styled FlexAppBar Factory begins here
  //  **************************************************************************
  //  **************************************************************************

  /// Creates an opinionated styled app bar that may use gradient primary
  /// color and gradually increasing transparency and blur effect, as well as a
  /// optional from screen or window edges floating app bar.
  ///
  /// The status bar scrim can also be removed with a singe toggle.
  ///
  /// The default configuration creates a stylish gradient app bar with no
  /// status bar scrim and a light transparency towards the end, and uses
  /// frosted glass effect for the transparency.
  // ignore: sort_constructors_first
  factory FlexAppBar.styled(
    /// The context is needed because the [FlexAppBar.styled] needs to know
    /// the theme for its styling, we must pass in current build context.
    final BuildContext context, {
    // AppBar properties, see AppBar for documentation
    final Key? key,

    /// See [AppBar] or [FlexAppBar] for full docs on properties.

    /// A widget to display before the toolbar's [title].
    final Widget? leading,

    /// Controls whether we should try to imply the leading widget if null.
    final bool automaticallyImplyLeading = true,

    /// The primary widget displayed in the app bar.
    final Widget? title,

    /// A list of Widgets to display in a row after the [title] widget.
    final List<Widget>? actions,

    /// This widget is stacked behind the toolbar and the tab bar. Its height
    /// will be the same as the app bar's overall height.
    // Widget flexibleSpace,

    /// This widget appears across the bottom of the app bar.
    final PreferredSizeWidget? bottom,

    /// The z-coordinate at which to place this app bar relative to its parent.
    final double? elevation,

    /// The color to paint the shadow below the app bar.
    final Color? shadowColor,

    /// The shape of the app bar's material's shape as well as its shadow.
    final ShapeBorder? shape,

    /// The fill color to use for an app bar's [Material].
    final Color? backgroundColor,

    /// The default color for [Text] and [Icon]s within the app bar.
    final Color? foregroundColor,

    /// The color, opacity, and size to use for toolbar icons.
    final IconThemeData? iconTheme,

    /// The color, opacity, and size to use for the icons that appear in the app
    /// bar's [actions].
    final IconThemeData? actionsIconTheme,

    /// Whether this app bar is being displayed at the top of the screen.
    final bool primary = true,

    /// Whether the title should be centered.
    final bool? centerTitle,

    /// Whether the title should be wrapped with header [Semantics].
    final bool excludeHeaderSemantics = false,

    /// The spacing around [title] content on the horizontal axis. This spacing
    /// is applied even if there is no [leading] content or [actions]. If you
    /// want [title] to take all the space available, set this value to 0.0.
    ///
    /// Defaults to [NavigationToolbar.kMiddleSpacing].
    final double? titleSpacing,

    /// How opaque the toolbar part of the app bar is.
    ///
    /// A value of 1.0 is fully opaque, and a value of 0.0 is fully transparent.
    ///
    /// Typically, this value is not changed from its default value (1.0). It is
    /// used by [SliverAppBar] to animate the opacity of the toolbar when the
    /// app bar is scrolled.
    final double toolbarOpacity = 1.0,

    /// How opaque the bottom part of the app bar is.
    ///
    /// A value of 1.0 is fully opaque, and a value of 0.0 is fully transparent.
    ///
    /// Typically, this value is not changed from its default value (1.0). It is
    /// used by [SliverAppBar] to animate the opacity of the toolbar when the
    /// app bar is scrolled.
    final double bottomOpacity = 1.0,

    /// Defines the height of the toolbar component of an [AppBar].
    ///
    /// By default, the value of `toolbarHeight` is [kToolbarHeight].
    final double? toolbarHeight,

    /// Defines the width of [leading] widget.
    ///
    /// By default, the value of `leadingWidth` is 56.0.
    final double? leadingWidth,

    /// The default text style for the AppBar's [leading], and
    /// [actions] widgets, but not its [title].
    final TextStyle? toolbarTextStyle,

    /// The default text style for the AppBar's [title] widget.
    final TextStyle? titleTextStyle,

    /// Specifies the style to use for the system overlays that overlap the
    /// AppBar.
    final SystemUiOverlayStyle? systemOverlayStyle,

    // *************************************************************************
    // *************************************************************************
    // The FlexAppBar.styled custom style properties start here
    // *************************************************************************
    // *************************************************************************

    /// The amount of [opacity] to be used on the styled app bar.
    ///
    /// Defaults to 0.9.
    final double opacity = 0.9,

    /// Opacity value for the start color, defaults to 1.
    ///
    /// This opacity value is only used when [gradient] is used, it is often set
    /// to 1 for fully opaque value for the start of the gradient, beginning at
    /// the start side of the app bar. This makes it easier to see the leading
    /// action widget and the title, that is often also at the beginning of
    /// the app bar.
    final double startOpacity = 1,

    /// App bar has a frosted glass blur effect when it has any transparency.
    ///
    /// This applies the same blurring effect on the Material app bar
    /// that is often used on Cupertino app bars when it has some transparency.
    ///
    /// This filter is bit expensive and is only applied when [blurred] is true,
    /// and when [opacity] or [startOpacity] is less than 1.
    ///
    /// Defaults to true.
    final bool blurred = true,

    /// The styled app bar is using a color gradient.
    ///
    /// The start color for the gradient is the app bar background color.
    /// The color used for the end gradient is an automatically computed shade
    /// of the app bar background color. The shade strength can be modified
    /// with [gradientPercentage].
    ///
    /// Defaults to true.
    final bool gradient = true,

    /// The percentage of color change we should apply to the app bar color
    /// in the gradient at the end of the appbar.
    ///
    /// In light theme the color hue will be made lighter by the given
    /// percentage value. In dark theme the app bar color hue will be made
    /// darker by the same percentage amount. The gradient is only applied
    /// if [gradient] is true.
    ///
    /// Defaults to 10 (%).
    final int gradientPercentage = 10,

    /// Reverse the gradient and transparency direction.
    ///
    /// The normal direction starts with app bar color from the start of the
    /// app bar and ends in the computed gradient color. Setting
    /// [reverseGradient] to true reverses the order.
    ///
    /// This is useful when multiple styled app bars are used in a row layout
    /// and we want the gradients to flow from one to the next app bar by
    /// reversing the order of the gradient color for each alternating app bar.
    ///
    /// Defaults to false.
    final bool reverseGradient = false,

    /// Use a standard scrim on the top status bar when [floatAppBar] is false.
    ///
    /// By default, the styled app bar does not use a scrim on the status bar
    /// when [floatAppBar] is false.
    /// If set to true, the default scrim of alpha (0x40) and black color will
    /// will be added to the styled app bar, provided [floatAppBar] is false
    ///  and [statusBarColor] is null. If [statusBarColor] is
    /// specified, it is up to the used color to include the desired alpha value
    /// for the status bar as well.
    final bool scrim = false,

    /// The scrim alpha value used when [floatAppBar] is true.
    ///
    /// Defaults to Hex CC. Value must be from hex 00 (0) to hex FF (255).
    final int floatScrim = 0xCC,

    /// The styled app bar is floating and not connected to screen edges.
    ///
    /// This type of app bar works best on devices that have a system status
    /// bar on top of the app bar, like iOS and Android has.
    ///
    /// Defaults to false.
    final bool floatAppBar = false,

    /// The color of the status bar of the style app bar.
    ///
    /// By default the top [statusBarColor] is null and its color is
    /// determined by the app bar background [color] and [floatAppBar]
    /// property.
    ///
    /// If the styled app bar has [floatAppBar] set to false,
    /// meaning it is a normal app bar that touches the edges of the screen,
    /// then the [statusBarColor] will be equal to the current app bar
    /// background [color]. If [floatAppBar] is true, then the [statusBarColor]
    /// will be equal to current theme scaffold background color.
    ///
    /// If a [statusBarColor] is is provided, then that color will always
    /// override the built in default color behavior and be used.
    final Color? statusBarColor,

    /// Padding for the float styled app bar.
    ///
    /// The padding above and below the styled app bar is removed from the app
    /// bar height and needs to be small, values from 0 to 4 can work OK for
    /// top and bottom. Setting top and bottom to other value than 0 is
    /// typically only needed for a floating effect on devices that dos not
    /// have a status bar, like desktop and web.
    ///
    /// Top and bottom values defaults to 0.
    ///
    /// The padding for start and end defaults to 3 and can look OK all the
    /// way up to 6. For a drawer app bar you should set end to 0 and for an
    /// end drawer app bar you should set to start to 0. For the main app bar
    /// you will need symmetric values from 2 to 6 for a nice floating and
    /// form the sides disconnected look.
    ///
    /// Defaults to EdgeInsetsDirectional.fromSTEB(3, 0, 3, 0).
    final EdgeInsetsDirectional floatPadding =
        const EdgeInsetsDirectional.fromSTEB(3, 0, 3, 0),

    /// Draw a border on the styled app bar.
    ///
    /// If [floatAppBar] is true, the border will be a border all around the
    /// styled app bar, if [floatAppBar] is false, the border will just be a
    /// bottom border line on the styled app bar.
    ///
    /// defaults to false.
    final bool hasBorder = false,

    /// Identical in behavior to [hasBorder], but the border is only drawn when
    /// the app bar is dark/black or white, or uses surface or background color.
    ///
    /// A colored app bar usually does not need any border, but one that is the
    /// same color as the background, or very close to it, looks better when
    /// there is some separation between it and the background.
    ///
    /// Defaults to true.
    final bool hasBorderOnSurface = true,

    /// The border to use on the styled app bar.
    ///
    /// The border is only drawn when [hasBorder] is true or
    /// [hasBorderOnSurface] is true and app bar color has a surface like
    /// color.
    ///
    /// If [border] is null and [floatAppBar] is false, then it defaults to a
    /// 1 dp bottom border line using [borderColor].
    /// If [border] is null and [floatAppBar] is true, it defaults to a 1 dp
    /// rectangle with rounded corners with a border radius of [borderRadius]
    /// using [borderColor].
    final Border? border,

    /// The border radius geometry used for the app bar border when
    /// [floatAppBar] is true.
    ///
    /// If [floatAppBar] is true, then it defaults to
    /// BorderRadius.circular(8), otherwise it defaults to null.
    final BorderRadiusGeometry? borderRadius,

    /// The color of the style app bar border.
    ///
    /// If null, it defaults to theme.dividerTheme.color, if it is null it
    /// uses theme.dividerColor.
    final Color? borderColor,

    /// Show the current screen size in the app bar
    ///
    /// This property is mostly intended as quick and easy way to show the
    /// current screen media size in the app bar. It is intended to as quick
    /// helper when developing responsive UI to see current screen size and
    /// that the design responds correctly at desired breakpoints.
    final bool showScreenSize = false,
  }) {
    // Make some input assertions, these are same as on the standard AppBar
    assert(elevation == null || elevation >= 0.0,
        'Elevation must be null or >= 0');
    // These are extra assertions for the styled AppBar
    assert(opacity >= 0 && opacity <= 1.0, 'Opacity must be >= 0 and <= 1');
    assert(startOpacity >= 0 && startOpacity <= 1.0,
        'Start opacity must be from 0 to 1.');
    assert(gradientPercentage >= 0 && gradientPercentage <= 100,
        'endPercentage must be >= 0 and <= 100');
    assert(floatScrim >= 0 && floatScrim <= 255,
        'looseScrim must be >= 0 and <= 255');

    final ThemeData theme = Theme.of(context);
    final AppBarTheme appBarTheme = AppBarTheme.of(context);
    final Color appBarColor =
        backgroundColor ?? appBarTheme.backgroundColor ?? theme.primaryColor;

    final Color endColor = theme.brightness == Brightness.light
        ? appBarColor.lighten(gradient ? gradientPercentage : 0)
        : appBarColor.darken(gradient ? gradientPercentage : 0);

    final Color endTextColor =
        ThemeData.estimateBrightnessForColor(appBarColor) == Brightness.light
            ? Colors.black87
            : Colors.white;

    // Determine if we should draw a bottom border. TRUE if the
    // flag to use it is true OR if the flag to use it on dark, black or white
    // app bars is true and we have dark, black or white color in the app bar.
    final Color schemeSurface = theme.colorScheme.surface;
    final Color schemeBackground = theme.colorScheme.surface;
    final bool effectiveBottomBorder = hasBorder ||
        (hasBorderOnSurface &&
            (appBarColor == Colors.black ||
                appBarColor == _kMaterialDarkSurface ||
                appBarColor == Colors.white ||
                appBarColor == schemeSurface ||
                appBarColor == schemeBackground ||
                endColor == Colors.black ||
                endColor == _kMaterialDarkSurface ||
                endColor == Colors.white ||
                endColor == schemeSurface ||
                endColor == schemeBackground));

    // User provided border color, if none use theme divider color.
    final Color bottomBorderColor =
        borderColor ?? theme.dividerTheme.color ?? theme.dividerColor;

    // Needed for the height of the flexible space, we need to pass it to
    // gradient container to know how high to make it to fill the AppBar.
    final double height =
        Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0.0))
                .height +
            MediaQuery.of(context).padding.top;

    // Get current screen size that we will show on the screen's app bar, if
    // [showScreenSize] is true.
    final Size size = MediaQuery.of(context).size;

    // Effective center title logic is from the Flutter app bar source, so we
    // can get same logic also for the styled app bar when screen size is shown.
    bool effectiveCenterTitle() {
      if (centerTitle != null) return centerTitle;
      if (theme.appBarTheme.centerTitle != null) {
        return theme.appBarTheme.centerTitle!;
      }
      switch (theme.platform) {
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
        case TargetPlatform.linux:
        case TargetPlatform.windows:
          return false;
        case TargetPlatform.iOS:
        case TargetPlatform.macOS:
          return actions == null || actions.length < 2;
      }
    }

    final Color effectiveStatusBarColor = statusBarColor ??
        (floatAppBar
            ? theme.scaffoldBackgroundColor.withAlpha(floatScrim)
            : scrim
                ? const Color(0x40000000)
                : Colors.transparent);
    final Brightness statusBarBrightness = ThemeData.estimateBrightnessForColor(
        floatAppBar ? theme.scaffoldBackgroundColor : appBarColor);
    final Brightness statusBarIconBrightness =
        statusBarBrightness == Brightness.light
            ? Brightness.dark
            : Brightness.light;

    // Make the system overlay for the styled app bar.
    final SystemUiOverlayStyle effectiveOverlay = systemOverlayStyle ??
        SystemUiOverlayStyle(
          statusBarColor: effectiveStatusBarColor,
          statusBarBrightness: statusBarBrightness,
          statusBarIconBrightness: statusBarIconBrightness,
          // The system navigation bar properties below are currently not set
          // at all for the style app bar, they have no effect anyway when set
          // in the AppBar. They are however used in a default AppBar with the
          // values shown below, but seem to have no effect. If needed later,
          // the properties can be added by removing the comments below.
          //
          // systemNavigationBarColor: Color(0xFF000000),
          // systemNavigationBarIconBrightness: Brightness.light,
          // systemNavigationBarDividerColor: null,
        );

    return FlexAppBar(
      key: key,
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: showScreenSize
          ? Row(children: <Widget>[
              // This spacer together with the expanded for the screen size will
              // center the title well enough also when screen size is shown.
              // The effective function is for theme and automatic
              // platform centering logic if the value is null.
              if (effectiveCenterTitle()) const Spacer(),
              title ?? const SizedBox.shrink(),
              if (actions == null) const SizedBox(width: 56),
              Expanded(
                child: Text(
                  ' ${size.width.round()}x${size.height.round()}',
                  style:
                      theme.textTheme.bodySmall!.copyWith(color: endTextColor),
                  textAlign: TextAlign.end,
                ),
              ),
            ])
          // No screen size shown, just include the title, nothing else
          : title,

      actions: actions,
      flexibleSpace: FlexAppBarStyling(
        height: height,
        color: appBarColor,
        endColor: endColor,
        opacity: opacity,
        blurred: blurred,
        gradient: gradient,
        reverseGradient: reverseGradient,
        floatAppBar: floatAppBar,
        floatPadding: floatPadding,
        hasBorder: effectiveBottomBorder,
        border: border,
        borderRadius: borderRadius,
        borderColor: bottomBorderColor,
        elevation: elevation,
      ),
      bottom: bottom,
      elevation: 0,
      shadowColor: shadowColor,
      shape: shape,
      // The styled AppBar is actually fully transparent, the used color and
      // gradient is added via the flexible space
      backgroundColor: const Color(0x01000000),
      foregroundColor: foregroundColor,
      iconTheme: iconTheme,
      actionsIconTheme: actionsIconTheme,
      primary: primary,
      centerTitle: effectiveCenterTitle(),
      excludeHeaderSemantics: excludeHeaderSemantics,
      titleSpacing: titleSpacing,
      toolbarOpacity: toolbarOpacity,
      bottomOpacity: bottomOpacity,
      toolbarHeight: toolbarHeight,
      leadingWidth: leadingWidth,
      toolbarTextStyle: toolbarTextStyle,
      titleTextStyle: titleTextStyle,
      systemOverlayStyle: effectiveOverlay,
    );
  }

  /// Return an actual [AppBar] widget from the [FlexAppBar] data object.
  ///
  /// Any pre-existing property values in the [FlexAppBar] object can
  /// be overridden before creating the [AppBar]. Flexfold uses this to adjust
  /// leading and actions widget's functionality before it constructs its
  /// actual app bars.
  AppBar toAppBar({
    final Key? key,
    final Widget? leading,
    final bool? automaticallyImplyLeading,
    final Widget? title,
    final List<Widget>? actions,
    final Widget? flexibleSpace,
    final PreferredSizeWidget? bottom,
    final double? elevation,
    final Color? shadowColor,
    final ShapeBorder? shape,
    final Color? backgroundColor,
    final Color? foregroundColor,
    final IconThemeData? iconTheme,
    final IconThemeData? actionsIconTheme,
    final TextTheme? textTheme,
    final bool? primary,
    final bool? centerTitle,
    final bool? excludeHeaderSemantics,
    final double? titleSpacing,
    final double? toolbarOpacity,
    final double? bottomOpacity,
    final double? toolbarHeight,
    final double? leadingWidth,
    final bool? backwardsCompatibility,
    final TextStyle? toolbarTextStyle,
    final TextStyle? titleTextStyle,
    final SystemUiOverlayStyle? systemOverlayStyle,
  }) {
    return AppBar(
      key: key ?? this.key,
      leading: leading ?? this.leading,
      automaticallyImplyLeading:
          automaticallyImplyLeading ?? this.automaticallyImplyLeading,
      title: title ?? this.title,
      actions: actions ?? this.actions,
      flexibleSpace: flexibleSpace ?? this.flexibleSpace,
      bottom: bottom ?? this.bottom,
      elevation: elevation ?? this.elevation,
      shadowColor: shadowColor ?? this.shadowColor,
      shape: shape ?? this.shape,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      iconTheme: iconTheme ?? this.iconTheme,
      actionsIconTheme: actionsIconTheme ?? this.actionsIconTheme,
      primary: primary ?? this.primary,
      centerTitle: centerTitle ?? this.centerTitle,
      excludeHeaderSemantics:
          excludeHeaderSemantics ?? this.excludeHeaderSemantics,
      titleSpacing: titleSpacing ?? this.titleSpacing,
      toolbarOpacity: toolbarOpacity ?? this.toolbarOpacity,
      bottomOpacity: bottomOpacity ?? this.bottomOpacity,
      toolbarHeight: toolbarHeight ?? this.toolbarHeight,
      leadingWidth: leadingWidth ?? this.leadingWidth,
      toolbarTextStyle: toolbarTextStyle ?? this.toolbarTextStyle,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      systemOverlayStyle: systemOverlayStyle ?? this.systemOverlayStyle,
    );
  }
}

/// A widget used to style the flexible space on an AppBar.
///
/// This Widget is typically used by the [FlexAppBar.styled] factory
/// constructor to create the gradient background it uses, as well as the
/// border for dark, black and white app bars. It also handles the
/// iOS style blur effect.
///
/// It can also be used to create an app bar style that floats over the UI and
/// is disconnected from the edges of the device screen or container window.
@immutable
class FlexAppBarStyling extends StatelessWidget {
  /// Default constructor.
  const FlexAppBarStyling({
    super.key,
    this.height = kToolbarHeight,
    required this.color,
    required this.endColor,
    this.startOpacity = 1,
    this.opacity = 0.9,
    this.blurred = true,
    this.gradient = true,
    this.reverseGradient = false,
    this.floatAppBar = false,
    this.floatPadding = const EdgeInsetsDirectional.fromSTEB(3, 0, 3, 0),
    this.hasBorder = false,
    this.border,
    this.borderRadius,
    this.borderColor,
    this.elevation,
    this.child,
  })  : assert(startOpacity >= 0 && startOpacity <= 1.0,
            'Start opacity must be from 0 to 1.'),
        assert(opacity >= 0 && opacity <= 1.0, 'Opacity must be from 0 to 1.'),
        assert(elevation == null || elevation >= 0.0,
            'Elevation must be null or >= 0');

  /// The flexible container height
  ///
  /// When used via [FlexAppBar.styled], it provides the correct value for
  /// the active app bar.
  ///
  /// Defaults to kToolbarHeight.
  final double height;

  /// Background color of the styled app bar, also used as start color for
  /// the gradient styled app bar.
  final Color color;

  /// Background end color for the gradient styled app bar.
  final Color endColor;

  /// Opacity value for the entire app bar when [gradient] is false,
  /// or [opacity] of the [endColor] when [gradient] is used.
  ///
  /// Defaults to 0.9.
  final double opacity;

  /// Opacity value for the app bar start [color].
  ///
  /// This opacity value is only used when [gradient] is true. It is often set
  /// to 1 for a fully opaque start value for the start gradient [color].
  /// This makes it easier to see the leading action widget and the title,
  /// that is often also at the beginning of the app bar.
  ///
  /// Defaults to 1, fully opaque.
  final double startOpacity;

  /// Apply a frosted glass blur effect on the app bar if it has other
  /// opacity values than 1.
  ///
  /// This applies the blurring effect on Material on app bar
  /// that is often used on Cupertino app bars when any of its opacity values
  /// are different from 1.
  ///
  /// This filter is bit expensive, it is only applied on the app bar
  /// when this flag is true and the start or end opacity is < 1, .
  ///
  /// The used blur effect is the same as Flutter SDK uses for on blur on
  /// Cupertino app bars. The used opacity values also impacts the
  /// final effect.
  ///
  /// Defaults to true.
  final bool blurred;

  /// The the app bar flexible space is using gradient style.
  ///
  /// If [gradient] is false, then the app bar styling does not use any gradient
  /// and the app bar will use [color] for its color. It will also get the
  /// [opacity] value applied. The entire app bar will thus be as transparent
  /// as the end point opacity value, when a gradient is not used and [opacity]
  /// has a value less than 1.
  final bool gradient;

  /// Se to true to reverse the order of the start [color] and [endColor]
  /// used for the flexible space gradient.
  ///
  /// This is mostly useful when multiple styled app bars are in a row layout,
  /// and we want the gradients to flow from one to the next app bar, by
  /// reversing the order of the gradient color for each alternating app bar.
  ///
  /// Defaults to false.
  final bool reverseGradient;

  /// The styled app bar is floating and not connected to the edges of the
  /// screen.
  ///
  /// This type of app bar can work well on devices that have system status
  /// bar on top of the app bar.
  ///
  /// Defaults to false.
  final bool floatAppBar;

  /// Padding for the float styled app bar.
  ///
  /// The padding above and below the styled app bar is space is removed from
  /// the AppBar height and needs to be very small, values from 0 to 4 can
  /// work OK for top and bottom, that is typically only needed for a floating
  /// effect on devices that doe not have a status bar, like desktop and web.
  /// Defaults to 0.
  ///
  /// The padding for start and end defaults to 3 and can look OK all the
  /// way up to 6.
  ///
  /// Defaults to EdgeInsetsDirectional.fromSTEB(3, 0, 3, 0).
  final EdgeInsetsDirectional floatPadding;

  /// Draw a border on the styled app bar.
  ///
  /// If [floatAppBar] is true, the border will be a border all around the
  /// style app bar, if [floatAppBar] is false, the border will just be a
  /// bottom border on the styled app bar.
  final bool hasBorder;

  /// The border to use on the styled App bar. The border is only drawn when
  /// [hasBorder] is true.
  ///
  /// If null and [floatAppBar] is false, it defaults to a bottom with a
  /// color that uses the theme of context Divider color.
  /// If null and [floatAppBar] is true, it defaults to a rect with rounded
  /// corners with diameter of 8 using a color that uses the theme of context
  /// Divider color.
  final Border? border;

  /// The border radius geometry used.
  ///
  /// If [floatAppBar] is true, then defaults to
  /// BorderRadius.circular(8) otherwise defaults to null.
  final BorderRadiusGeometry? borderRadius;

  /// The color of the border
  ///
  /// If null, it defaults to theme.dividerTheme.color, if it is null, it
  /// defaults to theme.dividerColor.
  final Color? borderColor;

  /// Elevation of the flexible space of the styled app bar.
  ///
  /// Defaults to theme.appBarTheme.elevation, but if it is null,
  /// it defaults to 0.
  final double? elevation;

  /// Optional child for the styled flexible space of an app bar.
  ///
  /// Normally null.
  final Widget? child;

  @override
  Widget build(final BuildContext context) {
    final double effectiveTopPadding =
        floatAppBar ? MediaQuery.of(context).padding.top + floatPadding.top : 0;

    final ThemeData theme = Theme.of(context);
    final Color effectiveBorderColor =
        borderColor ?? theme.dividerTheme.color ?? theme.dividerColor;

    final BorderRadiusGeometry? effectiveBorderRadius =
        borderRadius ?? (floatAppBar ? BorderRadius.circular(8) : null);

    final Border? effectiveBorder = hasBorder
        ? border ??
            (floatAppBar
                ? Border.all(color: effectiveBorderColor)
                : Border(bottom: BorderSide(color: effectiveBorderColor)))
        : null;

    return Column(
      children: <Widget>[
        SizedBox(height: effectiveTopPadding),
        Padding(
          padding: floatAppBar
              ? EdgeInsetsDirectional.fromSTEB(
                  floatPadding.start, 0, floatPadding.end, floatPadding.bottom)
              : EdgeInsets.zero,
          child: Material(
            color: Colors.transparent,
            elevation: elevation ?? theme.appBarTheme.elevation ?? 0,
            clipBehavior: Clip.antiAlias,
            borderRadius: effectiveBorderRadius,
            child: IfWrapper(
              condition: blurred && (opacity < 1 || startOpacity < 1),
              builder: (final BuildContext context, final Widget child) {
                return ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: child,
                  ),
                );
              },
              child: Container(
                height: height -
                    effectiveTopPadding -
                    (floatAppBar ? floatPadding.bottom : 0),
                decoration: BoxDecoration(
                  color: gradient ? null : color.withValues(alpha: opacity),
                  borderRadius: effectiveBorderRadius,
                  border: effectiveBorder,
                  gradient: gradient
                      ? LinearGradient(
                          begin: AlignmentDirectional.centerStart,
                          end: AlignmentDirectional.centerEnd,
                          colors: <Color>[
                            if (reverseGradient)
                              endColor.withValues(alpha: opacity)
                            else
                              color.withValues(alpha: startOpacity),
                            if (reverseGradient)
                              color.withValues(alpha: startOpacity)
                            else
                              endColor.withValues(alpha: opacity),
                          ],
                        )
                      : null,
                ),
                child: child,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
