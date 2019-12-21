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
    final AuthUserService _user = Provider.of<AuthUserService>(context);
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
                campaign.campaignName,
                style: Theme.of(context).textTheme.title,
              ),
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.40,
          child: Center(
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Image.asset(
                    'assets/mockData/campaign/${Random().nextInt(2)}.gif',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
        ),
        ListTile(
          title: Text(
            'Category',
            style: Theme.of(context).textTheme.title,
          ),
          subtitle: Text(campaign.category),
        ),
        const SizedBox(height: 16.0),
        ListTile(
          title: Text(
            'Type of Action',
            style: Theme.of(context).textTheme.title,
          ),
          subtitle: Text(campaign.actionType),
        ),
        const SizedBox(height: 16.0),
        ListTile(
          title: Text(
            'Goal',
            style: Theme.of(context).textTheme.title,
          ),
          subtitle: Text(campaign.goal),
        ),
        const SizedBox(height: 16.0),
        ListTile(
          title: Text(
            'Strategy',
            style: Theme.of(context).textTheme.title,
          ),
          subtitle: Text(campaign.strategy),
        ),
        const SizedBox(height: 16.0),
        ListTile(
          title: Text(
            'Historical Precedents',
            style: Theme.of(context).textTheme.title,
          ),
          subtitle: Text(campaign.histPrecedents),
        ),
        const SizedBox(height: 16.0),
        ListTile(
          title: Text(
            'Action Location / Time',
            style: Theme.of(context).textTheme.title,
          ),
          subtitle: Text(
              '${campaign.where} / ${DateFormat('yyyy MMM dd HH:MM').format(campaign.when)}'),
        ),
        const SizedBox(height: 16.0),
        ListTile(
          title: Text(
            'Length of the Action',
            style: Theme.of(context).textTheme.title,
          ),
          subtitle: Text(campaign.actionLength),
        ),
        const SizedBox(height: 16.0),
        ListTile(
          title: Text(
            'People already pledged',
            style: Theme.of(context).textTheme.title,
          ),
          subtitle: Text(campaign.alreadyPledged.toString()),
        ),
        const SizedBox(height: 16.0),
        ListTile(
          title: Text(
            'Backing/Endorsing Organizations',
            style: Theme.of(context).textTheme.title,
          ),
          subtitle: Text(campaign.backingOrg.join('\n')),
        ),
        const SizedBox(height: 16.0),
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              title: Text(
                'We Need :',
                style: Theme.of(context).textTheme.title,
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ListTile(
                    title: const Text('Pioneers needed to start'),
                    trailing: Text(
                      '${campaign.minStart}',
                      style: TextStyle(color: Theme.of(context).accentColor),
                    ),
                  ),
                  ListTile(
                    title: const Text('Rebels needed to trigger media'),
                    trailing: Text(
                      '${campaign.minSocialMedia}',
                      style: TextStyle(color: Theme.of(context).accentColor),
                    ),
                  ),
                  ListTile(
                    title: const Text('Rebels needed to win'),
                    trailing: Text(
                      '${campaign.minWin}',
                      style: TextStyle(color: Theme.of(context).accentColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        ListTile(
          title: Text(
            'Contact Details',
            style: Theme.of(context).textTheme.title,
          ),
          subtitle: Text(campaign.contact),
        ),
        const SizedBox(height: 16.0),
        _user.isLoggedIn
            ? const SizedBox(height: 0)
            : ListTile(
                title: const Text(
                  'Are you ready to be a resister in this strike/nonviolent direct action ?',
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed('/notready/$campaignID');
                        },
                        child: const Text('Not Ready'),
                      ),
                      RaisedButton(
                        onPressed: () {
                          if (_user.isLoggedIn) {
                            Navigator.of(context).pushNamed('/campaignview');
                          } else {
                            Navigator.of(context).pushNamed('/signup');
                          }
                        },
                        child: const Text('Ready'),
                      ),
                    ],
                  ),
                ),
              ),
        const SizedBox(height: 8.0),
      ],
    );
  }
}
