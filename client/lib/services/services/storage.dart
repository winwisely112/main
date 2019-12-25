import 'package:flutter/material.dart' show BuildContext;
import 'package:flutter/services.dart' show rootBundle;
import 'package:hive/hive.dart';
import 'package:repository/repository.dart';
import 'package:provider/provider.dart';

// TODO(FlutterDevelopers): Import modules here
import 'package:com.whitelabel/chat_view/chat_view.dart';
import 'package:com.whitelabel/chat_group/chat_group.dart';
import 'package:com.whitelabel/enrollment/enrollment.dart';
import 'package:com.whitelabel/news/news.dart';
import 'package:com.whitelabel/services/services.dart';
import 'package:com.whitelabel/vendor_plugins/vendor_plugins.dart';

/// A service that offers storage of app-wide data.
class StorageService {
  StorageService() {
    _storage = CachedRepository<StorageData>(
      cache: _inMemory,
      source: HiveRepository<StorageData>('dataStorage'),
    );
  }
  static const Id<StorageData> _dataId = Id<StorageData>('data');

  final InMemoryStorage<StorageData> _inMemory = InMemoryStorage<StorageData>();
  CachedRepository<StorageData> _storage;

  final Map<Cache, Box<dynamic>> hiveBox = <Cache, Box<dynamic>>{};
  String privacyPolicy;

  Future<void> initialize() async {
    await _inMemory.update(_dataId, StorageData());
/*     await _storage.loadItemsIntoCache().whenComplete(() {
      print('${DateTime.now().toUtc().toString()} Complete');
    }).then((void value) {
      print('${DateTime.now().toUtc().toString()} then');
    }).catchError((dynamic e) {
      print('${DateTime.now().toUtc().toString()} Error ${e.toString()}');
    }); */
    // TODO(FlutterDevelopers): Initial Hive store here
    hiveBox[Cache.Chats] =
        await Hive.openBox<ChatModel>(Cache.Chats.toString());
    hiveBox[Cache.News] = await Hive.openBox<News>(Cache.News.toString());
    hiveBox[Cache.Users] = await Hive.openBox<User>(Cache.Users.toString());
    hiveBox[Cache.ChatGroup] =
        await Hive.openBox<ChatGroup>(Cache.ChatGroup.toString());
    hiveBox[Cache.Campaign] =
        await Hive.openBox<Campaign>(Cache.Campaign.toString());
    hiveBox[Cache.Roles] = await Hive.openBox<Roles>(Cache.Roles.toString());
    privacyPolicy = await rootBundle.loadString('assets/commons/privacy.md');
    storageServiceReadyCompleter.complete();
  }

  StorageData get data => _inMemory.get(_dataId);
  Stream<StorageData> get dataStream => _inMemory.fetch(_dataId);
  set data(StorageData data) => _storage.update(_dataId, data);

  String get email => data.email;
  String get token => data.token;
  bool get hasToken => token != null;

  set email(String email) =>
      data = data.copy((MutableStorageData data) => data..email = email);
  set token(String token) =>
      data = data.copy((MutableStorageData data) => data..token = token);

  Future<void> clear() => _storage.clear();

  static StorageService of(BuildContext context) =>
      Provider.of<StorageService>(context);
}
