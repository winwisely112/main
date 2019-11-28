import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:com.winwisely99.app/services/services.dart';

import './drawer_list_tile.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({@required this.index});
  //final void Function(int index) onItemTap;
  final int index;
  @override
  Widget build(BuildContext context) {
    final AuthUserService _user = Provider.of<AuthUserService>(context);

    final List<Widget> _topList = <Widget>[
      IconButton(
        icon: Icon(
          Icons.home,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).pushNamed('/news');
        },
        //size: 32.0,
      ),
      IconButton(
        icon: Icon(
          Icons.chat_bubble,
          color: Colors.white,
          // size: 32.0,
        ),
        onPressed: () {
          Navigator.of(context).pushNamed('/chatgroup');
        },
        //size: 32.0,
      ),
      IconButton(
        icon: Icon(
          Icons.settings_input_antenna,
          color: Colors.white,
          //size: 32.0,
        ),
        onPressed: () {
          Navigator.of(context).pushNamed('/enrollments');
        },
        //size: 32.0,
      ),
    ];
    final List<Widget> _bottomList = <Widget>[
      FutureBuilder<User>(
        future: _user.globalUser,
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
      ),
      IconButton(
        icon: Icon(
          Icons.settings,
          color: Colors.white,
          //size: 32.0,
        ),
        onPressed: () {
          Navigator.of(context).pushNamed('/settings');
        },
        //size: 32.0,
      ),
    ];
    final List<bool> _menuList =
        _setIndex(index, _topList.length + _bottomList.length + 2);
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        color: Theme.of(context).colorScheme.primary,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 8),
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    //radius: 32.0,
                    child: IconButton(
                      hoverColor: Colors.blueGrey,
                      icon: Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                  ),
                  for (int i = 0; i < _topList.length; i++)
                    Column(
                      children: <Widget>[
                        const SizedBox(height: 8),
                        DrawerListTile(
                          selected: _menuList[i],
                          index: i,
                          child: _topList[i],
                        ),
                        const SizedBox(height: 8),
                      ],
                    )
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: <Widget>[
                  for (int i = 0; i < _bottomList.length; i++)
                    Column(
                      children: <Widget>[
                        const SizedBox(height: 8),
                        DrawerListTile(
                          selected: _menuList[_topList.length + i],
                          index: _topList.length + i,
                          child: _bottomList[i],
                        ),
                        const SizedBox(height: 8),
                      ],
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<bool> _setIndex(int _index, int _length) {
    final List<bool> _list = List<bool>.filled(_length, false);
    _list[_index] = true;
    return _list;
  }
}
