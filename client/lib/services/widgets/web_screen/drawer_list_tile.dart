import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({this.title, this.index, this.child, this.selected});
  final String title;
  final Widget child;
  final int index;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: CircleBorder(
        side: selected == true
            ? BorderSide(
                color: Colors.white,
                width: 1.0,
              )
            : BorderSide.none,
      ),
      color: Colors.transparent,
      child: InkWell(
/*         onTap: () {
          _nav.setIndex(index);
          //onItemTap(index);
        }, */
        hoverColor: Colors.blueGrey,
        child: CircleAvatar(
          backgroundColor: selected == true
              ? Theme.of(context).colorScheme.primaryVariant
              : Colors.transparent,
          //radius: 32.0,
          child: child,
        ),
      ),
    );
  }
}
