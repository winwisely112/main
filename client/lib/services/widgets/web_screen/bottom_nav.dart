import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({Key key, this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        buildWidget(
          icon: Icons.home,
          title: 'News',
          context: context,
        ),
        buildWidget(
          icon: Icons.chat_bubble,
          title: 'Chats',
          context: context,
        ),
        buildWidget(
          icon: Icons.event_note,
          title: 'My Campaigns',
          context: context,
        ),
      ],
      currentIndex: index,
      onTap: (int value) {
        switch (value) {
          case 0:
            Navigator.of(context).pushNamed('/news');
            break;
          case 1:
            Navigator.of(context).pushNamed('/chatgroup');
            break;
          case 2:
            Navigator.of(context).pushNamed('/campaignview');
            break;
          default:
            Navigator.of(context).pushNamed('/news');
        }
      },
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
        style: kIsWeb ||
                debugDefaultTargetPlatformOverride == TargetPlatform.fuchsia
            ? Theme.of(context).textTheme.subtitle
            : Theme.of(context)
                .textTheme
                .subtitle
                .copyWith(color: Theme.of(context).colorScheme.onPrimary),
      ),
    );
  }
}
