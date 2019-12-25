import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:com.whitelabel/services/services.dart';
import '../bloc/bloc.dart';
import '../bloc/data.dart';
import 'campaign_master_tile.dart';

class MobileCampaignView extends StatelessWidget {
  const MobileCampaignView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthUserService _user = Provider.of<AuthUserService>(context);
    return Scaffold(
      floatingActionButton: key == const ValueKey<String>('/mycampaign')
          ? FloatingActionButton.extended(
              icon: Icon(Icons.add),
              label: const Text('Explore More'),
              onPressed: () {
                Navigator.of(context).pushNamed('/userinfo');
              },
            )
          : null,
      appBar: _user.isLoggedIn
          ? null
          : AppBar(
              title: TitleWidget(
                icon: FontAwesomeIcons.fistRaised,
                title: key == const ValueKey<String>('/mycampaign')
                    ? 'My Campaigns'
                    : 'Campaigns',
              ),
              centerTitle: true,
            ),
      body: StreamBuilder<Map<int, Campaign>>(
        stream: Provider.of<CampaignBloc>(context).campaignList,
        builder:
            (BuildContext context, AsyncSnapshot<Map<int, Campaign>> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error occurred: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return CampaignTile(
                campaign: snapshot.data[index],
                showUserButtonBar: key == const ValueKey<String>('/mycampaign'),
              );
            },
          );
        },
      ),
    );
  }
}
