import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:repository/repository.dart';

import '../utils/utils.dart';

part 'data.g.dart';

@immutable
@HiveType()
class User implements Entity {
  User({
    @required this.id,
    @required this.firstName,
    @required this.lastName,
    @required this.email,
    @required this.displayName,
    @required this.avatarURL,
    this.chatGroupIds,
    this.campaignIds,
  })  : assert(id != null),
        assert(firstName != null),
        assert(lastName != null),
        assert(email != null),
        assert(displayName != null);

  @HiveField(0)
  final Id<User> id;

  @HiveField(1)
  final String firstName;

  @HiveField(2)
  final String lastName;

  @HiveField(3)
  final String email;

  @HiveField(4)
  final String displayName;

  @HiveField(5)
  final String avatarURL;

  @HiveField(6)
  final List<String> chatGroupIds;

  @HiveField(7)
  List<String> campaignIds;

  String get name => '$firstName $lastName';
  String get shortName => '${firstName[0]}. $lastName';
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id.toString(),
      'avatar_url': avatarURL,
      'chatgroup_ids': chatGroupIds.isEmpty ? '' : chatGroupIds.join(','),
      'campaign_ids': campaignIds.isEmpty ? '' : campaignIds.join(','),
      'displayName': displayName,
      'email': email,
      'firstName': firstName,
      'lastName': lastName
    };
  }
}

/// App-wide data to be stored by the [StorageService].
@HiveType()
class StorageData {
  StorageData({
    this.email,
    this.token,
  });

  StorageData copy(
      MutableStorageData Function(MutableStorageData data) builder) {
    final MutableStorageData data = builder(
      MutableStorageData()
        ..email = email
        ..token = token,
    );
    return StorageData(
      email: data.email,
      token: data.token,
    );
  }

  @HiveField(0)
  final String email;

  @HiveField(1)
  final String token;
}

class MutableStorageData {
  String email;
  String token;
}
