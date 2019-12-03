import 'package:flutter/material.dart';

import 'package:com.winwisely99.app/services/services.dart';

class UserInfoView extends StatefulWidget {
  UserInfoView({Key key}) : super(key: key);

  @override
  _UserInfoViewState createState() => _UserInfoViewState();
}

class _UserInfoViewState extends State<UserInfoView> {
  final countries = ['Germany', 'Australia', 'Pakistan', 'USA'];

  final cities = ['Berlin', 'Newyork', 'Vancouver', 'Shanghai'];

  final issues = ['Student Debt', 'Health Care', 'Climate'];

  final campaings = ['XR', 'Fridays for future'];
  final Map<String, String> dropdownValue = {};
  @override
  void initState() {
    // TODO: implement initState
    dropdownValue['countries'] = countries[0];
    dropdownValue['cities'] = cities[0];
    dropdownValue['issues'] = issues[0];
    dropdownValue['campaings'] = campaings[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Classify the user'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('1. Where are you?'),
              Utils.verticalMargin(16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  children: <Widget>[
                    _select(countries, 'Select Country', 'countries'),
                    Utils.verticalMargin(10),
                    _select(cities, 'Select City', 'cities'),
                    Utils.verticalMargin(10),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Zip Code',
                      ),
                    ),
                    Utils.verticalMargin(10),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: 'Your Location',
                          suffix: Icon(Icons.search)),
                    ),
                  ],
                ),
              ),
              Utils.verticalMargin(32),
              Text('2. Travel distance you can afford?'),
              Utils.verticalMargin(16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Distance in KM',
                  ),
                ),
              ),
              Utils.verticalMargin(32),
              Text('3. Issue with enviornment?'),
              Utils.verticalMargin(16),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: _select(issues, 'Your Issue', 'issues')),
              Utils.verticalMargin(32),
              Text('4. Any Campaign Affiliations ?'),
              Utils.verticalMargin(16),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child:
                      _select(campaings, 'Select Affiliation ', 'campaings')),
              Utils.verticalMargin(32),
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(right: 16),
                child: RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/campaignview');
                  },
                  child: Text('Next'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DropdownButton _select(List<String> items, String hint, String item) {
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
