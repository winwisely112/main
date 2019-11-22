import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import './drawer_list_tile.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer(this.onItemTap);
  final void Function(int index) onItemTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.05,
      height: double.infinity,
      color: const Color(0xFF34495e),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 8),
                DrawerListTile(
                  index: 0,
                  onItemTap: onItemTap,
                  child: Icon(
                    FontAwesomeIcons.newspaper,
                    color: Colors.white,
                    size: 32.0,
                  ),
                ),
                const SizedBox(height: 16),
                DrawerListTile(
                  index: 1,
                  onItemTap: onItemTap,
                  child: Icon(
                    FontAwesomeIcons.comments,
                    color: Colors.white,
                    size: 32.0,
                  ),
                ),
                const SizedBox(height: 16),
                DrawerListTile(
                  index: 2,
                  onItemTap: onItemTap,
                  child: Icon(
                    FontAwesomeIcons.blog,
                    color: Colors.white,
                    size: 32.0,
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
                    backgroundImage: AssetImage('assets/mockData/users/A.jpg'),
                  ),
                ),
                DrawerListTile(
                  index: 4,
                  onItemTap: onItemTap,
                  child: Icon(
                    FontAwesomeIcons.cog,
                    color: Colors.white,
                    size: 32.0,
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
