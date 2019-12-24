import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth_user_service.dart';
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
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Padding(
            // padding: const EdgeInsets.all(32),
            //child:
            Center(
              child: Image.asset(
                'assets/icon/placeholder.png',
                height: MediaQuery.of(context).size.width * 0.20,
                width: MediaQuery.of(context).size.width * 0.20,
                //scale: 0.25,
                fit: BoxFit.fill,
              ),
            ),
            //),
            Center(
              child: RaisedButton(
                onPressed: () {
                  final AuthUserService _user =
                      Provider.of<AuthUserService>(context);
                  _user.userLoggedIn = true;
                  //print('user log ${_user.isLoggedIn}');
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/home', ModalRoute.withName('/login'));
                },
                child: const Text('Sign In'),
              ),
            ),
            Center(
              child: FlatButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/userinfo');
                },
                child: const Text(
                  'Get Started',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
