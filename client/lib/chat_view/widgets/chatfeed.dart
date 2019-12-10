//import 'package:dash_chat/dash_chat.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repository/repository.dart';

import 'package:com.whitelabel/chat_group/chat_group.dart';
import 'package:com.whitelabel/services/services.dart';
import 'package:com.whitelabel/vendor_plugins/vendor_plugins.dart';
import '../bloc/bloc.dart';
import '../bloc/data.dart';

class ChatFeed extends StatelessWidget {
  const ChatFeed({Key key, @required this.chatGroupId}) : super(key: key);
  final String chatGroupId;
  @override
  Widget build(BuildContext context) {
    return ProxyProvider2<NetworkService, UserService, ChatBloc>(
      builder: (BuildContext _, NetworkService network, UserService user,
              ChatBloc __) =>
          ChatBloc(
        network: network,
        user: user,
        chatGroupId: chatGroupId,
      ),
      child: _ChatFeedView(chatGroupId: chatGroupId),
    );
  }
}

class _ChatFeedView extends StatelessWidget {
  const _ChatFeedView({
    Key key,
    @required this.chatGroupId,
  }) : super(key: key);

  final String chatGroupId;

  @override
  Widget build(BuildContext context) {
    //repos['conversations'].fetch(Id<Conversations>(conversationsId)).first;
    final ChatGroup chatGroup = hiveBox['chatgroup'].get(chatGroupId);
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          title: Text(
            chatGroup.title,
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).cardColor,
            backgroundImage: AssetImage(chatGroup.avatarUrl),
/*             NetworkImage(
              conversation.avatarURL
            ), */
            child: const Text(''),
          ),
        ),
/*         title: FutureBuilder<Conversations>(
          future: repos['conversations']
              .fetch(Id<Conversations>(conversationsId))
              .first,
          builder: (
            BuildContext context,
            AsyncSnapshot<Conversations> snapshot,
          ) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor,
                  ),
                ),
              );
            } else {
              print('BLOR hovez${snapshot.data.id.id} ${snapshot.data.title}');
              return ListTile(
                title: Text(snapshot.data.title),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                    snapshot.data.avatarURL,
                  ),
                  child: const Text(''),
                ),
              );
            }
          },
        ), */
      ),
      body: FutureBuilder<User>(
          future: Provider.of<ChatBloc>(context).getCurrentUser(),
          builder: (BuildContext context, AsyncSnapshot<User> user) {
            if (!user.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor,
                  ),
                ),
              );
            }
            return _ChatFeedBody(
              user: ChatUser(
                name: user.data.name,
                uid: user.data.id.id,
                avatar: user.data.avatarURL,
              ),
              chatGroupId: chatGroupId,
            );
          }),
    );
  }
}

class _ChatFeedBody extends StatefulWidget {
  const _ChatFeedBody({this.user, this.chatGroupId});
  final ChatUser user;
  final String chatGroupId;
  @override
  _ChatFeedBodyState createState() => _ChatFeedBodyState();
}

class _ChatFeedBodyState extends State<_ChatFeedBody> {
  final GlobalKey<DashChatState> _chatViewKey = GlobalKey<DashChatState>();

  @override
  Widget build(BuildContext context) {
    final ChatBloc _chatBloc = Provider.of<ChatBloc>(context);
    return StreamBuilder<Map<int, ChatModel>>(
      stream: _chatBloc.chatScreen,
      builder:
          (BuildContext context, AsyncSnapshot<Map<int, ChatModel>> snapshot) {
        List<ChatMessage> messages = <ChatMessage>[];
        if (!snapshot.hasData) {
/*           return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).primaryColor,
              ),
            ),
          ); */
        } else {
          messages.addAll(snapshot.data.values
              .where((ChatModel chat) => chat.chatGroupId == widget.chatGroupId)
              .map((ChatModel chat) => ChatMessage(
                    id: chat.id.id,
                    text: chat.text,
                    user: ChatUser(
                      uid: chat.user.id.id,
                      name: chat.user.displayName,
                      avatar: chat.user.avatarURL,
                    ),
                    image: chat.attachmentType == AttachmentType.image
                        ? chat.attachmentUrl
                        : null,
                    vedio: chat.attachmentType == AttachmentType.video
                        ? chat.attachmentUrl
                        : null,
                    createdAt: chat.createdAt,
/*                     quickReplies: QuickReplies(
                      values: <Reply>[
                        Reply(
                          title: "😋 Yes",
                          value: "Yes",
                        ),
                        Reply(
                          title: "😞 Nope. What?",
                          value: "no",
                        ),
                      ],
                    ), */
                  ))
              .toList());
        }
/*         if (snapshot.data == null) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).primaryColor,
              ),
            ),
          );
        } */

        return DashChat(
          key: _chatViewKey,
          inverted: false,
/*           messageImageBuilder: (String url) {
            return Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: FadeInImage.assetNetwork(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.7,
                fit: BoxFit.contain,
                placeholder: url,
                image: 'assets/mockData/chats/$url',
              ),
            );
          }, */
          onSend: (ChatMessage message) async {
            await _chatBloc.sendChat(
              ChatModel(
                id: Id<ChatModel>(UniqueKey().toString()),
                uid: Id<User>(widget.user.uid),
                text: message.text,
                createdAt: DateTime.now().toUtc(),
                attachmentType: AttachmentType.none,
                attachmentUrl: '',
                chatGroupId: widget.chatGroupId,
              ),
            );
          },
          user: widget.user,
          inputDecoration:
              const InputDecoration.collapsed(hintText: 'Add message here...'),
          dateFormat: DateFormat('yyyy-MMM-dd'),
          timeFormat: DateFormat('HH:mm'),
          messages: messages,
          showUserAvatar: true,
          showAvatarForEveryMessage: false,
          scrollToBottom: false,
          onPressAvatar: (ChatUser user) {
            print('OnPressAvatar: ${user.name}');
          },
          onLongPressAvatar: (ChatUser user) {
            print('OnLongPressAvatar: ${user.name}');
          },
          inputMaxLines: 5,
          messageContainerPadding: const EdgeInsets.only(left: 5.0, right: 5.0),
          alwaysShowSend: true,
          inputTextStyle: const TextStyle(fontSize: 16.0),
          inputContainerStyle: BoxDecoration(
            border: Border.all(width: 0.0),
            color: Theme.of(context).inputDecorationTheme.fillColor,
          ),
          onQuickReply: (Reply reply) {
            setState(
              () {
                messages.add(
                  ChatMessage(
                      text: reply.value,
                      createdAt: DateTime.now(),
                      user: widget.user),
                );
// ignore: sdk_version_ui_as_code
                messages = <ChatMessage>[...messages];
              },
            );
          },
        );
      },
    );
  }
}
