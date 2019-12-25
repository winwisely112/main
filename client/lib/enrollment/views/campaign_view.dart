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
    return ProxyProvider4<NetworkService, StorageService, AuthUserService,
        UserService, CampaignBloc>(
      update: (
        BuildContext _,
        NetworkService network,
        StorageService storage,
        AuthUserService globalUser,
        UserService user,
        CampaignBloc __,
      ) =>
          CampaignBloc(
        network: network,
        storage: storage,
        globalUser: globalUser,
        user: user,
        showMyCampaigns: key == const ValueKey<String>('/mycampaign'),
      ),
      child:
          kIsWeb || debugDefaultTargetPlatformOverride == TargetPlatform.fuchsia
              ? WebCampaignView(key: key)
              : MobileCampaignView(key: key),
    );
  }
}
