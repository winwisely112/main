import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_scaffold/responsive_scaffold.dart';

import '../profile_info.dart';
import './drawer.dart';

class HomeScaffold extends StatelessWidget {
  const HomeScaffold({Key key, this.child, this.bottomNavigationBar})
      : super(key: key);
  final Widget child;
  final Widget bottomNavigationBar;
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _key,
      drawer: ProfileInfo(),
      appBar: AppBar(
        leading: IconButton(
          hoverColor: Colors.blueGrey,
          icon: Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () {
            _key.currentState.openDrawer();
          },
        ),
        title: ListTile(
          leading: const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage('assets/icon/icon-old.png'),
            ),
          ),
          title: Text(
            'Winwisely99',
            style:
                Theme.of(context).textTheme.title.copyWith(color: Colors.white),
          ),
        ),
      ),
      body: child,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}

class WebLayoutBody extends StatefulWidget {
  const WebLayoutBody(
      {Key key,
      this.title,
      this.detailBuilder,
      this.drawerSelection = 0,
      this.itemBuilder,
      this.itemCount})
      : super(key: key);
  final String title;
  final DetailsScreen Function(BuildContext, int, bool) detailBuilder;
  final int drawerSelection;
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  @override
  _WebLayoutState createState() => _WebLayoutState();
}

class _WebLayoutState extends State<WebLayoutBody> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveListScaffold.builder(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: ListTile(
            title: Text(
              widget.title,
              style: Theme.of(context).textTheme.title,
            ),
          ),
        ),
      ],
      detailBuilder: widget.detailBuilder,
      drawer: ProfileInfo(),
      tabletSideMenu: (kIsWeb ||
              debugDefaultTargetPlatformOverride == TargetPlatform.fuchsia)
          ? Flexible(
              flex: 0,
              child: LeftDrawer(index: widget.drawerSelection),
              fit: FlexFit.tight,
            )
          : null,
      tabletFlexListView: 4,
      nullItems: const Center(child: CircularProgressIndicator()),
      emptyItems: const Center(child: CircularProgressIndicator()),
      itemCount: widget.itemCount,
      itemBuilder: widget.itemBuilder,
    );
  }
}
