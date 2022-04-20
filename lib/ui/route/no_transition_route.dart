import 'package:flutter/material.dart';

class NoTransitionRoute<T> extends MaterialPageRoute<T> {
  Duration duration;
  bool defaultPopAnimation;

  NoTransitionRoute(
      {WidgetBuilder builder,
      RouteSettings settings,
      this.defaultPopAnimation = false,
      this.duration = const Duration(milliseconds: 200)})
      : super(builder: builder, settings: settings);

  @override
  Duration get transitionDuration => duration;

  static Tween tween = Tween<double>(begin: 0.0, end: 1.0);

  @override
  Widget buildTransitions(
      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return AnimatedContainer(
      child: child,
      duration: duration,
    );
  }
}
