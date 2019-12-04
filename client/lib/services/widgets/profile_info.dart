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
              //width: 260,
              //height: double.infinity,
              color: Theme.of(context).colorScheme.primaryVariant,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      color: Theme.of(context).colorScheme.primaryVariant,
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
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
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
                          const Divider(
                            color: Colors.white,
                          ),
                          Tile(
                            iconData: Icons.exit_to_app,
                            title: 'Sign Out',
                            onTap: () {
                              Navigator.of(context).pushNamed('/signout');
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      color: Theme.of(context).colorScheme.primary,
                      child: Column(
                        children: <Widget>[
                          const Divider(
                            color: Colors.white,
                          ),
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
        const SizedBox(
          height: 8,
        ),
        Container(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              hoverColor: Theme.of(context).colorScheme.primary,
              child: ListTile(
                leading: Icon(
                  iconData,
                  color: Colors.white,
                ),
                title: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                subtitle: Text(
                  subtitle ?? '',
                  style: const TextStyle(
                      color: Colors.white, fontStyle: FontStyle.italic),
                ),
                onTap: onTap,
              ),
            ),
          ),
        ),
        //const Divider(
        //  color: Colors.white,
        //),
      ],
    );
  }
}
