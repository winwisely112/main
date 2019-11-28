import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:com.winwisely99.app/services/services.dart';

import '../bloc/bloc.dart';
import '../bloc/data.dart';
//import '../data/mockData/campaigns.dart';

class CampaignView extends StatelessWidget {
  const CampaignView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ProxyProvider<NetworkService, CampaignBloc>(
      builder: (
        BuildContext _,
        NetworkService network,
        CampaignBloc __,
      ) =>
          CampaignBloc(
        network: network,
      ),
      child: _CampaignView(),
    );
  }
}

class _CampaignView extends StatelessWidget {
  const _CampaignView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Campaign'),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Campaign>>(
        stream: Provider.of<CampaignBloc>(context).getCampaign(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Campaign>> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error occurred: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return _CampaignViewBody(campaigns: snapshot.data);
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
              title: Text(campaign.name),
              children: <Widget>[
                ListTile(
                  title: Image.asset(campaign.logoUrl),
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
