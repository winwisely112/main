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
          return CircleAvatar(
            backgroundColor: Theme.of(context).cardColor,
            backgroundImage: const AssetImage('assets/commons/avatar.jpg'),
          );
        }
        if (snapshot.data == null) {
          return CircleAvatar(
            backgroundColor: Theme.of(context).cardColor,
            backgroundImage: const AssetImage('assets/commons/avatar.jpg'),
          );
        }
        if (snapshot.data.avatarURL == null) {
          return CircleAvatar(
            backgroundColor: Theme.of(context).cardColor,
            backgroundImage: const AssetImage('assets/commons/avatar.jpg'),
          );
        }
        if (snapshot.data.avatarURL.isEmpty) {
          return CircleAvatar(
            backgroundColor: Theme.of(context).cardColor,
            backgroundImage: const AssetImage('assets/commons/avatar.jpg'),
          );
        }

        return CircleAvatar(
          backgroundColor: Theme.of(context).cardColor,
          backgroundImage: AssetImage(snapshot.data.avatarURL),
        );
      },
    );
  }
}
