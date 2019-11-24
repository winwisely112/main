import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../bloc/app_nav.dart';

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({this.title, this.index, this.child});
  final String title;
  final Widget child;
  final int index;

  @override
  Widget build(BuildContext context) {
    final AppNavigation _nav = Provider.of<AppNavigation>(context);
    return Material(
      shape: CircleBorder(
        side: _nav.selections[index] == true
            ? BorderSide(
                color: Colors.white,
                width: 1.0,
              )
            : BorderSide.none,
      ),
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          _nav.setIndex(index);
          //onItemTap(index);
        },
        hoverColor: Colors.blueGrey,
        child: CircleAvatar(
          backgroundColor: _nav.selections[index] == true
              ? Theme.of(context).colorScheme.primaryVariant
              : Colors.transparent,
          //radius: 32.0,
          child: child,
        ),
      ),
    );
  }
}
