import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:com.whitelabel/services/services.dart';

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
    final StorageService _storage = Provider.of<StorageService>(context);
    final Campaign campaign = _storage.hiveBox[Cache.Campaign].get(campaignID);

    return ResponsiveListView(
      children: <Widget>[
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Container(
                child: Image.asset(campaign.logoUrl),
              ),
              title: Text(
                campaign.name,
                style: Theme.of(context).textTheme.title,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24.0),
        ListTile(
          title: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Image.asset(
                'assets/mockData/campaign/${Random().nextInt(2)}.gif',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24.0),
        ListTile(
          title: Text(
            'Description',
            style: Theme.of(context).textTheme.title,
          ),
          subtitle: Text(campaign.description),
        ),
        const SizedBox(height: 24.0),
        ListTile(
          title: Text(
            'Action Location / Time',
            style: Theme.of(context).textTheme.title,
          ),
          subtitle: Text(
              '${campaign.where} / ${DateFormat('yyyy MMM dd HH:MM').format(campaign.when)}'),
        ),
        const SizedBox(height: 24.0),
        ListTile(
          title: Text(
            'People already pledged',
            style: Theme.of(context).textTheme.title,
          ),
          subtitle: Text(campaign.alreadyPledged.toString()),
        ),
        const SizedBox(height: 24.0),
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    'Needs',
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
                const Divider(),
                for (int index = 0; index < campaign.crgIdsMany.length; index++)
                  RolesLoader(
                    index: index,
                    crgId: campaign.crgIdsMany[index],
                    crgQuantity: campaign.crgQuantityMany[index],
                  ),
                const SizedBox(height: 8.0),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        ButtonBar(
          children: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/notready/$campaignID');
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

class RolesLoader extends StatelessWidget {
  const RolesLoader({Key key, this.index, this.crgId, this.crgQuantity})
      : super(key: key);
  final String crgId;
  final String crgQuantity;
  final int index;
  @override
  Widget build(BuildContext context) {
    final StorageService _storage = Provider.of<StorageService>(context);
    final Roles _roles = _storage.hiveBox[Cache.Roles].get(crgId);
    final List<String> _text = _roles.name.split(' ');
    String _name = '';
    for (String _t in _text) {
      _name = _name + toBeginningOfSentenceCase(_t) + ' ';
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ListTile(
        title: Text(_name),
        subtitle: Text(_roles.description),
        trailing: Text(
          '$crgQuantity ${_roles.uom}',
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
      ),
    );
  }
}
