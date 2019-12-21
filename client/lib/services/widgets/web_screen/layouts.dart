import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:responsive_scaffold/responsive_scaffold.dart';

import 'package:com.whitelabel/vendor_plugins/vendor_plugins.dart';

import '../../services/auth_user_service.dart';
import '../profile_info.dart';
import './bottom_nav.dart';
import './drawer.dart';

class HomeScaffold extends StatelessWidget {
  const HomeScaffold(
      {Key key,
      this.child,
      this.bottomNavigationBar,
      this.showBackButton = false})
      : super(key: key);
  final Widget child;
  final Widget bottomNavigationBar;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
    final AuthUserService _user = Provider.of<AuthUserService>(context);
    bool _showBackButton = showBackButton;
    if (!showBackButton) {
      if (!_user.isLoggedIn) {
        _showBackButton = true;
      } else {
        _showBackButton = false;
      }
    }

    return Scaffold(
        key: _key,
        drawer: ProfileInfo(),
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColorDark,
          leading: _showBackButton
              ? IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              : IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Theme.of(context).colorScheme.onPrimary,
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
                backgroundImage: AssetImage('assets/icon/icon.png'),
              ),
            ),
            title: Text(
              'Winwisely99',
              style: Theme.of(context).textTheme.title.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
            ),
          ),
        ),
        body: child,
        bottomNavigationBar: bottomNavigationBar
        // MediaQuery.of(context).size.width >= 720.0 ? null : const BottomNav(),
        );
  }
}

class WebLayoutBody extends StatefulWidget {
  const WebLayoutBody(
      {Key key,
      this.slivers,
      this.detailBuilder,
      this.drawerSelection = 0,
      this.itemBuilder,
      this.itemCount})
      : super(key: key);
  final List<Widget> slivers;
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
      bottomNavigationBar: !_user.isLoggedIn
          ? null
          : MediaQuery.of(context).size.width >= 720.0
              ? null
              : BottomNav(
                  index: widget.drawerSelection,
                ),
      slivers: widget.slivers ?? <Widget>[],
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
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: title,
          ),
          body: Scrollbar(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                child,
                const SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
      );
    }
  }
}

class ResponsiveDetailView extends StatelessWidget {
  const ResponsiveDetailView({Key key, this.child, this.title, this.icon})
      : super(key: key);
  final Widget child;
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    if (kIsWeb ||
        debugDefaultTargetPlatformOverride == TargetPlatform.fuchsia) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          //backgroundColor: Colors.transparent,
          title: Text(
            title,
            // style: Theme.of(context).textTheme.title,
          ),
        ),
        body: Scrollbar(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              child,
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      );
    } else {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              title,
              // style: Theme.of(context).textTheme.title,
            ),
          ),
          body: Scrollbar(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                child,
                const SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
      );
    }
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
      showBackButton: !(MediaQuery.of(context).size.width >= 720.0),
      child: MediaQuery.of(context).size.width >= 720.0
          ? Flex(
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
                      const SizedBox(height: 16.0),
                    ],
                  ),
                ),
              ],
            )
          : Column(
              children: <Widget>[
                title,
                const Divider(),
                child,
                const SizedBox(height: 16.0),
              ],
            ),
    );
  }
}

class ResponsiveListView extends StatelessWidget {
  const ResponsiveListView({Key key, this.children}) : super(key: key);
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(8.0),
          children: children),
    );
  }
}
