import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import './coversations_feed_mobile.dart';
import './coversations_feed_web.dart';

class ConversationsFeed extends StatelessWidget {
  const ConversationsFeed({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (kIsWeb ||
        debugDefaultTargetPlatformOverride == TargetPlatform.fuchsia) {
      return const WebConversationsFeed();
    } else {
      return const MobileConversationsFeed();
    }
  }
}
