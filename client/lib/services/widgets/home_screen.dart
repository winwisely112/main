import 'package:flutter/material.dart';

import './home_screen_mobile.dart';
import './web_layout.dart';
import './web_screen/home_screen_web.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

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
