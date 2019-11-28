import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import './chat_group_mobile.dart';
import './chat_group_web.dart';

class ChatGroupFeed extends StatelessWidget {
  const ChatGroupFeed({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (kIsWeb ||
        debugDefaultTargetPlatformOverride == TargetPlatform.fuchsia) {
      return const WebChatGroupFeed();
    } else {
      return const MobileChatGroupFeed();
    }
  }
}
