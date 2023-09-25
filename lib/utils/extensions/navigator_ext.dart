import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension NavigatorExt on BuildContext {
  Future<T?> push<T extends Object?>(Widget page, {RouteSettings? settings, bool replace = false}) async {
    Route<T> router = CupertinoPageRoute<T>(
      builder: (context) {
        return page;
      },
      settings: settings,
    );
    if (replace) {
      return await Navigator.of(this).pushAndRemoveUntil(router, (e) => false);
    } else {
      return await Navigator.of(this).push(router);
    }
  }

  Future<T?> pushNamed<T extends Object?>(String newRouterName, {bool replace = false}) async {
    if (replace) {
      return await Navigator.of(this).pushNamedAndRemoveUntil(newRouterName, (e) => false);
    } else {
      return await Navigator.of(this).pushNamed(newRouterName);
    }
  }

  void pop<T>([T? result]) {
    Navigator.of(this).pop(result);
  }

  void popUntil(RoutePredicate predicate) {
    Navigator.of(this).popUntil(predicate);
  }
}
