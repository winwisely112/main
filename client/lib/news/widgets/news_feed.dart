import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:com.whitelabel/services/services.dart';

import '../bloc/bloc.dart';
import './news_feed_mobile.dart';
import './news_feed_web.dart';

class NewsFeed extends StatelessWidget {
  const NewsFeed({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProxyProvider3<NetworkService, UserService, StorageService,
        NewsBloc>(
      update: (
        BuildContext _,
        NetworkService network,
        UserService user,
        StorageService storage,
        NewsBloc __,
      ) =>
          NewsBloc(
        network: network,
        user: user,
        storage: storage,
      ),
      child: (kIsWeb ||
              debugDefaultTargetPlatformOverride == TargetPlatform.fuchsia)
          ? const WebNewsFeed()
          : const MobileNewsFeed(),
    );
  }
}
