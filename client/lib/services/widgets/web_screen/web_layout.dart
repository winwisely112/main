import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_scaffold/responsive_scaffold.dart';

import '../../services/auth_user_service.dart';
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
    final AuthUserService _user = Provider.of<AuthUserService>(context);
    return Scaffold(
      key: _key,
      drawer: ProfileInfo(),
      appBar: AppBar(
        leading: !_user.isLoggedIn
            ? IconButton(
                hoverColor: Colors.blueGrey,
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            : IconButton(
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
  final Widget title;
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
    final AuthUserService _user = Provider.of<AuthUserService>(context);
    return ResponsiveListScaffold.builder(
      slivers: <Widget>[
        SliverList(
          delegate:
              SliverChildListDelegate(<Widget>[widget.title, const Divider()]),
        ),
      ],
      detailBuilder: widget.detailBuilder,
      drawer: ProfileInfo(),
      tabletSideMenu: (kIsWeb ||
              debugDefaultTargetPlatformOverride == TargetPlatform.fuchsia)
          ? Flexible(
              flex: 0,
              child: LeftDrawer(
                index: widget.drawerSelection,
              ),
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

class WebInfoView extends StatelessWidget {
  const WebInfoView({Key key, this.child, this.title, this.index = 4})
      : super(key: key);
  final Widget child;
  final Widget title;
  final int index;
  @override
  Widget build(BuildContext context) {
    if (kIsWeb ||
        debugDefaultTargetPlatformOverride == TargetPlatform.fuchsia) {
      return _WebView(
        title: title,
        child: child,
        index: index ?? 4,
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: title,
        ),
        body: child,
      );
    }
    ;
  }
}

class _WebView extends StatelessWidget {
  const _WebView({Key key, this.child, this.index = 4, this.title})
      : super(key: key);
  final Widget child;
  final Widget title;
  final int index;
  @override
  Widget build(BuildContext context) {
    return HomeScaffold(
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          Flexible(
            flex: 0,
            child: LeftDrawer(index: index),
            fit: FlexFit.tight,
          ),
          Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: Column(
              children: <Widget>[
                title,
                const Divider(),
                child,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
