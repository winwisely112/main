import 'package:meta/meta.dart';
import 'package:hive/hive.dart';
import 'package:repository/repository.dart';
import 'package:rxdart/rxdart.dart';

import 'package:com.winwisely99.app/services/services.dart';

import '../bloc/data.dart';
import 'data.dart';

class ConversationsBloc {
  ConversationsBloc({
    @required this.network,
    @required this.user,
  })  : assert(network != null),
        assert(user != null) {
    _conversationsFetcher.stream
        .transform(_chatListTransformer())
        .pipe(_conversationsOutput);
    _initializeScreen();
  }

  final NetworkService network;
  final UserService user;

// Streams for building chatscreen
  final PublishSubject<Conversations> _conversationsFetcher =
      PublishSubject<Conversations>();
  final BehaviorSubject<Map<int, Conversations>> _conversationsOutput =
      BehaviorSubject<Map<int, Conversations>>();
// Getter to Stream
  Observable<Map<int, Conversations>> get chatList =>
      _conversationsOutput.stream;
  Function(Conversations) get _addToList => _conversationsFetcher.sink.add;

  ScanStreamTransformer<Conversations, Map<int, Conversations>>
      _chatListTransformer() {
    return ScanStreamTransformer<Conversations, Map<int, Conversations>>(
        (Map<int, Conversations> cache, Conversations value, int index) {
      cache ??= <int, Conversations>{};
      final List<Conversations> _chatList = <Conversations>[];
      _chatList.addAll(cache.values);
      _chatList.add(value);
      return _chatList.asMap();
    }, <int, Conversations>{});
  }

  Future<bool> _initializeScreen() async {
    for (MapEntry<dynamic, Conversations> entry
        in hiveBox['conversations'].toMap().entries) {
      if (entry.value is Conversations) {
        _addToList(entry.value);
      }
    }

    hiveBox['conversations'].watch().listen((BoxEvent event) async {
      if (event.value is Conversations) {
        _addToList(event.value);
      }
    });
    return true;
  }

  void drain() {
    _conversationsFetcher.drain<bool>();
    _conversationsOutput.drain<Map<Id<Conversations>, Conversations>>();
  }

  Future<bool> dispose() async {
    await _conversationsFetcher.drain<bool>();
    _conversationsOutput.drain<Map<Id<Conversations>, Conversations>>();
    _conversationsFetcher.close();
    _conversationsOutput.close();
    return true;
  }
}
