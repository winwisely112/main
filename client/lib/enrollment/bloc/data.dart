import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:repository/repository.dart';

import 'package:com.whitelabel/services/services.dart';

part 'data.g.dart';

@immutable
@HiveType()
class Campaign implements Entity {
  const Campaign({
    @required this.id,
    @required this.name,
    @required this.logoUrl,
    @required this.description,
    @required this.crgIdsMany,
    @required this.crgQuantityMany,
    @required this.alreadyPledged,
    @required this.when,
    @required this.where,
    @required this.campaignStill,
    @required this.minStart,
    @required this.minSocialMedia,
    @required this.minWin,
  })  : assert(id != null),
        assert(name != null),
        assert(campaignStill != null),
        assert(minStart != null),
        assert(minSocialMedia != null),
        assert(minWin != null),
        assert(when != null),
        assert(where != null),
        assert(alreadyPledged != null),
        assert(logoUrl != null),
        assert(description != null),
        assert(crgQuantityMany != null),
        assert(crgIdsMany != null);

  Campaign.fromJson(dynamic data)
      : id = Id<Campaign>(data['campaign_id']),
        crgIdsMany = data['crg_ids_many'] != null
            ? data['crg_ids_many'].split(',')
            : <String>[],
        crgQuantityMany = data['crg_quantity_many'] != null
            ? data['crg_quantity_many'].split(',')
            : <int>[],
        description = data['description'],
        logoUrl = data['logo_url'],
        name = data['name'],
        where = data['location'],
        when = DateTime.parse(data['datetime']),
        alreadyPledged =
            int.parse(data['already_pledged'].replaceAll(RegExp(','), '')),
        minSocialMedia = int.parse(data['mass_media']),
        minStart = int.parse(data['start']),
        minWin = int.parse(data['win']),
        campaignStill = data['campaign_still'];

  @HiveField(0)
  final Id<Campaign> id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String logoUrl;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final List<String> crgQuantityMany;

  @HiveField(5)
  final List<String> crgIdsMany;

  @HiveField(6)
  final int alreadyPledged;

  @HiveField(7)
  final DateTime when;

  @HiveField(8)
  final String where;

  @HiveField(9)
  final String campaignStill;

  @HiveField(10)
  final int minStart;

  @HiveField(11)
  final int minSocialMedia;

  @HiveField(12)
  final int minWin;
}

@immutable
@HiveType()
class Roles implements Entity {
  const Roles({
    @required this.id,
    @required this.name,
    @required this.comment,
    @required this.mandatory,
    @required this.description,
    @required this.uom,
  })  : assert(id != null),
        assert(name != null),
        assert(comment != null),
        assert(mandatory != null),
        assert(description != null),
        assert(uom != null);

  Roles.fromJson(dynamic data)
      : id = Id<Roles>(data['id']),
        description = data['description'],
        comment = data['comment'],
        name = data['name'],
        uom = data['uom'],
        mandatory = data['mandatory'] == 1 ? true : false;

  @HiveField(0)
  final Id<Roles> id;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final String comment;

  @HiveField(3)
  final bool mandatory;

  @HiveField(4)
  final String name;

  @HiveField(5)
  final String uom;
}
