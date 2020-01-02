import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

import '../bloc/data.dart';
import '../services/auth_user_service.dart';

class ProfileInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthUserService _user = Provider.of<AuthUserService>(context);
    return Drawer(
      child: FutureBuilder<User>(
          future: _user.globalUser,
          builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
            return Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: <Widget>[
                          const SizedBox(height: 8),
                          AvatarGlow(
                            endRadius: 80.0,
                            duration: const Duration(milliseconds: 2000),
                            repeat: true,
                            repeatPauseDuration:
                                const Duration(milliseconds: 100),
                            child: Material(
                              elevation: 8.0,
                              shape: const CircleBorder(),
                              color: Colors.transparent,
                              child: CircleAvatar(
                                backgroundColor: Theme.of(context).cardColor,
                                //backgroundColor:
                                //    Theme.of(context).colorScheme.primary,
                                backgroundImage: !snapshot.hasData
                                    ? const AssetImage(
                                        'assets/commons/avatar.jpg')
                                    : AssetImage(snapshot.data.avatarURL),
                                radius: 40.0,
                              ),
                            ),
                          ),
                          Text(
                            !snapshot.hasData
                                ? 'John Doe'
                                : snapshot.data.displayName,
                            style: const TextStyle(
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
                                color: Theme.of(context).accentColor,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                !snapshot.hasData
                                    ? 'john.doe@email.com'
                                    : snapshot.data.email,
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const Divider(),
                          Tile(
                            iconData: Icons.settings,
                            title: 'Settings',
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pushNamed('/settings');
                            },
                          ),
                          Tile(
                            iconData: Icons.exit_to_app,
                            title: 'Sign Out',
                            onTap: () {
                              _user.userLoggedIn = false;
                              //print('user log ${_user.isLoggedIn}');
                              Navigator.of(context).pushNamed('/signout');
                            },
                          ),
                          Tile(
                            iconData: Icons.feedback,
                            title: 'Your Feedback',
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: Column(
                        children: <Widget>[
                          const Divider(),
                          FutureBuilder<PackageInfo>(
                            future: PackageInfo.fromPlatform(),
                            builder: (BuildContext context,
                                AsyncSnapshot<PackageInfo> snapshot) {
                              return Tile(
                                iconData: Icons.update,
                                title: 'Version',
                                onTap: () {},
                                subtitle: snapshot.hasData
                                    ? '${snapshot.data.version}+${snapshot.data.buildNumber}'
                                    : snapshot.hasError
                                        ? snapshot.error.toString()
                                        : 'Unknown',
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ]),
            );
          }),
    );
  }
}

class Tile extends StatelessWidget {
  const Tile({Key key, this.onTap, this.title, this.iconData, this.subtitle})
      : super(key: key);
  final void Function() onTap;
  final IconData iconData;
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              hoverColor: Theme.of(context).colorScheme.primary,
              child: ListTile(
                leading: Icon(
                  iconData,
                ),
                title: Text(
                  title,
                  style: const TextStyle(),
                ),
                subtitle: Text(
                  subtitle ?? '',
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
                onTap: onTap,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
