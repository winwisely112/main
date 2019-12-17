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
      other: fields[2] as String,
      logoUrl: fields[3] as String,
      description: fields[4] as String,
      crgIdsMany: (fields[6] as List)?.cast<String>(),
      crgQuantityMany: (fields[5] as List)?.cast<String>(),
      alreadyPledged: fields[7] as int,
      when: fields[8] as DateTime,
      where: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Campaign obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.other)
      ..writeByte(3)
      ..write(obj.logoUrl)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.crgQuantityMany)
      ..writeByte(6)
      ..write(obj.crgIdsMany)
      ..writeByte(7)
      ..write(obj.alreadyPledged)
      ..writeByte(8)
      ..write(obj.when)
      ..writeByte(9)
      ..write(obj.where);
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
