import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:com.whitelabel/services/services.dart';

import '../bloc/data.dart';

class NotReadyView extends StatelessWidget {
  const NotReadyView({Key key, this.campaignID}) : super(key: key);
  final String campaignID;
  @override
  Widget build(BuildContext context) {
    return WebInfoView(
      title: TitleWidget(
        icon: FontAwesomeIcons.handsHelping,
        title: 'My Needs',
      ),
      child: _NotReadyView(campaignID: campaignID),
      index: -1,
    );
  }
}

class _NotReadyView extends StatefulWidget {
  const _NotReadyView({Key key, this.campaignID}) : super(key: key);
  final String campaignID;
  @override
  __NotReadyViewState createState() => __NotReadyViewState();
}

class __NotReadyViewState extends State<_NotReadyView> {
  final Map<int, dynamic> _value = <int, dynamic>{
    1: false,
    2: false,
    3: false,
    4: false,
    5: false,
    6: false,
    7: false,
    8: false,
    9: ''
  };

  @override
  Widget build(BuildContext context) {
    final StorageService _storage = Provider.of<StorageService>(context);
    final Campaign _campaign =
        _storage.hiveBox[Cache.Campaign].get(widget.campaignID);
    return ResponsiveListView(
      children: <Widget>[
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Container(
                child: Image.asset(_campaign.logoUrl),
              ),
              title: Text(
                _campaign.campaignName,
                //style: Theme.of(context).textTheme.title,
              ),
              subtitle: Text(
                _campaign.goal,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        ListTile(
          title: Text(
            'Please choose up to 3 supports or needs you need satisfied to join the action.',
            style: Theme.of(context).textTheme.body1,
          ),
        ),
        const SizedBox(height: 8.0),
        CheckboxListTile(
          title: const Text(
              '1. I need to know that there will be enough people at the action for the campaign to have a high chance of success'),
          value: _value[1],
          onChanged: (bool value) {
            setState(() {
              _value[1] = value;
            });
          },
          secondary: const Icon(FontAwesomeIcons.peopleCarry),
        ),
        CheckboxListTile(
          title: const Text(
              '2. I need to be more confident regarding legal defense'),
          value: _value[2],
          onChanged: (bool value) {
            setState(() {
              _value[2] = value;
            });
          },
          secondary: const Icon(FontAwesomeIcons.briefcase),
        ),
        CheckboxListTile(
          title: const Text('3. I need to be invited to join by a friend'),
          value: _value[3],
          onChanged: (bool value) {
            setState(() {
              _value[3] = value;
            });
          },
          secondary: const Icon(FontAwesomeIcons.userFriends),
        ),
        CheckboxListTile(
          title: const Text(
              '4. I’m a party animal: I need to be invited to a party of other strikers and conditional strikers'),
          value: _value[4],
          onChanged: (bool value) {
            setState(() {
              _value[4] = value;
            });
          },
          secondary: const Icon(FontAwesomeIcons.fistRaised),
        ),
        CheckboxListTile(
          title: const Text('5. I need transport to the event'),
          value: _value[5],
          onChanged: (bool value) {
            setState(() {
              _value[5] = value;
            });
          },
          secondary: const Icon(FontAwesomeIcons.bus),
        ),
        CheckboxListTile(
          title: const Text('6. I need bail support'),
          value: _value[6],
          onChanged: (bool value) {
            setState(() {
              _value[6] = value;
            });
          },
          secondary: const Icon(FontAwesomeIcons.link),
        ),
        CheckboxListTile(
          title: const Text('7. I need help with childcare'),
          value: _value[7],
          onChanged: (bool value) {
            setState(() {
              _value[7] = value;
            });
          },
          secondary: const Icon(FontAwesomeIcons.babyCarriage),
        ),
        CheckboxListTile(
          title: const Text(
              '8. I need housing (if long term strike and worry about losing housing)'),
          value: _value[8],
          onChanged: (bool value) {
            setState(() {
              _value[8] = value;
            });
          },
          secondary: const Icon(FontAwesomeIcons.home),
        ),
        const SizedBox(height: 8.0),
        TextFormField(
          initialValue: _value[9],
          maxLines: 5,
          decoration: InputDecoration(
            labelText: 'I need something else...',
            alignLabelWithHint: true,
            hintText: 'I need something else...',
            fillColor: Theme.of(context).inputDecorationTheme.fillColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
              borderSide: const BorderSide(),
            ),
          ),
          onSaved: (String value) {
            setState(() {
              _value[9] = value;
            });
          },
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(
            fontFamily: 'Poppins',
          ),
        ),
        const SizedBox(height: 8.0),
        ButtonBar(
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                if (_validate()) {
                  if (_value[1]) {
                    Navigator.of(context).pop();
                    Navigator.of(context)
                        .pushNamed('/conditional/${widget.campaignID}');
                  } else {
                    showDialog<Widget>(
                      context: context,
                      builder: (BuildContext context) {
                        return SupportRolesDialog(
                            campaignID: widget.campaignID);
                      },
                    );
                  }
                }
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ],
    );
  }

  bool _validate() {
    int count = 0;
    for (int i = 1; i <= 8; i++) {
      if (_value[i]) {
        count = count + 1;
        if (count > 3) {
          showDialog<Widget>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('My Needs'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                elevation: 5.0,
                content: const Text(
                  'Please choose up to 3 supports or needs you need satisfied to join the action.',
                ),
                actions: <Widget>[
                  RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Ok'),
                  ),
                ],
              );
            },
          );
          return false; // more than 3
        }
      }
    }
    return true; // valid
  }
}

class SupportRolesDialog extends StatelessWidget {
  const SupportRolesDialog({Key key, this.campaignID}) : super(key: key);
  final String campaignID;
  @override
  Widget build(BuildContext context) {
    final AuthUserService _user = Provider.of<AuthUserService>(context);
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      elevation: 5.0,
      title: Text(
        'Support Role',
        style: Theme.of(context).textTheme.title,
      ),
      content: const Text(
        'If we cannot satisfy your chosen conditions, would you consider providing a support role to those willing to go on strike ?',
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
            if (_user.isLoggedIn) {
              Navigator.of(context).pushNamed('/campaignview');
            } else {
              Navigator.of(context).pushNamed('/signup');
            }
          },
          child: const Text('No'),
        ),
        RaisedButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed('/supportroles/$campaignID');
          },
          child: const Text('Yes'),
        ),
      ],
    );
  }
}
