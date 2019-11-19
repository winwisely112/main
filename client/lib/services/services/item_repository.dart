import 'package:meta/meta.dart';
import 'package:repository/repository.dart';

import 'package:com.winwisely99.app/services/services.dart';
import 'package:com.winwisely99.app/vendor_plugins/vendor_plugins.dart';

class ItemRepository<Entity> extends Repository<Entity> {
  ItemRepository(
      {@required this.network,
      @required this.user,
      @required this.globalUser,
      @required this.source,
      @required this.cache})
      : _repository = CachedRepository<Entity>(
          strategy: CacheStrategy.onlyFetchFromSourceIfNotInCache,
          source: source,
          cache: HiveRepository<Entity>(cache),
        ),
        super(isFinite: true, isMutable: false) {
    _repository.fetchAllItems();
  }
  final NetworkService network;
  final UserService user;
  final AuthUserService globalUser;
  final Repository<Entity> _repository;
  final Repository<Entity> source;
  final String cache;

  @override
  Stream<Entity> fetch(Id<Entity> id) => _repository.fetch(id);

  @override
  Stream<Map<Id<Entity>, Entity>> fetchAll() => _repository.fetchAll();
}
