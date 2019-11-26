import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './drawer_list_tile.dart';
import '../../bloc/app_nav.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer();
  //final void Function(int index) onItemTap;

  @override
  Widget build(BuildContext context) {
    final AppNavigation _nav = Provider.of<AppNavigation>(context);
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
      const CircleAvatar(
        backgroundImage: AssetImage('assets/mockData/users/A.jpg'),
      ),
      Icon(
        Icons.settings,
        color: Colors.white,
        // size: 32.0,
      ),
    ];
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
                        ChangeNotifierProvider<AppNavigation>.value(
                          value: Provider.of<AppNavigation>(context),
                          child: DrawerListTile(
                            index: i,
                            child: _topList[i],
                          ),
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
                        ChangeNotifierProvider<AppNavigation>.value(
                          value: Provider.of<AppNavigation>(context),
                          child: DrawerListTile(
                            index: _topList.length + i,
                            child: _bottomList[i],
                          ),
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
}
