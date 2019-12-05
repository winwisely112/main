import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:responsive_scaffold/responsive_scaffold.dart';

import 'package:com.winwisely99.app/services/services.dart';

import '../bloc/bloc.dart';
import '../bloc/data.dart';
import 'campaign_details_view.dart';
//import '../data/mockData/campaigns.dart';

class WebCampaignView extends StatelessWidget {
  const WebCampaignView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeScaffold(
      child: StreamBuilder<List<Campaign>>(
        stream: Provider.of<CampaignBloc>(context).getCampaign(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Campaign>> snapshot) {
          return WebLayoutBody(
            drawerSelection: 0,
            title: TitleWidget(
              icon: FontAwesomeIcons.fistRaised,
              title: 'Campaign',
            ),
            detailBuilder: (
              BuildContext context,
              int index,
              bool flag,
            ) {
              return DetailsScreen(
                body: Material(
                  color: Colors.white,
                  elevation: 8.0,
                  child: CampainDetailsView(
                    campaignID: snapshot.data[index].id.id,
                  ),
                ),
              );
            },
            itemCount: snapshot.hasData ? snapshot.data.length : 0,
            itemBuilder: (BuildContext context, int index) {
              final Campaign campaign = snapshot.data[index];
              return ListTile(
                leading: Container(
                  child: Image.asset(campaign.logoUrl),
                ),
                title: Text(campaign.name),
                subtitle: Text(
                  campaign.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _CampaignViewBody extends StatelessWidget {
  const _CampaignViewBody({Key key, this.campaigns}) : super(key: key);
  final List<Campaign> campaigns;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: campaigns.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildExpando(campaigns[index], context);
      },
    );
  }

  Widget _buildExpando(Campaign campaign, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        shape: RoundedRectangleBorder(
            side: BorderSide(width: 0.5, color: Colors.grey)),
        elevation: 0,
        child: Column(
          children: <Widget>[
            ExpansionTile(
              leading: Container(
                child: Image.asset(campaign.logoUrl),
              ),
              title: Text(campaign.name),
              children: <Widget>[
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
                      color: Colors.white,
                      textColor: Colors.blue,
                      onPressed: () {
                        Navigator.of(context).pushNamed('/notready');
                      },
                      child: const Text('Not Ready'),
                    ),
                    RaisedButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.of(context).pushNamed('/signup');
                      },
                      child: const Text('Ready'),
                    ),
                  ],
                )
              ],
            ),
            Container(
              height: 0.5,
              color: Colors.grey,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('/generalcampaign');
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.5 - 16,
                      height: 40,
                      alignment: Alignment.center,
                      child: const Text('Select')),
                ),
                Container(
                  height: 40,
                  width: 0.5,
                  color: Colors.grey,
                ),
                InkWell(
                  onTap: () {
                    // TODO(Vineeth): Need to add logic to pass campaignID
                    Navigator.of(context)
                        .pushNamed('/campaigndetails/campaignID');
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.5 - 16,
                      height: 40,
                      alignment: Alignment.center,
                      child: const Text('View Details')),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
