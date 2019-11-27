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
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.2),
            child: Card(
              elevation: 5.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //Padding(
                  // padding: const EdgeInsets.all(32),
                  //child:
                  Center(
                    child: Image.asset(
                      'assets/icon/Logo.png',
                      //scale: 0.25,
                      fit: BoxFit.contain,
                      //height: MediaQuery.of(context).size.height * 0.8,
                    ),
                  ),
                  //),
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
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
