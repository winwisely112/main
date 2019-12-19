import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
//import 'package:responsive_scaffold/responsive_scaffold.dart';

import 'package:com.whitelabel/services/services.dart';
import 'package:com.whitelabel/vendor_plugins/vendor_plugins.dart';

import '../bloc/bloc.dart';
import '../bloc/data.dart';
import 'campaign_details_view.dart';
import 'campaign_master_tile.dart';

class WebCampaignView extends StatelessWidget {
  const WebCampaignView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeScaffold(
      child: StreamBuilder<Map<int, Campaign>>(
        stream: Provider.of<CampaignBloc>(context).campaignList,
        builder:
            (BuildContext context, AsyncSnapshot<Map<int, Campaign>> snapshot) {
          return WebLayoutBody(
            drawerSelection: -1,
            slivers: <Widget>[
              SliverFloatingBar(
                floating: true,
                automaticallyImplyLeading: false,
                title: TextField(
                  decoration: const InputDecoration.collapsed(
                      hintText: 'Search Campaigns'),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(<Widget>[
                  TitleWidget(
                    icon: FontAwesomeIcons.fistRaised,
                    title: 'Campaign',
                  ),
                  const Divider()
                ]),
              ),
            ],
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
