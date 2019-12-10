import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:com.whitelabel/services/services.dart';

import '../bloc/bloc.dart';
import './campaign_view_mobile.dart';
import './campaign_view_web.dart';

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
      child:
          kIsWeb || debugDefaultTargetPlatformOverride == TargetPlatform.fuchsia
              ? const WebCampaignView()
              : const MobileCampaignView(),
    );
  }
}
