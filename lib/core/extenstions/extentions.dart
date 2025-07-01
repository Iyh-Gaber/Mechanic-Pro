/*


import 'package:flutter/material.dart';

extension NavigatorExt on BuildContext {
  void pushTo(Widget newScreen) {
    Navigator.push(this, MaterialPageRoute(builder: (context) => newScreen));
  }

  void pushReplacement(Widget newScreen) {
    Navigator.pushReplacement(
        this, MaterialPageRoute(builder: (context) => newScreen));
  }

  void pushAndRemoveUntil(Widget newScreen) {
    Navigator.pushAndRemoveUntil(this,
        MaterialPageRoute(builder: (context) => newScreen), (route) => false);
  }
}

/*
extension Navigator on BuildContext {

  void pushTo(Widget newView)
   {
Navigator.pushTo(this,MaterialPageRoute(builder: (context) => ,newView));

  }


}
*/
*/

import 'package:flutter/material.dart';

extension NavigationExtension on BuildContext {
  Future<dynamic>? pushNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic>? pushReplacementNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushReplacementNamed(routeName, arguments: arguments);
  }

  void pop() {
    Navigator.of(this).pop();
  }

  Future<dynamic>? pushAndRemoveUntil(
    String routeName, {
    Object? arguments,
    // هذا هو التوقيع الصحيح: دالة تستقبل String و Object? وتُرجع Widget
    required Widget Function(String, Object?) routeBuilder,
    bool Function(Route<dynamic>)? predicate,
  }) {
    return Navigator.of(this).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => routeBuilder(routeName, arguments)),
      predicate ?? (Route<dynamic> route) => false,
    );
  }
}