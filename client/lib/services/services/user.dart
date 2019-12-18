import 'package:meta/meta.dart';
import 'package:repository/repository.dart';

import 'package:com.whitelabel/vendor_plugins/vendor_plugins.dart';
import '../bloc/data.dart';
import '../services.dart';
import 'network.dart';

/// A service that offers retrieval and storage of users.
class UserService {
  UserService({@required this.network})
      : assert(network != null),
        _storage = CachedRepository<User>(
          source: _UserDownloader(network: network),
          cache: HiveRepository<User>(Cache.Users.toString()),
        ) {
    userServiceReadyCompleter.complete();
  }

  final NetworkService network;

  final Repository<User> _storage;

  Future<User> getUser(Id<User> id) => _storage.fetch(id).first;
}

class _UserDownloader extends CollectionFetcher<User> {
  _UserDownloader({@required this.network});
  //: assert(network != null),
  //  super(isFinite: false, isMutable: false);

  final NetworkService network;

  @override
  Future<List<User>> downloadAll() async {
    await networkReady;

    final List<Map<String, dynamic>> _dataList =
        await network.getAllItem(path: 'users');

    return <User>[
      // ignore: sdk_version_ui_as_code
      for (Map<String, dynamic> data in _dataList)
        User(
          id: Id<User>(data['_id']),
          firstName: data['firstName'],
          lastName: data['lastName'],
          email: data['email'],
          displayName: data['displayName'],
          avatarURL: data['avatar_url'],
          chatGroupIds: <String>[
            for (dynamic item in _getMemberIDs(data['chatgroup_ids']))
              item.toString()
          ],
        ),
    ];
  }

  @override
  Stream<User> fetch(Id<User> id) async* {
    await networkReady;
    final Map<String, dynamic> data =
        await network.getItem(path: 'users', id: id.id);

    yield User(
      id: Id<User>(data['_id']),
      firstName: data['firstName'],
      lastName: data['lastName'],
      email: data['email'],
      displayName: data['displayName'],
      avatarURL: data['avatar_url'],
      chatGroupIds: <String>[
        for (dynamic item in _getMemberIDs(data['chatgroup_ids']))
          item.toString()
      ],
    );
  }

  List<String> _getMemberIDs(String data) {
    final List<String> _list = data == null ? <String>[] : data.split(',');
    _list.removeWhere((String item) => item.isEmpty);
    return _list;
  }
}
