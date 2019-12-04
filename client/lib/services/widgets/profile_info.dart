import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../bloc/data.dart';
import '../services/auth_user_service.dart';

class ProfileInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthUserService _user = Provider.of<AuthUserService>(context);
    return FutureBuilder<User>(
        future: _user.globalUser,
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          return Container(
            width: 260,
            height: double.infinity,
            color: Theme.of(context).colorScheme.primary,
            child: SingleChildScrollView(
              child: Column(children: <Widget>[
                const SizedBox(height: 8),
                AvatarGlow(
                  endRadius: 80.0,
                  duration: const Duration(milliseconds: 2000),
                  repeat: true,
                  repeatPauseDuration: const Duration(milliseconds: 100),
                  child: Material(
                    elevation: 8.0,
                    shape: const CircleBorder(),
                    color: Colors.transparent,
                    child: CircleAvatar(
                      backgroundImage: !snapshot.hasData
                          ? const AssetImage('assets/commons/avatar.jpg')
                          : AssetImage(snapshot.data.avatarURL),
                      radius: 40.0,
                    ),
                  ),
                ),
                Text(
                  !snapshot.hasData ? 'John Doe' : snapshot.data.displayName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      !snapshot.hasData
                          ? 'john.doe@email.com'
                          : snapshot.data.email,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                ListTile(
                  title: const Text('Sign Out'),
                  onTap: () {
                    Navigator.of(context).pushNamed('/signout');
                  },
                ),
              ]),
            ),
          );
        });
  }
}
