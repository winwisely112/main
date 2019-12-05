import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bloc/bloc.dart';
import '../bloc/data.dart';
import 'campaign_master_tile.dart';

class MobileCampaignView extends StatelessWidget {
  const MobileCampaignView({Key key}) : super(key: key);

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
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return CampaignTile(campaign: snapshot.data[index]);
            },
          );
        },
      ),
    );
  }
}
