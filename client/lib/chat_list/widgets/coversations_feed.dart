import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:provider/provider.dart';
import 'package:com.winwisely99.app/services/services.dart';

import './coversations_feed_mobile.dart';
import './coversations_feed_web.dart';

class ConversationsFeed extends StatelessWidget {
  const ConversationsFeed({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (kIsWeb ||
        debugDefaultTargetPlatformOverride == TargetPlatform.fuchsia) {
      return ChangeNotifierProvider<AppNavigation>(
        builder: (BuildContext context) => AppNavigation.init(4, 1),
        child: const WebConversationsFeed(),
      );
    } else {
      return const MobileConversationsFeed();
    }
  }
}
