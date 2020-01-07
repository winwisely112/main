import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:repository/repository.dart';

import 'package:com.whitelabel/services/services.dart';

part 'data.g.dart';

@immutable
@HiveType()
class Campaign implements Entity {
  const Campaign({
    @required this.actionLength,
    @required this.actionType,
    @required this.alreadyPledged,
    @required this.backingOrg,
    @required this.campaignName,
    @required this.campaignStill,
    @required this.category,
    @required this.contact,
    @required this.crgIdsMany,
    @required this.crgQuantityMany,
    @required this.goal,
    @required this.histPrecedents,
    @required this.id,
    @required this.logoUrl,
    @required this.minStart,
    @required this.minSocialMedia,
    @required this.minWin,
    @required this.organization,
    @required this.strategy,
    @required this.uom,
    @required this.videoURL,
    @required this.when,
    @required this.where,
  })  : assert(id != null),
        assert(campaignName != null),
        assert(minStart != null),
        assert(minSocialMedia != null),
        assert(minWin != null),
        assert(when != null),
        assert(where != null),
        assert(alreadyPledged != null),
        assert(logoUrl != null),
        assert(crgQuantityMany != null),
        assert(actionLength != null),
        assert(actionType != null),
        assert(backingOrg != null),
        assert(category != null),
        assert(contact != null),
        assert(goal != null),
        assert(histPrecedents != null),
        assert(organization != null),
        assert(strategy != null),
        assert(videoURL != null),
        assert(uom != null),
        assert(crgIdsMany != null);

  Campaign.fromJson(dynamic data)
      : actionLength = data['action_length'],
        actionType = data['action_type'],
        alreadyPledged = data['already_pledged'],
        backingOrg = data['backing_org'] != null
            ? data['backing_org'].split(',')
            : <String>[],
        campaignName = data['camaign_name'],
        id = Id<Campaign>(data['campaign_id']),
        campaignStill = data['campaign_still'],
        category = data['catagory'],
        contact = data['contact'],
        crgIdsMany = data['crg_ids_many'] != null
            ? data['crg_ids_many'].split(',')
            : <String>[],
        crgQuantityMany = data['crg_quantity_many'] != null
            ? data['crg_quantity_many'].split(',')
            : <int>[],
        when = DateTime.parse(data['datetime']),
        goal = data['goal'],
        histPrecedents = data['historical_precedents'],
        where = data['location'],
        logoUrl = data['logo_url'],
        minSocialMedia = data['mass_media'],
        organization = data['organization'],
        minStart = data['start'],
        strategy = data['strategy'],
        uom = data['uom'],
        videoURL = data['video_url'] != null
            ? data['video_url'].split(',')
            : <String>[],
        minWin = data['win'];

  @HiveField(0)
  final Id<Campaign> id;

  @HiveField(1)
  final String campaignName;

  @HiveField(2)
  final String logoUrl;

  @HiveField(3)
  final String goal;

  @HiveField(4)
  final List<String> crgQuantityMany;

  @HiveField(5)
  final List<String> crgIdsMany;

  @HiveField(6)
  final String alreadyPledged;

  @HiveField(7)
  final DateTime when;

  @HiveField(8)
  final String where;

  @HiveField(9)
  final String campaignStill;

  @HiveField(10)
  final String minStart;

  @HiveField(11)
  final String minSocialMedia;

  @HiveField(12)
  final String minWin;

  @HiveField(13)
  final String actionLength;

  @HiveField(14)
  final String actionType;

  @HiveField(15)
  final List<String> backingOrg;

  @HiveField(16)
  final String category;

  @HiveField(17)
  final String contact;

  @HiveField(18)
  final String histPrecedents;

  @HiveField(19)
  final String organization;

  @HiveField(20)
  final String strategy;

  @HiveField(21)
  final List<String> videoURL;

  @HiveField(22)
  final String uom;
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
        mandatory = data['mandatory'] == '1' ? true : false;

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
