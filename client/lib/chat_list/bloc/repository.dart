import 'package:meta/meta.dart';
import 'package:repository/repository.dart';

import 'package:com.winwisely99.app/services/services.dart';
import '../bloc/data.dart';
import 'data.dart';

class ConversationsRepository extends CollectionFetcher<Conversations> {
  ConversationsRepository({
    @required this.network,
    @required this.user,
    @required this.globalUser,
  });

  final NetworkService network;
  final UserService user;
  final AuthUserService globalUser;
  @override
  Future<List<Conversations>> downloadAll() async {
    await networkReady;
    final List<Map<String, dynamic>> _dataList = <Map<String, dynamic>>[];
    final User _globalUser = await globalUser.globalUser;

    for (String conversationsId in _globalUser.conversationIds) {
      _dataList.addAll(
        await network.getAllItemForId(
          path: 'conversations',
          field: '_id',
          id: conversationsId,
        ),
      );
    }

    return <Conversations>[
      // ignore: sdk_version_ui_as_code
      for (Map<String, dynamic> data in _dataList)
        Conversations(
          id: Id<Conversations>(data['_id']),
          title: data['title'],
          avatarURL: data['avatarURL'],
          timestamp: DateTime.parse(data['timestamp']),
          members: <User>[
            for (String id in data['membersIds'])
              await user.getUser(Id<User>(id)),
          ],
        ),
    ];
  }
}
