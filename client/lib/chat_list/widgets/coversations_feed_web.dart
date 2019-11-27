//import 'package:collection/collection.dart' show groupBy;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_scaffold/responsive_scaffold.dart';

import 'package:com.winwisely99.app/services/services.dart';
import 'package:com.winwisely99.app/chat_view/chat_view.dart';
import 'package:com.winwisely99.app/vendor_plugins/vendor_plugins.dart';

import '../bloc/bloc.dart';
import '../bloc/data.dart';

class WebConversationsFeed extends StatelessWidget {
  const WebConversationsFeed({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildCloneableWidget>[
        ProxyProvider2<NetworkService, UserService, ConversationsBloc>(
          builder: (BuildContext _, NetworkService network, UserService user,
                  ConversationsBloc __) =>
              ConversationsBloc(
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
            conversationsId: null,
          ),
        )
      ],
      child: _ConversationsFeedBody(),
    );
  }
}

class _ConversationsFeedBody extends StatefulWidget {
  @override
  __ConversationsFeedBodyState createState() => __ConversationsFeedBodyState();
}

class __ConversationsFeedBodyState extends State<_ConversationsFeedBody> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map<int, Conversations>>(
      stream: Provider.of<ConversationsBloc>(context).chatList,
      builder: (BuildContext context,
          AsyncSnapshot<Map<int, Conversations>> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error occurred: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        return Scaffold(
          appBar: AppBar(
            leading: const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage('assets/icon/icon-old.png'),
              ),
            ),
            title: const Text('Winwisely99'),
          ),
          body: ResponsiveListScaffold.builder(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: ListTile(
                  title: Text(
                    'Groups',
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
              ),
            ],
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
                          conversationsId: snapshot.data[index].id.id,
                        );
                      }),
                ),
              );
            },
            //drawer: AppDrawer(),
            tabletSideMenu: (kIsWeb ||
                    debugDefaultTargetPlatformOverride ==
                        TargetPlatform.fuchsia)
                ? const Flexible(
                    flex: 0,
                    child: LeftDrawer(index: 1),
                    fit: FlexFit.tight,
                  )
                : null,
            tabletFlexListView: 4,
            nullItems: const Center(child: CircularProgressIndicator()),
            emptyItems: const Center(child: CircularProgressIndicator()),
            itemCount: snapshot.hasData ? snapshot.data.length : 0,
            itemBuilder: (BuildContext context, int index) {
              final Conversations conversation = snapshot.data[index];
              return Card(
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 8.0),
/*                     ProxyProvider2<NetworkService, UserService, ChatBloc>(
                      builder: (BuildContext _, NetworkService network,
                              UserService user, ChatBloc __) =>
                          ChatBloc(
                              network: network,
                              user: user,
                              conversationsId: conversation.id.id),
                      child:  */
                    _ConversationTile(conversation: conversation),
                    //),
                    const SizedBox(height: 8.0),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _ConversationTile extends StatelessWidget {
  const _ConversationTile({Key key, this.conversation}) : super(key: key);
  final Conversations conversation;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ChatModel>>(
        stream: Provider.of<ChatBloc>(context).getChats(conversation.id),
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
                    (ChatModel chat) =>
                        chat.conversationsId == conversation.id.id,
                    orElse: null);
              }
            } else {
              lastChat = null;
            }
            return ListTile(
              title: Text(conversation.title),
              subtitle: Text(
                lastChat != null ? lastChat.text : 'No messages',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              leading: CircleAvatar(
                backgroundImage: AssetImage(conversation.avatarURL),
                // NetworkImage(conversation.avatarURL),
                child: const Text(''),
              ),
            );
          }
        });
  }
}
