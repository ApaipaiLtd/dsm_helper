// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

const Duration _kExpand = Duration(milliseconds: 200);

class ExpansionTileController {
  /// Create a controller to be used with [ExpansionTile.controller].
  ExpansionTileController();

  _ExpansionContainerState? _state;

  /// Whether the [ExpansionTile] built with this controller is in expanded state.
  ///
  /// This property doesn't take the animation into account. It reports `true`
  /// even if the expansion animation is not completed.
  ///
  /// See also:
  ///
  ///  * [expand], which expands the [ExpansionTile].
  ///  * [collapse], which collapses the [ExpansionTile].
  ///  * [ExpansionTile.controller] to create an ExpansionTile with a controller.
  bool get isExpanded {
    assert(_state != null);
    return _state!._isExpanded;
  }

  /// Expands the [ExpansionTile] that was built with this controller;
  ///
  /// Normally the tile is expanded automatically when the user taps on the header.
  /// It is sometimes useful to trigger the expansion programmatically due
  /// to external changes.
  ///
  /// If the tile is already in the expanded state (see [isExpanded]), calling
  /// this method has no effect.
  ///
  /// Calling this method may cause the [ExpansionTile] to rebuild, so it may
  /// not be called from a build method.
  ///
  /// Calling this method will trigger an [ExpansionTile.onExpansionChanged] callback.
  ///
  /// See also:
  ///
  ///  * [collapse], which collapses the tile.
  ///  * [isExpanded] to check whether the tile is expanded.
  ///  * [ExpansionTile.controller] to create an ExpansionTile with a controller.
  void expand() {
    assert(_state != null);
    if (!isExpanded) {
      _state!._toggleExpansion();
    }
  }

  /// Collapses the [ExpansionTile] that was built with this controller.
  ///
  /// Normally the tile is collapsed automatically when the user taps on the header.
  /// It can be useful sometimes to trigger the collapse programmatically due
  /// to some external changes.
  ///
  /// If the tile is already in the collapsed state (see [isExpanded]), calling
  /// this method has no effect.
  ///
  /// Calling this method may cause the [ExpansionTile] to rebuild, so it may
  /// not be called from a build method.
  ///
  /// Calling this method will trigger an [ExpansionTile.onExpansionChanged] callback.
  ///
  /// See also:
  ///
  ///  * [expand], which expands the tile.
  ///  * [isExpanded] to check whether the tile is expanded.
  ///  * [ExpansionTile.controller] to create an ExpansionTile with a controller.
  void collapse() {
    assert(_state != null);
    if (isExpanded) {
      _state!._toggleExpansion();
    }
  }

  /// Finds the [ExpansionTileController] for the closest [ExpansionTile] instance
  /// that encloses the given context.
  ///
  /// If no [ExpansionTile] encloses the given context, calling this
  /// method will cause an assert in debug mode, and throw an
  /// exception in release mode.
  ///
  /// To return null if there is no [ExpansionTile] use [maybeOf] instead.
  ///
  /// {@tool dartpad}
  /// Typical usage of the [ExpansionTileController.of] function is to call it from within the
  /// `build` method of a descendant of an [ExpansionTile].
  ///
  /// When the [ExpansionTile] is actually created in the same `build`
  /// function as the callback that refers to the controller, then the
  /// `context` argument to the `build` function can't be used to find
  /// the [ExpansionTileController] (since it's "above" the widget
  /// being returned in the widget tree). In cases like that you can
  /// add a [Builder] widget, which provides a new scope with a
  /// [BuildContext] that is "under" the [ExpansionTile]:
  ///
  /// ** See code in examples/api/lib/material/expansion_tile/expansion_tile.1.dart **
  /// {@end-tool}
  ///
  /// A more efficient solution is to split your build function into
  /// several widgets. This introduces a new context from which you
  /// can obtain the [ExpansionTileController]. With this approach you
  /// would have an outer widget that creates the [ExpansionTile]
  /// populated by instances of your new inner widgets, and then in
  /// these inner widgets you would use [ExpansionTileController.of].
  static ExpansionTileController of(BuildContext context) {
    final _ExpansionContainerState? result = context.findAncestorStateOfType<_ExpansionContainerState>();
    if (result != null) {
      return result._tileController;
    }
    throw FlutterError.fromParts(<DiagnosticsNode>[
      ErrorSummary(
        'ExpansionTileController.of() called with a context that does not contain a ExpansionTile.',
      ),
      ErrorDescription(
        'No ExpansionTile ancestor could be found starting from the context that was passed to ExpansionTileController.of(). '
        'This usually happens when the context provided is from the same StatefulWidget as that '
        'whose build function actually creates the ExpansionTile widget being sought.',
      ),
      ErrorHint(
        'There are several ways to avoid this problem. The simplest is to use a Builder to get a '
        'context that is "under" the ExpansionTile. For an example of this, please see the '
        'documentation for ExpansionTileController.of():\n'
        '  https://api.flutter.dev/flutter/material/ExpansionTile/of.html',
      ),
      ErrorHint(
        'A more efficient solution is to split your build function into several widgets. This '
        'introduces a new context from which you can obtain the ExpansionTile. In this solution, '
        'you would have an outer widget that creates the ExpansionTile populated by instances of '
        'your new inner widgets, and then in these inner widgets you would use ExpansionTileController.of().\n'
        'An other solution is assign a GlobalKey to the ExpansionTile, '
        'then use the key.currentState property to obtain the ExpansionTile rather than '
        'using the ExpansionTileController.of() function.',
      ),
      context.describeElement('The context used was'),
    ]);
  }

