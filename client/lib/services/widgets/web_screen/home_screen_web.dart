import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_scaffold/responsive_scaffold.dart';

import 'package:com.winwisely99.app/chat_list/chat_list.dart';
import 'package:com.winwisely99.app/news/news.dart';

import '../../bloc/app_nav.dart';
import './drawer.dart';

class WebHomeScreen extends StatelessWidget {
  final PageController _controller = PageController();
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    final AppNavigation _nav = Provider.of<AppNavigation>(context);

    final List<Widget> _tabs = <Widget>[
      const NewsFeed(
        key: ValueKey<String>('/news'),
      ),
      const ConversationsFeed(
        key: ValueKey<String>('/conversations'),
      ),
      const Text(
        'Enrollments',
        style: optionStyle,
      ),
      const Text(
        'Profile',
        style: optionStyle,
      ),
    ];
    _nav.init(_tabs.length);
    final Widget drawer = ChangeNotifierProvider<AppNavigation>.value(
      value: Provider.of<AppNavigation>(context),
      child: const LeftDrawer(),
    );
    final Widget body = PageView(
      controller: _controller,
      scrollDirection: Axis.vertical,
      children: _tabs,
    );

    return ResponsiveListScaffold.builder(
      detailBuilder: (
        BuildContext context,
        int index,
        bool flag,
      ) {
        return const DetailsScreen(
          body: Text(
            'Details',
            style: optionStyle,
          ),
        );
      },
      //drawer: AppDrawer(),
      tabletSideMenu: (kIsWeb ||
              debugDefaultTargetPlatformOverride == TargetPlatform.fuchsia)
          ? const Flexible(
              flex: 0,
              child: LeftDrawer(),
              fit: FlexFit.tight,
            )
          : null,
      tabletFlexListView: 4,
      itemCount: 0,
      itemBuilder: (BuildContext context, int index) {
        return const Text(
          'Items',
          style: optionStyle,
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Winwisely99'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).pushNamed('/settings');
            },
          )
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            drawer,
            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: body,
            ),
          ],
        ),
      ),
    );
  }
}
