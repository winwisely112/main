import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../bloc/data.dart';

class CampaignTile extends StatelessWidget {
  const CampaignTile({Key key, this.campaign}) : super(key: key);
  final Campaign campaign;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: ListTile(
        onTap: kIsWeb ||
                debugDefaultTargetPlatformOverride == TargetPlatform.fuchsia
            ? null
            : () {
                Navigator.of(context)
                    .pushNamed('/campaigndetails/${campaign.id.id}');
              },
        leading: Container(
          child: Image.asset(campaign.logoUrl),
        ),
        title: Text(campaign.name),
        subtitle: Text(
          campaign.description,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
