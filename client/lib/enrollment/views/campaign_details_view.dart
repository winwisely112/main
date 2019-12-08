import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:com.winwisely99.app/services/services.dart';

import '../bloc/data.dart';
import '../widgets/video_player.dart';

class CampainDetailsView extends StatelessWidget {
  const CampainDetailsView({Key key, this.campaignID}) : super(key: key);
  final String campaignID;

  @override
  Widget build(BuildContext context) {
    return ResponsiveDetailView(
      child: _CampainDetailsBody(campaignID: campaignID),
      title: 'Campaign Details',
      icon: Icons.details,
    );
  }
}

class _CampainDetailsBody extends StatelessWidget {
  const _CampainDetailsBody({Key key, this.campaignID}) : super(key: key);
  final String campaignID;

  @override
  Widget build(BuildContext context) {
    final Campaign campaign = hiveBox['campaign'].get(campaignID);
    return ResponsiveListView(
      children: <Widget>[
        ListTile(
          leading: Container(
            child: Image.asset(campaign.logoUrl),
          ),
          title: Text(campaign.name),
        ),
        const Divider(),
        const SizedBox(height: 8.0),
        ListTile(
          title: const Text('Description'),
          subtitle: Text(campaign.description),
        ),
        const SizedBox(height: 8.0),
        ListTile(
          title: const Text('Other'),
          subtitle: Text(campaign.other),
        ),
        const SizedBox(height: 8.0),
        ListTile(
          title: const Text('CRQ Ids'),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Wrap(
              children: <Widget>[
                for (String id in campaign.crgIdsMany)
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                      )),
                      padding: const EdgeInsets.all(8.0),
                      child: Text(id),
                    ),
                  )
              ],
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        ListTile(
          title: const Text('CRQ Quantity'),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Wrap(
              children: <Widget>[
                for (String id in campaign.crgQuantityMany)
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                      )),
                      padding: const EdgeInsets.all(8.0),
                      child: Text(id),
                    ),
                  )
              ],
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        ButtonBar(
          children: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/notready');
              },
              child: const Text('Not Ready'),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/signup');
              },
              child: const Text('Ready'),
            ),
          ],
        )
      ],
    );
  }
}
