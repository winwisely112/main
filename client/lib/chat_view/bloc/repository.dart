import 'package:meta/meta.dart';
import 'package:repository/repository.dart';

import 'package:com.winwisely99.app/services/services.dart';

import 'data.dart';

class ChatRepository extends CollectionFetcher<ChatModel> {
  ChatRepository({
    @required this.network,
    @required this.user,
    @required this.globalUser,
  });

  final NetworkService network;
  final UserService user;
  final AuthUserService globalUser;
  @override
  Future<List<ChatModel>> downloadAll() async {
    await networkReady;
    final List<Map<String, dynamic>> _dataList = <Map<String, dynamic>>[];
    final User _globalUser = await globalUser.globalUser;

    for (String chatGroupId in _globalUser.chatGroupIds) {
      _dataList.addAll(
        await network.getAllItemForId(
          path: 'chats',
          field: 'chatgroup_id',
          id: chatGroupId,
        ),
      );
    }

    return <ChatModel>[
      // ignore: sdk_version_ui_as_code
      for (dynamic data in _dataList)
        ChatModel(
          id: Id<ChatModel>(data['_id']),
          text: data['text'],
          uid: Id<User>(data['user_id']),
          user: await user.getUser(Id<User>(data['user_id'])),
          createdAt: DateTime.parse(data['created_at']),
          attachmentType: getAttachmentType(data['attachment_type']),
          attachmentUrl: data['attachment_url'],
          chatGroupId: data['chatgroup_id'],
        ),
    ];
  }
}

AttachmentType getAttachmentType(String attachmentType) {
  AttachmentType type;
  switch (attachmentType) {
    case 'image':
      type = AttachmentType.image;
      break;
    case 'file':
      type = AttachmentType.file;
      break;
    case 'video':
      type = AttachmentType.video;
      break;
    case 'geolocation':
      type = AttachmentType.geolocation;
      break;
    case 'calender':
      type = AttachmentType.calender;
      break;
    default:
      return AttachmentType.none;
  }
  return type;
}
