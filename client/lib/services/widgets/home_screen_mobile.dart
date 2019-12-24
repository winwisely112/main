import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:com.whitelabel/chat_group/chat_group.dart';
import 'package:com.whitelabel/enrollment/enrollment.dart';
import 'package:com.whitelabel/news/news.dart';

import './web_screen/layouts.dart';

class MobileHomeScreen extends StatefulWidget {
  @override
  _MobileHomeScreenState createState() => _MobileHomeScreenState();
}

class _MobileHomeScreenState extends State<MobileHomeScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    CampaignView(
      key: ValueKey<String>('/mycampaign'),
    ),
    ChatGroupFeed(
      key: ValueKey<String>('/conversations'),
    ),
    NewsFeed(
      key: ValueKey<String>('/news'),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return HomeScaffold(
      child: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          buildWidget(
            icon: FontAwesomeIcons.bullhorn,
            title: 'My Campaigns',
            context: context,
          ),
          buildWidget(
            icon: Icons.chat_bubble,
            title: 'My Chats',
            context: context,
          ),
          buildWidget(
            icon: FontAwesomeIcons.newspaper,
            title: 'News Feed',
            context: context,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        onTap: _onItemTapped,
      ),
    );
  }

  BottomNavigationBarItem buildWidget(
      {BuildContext context, IconData icon, String title}) {
    return BottomNavigationBarItem(
      activeIcon: Card(
        shape: const CircleBorder(),
        child: CircleAvatar(
          backgroundColor: Theme.of(context).cardColor,
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
      icon: Icon(
        icon,
        color: Theme.of(context).primaryColorLight,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.subtitle,
      ),
    );
  }
}
