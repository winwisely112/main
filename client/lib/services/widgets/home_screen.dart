import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import './home_screen_mobile.dart';
import './web_screen/simple_route.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  static Route<dynamic> route() {
    return SimpleRoute(
      name: '/home',
      title: 'Home',
      builder: (_) => const HomeScreen(
        key: ValueKey<String>('/home'),
      ),
    );
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    if (kIsWeb ||
        debugDefaultTargetPlatformOverride == TargetPlatform.fuchsia) {
      return const Redirect();
    } else {
      return MobileHomeScreen();
    }
  }
}

class Redirect extends StatelessWidget {
  const Redirect({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<dynamic>.microtask(() async {
      Navigator.of(context).pushNamed('/news');
    });

    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    );
  }
}
