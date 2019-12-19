import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import 'package:com.whitelabel/services/services.dart';

enum MeetUpWithOthers { Yes, No }

class SignUpView extends StatelessWidget {
  const SignUpView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WebInfoView(
      title: TitleWidget(
        icon: Icons.lock,
        title: 'Sign Up',
      ),
      child: const _SignUpView(),
      index: -1,
    );
  }
}

class _SignUpView extends StatefulWidget {
  const _SignUpView({Key key}) : super(key: key);

  @override
  __SignUpViewState createState() => __SignUpViewState();
}

class __SignUpViewState extends State<_SignUpView> {
  MeetUpWithOthers _character = MeetUpWithOthers.No;
  bool _emailSwitch = false;
  bool _appMessagingSwitch = false;
  @override
  Widget build(BuildContext context) {
    return ResponsiveListView(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Image.asset(
            'assets/icon/Logo.png',
            width: 200,
            height: 100,
          ),
        ),
        ListTile(
          title: Text('Sign up for your account',
              style: Theme.of(context).textTheme.display1),
        ),
        ListTile(
          title: TextFormField(
            decoration: InputDecoration(
              labelText: 'Email Address *',
              labelStyle: Theme.of(context).textTheme.body2,
              suffix: Icon(MdiIcons.emailOutline),
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  '* Need a protonmail ? ',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
                InkWell(
                  onTap: () {
                    _showBottomSheet(context);
                  },
                  child: Text(
                    ' Explain why?',
                    style: Theme.of(context).textTheme.body2.copyWith(
                          color: Theme.of(context).accentColor,
                          fontStyle: FontStyle.italic,
                        ),
                  ),
                )
              ],
            ),
          ),
        ),
        ListTile(
          title: TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              labelStyle: Theme.of(context).textTheme.body2,
              suffix: Icon(Icons.lock_outline),
            ),
          ),
        ),
        const ListTile(
          title: Text('Meet others with shared interests?'),
        ),
        RadioListTile<MeetUpWithOthers>(
          title: const Text('Yes'),
          value: MeetUpWithOthers.Yes,
          groupValue: _character,
          onChanged: (MeetUpWithOthers value) {
            setState(() {
              _character = value;
            });
          },
        ),
        RadioListTile<MeetUpWithOthers>(
          title: const Text('No'),
          value: MeetUpWithOthers.No,
          groupValue: _character,
          onChanged: (MeetUpWithOthers value) {
            setState(() {
              _character = value;
            });
          },
        ),
        const ListTile(
          title: Text('Setup notification channel'),
        ),
        SwitchListTile(
          title: const Text('Email'),
          value: _emailSwitch,
          onChanged: (bool value) {
            setState(() {
              _emailSwitch = value;
            });
          },
          secondary: const Icon(Icons.email),
        ),
        SwitchListTile(
          title: const Text('App Messaging'),
          value: _appMessagingSwitch,
          onChanged: (bool value) {
            setState(() {
              _appMessagingSwitch = value;
            });
          },
          secondary: const Icon(Icons.message),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: RaisedButton(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child:
                      Text('Sign Up', style: Theme.of(context).textTheme.body2),
                  onPressed: () {
                    final AuthUserService _user =
                        Provider.of<AuthUserService>(context);
                    _user.userLoggedIn = true;
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/home', ModalRoute.withName('/signup'));
                    Toast.show('Thank you for signing Up', context,
                        backgroundColor: Theme.of(context).accentColor,
                        textColor: Theme.of(context).colorScheme.onSecondary,
                        duration: Toast.LENGTH_SHORT,
                        gravity: Toast.CENTER);
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet<Widget>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      context: context,
      builder: (BuildContext con) {
        return Scrollbar(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 4),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 40,
                  color: Theme.of(context).colorScheme.secondaryVariant,
                  height: 4,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8.0),
                  children: <Widget>[
                    const SizedBox(height: 24),
                    ListTile(
                      title: Text(
                        'Why Protonmail',
                        style: Theme.of(context).textTheme.display1,
                      ),
                    ),
                    Utils.verticalMargin(32),
                    const ListTile(
                      title: Text(
                          ' It uses end-to-end encryption, meaning that only the people sending and receiving messages can read them, and it was founded by former CERN and MIT scientists, so the implication is that it’s basically the Fort Knox of email providers. It’s the email provider of choice for Elliot, the hacker protagonist on Mr. Robot.'),
                    ),
                    const ListTile(
                      title: Text('Would you like to get the protonmail?'),
                    ),
                    ListTile(
                      title: ButtonBar(
                        children: <Widget>[
                          FlatButton(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Text('No',
                                style: Theme.of(context).textTheme.body2),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          RaisedButton(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Text('Yes',
                                style: Theme.of(context).textTheme.body2),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