  /// Finds the [ExpansionTile] from the closest instance of this class that
  /// encloses the given context and returns its [ExpansionTileController].
  ///
  /// If no [ExpansionTile] encloses the given context then return null.
  /// To throw an exception instead, use [of] instead of this function.
  ///
  /// See also:
  ///
  ///  * [of], a similar function to this one that throws if no [ExpansionTile]
  ///    encloses the given context. Also includes some sample code in its
  ///    documentation.
  static ExpansionTileController? maybeOf(BuildContext context) {
    return context.findAncestorStateOfType<_ExpansionContainerState>()?._tileController;
  }
}

/// A single-line [ListTile] with an expansion arrow icon that expands or collapses
/// the tile to reveal or hide the [children].
///
/// This widget is typically used with [ListView] to create an
/// "expand / collapse" list entry. When used with scrolling widgets like
/// [ListView], a unique [PageStorageKey] must be specified to enable the
/// [ExpansionContainer] to save and restore its expanded state when it is scrolled
/// in and out of view.
///
/// This class overrides the [ListTileTheme.iconColor] and [ListTileTheme.textColor]
/// theme properties for its [ListTile]. These colors animate between values when
/// the tile is expanded and collapsed: between [iconColor], [collapsedIconColor] and
/// between [textColor] and [collapsedTextColor].
///
/// The expansion arrow icon is shown on the right by default in left-to-right languages
/// (i.e. the trailing edge). This can be changed using [controlAffinity]. This maps
/// to the [leading] and [trailing] properties of [ExpansionContainer].
///
/// {@tool dartpad --template=stateful_widget_scaffold}
///
/// This example demonstrates different configurations of ExpansionTile.
///
/// ```dart
/// bool _customTileExpanded = false;
///
/// @override
/// Widget build(BuildContext context) {
///   return Column(
///     children: <Widget>[
///       const ExpansionTile(
///         title: Text('ExpansionTile 1'),
///         subtitle: Text('Trailing expansion arrow icon'),
///         children: <Widget>[
///           ListTile(title: Text('This is tile number 1')),
///         ],
///       ),
///       ExpansionTile(
///         title: const Text('ExpansionTile 2'),
///         subtitle: const Text('Custom expansion arrow icon'),
///         trailing: Icon(
///           _customTileExpanded
///               ? Icons.arrow_drop_down_circle
///               : Icons.arrow_drop_down,
///         ),
///         children: const <Widget>[
///           ListTile(title: Text('This is tile number 2')),
///         ],
///         onExpansionChanged: (bool expanded) {
///           setState(() => _customTileExpanded = expanded);
///         },
///       ),
///       const ExpansionTile(
///         title: Text('ExpansionTile 3'),
///         subtitle: Text('Leading expansion arrow icon'),
///         controlAffinity: ListTileControlAffinity.leading,
///         children: <Widget>[
///           ListTile(title: Text('This is tile number 3')),
///         ],
///       ),
///     ],
///   );
/// }
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [ListTile], useful for creating expansion tile [children] when the
///    expansion tile represents a sublist.
///  * The "Expand and collapse" section of
///    <https://material.io/components/lists#types>
class ExpansionContainer extends StatefulWidget {
  /// Creates a single-line [ListTile] with an expansion arrow icon that expands or collapses
  /// the tile to reveal or hide the [children]. The [initiallyExpanded] property must
  /// be non-null.
  const ExpansionContainer({
    super.key,
    this.leading,
    required this.title,
    this.showFirst = false,
    this.first,
    this.subtitle,
    this.onExpansionChanged,
    this.children = const <Widget>[],
    this.trailing,
    this.initiallyExpanded = false,
    this.maintainState = false,
    this.tilePadding,
    this.expandedCrossAxisAlignment,
    this.expandedAlignment,
    this.childrenPadding,
    this.backgroundColor,
    this.collapsedBackgroundColor,
    this.textColor,
    this.collapsedTextColor,
    this.shape,
    this.collapsedShape,
    this.iconColor,
    this.collapsedIconColor,
    this.controlAffinity,
    this.bottomTitle = false,
    this.controller,
  }) : assert(
          expandedCrossAxisAlignment != CrossAxisAlignment.baseline,
          'CrossAxisAlignment.baseline is not supported since the expanded children '
          'are aligned in a column, not a row. Try to use another constant.',
        );

