import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

// TODO(FlutterDevelopers): Import modules here
import 'package:com.whitelabel/chat_view/chat_view.dart';
import 'package:com.whitelabel/chat_group/chat_group.dart';
import 'package:com.whitelabel/enrollment/enrollment.dart';
import 'package:com.whitelabel/news/news.dart';
import 'package:com.whitelabel/services/services.dart';
import 'app.dart';
import 'hive.dart';

class ServicesProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildCloneableWidget>[
        // Initializes hive and offers a service that stores app-wide data.
        FutureProvider<StorageService>(
          create: (BuildContext context) async {
            await initializeHive();
            // TODO(FlutterDevelopers): Initial Hive store here
            hiveBox['chats'] = await Hive.openBox<ChatModel>('chats');
            hiveBox['news'] = await Hive.openBox<News>('news');
            hiveBox['users'] = await Hive.openBox<User>('users');
            hiveBox['chatgroup'] = await Hive.openBox<ChatGroup>('chatgroup');
            hiveBox['campaign'] = await Hive.openBox<Campaign>('campaign');
            hiveBox['roles'] = await Hive.openBox<Roles>('roles');
            final StorageService storage = StorageService();
            // TODO(Vineeth): Removed await for now. Need to fix this later
            storage.initialize();
            print('${DateTime.now().toUtc().toString()} StorageService');
            storageServiceReadyCompleter.complete();
            return storage;
          },
        ),
        // This service offers network calls and automatically enriches the
        // header using the authentication provided by the
        // [AuthenticationStorageService].
        ProxyProvider<StorageService, NetworkService>(
          update: (
            BuildContext _,
            StorageService storage,
            NetworkService __,
          ) {
            print(
                '${DateTime.now().toUtc().toString()} NetworkService $storage');
            return storage == null
                ? null
                : NetworkService('unique',
                    storage: storage,
                    subscriptions: <MessageType, Subscriptions<dynamic>>{
                        // TODO(FlutterDevelopers): Import your subscriptions here
/*                         MessageType.CHAT: Subscriptions<Chat>(
                          receivingIsolate: chatReceivingIsolate,
                          sendingIsolate: chatSendingIsolate,
                          onSendDo: chatOnSendDo,
                          onRecieveDo: chatOnRecieveDo,
                        ), */
                      });
          },
        ),
        // This service offers fetching of users.
        ProxyProvider<NetworkService, UserService>(
          update: (
            BuildContext _,
            NetworkService network,
            UserService __,
          ) {
            print('${DateTime.now().toUtc().toString()} UserService $network');
            return network == null ? null : UserService(network: network);
          },
        ),
        // This service offers fetching of the currently logged in user.
        ProxyProvider3<StorageService, UserService, NetworkService,
            AuthUserService>(
          update: (
            BuildContext _,
            StorageService storage,
            UserService user,
            NetworkService network,
            AuthUserService __,
          ) {
            print(
                '${DateTime.now().toUtc().toString()} GlobalUserService $user');
            // TODO(Vineeth): Move this to after authentication is successfull
            if (storage != null && user != null) {
              final AuthUserService _auth =
                  AuthUserService(storage: storage, user: user);
              if (_auth != null) {
                // this order is important
                repos['chatgroup'] = ItemRepository<ChatGroup>(
                  user: user,
                  network: network,
                  globalUser: _auth,
                  source: ChatGroupRepository(
                    user: user,
                    network: network,
                    globalUser: _auth,
                  ),
                  cache: 'chatgroup',
                );
                repos['chats'] = ItemRepository<ChatModel>(
                  user: user,
                  network: network,
                  globalUser: _auth,
                  source: ChatRepository(
                    user: user,
                    network: network,
                    globalUser: _auth,
                  ),
                  cache: 'chats',
                );
              }
              return _auth;
            } else {
              return null;
            }
            //return storage == null || user == null
            //    ? null
            //    : AuthUserService(storage: storage, user: user);
          },
          dispose: (BuildContext _, AuthUserService authUser) =>
              authUser?.dispose(),
        ),
      ],
      child: ChangeNotifierProvider<AppConfiguration>(
        create: (BuildContext context) => AppConfiguration(),
        child: const App(
          key: ValueKey<String>('App'),
        ),
      ),
    );
  }
}
