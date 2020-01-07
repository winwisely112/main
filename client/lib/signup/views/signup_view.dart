import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import 'package:com.whitelabel/services/services.dart';

enum MeetUpWithOthers { Yes, No }

class SignUpView extends StatelessWidget {
  const SignUpView({Key key, this.campaignID}) : super(key: key);
  final String campaignID;
  @override
  Widget build(BuildContext context) {
    return WebInfoView(
      title: TitleWidget(
        icon: Icons.lock,
        title: 'Sign Up',
      ),
      child: _SignUpView(campaignID: campaignID),
      index: -1,
    );
  }
}

class _SignUpView extends StatefulWidget {
  const _SignUpView({Key key, this.campaignID}) : super(key: key);
  final String campaignID;
  @override
  __SignUpViewState createState() => __SignUpViewState();
}

class __SignUpViewState extends State<_SignUpView> {
  MeetUpWithOthers _interests = MeetUpWithOthers.No;
  MeetUpWithOthers _training = MeetUpWithOthers.No;
  bool _emailSwitch = false;
  bool _appMessagingSwitch = false;
  @override
  Widget build(BuildContext context) {
    return ResponsiveListView(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Image.asset(
            'assets/icon/placeholder.png',
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
              suffix: const Icon(Icons.email),
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
                    _showProtonMail(context);
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
          subtitle: const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Your password should be a minimum of 8 of characters and use at least three of the four available character types: lowercase letters, uppercase letters, numbers, and symbols.',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        ListTile(
          title: TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Re-enter Password',
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
          groupValue: _interests,
          onChanged: (MeetUpWithOthers value) {
            setState(() {
              _interests = value;
            });
          },
        ),
        RadioListTile<MeetUpWithOthers>(
          title: const Text('No'),
          value: MeetUpWithOthers.No,
          groupValue: _interests,
          onChanged: (MeetUpWithOthers value) {
            setState(() {
              _interests = value;
            });
          },
        ),
        const ListTile(
          title: Text('I have civil disobedience training'),
        ),
        RadioListTile<MeetUpWithOthers>(
          title: const Text('Yes'),
          value: MeetUpWithOthers.Yes,
          groupValue: _training,
          onChanged: (MeetUpWithOthers value) {
            setState(() {
              _training = value;
            });
          },
        ),
        RadioListTile<MeetUpWithOthers>(
          title: const Text('No'),
          value: MeetUpWithOthers.No,
          groupValue: _training,
          onChanged: (MeetUpWithOthers value) {
            setState(() {
              _training = value;
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
          child: Column(
            children: <Widget>[
              Center(
                child: Container(
                  height: 72,
                  width: 128,
                  child: ListTile(
                    title: Image.asset(
                      'assets/commons/download.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: RaisedButton(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text('Sign Up',
                          style: Theme.of(context).textTheme.body2),
                      onPressed: () {
/*                         Toast.show('Thank you for joining our cause!', context,
                            backgroundColor: Theme.of(context).accentColor,
                            textColor:
                                Theme.of(context).colorScheme.onSecondary,
                            duration: Toast.LENGTH_SHORT,
                            gravity: Toast.CENTER); */
                        final StorageService _storage =
                            Provider.of<StorageService>(context);
                        final User _user =
                            _storage.hiveBox[Cache.Users].get('user001');
                        final List<String> _campaigns =
                            _user.campaignIds ?? <String>[];
                        _campaigns.add(widget.campaignID);
                        _user.campaignIds = _campaigns;
                        // TODO(developer): Remove this logic when network is implemented and make it network updates
                        final NetworkService _network =
                            Provider.of<NetworkService>(context);
                        final List<Map<String, dynamic>> _maps =
                            _network.mockData['users'];
                        _maps.removeWhere((Map<String, dynamic> value) =>
                            value['_id'] == 'user001');
                        _maps.add(_user.toMap());
                        _network.mockData['users'] = _maps;
                        //print(_maps.where((Map<String, dynamic> value) =>
                        //    value['_id'] == 'user001'));
                        // till here
                        _storage.hiveBox[Cache.Users]
                            .put(_user.id.toString(), _user);
                        showDialog<Widget>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(
                                  'Thank you for joining our cause!'),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              elevation: 5.0,
                              content: const Text(
                                'We’ll keep you updated on goals met, training opportunities, transportation, and location information as we get closer to the date.',
                              ),
                              actions: <Widget>[
                                RaisedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    final AuthUserService _user =
                                        Provider.of<AuthUserService>(context);
                                    _user.userLoggedIn = true;
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            '/home',
                                            ModalRoute.withName(
                                                '/signup/${widget.campaignID}'));
                                  },
                                  child: const Text('Ok'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      _showBottomSheet(context);
                    },
                    child: Text(
                      'Privacy Policy',
                      style: Theme.of(context).textTheme.body2.copyWith(
                            color: Theme.of(context).accentColor,
                            decoration: TextDecoration.underline,
                          ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }

  void _showProtonMail(BuildContext context) {
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(height: 24),
                    const ListTile(
                      title: Text('Why ProtonMail ?'),
                      subtitle: Text(
                          'ProtonMail to ProtonMail emails are considered to be secure by Information Security professionals. They’re both free to use on Android and Apple smart phones and Windows and Mac computers.'),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showBottomSheet(BuildContext context) {
    final StorageService _storage = Provider.of<StorageService>(context);
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
/*               const ListTile(
                title: Text(
                    'Currently in development, to assure a highly secure system based on End to End encryption principles. On the users devices all user data is encrypted at rest against the users public key. On our servers, all data in transit or at rest is encrypted against the users public key. User aggregation is not done.'),
              ), */
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8.0),
                  children: <Widget>[
                    const SizedBox(height: 24),
                    ListTile(
                      title: MarkdownBody(data: _storage.privacyPolicy),
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
