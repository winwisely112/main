import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            final StorageService storage = StorageService();
            // TODO(Vineeth): Removed await for now. Need to fix this later
            await storage.initialize();
            print(
                '${DateTime.now().toUtc().toString()} StorageService ${storage.hiveBox}');
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
            return storage == null || user == null
                ? null
                : AuthUserService(storage: storage, user: user);
          },
          dispose: (BuildContext _, AuthUserService authUser) =>
              authUser?.dispose(),
        ),
        ProxyProvider3<UserService, NetworkService, AuthUserService,
            CacheService>(
          update: (
            BuildContext _,
            UserService user,
            NetworkService network,
            AuthUserService auth,
            CacheService __,
          ) {
            print('${DateTime.now().toUtc().toString()} CacheService');
            // TODO(Vineeth): Move this to after authentication is successfull
            return network == null || user == null || auth == null
                ? null
                : CacheService(auth: auth, user: user, network: network);
          },
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
