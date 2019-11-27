import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './news_feed_mobile.dart';
import './news_feed_web.dart';

class NewsFeed extends StatelessWidget {
  const NewsFeed({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kIsWeb ||
        debugDefaultTargetPlatformOverride == TargetPlatform.fuchsia) {
      return const WebNewsFeed();
    } else {
      return const MobileNewsFeed();
    }
  }
}
