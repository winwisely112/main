import 'package:flutter/material.dart';
import '../bloc/data.dart';

class CampaignTile extends StatelessWidget {
  const CampaignTile({Key key, this.campaign}) : super(key: key);
  final Campaign campaign;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        child: ListTile(
          leading: Container(
            child: Image.asset(campaign.logoUrl),
          ),
          title: Text(campaign.name),
          subtitle: Text(
            campaign.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
