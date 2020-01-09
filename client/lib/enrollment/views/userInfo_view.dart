import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:com.whitelabel/services/services.dart';

class UserInfoView extends StatelessWidget {
  const UserInfoView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> imgList = <String>[
      'assets/splash/splash01.png',
      'assets/splash/splash02.png',
      'assets/splash/splash03.png',
      'assets/splash/splash04.png',
      'assets/splash/splash-05.png',
      'assets/splash/splash-06.png',
      'assets/splash/splash-07.png',
      'assets/splash/splash-08.png',
      'assets/splash/splash-09.png',
      'assets/splash/splash-10.png',
      'assets/splash/splash-11.png',
      'assets/splash/splash-12.png',
      'assets/splash/splash-13.png',
    ];
    return WebInfoView(
      title: TitleWidget(
        icon: FontAwesomeIcons.fistRaised,
        title: 'Campaign for Your Cause',
      ),
      child: MediaQuery.of(context).size.width >= 720.0
          ? Container(
              margin: const EdgeInsets.all(0),
              alignment: Alignment.topLeft,
              width: MediaQuery.of(context).size.width * 0.88,
              height: MediaQuery.of(context).size.height * 0.81,
              child: Row(
                //mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.all(0),
                    alignment: Alignment.topLeft,
                    width: MediaQuery.of(context).size.width * 0.32,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: const <Widget>[
                        _UserInfoView(),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(0),
                    width: MediaQuery.of(context).size.width * 0.56,
                    child: CarouselSlider(
                      enlargeCenterPage: true,
                      autoPlayInterval: const Duration(seconds: 5),
                      autoPlayAnimationDuration: const Duration(seconds: 2),
                      height: MediaQuery.of(context).size.height * 0.80,
                      items: imgList
                          .map(
                            (String url) => Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: Image.asset(
                                  url,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      //aspectRatio: 4 / 3,
                      autoPlay: true,
                      pauseAutoPlayOnTouch: const Duration(milliseconds: 800),
                    ),
                  ),
                ],
              ),
            )
          : const _UserInfoView(),
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
  final List<String> countries = <String>[
    'United Kingdom',
    'Australia',
    'Canada',
    'Germany',
    'Pakistan',
    'USA',
  ];

  final List<String> cities = <String>[
    'London',
    'Berlin',
    'New York',
    'Vancouver',
    'Shanghai',
  ];

  final List<String> issues = <String>[
    'Student Debt',
    'Health Care',
    'Climate'
  ];

  final List<String> campaings = <String>[
    'Extinction Rebellion (XR)',
    'Fridays for Future',
    'Children\'s Climate Strike',
    'GreenPeace',
    'None',
    'Others',
  ];
  final List<String> ages = <String>[
    '10-15',
    '16-20',
    '21-30',
    '31-40',
    '41-50',
    '51-60',
    '61-65',
    '66-70',
    '71 and over'
  ];
  final Map<String, String> dropdownValue = <String, String>{};

  @override
  void initState() {
    dropdownValue['countries'] = countries[0];
    dropdownValue['cities'] = cities[0];
    dropdownValue['issues'] = issues[0];
    dropdownValue['campaings'] = campaings[0];
    dropdownValue['ages'] = ages[2];
    dropdownValue['others'] = '';
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
/*         ListTile(
          title: TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                hintText: 'Your Location', suffix: Icon(Icons.search)),
          ),
        ), */
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
            '3. Age',
            style: Theme.of(context).textTheme.title,
          ),
        ),
        ListTile(title: _select(ages, 'Select Age Range', 'ages')),
        // TODO(me): Commented Cause for demo
/*         const SizedBox(height: 48.0),
        ListTile(
          title: Text(
            '3. Cause',
            style: Theme.of(context).textTheme.title,
          ),
        ),
        ListTile(title: _select(issues, 'Your Issue', 'issues')), */
        const SizedBox(height: 48.0),
        ListTile(
          title: Text(
            '4. Any Campaign Affiliations ?',
            style: Theme.of(context).textTheme.title,
          ),
        ),
        ListTile(
          title: _select(campaings, 'Select Affiliation ', 'campaings'),
          subtitle: dropdownValue['campaings'] == 'Others'
              ? TextFormField(
                  initialValue: dropdownValue['others'],
                  maxLines: 1,
                  decoration: InputDecoration(
                    labelText: 'Others',
                    alignLabelWithHint: true,
                    hintText: 'Others',
                    fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide: const BorderSide(),
                    ),
                  ),
                  onSaved: (String value) {
                    setState(() {
                      dropdownValue['others'] = value;
                    });
                  },
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                  ),
                )
              : const SizedBox(height: 0),
        ),
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

  Widget _select(List<String> items, String hint, String item) {
    return DropdownButton<String>(
      value: dropdownValue[item],
      icon: Icon(Icons.arrow_downward),
      underline: Container(
        height: 2,
        color: Theme.of(context).colorScheme.secondaryVariant,
      ),
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
