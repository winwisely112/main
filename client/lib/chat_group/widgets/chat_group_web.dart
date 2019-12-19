import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:com.whitelabel/services/services.dart';
import 'package:com.whitelabel/chat_group/chat_group.dart';
import 'package:com.whitelabel/chat_view/chat_view.dart';
import 'package:com.whitelabel/vendor_plugins/vendor_plugins.dart';

class WebChatGroupFeed extends StatefulWidget {
  @override
  __ChatGroupFeedBodyState createState() => __ChatGroupFeedBodyState();
}

class __ChatGroupFeedBodyState extends State<WebChatGroupFeed> {
  @override
  Widget build(BuildContext context) {
    return HomeScaffold(
      child: StreamBuilder<Map<int, ChatGroup>>(
          stream: Provider.of<ChatGroupBloc>(context).chatList,
          builder: (BuildContext context,
              AsyncSnapshot<Map<int, ChatGroup>> snapshot) {
            return WebLayoutBody(
              drawerSelection: 1,
              slivers: <Widget>[
                const SliverPadding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  sliver: SliverFloatingBar(
                    elevation: 1.0,
                    floating: true,
                    pinned: true,
                    automaticallyImplyLeading: false,
                    title: TextField(
                      decoration: const InputDecoration.collapsed(
                          hintText: 'Search Groups'),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(<Widget>[
                    TitleWidget(
                      title: 'Groups',
                      icon: Icons.chat_bubble,
                    ),
                    const Divider()
                  ]),
                ),
              ],
              detailBuilder: (
                BuildContext context,
                int index,
                bool flag,
              ) {
                return DetailsScreen(
                  body: Material(
                    color: Theme.of(context).cardColor,
                    elevation: 5.0,
                    child: ChatFeed(
                      chatGroupId: snapshot.data[index].id.id,
                    ),
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
