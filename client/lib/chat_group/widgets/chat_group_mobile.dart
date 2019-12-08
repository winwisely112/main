import 'package:collection/collection.dart' show groupBy;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:com.winwisely99.app/services/services.dart';
import 'package:com.winwisely99.app/chat_view/chat_view.dart';

import '../bloc/bloc.dart';
import '../bloc/data.dart';

class MobileChatGroupFeed extends StatelessWidget {
  const MobileChatGroupFeed({Key key}) : super(key: key);
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
      ],
      child: _ChatGroupFeedBody(),
    );
  }
}

class _ChatGroupFeedBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map<int, ChatGroup>>(
      stream: Provider.of<ChatGroupBloc>(context).chatList,
      builder:
          (BuildContext context, AsyncSnapshot<Map<int, ChatGroup>> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error occurred: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final Map<DateTime, List<ChatGroup>> _chatGroup =
            groupBy<ChatGroup, DateTime>(
          snapshot.data.values,
          (ChatGroup h) => h.timestamp,
        );
        final List<DateTime> dates = _chatGroup.keys.toList()
          ..sort((DateTime a, DateTime b) => b.compareTo(a));
        return ListView(
          children: ListTile.divideTiles(
            context: context,
            tiles: <Widget>[
// ignore: sdk_version_ui_as_code
              for (DateTime key in dates) ...<Widget>[
                for (ChatGroup chatGroup in _chatGroup[key])
                  Column(
                    children: <Widget>[
                      const SizedBox(height: 10.0),
                      ProxyProvider2<NetworkService, UserService, ChatBloc>(
                        builder: (BuildContext _, NetworkService network,
                                UserService user, ChatBloc __) =>
                            ChatBloc(
                                network: network,
                                user: user,
                                chatGroupId: chatGroup.id.id),
                        child: _ConversationTile(
                          chatGroup: chatGroup,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                    ],
                  ),
              ],
            ],
          ).toList(),
        );
      },
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
              onTap: () {
                Navigator.of(context).pushNamed('/chatfeed/${chatGroup.id.id}');
              },
              title: Text(chatGroup.title),
              subtitle: Text(
                lastChat != null ? lastChat.text : 'No messages',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).cardColor,
                backgroundImage: AssetImage(chatGroup.avatarUrl),
                // NetworkImage(chatGroup.avatarURL),
                child: const Text(''),
              ),
            );
          }
        });
  }
}
