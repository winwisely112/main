import 'package:flutter/material.dart';

import './home_screen_mobile.dart';
import './web_layout.dart';
import './web_screen/home_screen_web.dart';
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
    return WebLayout(
      mobileLayout: MobileHomeScreen(),
      webLayout: WebHomeScreen(),
    );
  }
}
