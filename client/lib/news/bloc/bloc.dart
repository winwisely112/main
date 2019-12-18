import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:repository/repository.dart';

import 'package:com.whitelabel/services/services.dart';
import 'package:com.whitelabel/vendor_plugins/vendor_plugins.dart';

import '../bloc/data.dart';

class NewsBloc {
  NewsBloc({
    @required this.network,
    @required this.user,
    @required this.storage,
  })  : assert(network != null),
        assert(user != null),
        _news = CachedRepository<News>(
          strategy: CacheStrategy.onlyFetchFromSourceIfNotInCache,
          source: _NewsDownloader(network: network, user: user),
          cache: HiveRepository<News>(Cache.News.toString()),
        );
  final NetworkService network;
  final UserService user;
  final StorageService storage;
  final Repository<News> _news;
  Stream<List<News>> getNews() => _news.fetchAllItems();
  Future<News> getNewsId(String id) => _news.fetch(Id<News>(id)).first;
}

class _NewsDownloader extends CollectionFetcher<News> {
  _NewsDownloader({
    @required this.network,
    @required this.user,
  });
  final NetworkService network;
  final UserService user;
  @override
  Future<List<News>> downloadAll() async {
    await networkReady;
    final List<Map<String, dynamic>> dataList =
        await network.getAllItem(path: 'news');
    return <News>[
      // ignore: sdk_version_ui_as_code
      for (dynamic data in dataList)
        News(
          id: Id<News>(data['_id']),
          title: data['title'],
          text: data['text'],
          thumbnailUrl: data['thumbnail_url'],
          timestamp: DateTime.parse(data['timestamp']),
          createdBy: await user.getUser(Id<User>(data['user_id'])),
        ),
    ];
  }
}
