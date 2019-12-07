import 'package:flutter/material.dart';
import 'package:com.winwisely99.app/chat_group/chat_group.dart';
import 'package:com.winwisely99.app/news/news.dart';

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
    NewsFeed(
      key: ValueKey<String>('/news'),
    ),
    ChatGroupFeed(
      key: ValueKey<String>('/conversations'),
    ),
    Text(
      'Enrollments',
      style: optionStyle,
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
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('News'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            title: Text('Chats'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_note),
            title: Text('Enrollments'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.indigo,
        onTap: _onItemTapped,
      ),
    );
  }
}
