import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

/// The gestures available to dismiss the keyboard with [KeyboardDismisser].
///
/// Note that these gestures are also the ones available in [GestureDetector]
/// from Flutter's widgets library, except for [onPanUpdateDownDirection],
/// [onPanUpdateUpDirection], [onPanUpdateLeftDirection] and
/// [onPanUpdateRightDirection], which are special types of
/// [onPanUpdateAnyDirection] (corresponding to [GestureDetector.onPanUpdate])
/// that will trigger the keyboard's dismissal when swiping only in the
/// specified direction (down, up, left and right, respectively).
///
/// Just like with [GestureDetector], pan and scale callbacks cannot be used
/// simultaneously, and horizontal and vertical drag callbacks cannot be used
/// simultaneously.
///
/// See also:
///
///   * [GestureDetector], which is a widget that detects gestures.
enum GestureType {
  onTapDown,
  onTapUp,
  onTap,
  onTapCancel,
  onSecondaryTapDown,
  onSecondaryTapUp,
  onSecondaryTapCancel,
  onDoubleTap,
  onLongPress,
  onLongPressStart,
  onLongPressMoveUpdate,
  onLongPressUp,
  onLongPressEnd,
  onVerticalDragDown,
  onVerticalDragStart,
  onVerticalDragUpdate,
  onVerticalDragEnd,
  onVerticalDragCancel,
  onHorizontalDragDown,
  onHorizontalDragStart,
  onHorizontalDragUpdate,
  onHorizontalDragEnd,
  onHorizontalDragCancel,
  onForcePressStart,
  onForcePressPeak,
  onForcePressUpdate,
  onForcePressEnd,
  onPanDown,
  onPanStart,
  onPanUpdateAnyDirection,
  onPanUpdateDownDirection,
  onPanUpdateUpDirection,
  onPanUpdateLeftDirection,
  onPanUpdateRightDirection,
  onPanEnd,
  onPanCancel,
  onScaleStart,
  onScaleUpdate,
  onScaleEnd,
}

/// A widget that can dismiss the keyboard when performing a gesture.
///
/// Wrapping any widget with this widget will trigger the keyboard's dismissal
/// when performing a gesture in an area of the screen with no other widgets
/// that can absorb the gesture in it. For example, if a [KeyboardDismisser]
/// that is looking to dismiss the keyboard when performing a gesture of
/// [GestureType.onTap] is wrapping a widget that contains a button, the
/// keyboard will be dismissed when tapping outside of the button, but it won't
/// when tapped inside it, since the button will be pushed, absorbing the tap.
///
/// Typical usage of [KeyboardDismisser] involves wrapping a whole page with it,
/// including its [Scaffold], so that the keyboard is dismissed when tapping on
/// any inactive widget. For example:
///
/// ```dart
/// class KeyboardDismissiblePageWithButton extends StatelessWidget {
///  @override
///  Widget build(BuildContext context) => KeyboardDismisser(
///        child: Scaffold(
///          appBar: AppBar(
///            title: Text('KeyboardDismisser example'),
///          ),
///          body: Column(
///            children: <Widget>[
///              Padding(
///                padding: const EdgeInsets.all(42.0),
///                child: TextField(
///                  decoration: InputDecoration(
///                    border: OutlineInputBorder(),
///                    labelText: 'Tap to show the keyboard',
///                    hintText: 'Tap elsewhere to dismiss',
///                  ),
///                ),
///              ),
///              Center(
///                child: RaisedButton(
///                  onPressed: () => print('Keyboard persists'),
///                  child: Text('Tap me!'),
///                ),
///              ),
///            ],
///          ),
///        ),
///      );
/// }
/// ```
///
/// Wrapping a [MaterialApp], [WidgetsApp] or [CupertinoApp] with a
/// [KeyboardDismisser] will make the whole app acquire the behaviour from
/// [KeyboardDismisser], since every [Scaffold] will be a child of the
/// corresponding app widget.
class KeyboardDismisser extends StatelessWidget {
  /// Creates a widget that can dismiss the keyboard when performing a gesture.
  ///
  /// The [gestures] property holds a list of [GestureType] that will dismiss
  /// the keyboard when performed. This way, several gestures are supported.
  /// Pan and scale callbacks cannot be used simultaneously, and horizontal and
  /// vertical drag callbacks cannot be used simultaneously. By default, the
  /// [KeyboardDismisser] will dismiss the keyboard when performing a tapping
  /// gesture.
  const KeyboardDismisser({
    Key? key,
    required this.child,
    this.behavior,
    this.gestures = const [GestureType.onTap],
    this.dragStartBehavior = DragStartBehavior.start,
    this.excludeFromSemantics = false,
  }) : super(key: key);

  /// The list of gestures that will dismiss the keyboard when performed.
  final List<GestureType> gestures;

  /// Determines the way that drag start behavior is handled.
  ///
  /// See also:
  ///
  ///   * [GestureDetector.dragStartBehavior], which determines when a drag
  ///   formally starts when the user initiates a drag.
  final DragStartBehavior dragStartBehavior;

  /// How the this widget's [GestureDetector] should behave when hit testing.
  ///
  /// See also:
  ///
  ///   * [GestureDetector.behavior], which defaults to
  ///   [HitTestBehavior.deferToChild] if [child] is not null and
  ///   [HitTestBehavior.translucent] if child is null.
  final HitTestBehavior? behavior;

  /// Whether to exclude these gestures from the semantics tree.
  ///
  /// See also:
  ///
  ///   * [GestureDetector.excludeFromSemantics], which includes an example of
  ///   a case where this property can be used.
  final bool excludeFromSemantics;

  /// The widget below this widget in the tree.
  final Widget child;

