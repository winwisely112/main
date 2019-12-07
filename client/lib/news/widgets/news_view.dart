import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:com.winwisely99.app/services/services.dart';

import '../bloc/bloc.dart';
import '../bloc/data.dart';

class NewsView extends StatelessWidget {
  const NewsView({Key key, this.newsId}) : super(key: key);
  final String newsId;

  @override
  Widget build(BuildContext context) {
    return ProxyProvider2<NetworkService, UserService, NewsBloc>(
      builder: (
        BuildContext _,
        NetworkService network,
        UserService user,
        NewsBloc __,
      ) =>
          NewsBloc(
        network: network,
        user: user,
      ),
      child: ResponsiveDetailView(
        child: _NewsView(newsId: newsId),
        title: 'News View',
        icon: FontAwesomeIcons.newspaper,
      ),
    );
  }
}

class _NewsView extends StatelessWidget {
  const _NewsView({Key key, this.newsId}) : super(key: key);
  final String newsId;

  @override
  Widget build(BuildContext context) {
    final News _news = hiveBox['news'].get(newsId);
    final User _user = hiveBox['users'].get(_news.uid);
    return ResponsiveListView(
      children: <Widget>[
        ListTile(
          title: Text(
            _news == null ? 'Unable to load News !' : _news.title ?? '',
            maxLines: 2,
            style: Theme.of(context).textTheme.title,
          ),
        ),
        ListTile(
          leading: _user != null
              ? CircleAvatar(
                  backgroundImage: AssetImage(_user.avatarURL),
                  child: const Text(''),
                )
              : const SizedBox(width: 0),
          title:
              Text('Posted on ${DateFormat('MMM dd').format(_news.timestamp)}'),
        ),
        ListTile(
          title: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: _news.thumbnailUrl == null
                  ? const Text('')
                  : Image.asset(
                      _news.thumbnailUrl,
                      fit: BoxFit.contain,
                    ),
              /*                                   Image.network(
                                        news.thumbnailUrl,
                                      ), */
            ),
          ),
        ),
        ListTile(
          title: _news == null
              ? 'Unable to load News !'
              : MarkdownBody(data: _news.text),
        ),
        const SizedBox(height: 48),
      ],
    );
  }
}
