import 'package:meta/meta.dart';

// TODO(FlutterDevelopers): Import modules here
import 'package:com.whitelabel/chat_view/chat_view.dart';
import 'package:com.whitelabel/chat_group/chat_group.dart';
import 'package:com.whitelabel/enrollment/enrollment.dart';
import 'package:com.whitelabel/services/services.dart';

class CacheService {
  CacheService({
    @required this.auth,
    @required this.user,
    @required this.network,
  })  : assert(auth != null),
        assert(network != null),
        assert(user != null) {
    repos[Cache.Roles] = ItemRepository<Roles>(
      user: user,
      network: network,
      globalUser: auth,
      source: RolesRepository(
        network: network,
      ),
      cache: Cache.Roles.toString(),
    );
    repos[Cache.Campaign] = ItemRepository<Campaign>(
      user: user,
      network: network,
      globalUser: auth,
      source: CampaignRepository(
        network: network,
      ),
      cache: Cache.Campaign.toString(),
    );
    if (auth != null) {
      // this order is important
      repos[Cache.ChatGroup] = ItemRepository<ChatGroup>(
        user: user,
        network: network,
        globalUser: auth,
        source: ChatGroupRepository(
          user: user,
          network: network,
          globalUser: auth,
        ),
        cache: Cache.ChatGroup.toString(),
      );
      repos[Cache.Chats] = ItemRepository<ChatModel>(
        user: user,
        network: network,
        globalUser: auth,
        source: ChatRepository(
          user: user,
          network: network,
          globalUser: auth,
        ),
        cache: Cache.Chats.toString(),
      );
    }
    cacheServiceReadyCompleter.complete();
  }

  final AuthUserService auth;
  final NetworkService network;
  final UserService user;
  final Map<Cache, ItemRepository<dynamic>> repos =
      <Cache, ItemRepository<dynamic>>{};
}
