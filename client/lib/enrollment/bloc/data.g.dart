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
      id: fields[0] as Id,
      name: fields[1] as String,
      logoUrl: fields[2] as String,
      description: fields[3] as String,
      crgIdsMany: (fields[5] as List)?.cast<String>(),
      crgQuantityMany: (fields[4] as List)?.cast<String>(),
      alreadyPledged: fields[6] as int,
      when: fields[7] as DateTime,
      where: fields[8] as String,
      campaignStill: fields[9] as String,
      minStart: fields[10] as int,
      minSocialMedia: fields[11] as int,
      minWin: fields[12] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Campaign obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.logoUrl)
      ..writeByte(3)
      ..write(obj.description)
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
      ..write(obj.minWin);
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
