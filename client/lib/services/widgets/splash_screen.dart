import 'package:flutter/material.dart';

import '../services.dart';

/// This splash screen waits for all the services to be initialized. When they
/// are, it automatically redirects either to the [NewsFeed] or the
/// [LoginScreen] based on whether the user is logged in.
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();

  static Route<dynamic> route() {
    return SimpleRoute(
      name: '/',
      title: 'WinWisely99',
      builder: (_) => const SplashScreen(
        key: ValueKey<String>('/'),
      ),
    );
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Future<dynamic>.microtask(() async {
      await storageReady;
      await networkReady;
      await userServiceReady;
      // TODO(Vineeth): Add the authentication logic here
      await authUserReady;
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/login', ModalRoute.withName('/'));
    });

    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    );
  }
}
