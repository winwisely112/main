import 'package:flutter/material.dart';

import './drawer_list_tile.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer(this.onItemTap);
  final void Function(int index) onItemTap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: const Color(0xFF34495e),
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
                    radius: 32.0,
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
                  const SizedBox(height: 16),
                  DrawerListTile(
                    index: 0,
                    onItemTap: onItemTap,
                    child: Icon(
                      Icons.home,
                      color: Colors.white,
                      //size: 32.0,
                    ),
                  ),
                  const SizedBox(height: 16),
                  DrawerListTile(
                    index: 1,
                    onItemTap: onItemTap,
                    child: Icon(
                      Icons.chat_bubble,
                      color: Colors.white,
                      // size: 32.0,
                    ),
                  ),
                  const SizedBox(height: 16),
                  DrawerListTile(
                    index: 2,
                    onItemTap: onItemTap,
                    child: Icon(
                      Icons.settings_input_antenna,
                      color: Colors.white,
                      //size: 32.0,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 16),
                  DrawerListTile(
                    index: 3,
                    onItemTap: onItemTap,
                    child: const CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/mockData/users/A.jpg'),
                    ),
                  ),
                  DrawerListTile(
                    index: 4,
                    onItemTap: onItemTap,
                    child: Icon(
                      Icons.settings,
                      color: Colors.white,
                      // size: 32.0,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
