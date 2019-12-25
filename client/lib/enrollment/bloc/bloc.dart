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
    @required this.showMyCampaigns,
    @required this.globalUser,
  }) : assert(network != null) {
    _campaignFetcher.stream
        .transform(_campaignListTransformer())
        .pipe(_campaignOutput);
    _initializeScreen();
  }

  final NetworkService network;
  final StorageService storage;
  final AuthUserService globalUser;
  final bool showMyCampaigns;

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
    final User _globalUser = await globalUser.globalUser;
    for (MapEntry<dynamic, Campaign> entry
        in storage.hiveBox[Cache.Campaign].toMap().entries) {
      if (entry.value is Campaign) {
        if (showMyCampaigns) {
          if (_globalUser.campaignIds != null) {
            final Campaign _campaign = entry.value;
            if (_globalUser.campaignIds.contains(_campaign.id.toString())) {
              _addToList(entry.value);
            }
          }
        } else {
          if (_globalUser.campaignIds != null) {
            final Campaign _campaign = entry.value;
            if (!_globalUser.campaignIds.contains(_campaign.id.toString())) {
              _addToList(entry.value);
            }
          } else {
            _addToList(entry.value);
          }
        }
      }
    }

    storage.hiveBox[Cache.Campaign].watch().listen((BoxEvent event) async {
      if (event.value is Campaign) {
        if (showMyCampaigns) {
          if (_globalUser.campaignIds != null) {
            final Campaign _campaign = event.value;
            if (_globalUser.campaignIds.contains(_campaign.id.toString())) {
              _addToList(event.value);
            }
          }
        } else {
          if (_globalUser.campaignIds != null) {
            final Campaign _campaign = event.value;
            if (!_globalUser.campaignIds.contains(_campaign.id.toString())) {
              _addToList(event.value);
            }
          } else {
            _addToList(event.value);
          }
        }
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
