import 'package:flutter/material.dart';
import '../bloc/data.dart';

class AvatarLoader extends StatelessWidget {
  const AvatarLoader({Key key, this.future}) : super(key: key);
  final Future<User> future;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        if (!snapshot.hasData) {
          return const CircleAvatar(
            backgroundImage: AssetImage('assets/commons/avatar.jpg'),
          );
        }
        if (snapshot.data == null) {
          return const CircleAvatar(
            backgroundImage: AssetImage('assets/commons/avatar.jpg'),
          );
        }
        if (snapshot.data.avatarURL == null) {
          return const CircleAvatar(
            backgroundImage: AssetImage('assets/commons/avatar.jpg'),
          );
        }
        if (snapshot.data.avatarURL.isEmpty) {
          return const CircleAvatar(
            backgroundImage: AssetImage('assets/commons/avatar.jpg'),
          );
        }

        return CircleAvatar(
          backgroundImage: AssetImage(snapshot.data.avatarURL),
        );
      },
    );
  }
}
