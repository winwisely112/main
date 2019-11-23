import 'package:flutter/material.dart';
// From https://medium.com/flutter-community/more-than-a-flutter-web-app-is-a-full-flutter-website-c6bb210b1f16

class SimpleRoute extends PageRoute<Widget> {
  SimpleRoute({
    @required String name,
    @required this.title,
    @required this.builder,
  }) : super(
            settings: RouteSettings(
          name: name,
        ));

  final String title;
  final WidgetBuilder builder;

  @override
  Color get barrierColor => null;

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Title(
      title: title,
      color: Theme.of(context).primaryColor,
      child: builder(context),
    );
  }
}

class FadeRoute extends PageRoute<Widget> {
  FadeRoute({
    @required String name,
    @required this.title,
    @required this.builder,
  }) : super(
            settings: RouteSettings(
          name: name,
        ));

  final String title;
  final WidgetBuilder builder;

  @override
  Color get barrierColor => null;

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration(milliseconds: 500);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Title(
      title: title,
      color: Theme.of(context).primaryColor,
      child: builder(context),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(opacity: animation, child: child);
  }
}
