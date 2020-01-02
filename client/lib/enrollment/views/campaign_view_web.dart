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
      showBackButton: key != const ValueKey<String>('/mycampaign'),
      child: StreamBuilder<Map<int, Campaign>>(
        stream: Provider.of<CampaignBloc>(context).campaignList,
        builder:
            (BuildContext context, AsyncSnapshot<Map<int, Campaign>> snapshot) {
          return WebLayoutBody(
            floatingActionButton: key == const ValueKey<String>('/mycampaign')
                ? FloatingActionButton.extended(
                    icon: Icon(Icons.add),
                    label: const Text('Explore More'),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/userinfo');
                    },
                  )
                : null,
            showBottomNav: key == const ValueKey<String>('/mycampaign'),
            emptyItems: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  FlatButton(
                    child: Text(
                      'Haven\'t Found Your Cause Yet?',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondaryVariant,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/userinfo');
                    },
                  ),
                  FlatButton(
                    child: Text(
                      'Explore more',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondaryVariant,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/userinfo');
                    },
                  ),
                ],
              ),
            ),
            drawerSelection:
                key == const ValueKey<String>('/mycampaign') ? 0 : -1,
            slivers: <Widget>[
              const SliverPadding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                sliver: SliverFloatingBar(
                  elevation: 1.0,
                  floating: true,
                  pinned: true,
                  automaticallyImplyLeading: false,
                  title: TextField(
                    decoration:
                        InputDecoration.collapsed(hintText: 'Search Campaigns'),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(<Widget>[
                  TitleWidget(
                    icon: FontAwesomeIcons.fistRaised,
                    title: key == const ValueKey<String>('/mycampaign')
                        ? 'My Campaigns'
                        : 'Campaigns',
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
                    showUserButtonBar:
                        key == const ValueKey<String>('/mycampaign'),
                  ),
                ),
              );
            },
            itemCount: snapshot.hasData ? snapshot.data.length : 0,
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
