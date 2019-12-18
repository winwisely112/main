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
    @required this.other,
    @required this.logoUrl,
    @required this.description,
    @required this.crgIdsMany,
    @required this.crgQuantityMany,
    @required this.alreadyPledged,
    @required this.when,
    @required this.where,
  })  : assert(id != null),
        assert(name != null),
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
        other = data['other'];

  @HiveField(0)
  final Id<Campaign> id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String other;

  @HiveField(3)
  final String logoUrl;

  @HiveField(4)
  final String description;

  @HiveField(5)
  final List<String> crgQuantityMany;

  @HiveField(6)
  final List<String> crgIdsMany;

  @HiveField(7)
  final int alreadyPledged;

  @HiveField(8)
  final DateTime when;

  @HiveField(9)
  final String where;
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
