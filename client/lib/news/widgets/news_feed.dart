import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:com.winwisely99.app/services/services.dart';
import './news_feed_mobile.dart';
import './news_feed_web.dart';

class NewsFeed extends StatelessWidget {
  const NewsFeed({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kIsWeb ||
        debugDefaultTargetPlatformOverride == TargetPlatform.fuchsia) {
      return ChangeNotifierProvider<AppNavigation>(
        builder: (BuildContext context) => AppNavigation.init(4, 0),
        child: const WebNewsFeed(),
      );
    } else {
      return const MobileNewsFeed();
    }
  }
}
