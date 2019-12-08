import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:com.winwisely99.app/services/services.dart';

class NotReadyView extends StatelessWidget {
  const NotReadyView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WebInfoView(
      title: TitleWidget(
        icon: FontAwesomeIcons.handsHelping,
        title: 'Needs',
      ),
      child: const _NotReadyView(),
      index: -1,
    );
  }
}

class _NotReadyView extends StatefulWidget {
  const _NotReadyView({Key key}) : super(key: key);

  @override
  __NotReadyViewState createState() => __NotReadyViewState();
}

class __NotReadyViewState extends State<_NotReadyView> {
  final TextEditingController _controller = TextEditingController();
  final Map<int, dynamic> _value = <int, dynamic>{
    1: '30.0',
    2: false,
    3: false,
    4: false,
    5: false,
    6: false,
    7: false,
    8: false,
    9: false,
    10: '',
  };
  @override
  Widget build(BuildContext context) {
    return ResponsiveListView(
      children: <Widget>[
        ListTile(
          title: Text(
            'How can we help you be ready',
            style: Theme.of(context).textTheme.display1,
          ),
        ),
        const ListTile(
          title: Text('1. How much willing you are to join?'),
        ),
        ListTile(
          //trailing: Text('${_value[1].toString()}%'),
          title: Slider(
            label: '${_value[1].toString()}%',
            divisions: 10,
            min: 0.0,
            max: 100,
            value: double.parse(_value[1]),
            onChanged: (double value) {
              setState(() {
                _value[1] = value.toString();
              });
            },
          ),
        ),
        CheckboxListTile(
          title: const Text('2. I need to be more confident re legal defense'),
          value: _value[2],
          onChanged: (bool value) {
            setState(() {
              _value[2] = value;
            });
          },
          secondary: const Icon(FontAwesomeIcons.briefcase),
        ),
        CheckboxListTile(
          title: const Text('3. I need to be more confident re legal defense'),
          value: _value[3],
          onChanged: (bool value) {
            setState(() {
              _value[3] = value;
            });
          },
          secondary: const Icon(FontAwesomeIcons.briefcase),
        ),
        CheckboxListTile(
          title: const Text('4. I need to be invited to join by a friend'),
          value: _value[4],
          onChanged: (bool value) {
            setState(() {
              _value[4] = value;
            });
          },
          secondary: const Icon(FontAwesomeIcons.userFriends),
        ),
        CheckboxListTile(
          title: const Text(
              '5. I’m a party animal: I need to be invited to a party of other strikers and conditional strikers'),
          value: _value[5],
          onChanged: (bool value) {
            setState(() {
              _value[5] = value;
            });
          },
          secondary: const Icon(FontAwesomeIcons.fistRaised),
        ),
        CheckboxListTile(
          title: const Text('6. Need transport'),
          value: _value[6],
          onChanged: (bool value) {
            setState(() {
              _value[6] = value;
            });
          },
          secondary: const Icon(FontAwesomeIcons.bus),
        ),
        CheckboxListTile(
          title: const Text('7. Need bail support'),
          value: _value[7],
          onChanged: (bool value) {
            setState(() {
              _value[7] = value;
            });
          },
          secondary: const Icon(FontAwesomeIcons.link),
        ),
        CheckboxListTile(
          title: const Text('8. Need childcare'),
          value: _value[8],
          onChanged: (bool value) {
            setState(() {
              _value[8] = value;
            });
          },
          secondary: const Icon(FontAwesomeIcons.babyCarriage),
        ),
        CheckboxListTile(
          title: const Text(
              '9. Need housing (if long term strike and worry about losing housing)'),
          value: _value[9],
          onChanged: (bool value) {
            setState(() {
              _value[9] = value;
            });
          },
          secondary: const Icon(FontAwesomeIcons.home),
        ),
        const SizedBox(height: 8.0),
        TextFormField(
          maxLines: 5,
          controller: _controller,
          decoration: InputDecoration(
            labelText: 'Is there any other need you have....',
            alignLabelWithHint: true,
            hintText: 'Is there any other need you have....',
            fillColor: Theme.of(context).inputDecorationTheme.fillColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
              borderSide: const BorderSide(),
            ),
          ),
          validator: (String val) {
            if (val.isEmpty) {
              return 'Email cannot be empty';
            } else {
              return null;
            }
          },
          onSaved: (String value) {
            setState(() {
              _value[10] = value;
            });
          },
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(
            fontFamily: 'Poppins',
          ),
        ),
        const SizedBox(height: 8.0),
        const ListTile(
          title: Text(
            '10. If we cannot satisfy your conditions, would you be willing to consider providing a support role to those willing to strike?',
          ),
        ),
        ButtonBar(
          children: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/supportroles');
              },
              child: const Text('Yes'),
            ),
          ],
        ),
      ],
    );
  }
}
