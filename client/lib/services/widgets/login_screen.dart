import 'package:flutter/material.dart';
import './web_screen/simple_route.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();

  static Route<dynamic> route() {
    return SimpleRoute(
      name: '/login',
      title: 'Login',
      builder: (_) => const LoginScreen(
        key: ValueKey<String>('/login'),
      ),
    );
  }
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Image.asset(
              'assets/icon/Logo.png',
              height: MediaQuery.of(context).size.height * 0.8,
            ),
          ),
          Center(
            child: RaisedButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/home', ModalRoute.withName('/login'));
              }, // TODO
              child: const Text('Sign In'),
            ),
          ),
          Center(
            child: FlatButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/userinfo');
              },
              child: const Text('Get Started'),
            ),
          )
        ],
      ),
    );
  }
}
