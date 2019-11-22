import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({this.title, this.index, this.onItemTap, this.child});
  final String title;
  final Widget child;
  final int index;
  final void Function(int index) onItemTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        shape: const CircleBorder(),
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            onItemTap(index);
          },
          hoverColor: Colors.blueGrey,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 32.0,
            child: child,
          ),
        ),
      ),
    );
  }
}
