import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:repository/repository.dart';

import 'package:com.winwisely99.app/services/services.dart';
import 'package:com.winwisely99.app/chat_view/chat_view.dart';

part 'data.g.dart';

@immutable
@HiveType()
class ChatGroup implements Entity {
  const ChatGroup({
    @required this.id,
    @required this.title,
    @required this.members,
    @required this.avatarUrl,
    @required this.timestamp,
    this.memberIds,
    this.lastChat,
    @required this.ownerUid,
    this.owner,
  })  : assert(id != null),
        assert(title != null),
        assert(members != null),
        assert(timestamp != null),
        assert(ownerUid != null),
        assert(avatarUrl != null);
  @HiveField(0)
  final Id<ChatGroup> id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final List<User> members;

  @HiveField(3)
  final String avatarUrl;

  @HiveField(4)
  final DateTime timestamp;

  @HiveField(5)
  final List<Id<User>> memberIds;

  @HiveField(6)
  final ChatModel lastChat;

  @HiveField(7)
  final Id<User> ownerUid;

  @HiveField(8)
  final User owner;
}