  /// A widget to display before the title.
  ///
  /// Typically a [CircleAvatar] widget.
  ///
  /// Note that depending on the value of [controlAffinity], the [leading] widget
  /// may replace the rotating expansion arrow icon.
  final Widget? leading;

  /// The primary content of the list item.
  ///
  /// Typically a [Text] widget.
  final Widget title;

  /// Additional content displayed below the title.
  ///
  /// Typically a [Text] widget.
  final Widget? subtitle;

  final Widget? first;

  final bool showFirst;

  /// Called when the tile expands or collapses.
  ///
  /// When the tile starts expanding, this function is called with the value
  /// true. When the tile starts collapsing, this function is called with
  /// the value false.
  final ValueChanged<bool>? onExpansionChanged;

  /// The widgets that are displayed when the tile expands.
  ///
  /// Typically [ListTile] widgets.
  final List<Widget> children;

  /// The color to display behind the sublist when expanded.
  final Color? backgroundColor;

  /// When not null, defines the background color of tile when the sublist is collapsed.
  final Color? collapsedBackgroundColor;

  /// A widget to display after the title.
  ///
  /// Note that depending on the value of [controlAffinity], the [trailing] widget
  /// may replace the rotating expansion arrow icon.
  final Widget? trailing;

  /// Specifies if the list tile is initially expanded (true) or collapsed (false, the default).
  final bool initiallyExpanded;

  /// Specifies whether the state of the children is maintained when the tile expands and collapses.
  ///
  /// When true, the children are kept in the tree while the tile is collapsed.
  /// When false (default), the children are removed from the tree when the tile is
  /// collapsed and recreated upon expansion.
  final bool maintainState;

  /// Specifies padding for the [ListTile].
  ///
  /// Analogous to [ListTile.contentPadding], this property defines the insets for
  /// the [leading], [title], [subtitle] and [trailing] widgets. It does not inset
  /// the expanded [children] widgets.
  ///
  /// When the value is null, the tile's padding is `EdgeInsets.symmetric(horizontal: 16.0)`.
  final EdgeInsetsGeometry? tilePadding;

  /// Specifies the alignment of [children], which are arranged in a column when
  /// the tile is expanded.
  ///
  /// The internals of the expanded tile make use of a [Column] widget for
  /// [children], and [Align] widget to align the column. The `expandedAlignment`
  /// parameter is passed directly into the [Align].
  ///
  /// Modifying this property controls the alignment of the column within the
  /// expanded tile, not the alignment of [children] widgets within the column.
  /// To align each child within [children], see [expandedCrossAxisAlignment].
  ///
  /// The width of the column is the width of the widest child widget in [children].
  ///
  /// When the value is null, the value of `expandedAlignment` is [Alignment.center].
  final Alignment? expandedAlignment;

  /// Specifies the alignment of each child within [children] when the tile is expanded.
  ///
  /// The internals of the expanded tile make use of a [Column] widget for
  /// [children], and the `crossAxisAlignment` parameter is passed directly into the [Column].
  ///
  /// Modifying this property controls the cross axis alignment of each child
  /// within its [Column]. Note that the width of the [Column] that houses
  /// [children] will be the same as the widest child widget in [children]. It is
  /// not necessarily the width of [Column] is equal to the width of expanded tile.
  ///
  /// To align the [Column] along the expanded tile, use the [expandedAlignment] property
  /// instead.
  ///
  /// When the value is null, the value of `expandedCrossAxisAlignment` is [CrossAxisAlignment.center].
  final CrossAxisAlignment? expandedCrossAxisAlignment;

