import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:repository/repository.dart';
import 'package:rxdart/rxdart.dart';

import 'package:com.whitelabel/services/services.dart';

import '../bloc/data.dart';

class CampaignBloc {
  CampaignBloc({
    @required this.network,
    @required this.storage,
  }) : assert(network != null) {
    _campaignFetcher.stream
        .transform(_campaignListTransformer())
        .pipe(_campaignOutput);
    _initializeScreen();
  }

  final NetworkService network;
  final StorageService storage;

// Streams for building chatscreen
  final PublishSubject<Campaign> _campaignFetcher = PublishSubject<Campaign>();
  final BehaviorSubject<Map<int, Campaign>> _campaignOutput =
      BehaviorSubject<Map<int, Campaign>>();
// Getter to Stream
  Observable<Map<int, Campaign>> get campaignList => _campaignOutput.stream;
  Function(Campaign) get _addToList => _campaignFetcher.sink.add;

  ScanStreamTransformer<Campaign, Map<int, Campaign>>
      _campaignListTransformer() {
    return ScanStreamTransformer<Campaign, Map<int, Campaign>>(
        (Map<int, Campaign> cache, Campaign value, int index) {
      cache ??= <int, Campaign>{};
      final List<Campaign> _campaignList = <Campaign>[];
      _campaignList.addAll(cache.values);
      _campaignList.add(value);
      _campaignList.sort((Campaign a, Campaign b) => a.when.compareTo(b.when));
      return _campaignList.asMap();
    }, <int, Campaign>{});
  }

  Future<bool> _initializeScreen() async {
    for (MapEntry<dynamic, Campaign> entry
        in storage.hiveBox[Cache.Campaign].toMap().entries) {
      if (entry.value is Campaign) {
        _addToList(entry.value);
      }
    }

    storage.hiveBox[Cache.Campaign].watch().listen((BoxEvent event) async {
      if (event.value is Campaign) {
        _addToList(event.value);
      }
    });
    return true;
  }

  void drain() {
    _campaignFetcher.drain<bool>();
    _campaignOutput.drain<Map<Id<Campaign>, Campaign>>();
  }

  Future<bool> dispose() async {
    await _campaignFetcher.drain<bool>();
    _campaignOutput.drain<Map<Id<Campaign>, Campaign>>();
    _campaignFetcher.close();
    _campaignOutput.close();
    return true;
  }
}
