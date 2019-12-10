import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:com.whitelabel/services/services.dart';

class UserInfoView extends StatelessWidget {
  const UserInfoView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WebInfoView(
      title: TitleWidget(
        icon: FontAwesomeIcons.fistRaised,
        title: 'Campaign for Your Cause',
      ),
      child: const _UserInfoView(),
      index: -1,
    );
  }
}

class _UserInfoView extends StatefulWidget {
  const _UserInfoView({Key key}) : super(key: key);

  @override
  _UserInfoViewState createState() => _UserInfoViewState();
}

class _UserInfoViewState extends State<_UserInfoView> {
  final List<String> countries = ['Germany', 'Australia', 'Pakistan', 'USA'];

  final List<String> cities = ['Berlin', 'Newyork', 'Vancouver', 'Shanghai'];

  final List<String> issues = ['Student Debt', 'Health Care', 'Climate'];

  final List<String> campaings = ['XR', 'Fridays for future'];
  final Map<String, String> dropdownValue = <String, String>{};
  @override
  void initState() {
    dropdownValue['countries'] = countries[0];
    dropdownValue['cities'] = cities[0];
    dropdownValue['issues'] = issues[0];
    dropdownValue['campaings'] = campaings[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveListView(
      children: <Widget>[
        ListTile(
            title: Text(
          '1. Where are you?',
          style: Theme.of(context).textTheme.title,
        )),
        ListTile(
          title: _select(countries, 'Select Country', 'countries'),
        ),
        ListTile(
          title: _select(cities, 'Select City', 'cities'),
        ),
        ListTile(
          title: TextFormField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Zip Code',
            ),
          ),
        ),
        ListTile(
          title: TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                hintText: 'Your Location', suffix: Icon(Icons.search)),
          ),
        ),
        const SizedBox(height: 48.0),
        ListTile(
          title: Text(
            '2. Travel distance you can afford?',
            style: Theme.of(context).textTheme.title,
          ),
        ),
        ListTile(
          title: TextFormField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Distance in KM',
            ),
          ),
        ),
        const SizedBox(height: 48.0),
        ListTile(
          title: Text(
            '3. Cause',
            style: Theme.of(context).textTheme.title,
          ),
        ),
        ListTile(title: _select(issues, 'Your Issue', 'issues')),
        const SizedBox(height: 48.0),
        ListTile(
          title: Text(
            '4. Any Campaign Affiliations ?',
            style: Theme.of(context).textTheme.title,
          ),
        ),
        ListTile(title: _select(campaings, 'Select Affiliation ', 'campaings')),
        const SizedBox(height: 48.0),
        ListTile(
          title: ButtonBar(
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/campaignview');
                },
                child: const Text('Next'),
              ),
            ],
          ),
        ),
      ],
      // ),
      //   ),
    );
  }

  DropdownButton<String> _select(List<String> items, String hint, String item) {
    return DropdownButton<String>(
      value: dropdownValue[item],
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 5,
      isExpanded: true,
      hint: Text(hint),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue[item] = newValue;
        });
      },
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