  /// Specifies padding for [children].
  ///
  /// When the value is null, the value of `childrenPadding` is [EdgeInsets.zero].
  final EdgeInsetsGeometry? childrenPadding;

  /// The icon color of tile's expansion arrow icon when the sublist is expanded.
  ///
  /// Used to override to the [ListTileTheme.iconColor].
  final Color? iconColor;

  /// The icon color of tile's expansion arrow icon when the sublist is collapsed.
  ///
  /// Used to override to the [ListTileTheme.iconColor].
  final Color? collapsedIconColor;

  /// The color of the tile's titles when the sublist is expanded.
  ///
  /// Used to override to the [ListTileTheme.textColor].
  final Color? textColor;

  /// The color of the tile's titles when the sublist is collapsed.
  ///
  /// Used to override to the [ListTileTheme.textColor].
  final Color? collapsedTextColor;

  final ShapeBorder? collapsedShape;

  final ShapeBorder? shape;

  /// Typically used to force the expansion arrow icon to the tile's leading or trailing edge.
  ///
  /// By default, the value of `controlAffinity` is [ListTileControlAffinity.platform],
  /// which means that the expansion arrow icon will appear on the tile's trailing edge.
  final ListTileControlAffinity? controlAffinity;
  final bool bottomTitle;

  final ExpansionTileController? controller;
  @override
  State<ExpansionContainer> createState() => _ExpansionContainerState();
}

