import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:intl/intl.dart';

import 'package:com.winwisely99.app/services/services.dart';

import '../bloc/data.dart';

class NewsView extends StatelessWidget {
  const NewsView({Key key, this.newsId}) : super(key: key);
  final String newsId;

  @override
  Widget build(BuildContext context) {
    if (kIsWeb ||
        debugDefaultTargetPlatformOverride == TargetPlatform.fuchsia) {
      return _NewsView(newsId: newsId);
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('News View'),
        ),
        body: _NewsView(newsId: newsId),
      );
    }
  }
}

class _NewsView extends StatelessWidget {
  const _NewsView({Key key, this.newsId}) : super(key: key);
  final String newsId;

  @override
  Widget build(BuildContext context) {
    final News _news = hiveBox['news'].get(newsId);
    final User _user = hiveBox['users'].get(_news.uid);

    return Scrollbar(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text(
                    _news == null ? 'Unable to load News !' : _news.title ?? '',
                    maxLines: 2,
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                _user != null
                    ? CircleAvatar(
                        backgroundImage: AssetImage(_user.avatarURL),
                        child: const Text(''),
                      )
                    : const SizedBox(width: 0),
                Text(
                    'Posted on ${DateFormat('MMM dd').format(_news.timestamp)}'),
              ],
            ),
          ),
          Expanded(
            child: _news == null
                ? 'Unable to load News !'
                : Markdown(data: _news.text),
          ),
        ],
      ),
    );
  }
}