  @override
  Widget build(BuildContext context) => GestureDetector(
        excludeFromSemantics: excludeFromSemantics,
        dragStartBehavior: dragStartBehavior,
        behavior: behavior,
        onTap: gestures.contains(GestureType.onTap) ? () => _unFocus(context) : null,
        onTapDown: gestures.contains(GestureType.onTapDown) ? (_) => _unFocus(context) : null,
        onPanUpdate: gestures.contains(GestureType.onPanUpdateAnyDirection) ? (_) => _unFocus(context) : null,
        onTapUp: gestures.contains(GestureType.onTapUp) ? (_) => _unFocus(context) : null,
        onTapCancel: gestures.contains(GestureType.onTapCancel) ? () => _unFocus(context) : null,
        onSecondaryTapDown: gestures.contains(GestureType.onSecondaryTapDown) ? (_) => _unFocus(context) : null,
        onSecondaryTapUp: gestures.contains(GestureType.onSecondaryTapUp) ? (_) => _unFocus(context) : null,
        onSecondaryTapCancel: gestures.contains(GestureType.onSecondaryTapCancel) ? () => _unFocus(context) : null,
        onDoubleTap: gestures.contains(GestureType.onDoubleTap) ? () => _unFocus(context) : null,
        onLongPress: gestures.contains(GestureType.onLongPress) ? () => _unFocus(context) : null,
        onLongPressStart: gestures.contains(GestureType.onLongPressStart) ? (_) => _unFocus(context) : null,
        onLongPressMoveUpdate: gestures.contains(GestureType.onLongPressMoveUpdate) ? (_) => _unFocus(context) : null,
        onLongPressUp: gestures.contains(GestureType.onLongPressUp) ? () => _unFocus(context) : null,
        onLongPressEnd: gestures.contains(GestureType.onLongPressEnd) ? (_) => _unFocus(context) : null,
        onVerticalDragDown: gestures.contains(GestureType.onVerticalDragDown) ? (_) => _unFocus(context) : null,
        onVerticalDragStart: gestures.contains(GestureType.onVerticalDragStart) ? (_) => _unFocus(context) : null,
        onVerticalDragUpdate: _gesturesContainsDirectionalPanUpdate() ? (details) => _unFocusWithDetails(context, details) : null,
        onVerticalDragEnd: gestures.contains(GestureType.onVerticalDragEnd) ? (_) => _unFocus(context) : null,
        onVerticalDragCancel: gestures.contains(GestureType.onVerticalDragCancel) ? () => _unFocus(context) : null,
        onHorizontalDragDown: gestures.contains(GestureType.onHorizontalDragDown) ? (_) => _unFocus(context) : null,
        onHorizontalDragStart: gestures.contains(GestureType.onHorizontalDragStart) ? (_) => _unFocus(context) : null,
        onHorizontalDragUpdate: _gesturesContainsDirectionalPanUpdate() ? (details) => _unFocusWithDetails(context, details) : null,
        onHorizontalDragEnd: gestures.contains(GestureType.onHorizontalDragEnd) ? (_) => _unFocus(context) : null,
        onHorizontalDragCancel: gestures.contains(GestureType.onHorizontalDragCancel) ? () => _unFocus(context) : null,
        onForcePressStart: gestures.contains(GestureType.onForcePressStart) ? (_) => _unFocus(context) : null,
        onForcePressPeak: gestures.contains(GestureType.onForcePressPeak) ? (_) => _unFocus(context) : null,
        onForcePressUpdate: gestures.contains(GestureType.onForcePressUpdate) ? (_) => _unFocus(context) : null,
        onForcePressEnd: gestures.contains(GestureType.onForcePressEnd) ? (_) => _unFocus(context) : null,
        onPanDown: gestures.contains(GestureType.onPanDown) ? (_) => _unFocus(context) : null,
        onPanStart: gestures.contains(GestureType.onPanStart) ? (_) => _unFocus(context) : null,
        onPanEnd: gestures.contains(GestureType.onPanEnd) ? (_) => _unFocus(context) : null,
        onPanCancel: gestures.contains(GestureType.onPanCancel) ? () => _unFocus(context) : null,
        onScaleStart: gestures.contains(GestureType.onScaleStart) ? (_) => _unFocus(context) : null,
        onScaleUpdate: gestures.contains(GestureType.onScaleUpdate) ? (_) => _unFocus(context) : null,
        onScaleEnd: gestures.contains(GestureType.onScaleEnd) ? (_) => _unFocus(context) : null,
        child: child,
      );

  void _unFocus(BuildContext context) => WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();

  void _unFocusWithDetails(
    BuildContext context,
    DragUpdateDetails details,
  ) {
    final dy = details.delta.dy;
    final dx = details.delta.dx;
    final isDragMainlyHorizontal = dx.abs() - dy.abs() > 0;
    if (gestures.contains(GestureType.onPanUpdateDownDirection) && dy > 0 && !isDragMainlyHorizontal) {
      _unFocus(context);
    } else if (gestures.contains(GestureType.onPanUpdateUpDirection) && dy < 0 && !isDragMainlyHorizontal) {
      _unFocus(context);
    } else if (gestures.contains(GestureType.onPanUpdateRightDirection) && dx > 0 && isDragMainlyHorizontal) {
      _unFocus(context);
    } else if (gestures.contains(GestureType.onPanUpdateLeftDirection) && dx < 0 && isDragMainlyHorizontal) {
      _unFocus(context);
    }
  }

  bool _gesturesContainsDirectionalPanUpdate() => gestures.contains(GestureType.onPanUpdateDownDirection) || gestures.contains(GestureType.onPanUpdateUpDirection) || gestures.contains(GestureType.onPanUpdateRightDirection) || gestures.contains(GestureType.onPanUpdateLeftDirection);
}
