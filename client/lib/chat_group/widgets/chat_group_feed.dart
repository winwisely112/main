import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import 'package:com.whitelabel/chat_view/chat_view.dart';
import 'package:com.whitelabel/services/services.dart';

import '../bloc/bloc.dart';
import './chat_group_mobile.dart';
import './chat_group_web.dart';

class ChatGroupFeed extends StatelessWidget {
  const ChatGroupFeed({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: <SingleChildCloneableWidget>[
          ProxyProvider3<NetworkService, UserService, StorageService,
              ChatGroupBloc>(
            update: (BuildContext _, NetworkService network, UserService user,
                    StorageService storage, ChatGroupBloc __) =>
                ChatGroupBloc(
              network: network,
              user: user,
              storage: storage,
            ),
          ),
          ProxyProvider3<NetworkService, UserService, StorageService, ChatBloc>(
            update: (BuildContext _, NetworkService network, UserService user,
                    StorageService storage, ChatBloc __) =>
                ChatBloc(
              network: network,
              user: user,
              chatGroupId: null,
              storage: storage,
            ),
          )
        ],
        child: (kIsWeb ||
                debugDefaultTargetPlatformOverride == TargetPlatform.fuchsia)
            ? WebChatGroupFeed()
            : MobileChatGroupFeed());
  }
}
