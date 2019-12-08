import 'package:flutter/foundation.dart';
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
          backgroundColor: Theme.of(context).cardColor,
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
      title: Text(
        title,
        style: kIsWeb ||
                debugDefaultTargetPlatformOverride == TargetPlatform.fuchsia
            ? Theme.of(context).textTheme.title
            : Theme.of(context)
                .textTheme
                .title
                .copyWith(color: Theme.of(context).colorScheme.onPrimary),
      ),
    );
  }
}
