// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatGroupAdapter extends TypeAdapter<ChatGroup> {
  @override
  ChatGroup read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatGroup(
      id: fields[0] as Id,
      title: fields[1] as String,
      members: (fields[2] as List)?.cast<User>(),
      avatarUrl: fields[3] as String,
      timestamp: fields[4] as DateTime,
      memberIds: (fields[5] as List)?.cast<Id>(),
      lastChat: fields[6] as ChatModel,
      ownerUid: fields[7] as Id,
      owner: fields[8] as User,
    );
  }

  @override
  void write(BinaryWriter writer, ChatGroup obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.members)
      ..writeByte(3)
      ..write(obj.avatarUrl)
      ..writeByte(4)
      ..write(obj.timestamp)
      ..writeByte(5)
      ..write(obj.memberIds)
      ..writeByte(6)
      ..write(obj.lastChat)
      ..writeByte(7)
      ..write(obj.ownerUid)
      ..writeByte(8)
      ..write(obj.owner);
  }
}
