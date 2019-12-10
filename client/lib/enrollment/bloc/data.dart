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
  })  : assert(id != null),
        assert(name != null),
        assert(other != null),
        assert(logoUrl != null),
        assert(description != null),
        assert(crgQuantityMany != null),
        assert(crgIdsMany != null);

  Campaign.fromJson(dynamic data)
      : id = Id<Campaign>(data['_id']),
        crgIdsMany = data['crg_ids_many'] != null
            ? data['crg_ids_many'].split(',')
            : <String>[],
        crgQuantityMany = data['crg_quantity_many'] != null
            ? data['crg_quantity_many'].split(',')
            : <int>[],
        description = data['description'],
        logoUrl = data['logo_url'],
        name = data['name'],
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
}
