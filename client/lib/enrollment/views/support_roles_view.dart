import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:com.whitelabel/services/services.dart';

import '../bloc/data.dart';

class SupportRolesView extends StatelessWidget {
  const SupportRolesView({Key key, this.campaignID}) : super(key: key);
  final String campaignID;
  @override
  Widget build(BuildContext context) {
    final StorageService _storage = Provider.of<StorageService>(context);
    final Campaign _campaign = _storage.hiveBox[Cache.Campaign].get(campaignID);
    final List<Roles> _list = _storage.hiveBox[Cache.Roles].values.toList();
    _list.removeWhere((Roles role) => role.mandatory);

    return WebInfoView(
      title: TitleWidget(
        icon: Icons.supervisor_account,
        title: 'Support Roles',
      ),
      child: _SupportRolesView(
        campaign: _campaign,
        supportRoles: _list.asMap(),
      ),
      index: -1,
    );
  }
}

class _SupportRolesView extends StatefulWidget {
  const _SupportRolesView({
    Key key,
    this.campaign,
    this.supportRoles,
  }) : super(key: key);
  final Campaign campaign;
  final Map<int, Roles> supportRoles;
  @override
  _SupportRolesViewState createState() => _SupportRolesViewState();
}

class _SupportRolesViewState extends State<_SupportRolesView> {
  final Map<int, bool> selections = <int, bool>{};
  final Map<int, double> hours = <int, double>{};

  @override
  void initState() {
    selections
        .addAll(List<bool>.filled(widget.supportRoles.length, false).asMap());
    hours.addAll(List<double>.filled(widget.supportRoles.length, 0).asMap());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AuthUserService _user = Provider.of<AuthUserService>(context);
    return ResponsiveListView(
      children: <Widget>[
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Container(
                child: Image.asset(widget.campaign.logoUrl),
              ),
              title: Text(
                widget.campaign.campaignName,
                style: Theme.of(context).textTheme.title,
              ),
              subtitle: Text(
                widget.campaign.goal,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        ListTile(
          title: Text(
            'Please choose up to 3 support roles :',
            style: Theme.of(context).textTheme.title,
          ),
        ),
        for (int index in widget.supportRoles.keys)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _supportRole(context, index),
          ),
        const SizedBox(height: 16.0),
        ButtonBar(
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                if (_validate()) {
                  if (_user.isLoggedIn) {
                    Navigator.of(context).pushNamed('/campaignview');
                  } else {
                    Navigator.of(context)
                        .pushNamed('/signup/${widget.campaign.id.toString()}');
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

  Widget _supportRole(BuildContext context, int index) {
    final List<String> _text = widget.supportRoles[index].name.split(' ');
    String _name = '';
    for (String _t in _text) {
      _name = _name + toBeginningOfSentenceCase(_t) + ' ';
    }
    return InkWell(
      onTap: () {
        setState(() {
          selections[index] = !selections[index];
          if (!selections[index]) {
            hours[index] = 1;
          }
        });
      },
      child: Container(
        color: selections[index]
            ? Theme.of(context).accentColor
            : Theme.of(context).scaffoldBackgroundColor,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CheckboxListTile(
                  title: Text(
                    _name,
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Text(
                    widget.supportRoles[index].description,
                  ),
                  value: selections[index],
                  onChanged: (bool value) {
                    setState(() {
                      selections[index] = value;
                      if (!value) {
                        hours[index] = 1;
                      }
                    });
                  },
/*               secondary: Card(
                    shape: const CircleBorder(),
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).cardColor,
                      child: Icon(
                        supportRoles[index].icon,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ), */
                ),
                const SizedBox(height: 8.0),
                ListTile(
                  title: Text(
                    'Minimum hours you can dedicate  : ',
                    style: Theme.of(context).textTheme.subtitle,
                  ),
                  trailing: Text(
                    '${hours[index]} hr',
                    style: Theme.of(context)
                        .textTheme
                        .body1
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Slider(
                    label: hours[index].toString(),
                    divisions: 8,
                    min: 0.0,
                    max: 8,
                    value: hours[index],
                    onChanged: !selections[index]
                        ? null
                        : (double value) {
                            setState(() {
                              hours[index] = value;
                            });
                          },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _validate() {
    int count = 0;
    for (int i = 0; i < selections.length; i++) {
      if (selections[i]) {
        count = count + 1;
        if (count > 3) {
          showDialog<Widget>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Support Roles'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                elevation: 5.0,
                content: const Text(
                  'Please choose up to 3 supports roles.',
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
