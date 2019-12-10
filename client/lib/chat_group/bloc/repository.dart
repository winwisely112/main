import 'package:meta/meta.dart';
import 'package:repository/repository.dart';

import 'package:com.whitelabel/services/services.dart';
import '../bloc/data.dart';
import 'data.dart';

class ChatGroupRepository extends CollectionFetcher<ChatGroup> {
  ChatGroupRepository({
    @required this.network,
    @required this.user,
    @required this.globalUser,
  });

  final NetworkService network;
  final UserService user;
  final AuthUserService globalUser;
  @override
  Future<List<ChatGroup>> downloadAll() async {
    await networkReady;
    final List<Map<String, dynamic>> _dataList = <Map<String, dynamic>>[];
    final User _globalUser = await globalUser.globalUser;

    for (String chatGroupId in _globalUser.chatGroupIds) {
      _dataList.addAll(
        await network.getAllItemForId(
          path: 'chatgroup',
          field: '_id',
          id: chatGroupId,
        ),
      );
    }
/*     _dataList.addAll(
      await network.getAllItemForId(
        path: 'chatgroup',
        field: 'member_ids',
        id: _globalUser.id.id,
      ),
    ); */

    return <ChatGroup>[
      // ignore: sdk_version_ui_as_code
      for (Map<String, dynamic> data in _dataList)
        ChatGroup(
          id: Id<ChatGroup>(data['_id']),
          title: data['title'],
          avatarUrl: data['avatar_url'],
          timestamp: DateTime.parse(data['timestamp']),
          memberIds: _getMemberIDs(data['member_ids']),
          members: <User>[
            for (String id in _getMemberIDs(data['member_ids']))
              await user.getUser(Id<User>(id)),
          ],
          ownerUid: Id<User>(data['owner_uid']),
          owner: await user.getUser(Id<User>(data['owner_uid'])),
        ),
    ];
  }

  List<String> _getMemberIDs(String data) {
    final List<String> _list = data == null ? <String>[] : data.split(',');
    _list.removeWhere((String item) => item.isEmpty);
    return _list;
  }
}
