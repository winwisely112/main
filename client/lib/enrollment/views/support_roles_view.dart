import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:com.winwisely99.app/services/services.dart';

class SupportRoles {
  SupportRoles(this.title, this.description, this.icon)
      : hours = 1,
        selected = false;
  String title;
  String description;
  double hours;
  bool selected;
  IconData icon;
}

class SupportRolesView extends StatelessWidget {
  const SupportRolesView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const WebInfoView(
      title: TitleWidget(
        icon: Icons.supervisor_account,
        title: 'Support Roles',
      ),
      child: _SupportRolesView(),
      index: -1,
    );
  }
}

class _SupportRolesView extends StatefulWidget {
  const _SupportRolesView({Key key}) : super(key: key);

  @override
  _SupportRolesViewState createState() => _SupportRolesViewState();
}

class _SupportRolesViewState extends State<_SupportRolesView> {
  final Map<int, SupportRoles> supportRoles = <SupportRoles>[
    SupportRoles(
      'Lawyer',
      'Provide legal advise, support and consulting for event permits and members in need.',
      FontAwesomeIcons.briefcase,
    ),
    SupportRoles(
      'Social Media ',
      'Provide support by spreading the message to the masses.',
      Icons.share,
    ),
    SupportRoles(
      'Transport',
      'Provide logistical services for the members.',
      FontAwesomeIcons.bus,
    ),
    SupportRoles(
      'Child care',
      'Provide child care support for members.',
      FontAwesomeIcons.babyCarriage,
    ),
    SupportRoles(
      'Bail support',
      'Provide legal / financial support for members that need bail.',
      FontAwesomeIcons.hammer,
    ),
    SupportRoles(
      'Phonebanker or p2p texter',
      'Coordinate finance and events',
      FontAwesomeIcons.mobile,
    ),
  ].asMap();

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return ResponsiveListView(children: <Widget>[
      for (int index in supportRoles.keys)
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: _supportRole(context, index),
        ),
    ]);
  }

  Widget _supportRole(BuildContext context, int index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CheckboxListTile(
              title: Text(
                supportRoles[index].title,
                style: Theme.of(context).textTheme.title,
              ),
              value: supportRoles[index].selected,
              onChanged: (bool value) {
                setState(() {
                  supportRoles[index].selected = value;
                  if (!value) {
                    supportRoles[index].hours = 1;
                  }
                });
              },
              secondary: Card(
                shape: const CircleBorder(),
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).cardColor,
                  child: Icon(
                    supportRoles[index].icon,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
            ),
            ListTile(
              subtitle: Text(supportRoles[index].description),
            ),
            ListTile(
              title: Text(
                'Minimum hours you can dedicate  : ',
                style: Theme.of(context).textTheme.subtitle,
              ),
              trailing: Text(
                '${supportRoles[index].hours} hr',
                style: Theme.of(context)
                    .textTheme
                    .body1
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              subtitle: Slider(
                divisions: 8,
                min: 0.0,
                max: 8,
                value: supportRoles[index].hours,
                onChanged: !supportRoles[index].selected
                    ? null
                    : (double value) {
                        setState(() {
                          supportRoles[index].hours = value;
                        });
                      },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