class _ExpansionContainerState extends State<ExpansionContainer> with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeOutTween = CurveTween(curve: Curves.easeOut);
  static final Animatable<double> _easeInTween = CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween = Tween<double>(begin: 0.0, end: 0.5);

  final ShapeBorderTween _borderTween = ShapeBorderTween();
  final ColorTween _headerColorTween = ColorTween();
  final ColorTween _iconColorTween = ColorTween();
  final ColorTween _backgroundColorTween = ColorTween();

  late AnimationController _animationController;
  late Animation<double> _iconTurns;
  late Animation<double> _heightFactor;
  late Animation<Color?> _backgroundColor;

  bool _isExpanded = false;
  late ExpansionTileController _tileController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: _kExpand, vsync: this);
    _heightFactor = _animationController.drive(_easeInTween);
    _iconTurns = _animationController.drive(_halfTween.chain(_easeInTween));
    _backgroundColor = _animationController.drive(_backgroundColorTween.chain(_easeOutTween));

    _isExpanded = PageStorage.maybeOf(context)?.readState(context) as bool? ?? widget.initiallyExpanded;
    if (_isExpanded) {
      _animationController.value = 1.0;
    }

    assert(widget.controller?._state == null);
    _tileController = widget.controller ?? ExpansionTileController();
    _tileController._state = this;
  }

  @override
  void dispose() {
    _tileController._state = null;
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpansion() {
    final TextDirection textDirection = WidgetsLocalizations.of(context).textDirection;
    final MaterialLocalizations localizations = MaterialLocalizations.of(context);
    final String stateHint = _isExpanded ? localizations.expandedHint : localizations.collapsedHint;
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse().then<void>((void value) {
          if (!mounted) {
            return;
          }
          setState(() {
            // Rebuild without widget.children.
          });
        });
      }
      PageStorage.maybeOf(context)?.writeState(context, _isExpanded);
    });
    widget.onExpansionChanged?.call(_isExpanded);
    SemanticsService.announce(stateHint, textDirection);
  }

  void _handleTap() {
    _toggleExpansion();
  }

  // Platform or null affinity defaults to trailing.
  ListTileControlAffinity _effectiveAffinity(ListTileControlAffinity? affinity) {
    switch (affinity ?? ListTileControlAffinity.trailing) {
      case ListTileControlAffinity.leading:
        return ListTileControlAffinity.leading;
      case ListTileControlAffinity.trailing:
      case ListTileControlAffinity.platform:
        return ListTileControlAffinity.trailing;
      default:
        return ListTileControlAffinity.leading;
    }
  }

  Widget _buildIcon(BuildContext context) {
    return RotationTransition(
      turns: _iconTurns,
      child: const Icon(Icons.expand_more),
    );
  }

  // Widget _buildLeadingIcon(BuildContext context) {
  //   if (_effectiveAffinity(widget.controlAffinity) != ListTileControlAffinity.leading) return null;
  //   return _buildIcon(context);
  // }

  Widget? _buildTrailingIcon(BuildContext context) {
    if (_effectiveAffinity(widget.controlAffinity) != ListTileControlAffinity.trailing) {
      return null;
    }
    return _buildIcon(context);
  }

  Widget _buildChildren(BuildContext context, Widget? child) {
    Widget children = ClipRect(
      child: Align(
        alignment: widget.expandedAlignment ?? Alignment.center,
        heightFactor: _heightFactor.value,
        child: child,
      ),
    );
    return Container(
      decoration: BoxDecoration(
        color: _backgroundColor.value ?? Colors.transparent,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (widget.bottomTitle) children,
          Column(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: _handleTap,
                child: Container(
                  padding: widget.tilePadding ?? EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    children: [
                      Expanded(child: widget.title),
                      SizedBox(
                        width: 5,
                      ),
                      widget.trailing ?? _buildTrailingIcon(context) ?? SizedBox(),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(23),
                ),
                child: Column(
                  children: [
                    if (widget.showFirst && widget.first != null) widget.first!,
                    if (!widget.bottomTitle) children,
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    final ThemeData theme = Theme.of(context);
    final ExpansionTileThemeData expansionTileTheme = ExpansionTileTheme.of(context);
    final ExpansionTileThemeData defaults = theme.useMaterial3 ? _ExpansionTileDefaultsM3(context) : _ExpansionTileDefaultsM2(context);
    _borderTween
      ..begin = widget.collapsedShape ??
          expansionTileTheme.collapsedShape ??
          const Border(
            top: BorderSide(color: Colors.transparent),
            bottom: BorderSide(color: Colors.transparent),
          )
      ..end = widget.shape ??
          expansionTileTheme.collapsedShape ??
          Border(
            top: BorderSide(color: theme.dividerColor),
            bottom: BorderSide(color: theme.dividerColor),
          );
    _headerColorTween
      ..begin = widget.collapsedTextColor ?? expansionTileTheme.collapsedTextColor ?? defaults.collapsedTextColor
      ..end = widget.textColor ?? expansionTileTheme.textColor ?? defaults.textColor;
    _iconColorTween
      ..begin = widget.collapsedIconColor ?? expansionTileTheme.collapsedIconColor ?? defaults.collapsedIconColor
      ..end = widget.iconColor ?? expansionTileTheme.iconColor ?? defaults.iconColor;
    _backgroundColorTween
      ..begin = widget.collapsedBackgroundColor ?? expansionTileTheme.collapsedBackgroundColor
      ..end = widget.backgroundColor ?? expansionTileTheme.backgroundColor;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _animationController.isDismissed;
    final bool shouldRemoveChildren = closed && !widget.maintainState;

    final Widget result = Offstage(
      offstage: closed,
      child: TickerMode(
        enabled: !closed,
        child: Padding(
          padding: widget.childrenPadding ?? EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: widget.expandedCrossAxisAlignment ?? CrossAxisAlignment.center,
            children: widget.children.sublist(widget.showFirst ? 1 : 0),
          ),
        ),
      ),
    );

    return AnimatedBuilder(
      animation: _animationController.view,
      builder: _buildChildren,
      child: shouldRemoveChildren ? null : result,
    );
  }
}

class _ExpansionTileDefaultsM2 extends ExpansionTileThemeData {
  _ExpansionTileDefaultsM2(this.context);

  final BuildContext context;
  late final ThemeData _theme = Theme.of(context);
  late final ColorScheme _colorScheme = _theme.colorScheme;

  @override
  Color? get textColor => _colorScheme.primary;

  @override
  Color? get iconColor => _colorScheme.primary;

  @override
  Color? get collapsedTextColor => _theme.textTheme.titleMedium!.color;

  @override
  Color? get collapsedIconColor => _theme.unselectedWidgetColor;
}

// BEGIN GENERATED TOKEN PROPERTIES - ExpansionTile

// Do not edit by hand. The code between the "BEGIN GENERATED" and
// "END GENERATED" comments are generated from data in the Material
// Design token database by the script:
//   dev/tools/gen_defaults/bin/gen_defaults.dart.

class _ExpansionTileDefaultsM3 extends ExpansionTileThemeData {
  _ExpansionTileDefaultsM3(this.context);

  final BuildContext context;
  late final ThemeData _theme = Theme.of(context);
  late final ColorScheme _colors = _theme.colorScheme;

  @override
  Color? get textColor => _colors.onSurface;

  @override
  Color? get iconColor => _colors.primary;

  @override
  Color? get collapsedTextColor => _colors.onSurface;

  @override
  Color? get collapsedIconColor => _colors.onSurfaceVariant;
}

// END GENERATED TOKEN PROPERTIES - ExpansionTile
