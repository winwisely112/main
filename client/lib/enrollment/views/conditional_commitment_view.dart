import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:com.whitelabel/services/services.dart';

import '../bloc/data.dart';
import 'notready_view.dart';

class ConditionalCommitmentView extends StatelessWidget {
  const ConditionalCommitmentView({Key key, this.campaignID}) : super(key: key);
  final String campaignID;
  @override
  Widget build(BuildContext context) {
    return WebInfoView(
      title: TitleWidget(
        icon: FontAwesomeIcons.personBooth,
        title: 'Conditional Commitment',
      ),
      child: _ConditionalCommitmentView(campaignID: campaignID),
      index: -1,
    );
  }
}

class _ConditionalCommitmentView extends StatefulWidget {
  const _ConditionalCommitmentView({Key key, this.campaignID})
      : super(key: key);
  final String campaignID;
  @override
  __ConditionalCommitmentViewState createState() =>
      __ConditionalCommitmentViewState();
}

class __ConditionalCommitmentViewState
    extends State<_ConditionalCommitmentView> {
  final Map<int, dynamic> _value = <int, dynamic>{
    10: false,
    11: false,
    12: false,
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
                _campaign.name,
                style: Theme.of(context).textTheme.title,
              ),
              subtitle: Text(
                _campaign.description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        ListTile(
          title: Text(
            'Select the turn out level, and therefore chance of success, you would need to join',
            style: Theme.of(context).textTheme.title,
          ),
          subtitle: const Text(
            'The following figures is derived from extrapolating from similar struggles against similar powerful companies, both that succeeded and that failed.',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        const SizedBox(height: 8.0),
        CheckboxListTile(
          title: RichText(
            text: TextSpan(
              text:
                  'The number of volunteers needed to realistically start the campaign : ',
              style: Theme.of(context).textTheme.body1,
              children: <TextSpan>[
                TextSpan(
                  text: '${_campaign.minStart}',
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
              ],
            ),
          ),
          subtitle:
              const Text('I will join when the campaign has this many people.'),
          value: _value[10],
          onChanged: (bool value) {
            setState(() {
              _value[10] = value;
            });
          },
        ),
        const SizedBox(height: 8.0),
        CheckboxListTile(
          title: RichText(
            text: TextSpan(
              text:
                  'The number of volunteers needed to trigger mass media and social media organic rapid growth (critical mass) : ',
              style: Theme.of(context).textTheme.body1,
              children: <TextSpan>[
                TextSpan(
                  text: '${_campaign.minSocialMedia}',
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
              ],
            ),
          ),
          subtitle:
              const Text('I will join when the campaign has this many people.'),
          value: _value[11],
          onChanged: (bool value) {
            setState(() {
              _value[11] = value;
            });
          },
        ),
        const SizedBox(height: 8.0),
        CheckboxListTile(
          title: RichText(
            text: TextSpan(
              text:
                  'The number of volunteers needed to have 70-80% chance to succeed : ',
              style: Theme.of(context).textTheme.body1,
              children: <TextSpan>[
                TextSpan(
                  text: '${_campaign.minWin}',
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
              ],
            ),
          ),
          subtitle:
              const Text('I will join when the campaign has this many people.'),
          value: _value[12],
          onChanged: (bool value) {
            setState(() {
              _value[12] = value;
            });
          },
        ),
        const SizedBox(height: 16.0),
        ButtonBar(
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                showDialog<Widget>(
                  context: context,
                  builder: (BuildContext context) {
                    return SupportRolesDialog(campaignID: widget.campaignID);
                  },
                );
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ],
    );
  }
}
