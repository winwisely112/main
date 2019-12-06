//import 'package:collection/collection.dart' show groupBy;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:responsive_scaffold/responsive_scaffold.dart';

import 'package:com.winwisely99.app/services/services.dart';
import 'package:com.winwisely99.app/chat_view/chat_view.dart';
import 'package:com.winwisely99.app/vendor_plugins/vendor_plugins.dart';

import '../bloc/bloc.dart';
import '../bloc/data.dart';

class WebChatGroupFeed extends StatelessWidget {
  const WebChatGroupFeed({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildCloneableWidget>[
        ProxyProvider2<NetworkService, UserService, ChatGroupBloc>(
          builder: (BuildContext _, NetworkService network, UserService user,
                  ChatGroupBloc __) =>
              ChatGroupBloc(
            network: network,
            user: user,
          ),
        ),
        ProxyProvider2<NetworkService, UserService, ChatBloc>(
          builder: (BuildContext _, NetworkService network, UserService user,
                  ChatBloc __) =>
              ChatBloc(
            network: network,
            user: user,
            chatGroupId: null,
          ),
        )
      ],
      child: _ChatGroupFeedBody(),
    );
  }
}

class _ChatGroupFeedBody extends StatefulWidget {
  @override
  __ChatGroupFeedBodyState createState() => __ChatGroupFeedBodyState();
}

class __ChatGroupFeedBodyState extends State<_ChatGroupFeedBody> {
  @override
  Widget build(BuildContext context) {
    return HomeScaffold(
      child: StreamBuilder<Map<int, ChatGroup>>(
          stream: Provider.of<ChatGroupBloc>(context).chatList,
          builder: (BuildContext context,
              AsyncSnapshot<Map<int, ChatGroup>> snapshot) {
            return WebLayoutBody(
              drawerSelection: 1,
              title: TitleWidget(
                title: 'Groups',
                icon: Icons.chat_bubble,
              ),
              detailBuilder: (
                BuildContext context,
                int index,
                bool flag,
              ) {
                return DetailsScreen(
                  body: Material(
                    color: Colors.white,
                    elevation: 8.0,
                    child: FutureBuilder<User>(
                        future: Provider.of<ChatBloc>(context).getCurrentUser(),
                        builder:
                            (BuildContext context, AsyncSnapshot<User> user) {
                          if (!user.hasData) {
                            return Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Theme.of(context).primaryColor,
                                ),
                              ),
                            );
                          }
                          return ChatFeedBody(
                            user: ChatUser(
                              name: user.data.name,
                              uid: user.data.id.id,
                              avatar: user.data.avatarURL,
                            ),
                            chatGroupId: snapshot.data[index].id.id,
                          );
                        }),
                  ),
                );
              },
              itemCount: snapshot.hasData ? snapshot.data.length : 0,
              itemBuilder: (BuildContext context, int index) {
                final ChatGroup chatGroup = snapshot.data[index];
                return Card(
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 8.0),
                      _ConversationTile(chatGroup: chatGroup),
                      const SizedBox(height: 8.0),
                    ],
                  ),
                );
              },
            );
          }),
    );
  }
}

class _ConversationTile extends StatelessWidget {
  const _ConversationTile({Key key, this.chatGroup}) : super(key: key);
  final ChatGroup chatGroup;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ChatModel>>(
        stream: Provider.of<ChatBloc>(context).getChats(chatGroup.id),
        builder:
            (BuildContext context, AsyncSnapshot<List<ChatModel>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor,
                ),
              ),
            );
          } else {
            ChatModel lastChat;
            if (snapshot.data.isNotEmpty) {
              final List<ChatModel> _list = snapshot.data;
              _list.removeWhere((ChatModel item) => item == null);
              if (_list.isEmpty) {
                lastChat = null;
              } else {
                _list.sort((ChatModel a, ChatModel b) =>
                    b.createdAt.compareTo(a.createdAt));
                lastChat = _list.firstWhere(
                    (ChatModel chat) => chat.chatGroupId == chatGroup.id.id,
                    orElse: null);
              }
            } else {
              lastChat = null;
            }
            return ListTile(
              title: Text(chatGroup.title),
              subtitle: Text(
                lastChat != null ? lastChat.text : 'No messages',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              leading: CircleAvatar(
                backgroundImage: AssetImage(chatGroup.avatarUrl),
                // NetworkImage(chatGroup.avatarURL),
                child: const Text(''),
              ),
            );
          }
        });
  }
}
