import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
      //currentIndex: _selectedIndex,
      selectedItemColor: Colors.indigo,
      //onTap: _onItemTapped,
    );
  }
}
