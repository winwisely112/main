import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
//import 'package:responsive_scaffold/responsive_scaffold.dart';

import 'package:com.winwisely99.app/services/services.dart';
import 'package:com.winwisely99.app/vendor_plugins/vendor_plugins.dart';

import '../bloc/bloc.dart';
import '../bloc/data.dart';
import 'campaign_details_view.dart';
import 'campaign_master_tile.dart';

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
            drawerSelection: -1,
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
                  color: Theme.of(context).cardColor,
                  elevation: 8.0,
                  child: CampainDetailsView(
                    campaignID: snapshot.data[index].id.id,
                  ),
                ),
              );
            },
            itemCount: snapshot.hasData ? snapshot.data.length : 0,
            itemBuilder: (BuildContext context, int index) {
              return CampaignTile(campaign: snapshot.data[index]);
            },
          );
        },
      ),
    );
  }
}
