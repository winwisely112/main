import 'package:meta/meta.dart';

import 'package:com.whitelabel/services/services.dart';

import 'data.dart';

class RolesRepository extends CollectionFetcher<Roles> {
  RolesRepository({
    @required this.network,
  });

  final NetworkService network;

  @override
  Future<List<Roles>> downloadAll() async {
    await networkReady;
    final List<Map<String, dynamic>> dataList =
        await network.getAllItem(path: 'roles');
    return <Roles>[
      // ignore: sdk_version_ui_as_code
      for (dynamic data in dataList) Roles.fromJson(data)
    ];
  }
}

class CampaignRepository extends CollectionFetcher<Campaign> {
  CampaignRepository({
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
