import 'package:meta/meta.dart';
import 'package:hive/hive.dart';
import 'package:repository/repository.dart';
import 'package:rxdart/rxdart.dart';

import 'package:com.winwisely99.app/services/services.dart';

import '../bloc/data.dart';
import 'data.dart';

class ChatGroupBloc {
  ChatGroupBloc({
    @required this.network,
    @required this.user,
  })  : assert(network != null),
        assert(user != null) {
    _chatGroupFetcher.stream
        .transform(_chatListTransformer())
        .pipe(_chatGroupOutput);
    _initializeScreen();
  }

  final NetworkService network;
  final UserService user;

// Streams for building chatscreen
  final PublishSubject<ChatGroup> _chatGroupFetcher =
      PublishSubject<ChatGroup>();
  final BehaviorSubject<Map<int, ChatGroup>> _chatGroupOutput =
      BehaviorSubject<Map<int, ChatGroup>>();
// Getter to Stream
  Observable<Map<int, ChatGroup>> get chatList => _chatGroupOutput.stream;
  Function(ChatGroup) get _addToList => _chatGroupFetcher.sink.add;

  ScanStreamTransformer<ChatGroup, Map<int, ChatGroup>> _chatListTransformer() {
    return ScanStreamTransformer<ChatGroup, Map<int, ChatGroup>>(
        (Map<int, ChatGroup> cache, ChatGroup value, int index) {
      cache ??= <int, ChatGroup>{};
      final List<ChatGroup> _chatList = <ChatGroup>[];
      _chatList.addAll(cache.values);
      _chatList.add(value);
      return _chatList.asMap();
    }, <int, ChatGroup>{});
  }

  Future<bool> _initializeScreen() async {
    for (MapEntry<dynamic, ChatGroup> entry
        in hiveBox['chatgroup'].toMap().entries) {
      if (entry.value is ChatGroup) {
        _addToList(entry.value);
      }
    }

    hiveBox['chatgroup'].watch().listen((BoxEvent event) async {
      if (event.value is ChatGroup) {
        _addToList(event.value);
      }
    });
    return true;
  }

  void drain() {
    _chatGroupFetcher.drain<bool>();
    _chatGroupOutput.drain<Map<Id<ChatGroup>, ChatGroup>>();
  }

  Future<bool> dispose() async {
    await _chatGroupFetcher.drain<bool>();
    _chatGroupOutput.drain<Map<Id<ChatGroup>, ChatGroup>>();
    _chatGroupFetcher.close();
    _chatGroupOutput.close();
    return true;
  }
}
