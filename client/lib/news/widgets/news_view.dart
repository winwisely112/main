import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:com.whitelabel/services/services.dart';

import '../bloc/bloc.dart';
import '../bloc/data.dart';

class NewsView extends StatelessWidget {
  const NewsView({Key key, this.newsId}) : super(key: key);
  final String newsId;

  @override
  Widget build(BuildContext context) {
    return ProxyProvider3<NetworkService, UserService, StorageService,
        NewsBloc>(
      update: (
        BuildContext _,
        NetworkService network,
        UserService user,
        StorageService storage,
        NewsBloc __,
      ) =>
          NewsBloc(
        network: network,
        user: user,
        storage: storage,
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
    //final StorageService _storage = Provider.of<StorageService>(context);
    final UserService _user = Provider.of<UserService>(context);
    //final News _news = _storage.hiveBox[Cache.News].get(newsId);
    //final User _user = hiveBox['users'].get(_news.uid);
    return FutureBuilder<News>(
      future: Provider.of<NewsBloc>(context).getNewsId(newsId),
      builder: (BuildContext context, AsyncSnapshot<News> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error occurred: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final News _news = snapshot.data;
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
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).cardColor,
                backgroundImage: AssetImage(_news.createdBy == null
                    ? 'assets/commons/avatar.jpg'
                    : _news.createdBy.avatarURL),
              ),
              //AvatarLoader(future: _user.getUser(_news.uid)),
              title: Text(
                  'Posted on ${DateFormat('MMM dd').format(_news.timestamp)}'),
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
      },
    );
  }
}
