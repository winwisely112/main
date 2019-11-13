import 'package:meta/meta.dart';
import 'package:repository/repository.dart';

import 'package:com.winwisely99.app/chat_list/chat_list.dart';
import 'package:com.winwisely99.app/services/services.dart';
import 'package:com.winwisely99.app/vendor_plugins/vendor_plugins.dart';

import 'data.dart';

abstract class ItemRepository extends Repository<Entity> {
  ItemRepository(
      {@required this.network,
      @required this.user,
      @required this.globalUser,
      @required this.cache})
      : _repository = CachedRepository<Entity>(
          strategy: CacheStrategy.onlyFetchFromSourceIfNotInCache,
          source: _ChatFetcher(
            network: network,
            user: user,
            globalUser: globalUser,
          ),
          cache: cache,
        );
  final NetworkService network;
  final UserService user;
  final AuthUserService globalUser;
  final Repository<Entity> _repository;
  final HiveRepository<Entity> cache;
  @override
  Stream<Entity> fetch(Id<Entity> id) => _repository.fetch(id);
}

class ChatRepository extends Repository<ChatModel> {
  ChatRepository({
    @required this.network,
    @required this.user,
    @required this.globalUser,
  })  : _repository = CachedRepository<ChatModel>(
          strategy: CacheStrategy.onlyFetchFromSourceIfNotInCache,
          source: _ChatFetcher(
            network: network,
            user: user,
            globalUser: globalUser,
          ),
          cache: HiveRepository<ChatModel>('chats'),
        ),
        super(isFinite: true, isMutable: false) {
    _repository.fetchAllItems();
  }

  final NetworkService network;
  final UserService user;
  final AuthUserService globalUser;
  final Repository<ChatModel> _repository;

  @override
  Stream<ChatModel> fetch(Id<ChatModel> id) => _repository.fetch(id);
}

class _ChatFetcher extends CollectionFetcher<ChatModel> {
  _ChatFetcher({
    @required this.network,
    @required this.user,
    @required this.globalUser,
  });

  final NetworkService network;
  final UserService user;
  final AuthUserService globalUser;
  @override
  Future<List<ChatModel>> downloadAll() async {
    final List<Map<String, dynamic>> _dataList = <Map<String, dynamic>>[];
    final User _globalUser = await globalUser.globalUser;

    for (String conversationsId in _globalUser.conversationIds) {
      _dataList.addAll(
        await network.getAllItemForId(
          path: 'chats',
          field: 'conversationsId',
          id: conversationsId,
        ),
      );
    }

    return <ChatModel>[
      // ignore: sdk_version_ui_as_code
      for (dynamic data in _dataList)
        ChatModel(
          id: Id<ChatModel>(data['_id']),
          text: data['text'],
          uid: Id<User>(data['uid']),
          user: await user.getUser(Id<User>(data['uid'])),
          createdAt: DateTime.parse(data['createdAt']),
          attachmentType: getAttachmentType(data['attachmentType']),
          attachmentUrl: data['attachmentUrl'],
          conversationsId: data['conversationsId'],
        ),
    ];
  }
}

AttachmentType getAttachmentType(String attachmentType) {
  AttachmentType type;
  switch (attachmentType) {
    case 'image':
      type = AttachmentType.image;
      break;
    case 'file':
      type = AttachmentType.file;
      break;
    case 'video':
      type = AttachmentType.video;
      break;
    case 'geolocation':
      type = AttachmentType.geolocation;
      break;
    case 'calender':
      type = AttachmentType.calender;
      break;
    default:
      return AttachmentType.none;
  }
  return type;
}
