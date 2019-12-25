import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../bloc/data.dart';

class CampaignTile extends StatelessWidget {
  const CampaignTile({Key key, this.campaign, this.showUserButtonBar})
      : super(key: key);
  final Campaign campaign;
  final bool showUserButtonBar;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: ListTile(
        onTap: kIsWeb ||
                debugDefaultTargetPlatformOverride == TargetPlatform.fuchsia
            ? null
            : () {
                if (showUserButtonBar) {
                  Navigator.of(context)
                      .pushNamed('/mycampaigndetails/${campaign.id.id}');
                } else {
                  Navigator.of(context)
                      .pushNamed('/campaigndetails/${campaign.id.id}');
                }
              },
        leading: Container(
          child: Image.asset(campaign.logoUrl),
        ),
        title: Text(campaign.campaignName,
            style: Theme.of(context).textTheme.title),
        subtitle: Text(campaign.organization),
      ),
    );
  }
}
