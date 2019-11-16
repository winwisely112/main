import 'package:meta/meta.dart';
import 'package:hive/hive.dart';
import 'package:repository/repository.dart';
import 'package:rxdart/rxdart.dart';

import 'package:com.winwisely99.app/services/services.dart';
import 'package:com.winwisely99.app/chat_list/chat_list.dart';
import 'package:com.winwisely99.app/vendor_plugins/vendor_plugins.dart';

import 'data.dart';

class ChatBloc {
  ChatBloc(
      {@required this.network,
      @required this.user,
      @required this.conversationsId})
      : assert(network != null),
        assert(user != null) {
    _chatFetcher.stream
        .transform(_chatScreenTransformer())
        .pipe(_chatScreenOutput);
    _initializeScreen();
  }

  final NetworkService network;
  final UserService user;
  final String conversationsId;

// Streams for building chatscreen
  final PublishSubject<ChatModel> _chatFetcher = PublishSubject<ChatModel>();
  final BehaviorSubject<Map<int, ChatModel>> _chatScreenOutput =
      BehaviorSubject<Map<int, ChatModel>>();
// Getter to Stream
  Observable<Map<int, ChatModel>> get chatScreen => _chatScreenOutput.stream;
  Function(ChatModel) get _addChatToScreen => _chatFetcher.sink.add;

  ScanStreamTransformer<ChatModel, Map<int, ChatModel>>
      _chatScreenTransformer() {
    return ScanStreamTransformer<ChatModel, Map<int, ChatModel>>(
        (Map<int, ChatModel> cache, ChatModel value, int index) {
      cache ??= <int, ChatModel>{};
      final List<ChatModel> _chats = <ChatModel>[];
      _chats.addAll(cache.values);
      _chats.add(value);
      _chats.sort(
          (ChatModel a, ChatModel b) => a.createdAt.compareTo(b.createdAt));
      return _chats.asMap();
    }, <int, ChatModel>{});
  }

  Future<bool> _initializeScreen() async {
    for (MapEntry<dynamic, ChatModel> entry
        in hiveBox['chats'].toMap().entries) {
      if (entry.value is ChatModel) {
        _addToStream(entry.value);
      }
    }

    hiveBox['chats'].watch().listen((BoxEvent event) async {
      if (event.value is ChatModel) {
        _addToStream(event.value);
      }
    });
    return true;
  }

  Future<bool> _addToStream(ChatModel chatModel) async {
    if (chatModel.conversationsId == conversationsId) {
      final User _user = await user.getUser(chatModel.uid);
      _addChatToScreen(
        ChatModel(
          id: chatModel.id,
          text: chatModel.text,
          uid: chatModel.uid,
          user: _user,
          createdAt: chatModel.createdAt,
          attachmentType: chatModel.attachmentType,
          attachmentUrl: chatModel.attachmentUrl,
          conversationsId: chatModel.conversationsId,
        ),
      );
    }
    return true;
  }

  Stream<List<ChatModel>> getChats(Id<Conversations> id) async* {
    List<ChatModel> getCurrent() {
      return <ChatModel>[
        // ignore: sdk_version_ui_as_code
        for (MapEntry<dynamic, ChatModel> entry
            in hiveBox['chats'].toMap().entries)
          entry.value.conversationsId == id.id ? entry.value : null
      ];
    }

    yield getCurrent();

    // The following needs to happen in an other microtask. Otherwise, this
    // leads to unexpected behavior:
    // https://github.com/dart-lang/sdk/issues/34685
    await Future<dynamic>.delayed(Duration.zero);
    await for (BoxEvent _ in hiveBox['chats'].watch()) {
      yield getCurrent();
    }
  }

  Future<User> getCurrentUser() async {
    // TODO(Vineeth): Remove this logic later once authentication is complete
    return user.getUser(const Id<User>('A'));
  }

  Future<dynamic> sendChat(ChatModel chat) async {
    hiveBox['chats'].put(chat.id.id, chat);
    network.send(
      MessageHandler<ChatModel>(
        message: chat,
        status: MessageStatus.NEW,
        messageType: MessageType.CHAT,
      ),
    );
  }

  void drain() {
    _chatFetcher.drain<bool>();
    _chatScreenOutput.drain<Map<Id<ChatModel>, ChatModel>>();
  }

  Future<bool> dispose() async {
    await _chatFetcher.drain<bool>();
    _chatScreenOutput.drain<Map<Id<ChatModel>, ChatModel>>();

    _chatFetcher.close();
    _chatScreenOutput.close();

    return true;
  }
}
