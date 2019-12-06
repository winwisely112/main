import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({Key key, this.icon, this.title}) : super(key: key);
  final IconData icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Card(
        shape: const CircleBorder(),
        child: CircleAvatar(
          //padding: const EdgeInsets.all(8.0),
          backgroundColor: Colors.white,
          child: Icon(
            icon,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.title,
      ),
    );
  }
}
