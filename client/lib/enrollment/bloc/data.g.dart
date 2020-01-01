// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CampaignAdapter extends TypeAdapter<Campaign> {
  @override
  Campaign read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Campaign(
      actionLength: fields[13] as String,
      actionType: fields[14] as String,
      alreadyPledged: fields[6] as String,
      backingOrg: (fields[15] as List)?.cast<String>(),
      campaignName: fields[1] as String,
      campaignStill: fields[9] as String,
      category: fields[16] as String,
      contact: fields[17] as String,
      crgIdsMany: (fields[5] as List)?.cast<String>(),
      crgQuantityMany: (fields[4] as List)?.cast<String>(),
      goal: fields[3] as String,
      histPrecedents: fields[18] as String,
      id: fields[0] as Id,
      logoUrl: fields[2] as String,
      minStart: fields[10] as String,
      minSocialMedia: fields[11] as String,
      minWin: fields[12] as String,
      organization: fields[19] as String,
      strategy: fields[20] as String,
      uom: fields[22] as String,
      videoURL: (fields[21] as List)?.cast<String>(),
      when: fields[7] as DateTime,
      where: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Campaign obj) {
    writer
      ..writeByte(23)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.campaignName)
      ..writeByte(2)
      ..write(obj.logoUrl)
      ..writeByte(3)
      ..write(obj.goal)
      ..writeByte(4)
      ..write(obj.crgQuantityMany)
      ..writeByte(5)
      ..write(obj.crgIdsMany)
      ..writeByte(6)
      ..write(obj.alreadyPledged)
      ..writeByte(7)
      ..write(obj.when)
      ..writeByte(8)
      ..write(obj.where)
      ..writeByte(9)
      ..write(obj.campaignStill)
      ..writeByte(10)
      ..write(obj.minStart)
      ..writeByte(11)
      ..write(obj.minSocialMedia)
      ..writeByte(12)
      ..write(obj.minWin)
      ..writeByte(13)
      ..write(obj.actionLength)
      ..writeByte(14)
      ..write(obj.actionType)
      ..writeByte(15)
      ..write(obj.backingOrg)
      ..writeByte(16)
      ..write(obj.category)
      ..writeByte(17)
      ..write(obj.contact)
      ..writeByte(18)
      ..write(obj.histPrecedents)
      ..writeByte(19)
      ..write(obj.organization)
      ..writeByte(20)
      ..write(obj.strategy)
      ..writeByte(21)
      ..write(obj.videoURL)
      ..writeByte(22)
      ..write(obj.uom);
  }
}

class RolesAdapter extends TypeAdapter<Roles> {
  @override
  Roles read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Roles(
      id: fields[0] as Id,
      name: fields[4] as String,
      comment: fields[2] as String,
      mandatory: fields[3] as bool,
      description: fields[1] as String,
      uom: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Roles obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.comment)
      ..writeByte(3)
      ..write(obj.mandatory)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.uom);
  }
}
