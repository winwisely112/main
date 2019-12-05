import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:com.winwisely99.app/services/services.dart';

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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text('1. Where are you?'),
            Utils.verticalMargin(16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: <Widget>[
                  _select(countries, 'Select Country', 'countries'),
                  Utils.verticalMargin(10),
                  _select(cities, 'Select City', 'cities'),
                  Utils.verticalMargin(10),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Zip Code',
                    ),
                  ),
                  Utils.verticalMargin(10),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: 'Your Location', suffix: Icon(Icons.search)),
                  ),
                ],
              ),
            ),
            Utils.verticalMargin(32),
            const Text('2. Travel distance you can afford?'),
            Utils.verticalMargin(16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Distance in KM',
                ),
              ),
            ),
            Utils.verticalMargin(32),
            const Text('3. Issue with enviornment?'),
            Utils.verticalMargin(16),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: _select(issues, 'Your Issue', 'issues')),
            Utils.verticalMargin(32),
            const Text('4. Any Campaign Affiliations ?'),
            Utils.verticalMargin(16),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: _select(campaings, 'Select Affiliation ', 'campaings')),
            Utils.verticalMargin(32),
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.only(right: 24),
              child: RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/campaignview');
                },
                child: const Text('Next'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  DropdownButton<String> _select(List<String> items, String hint, String item) {
    return DropdownButton<String>(
      value: dropdownValue[item],
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      isExpanded: true,
      hint: Text(hint),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
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
