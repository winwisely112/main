import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:repository/repository.dart';

import 'package:com.winwisely99.app/services/services.dart';
import 'package:com.winwisely99.app/vendor_plugins/vendor_plugins.dart';

import '../bloc/data.dart';

class CampaignBloc {
  CampaignBloc({
    @required this.network,
  })  : assert(network != null),
        _news = CachedRepository<Campaign>(
          //strategy: CacheStrategy.onlyFetchFromSourceIfNotInCache,
          source: _CampaignDownloader(network: network),
          cache: HiveRepository<Campaign>('campaign'),
        );
  final NetworkService network;

  final Repository<Campaign> _news;
  Stream<List<Campaign>> getCampaign() => _news.fetchAllItems();
  Future<Campaign> getCampaignId(String id) =>
      _news.fetch(Id<Campaign>(id)).first;
}

class _CampaignDownloader extends CollectionFetcher<Campaign> {
  _CampaignDownloader({
    @required this.network,
  });
  final NetworkService network;
  @override
  Future<List<Campaign>> downloadAll() async {
    await networkReady;
    final List<Map<String, dynamic>> dataList =
        await network.getAllItem(path: 'campaign');
    return <Campaign>[
      // ignore: sdk_version_ui_as_code
      for (dynamic data in dataList) Campaign.fromJson(data)
    ];
  }
}
