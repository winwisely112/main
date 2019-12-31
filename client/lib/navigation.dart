import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// TODO(FlutterDevelopers): Import modules here
import 'package:com.whitelabel/chat_group/chat_group.dart';
import 'package:com.whitelabel/chat_view/chat_view.dart';
import 'package:com.whitelabel/enrollment/enrollment.dart';
import 'package:com.whitelabel/news/news.dart';
import 'package:com.whitelabel/signup/signup.dart';
import 'package:com.whitelabel/services/services.dart';

Route<dynamic> routes(RouteSettings settings) {
  MaterialPageRoute<dynamic> _route;
  // TODO(FlutterDevelopers): Add the path to module as a 'case'
  switch (settings.name) {
    case '/':
      _route = MaterialPageRoute<dynamic>(
        builder: (BuildContext context) {
          return SplashScreen(
            key: ValueKey<String>(settings.name),
          );
        },
      );
      break;
    case '/settings':
      _route = MaterialPageRoute<dynamic>(
        settings: settings,
        builder: (BuildContext context) {
          return ChangeNotifierProvider<AppConfiguration>.value(
            value: Provider.of<AppConfiguration>(context),
            child: const Settings(),
          );
        },
      );
      break;
    case '/campaignview':
      _route = MaterialPageRoute<dynamic>(
        settings: settings,
        builder: (BuildContext context) {
          return CampaignView(
            key: ValueKey<String>(settings.name),
          );
        },
      );
      break;
    case '/mycampaign':
      _route = MaterialPageRoute<dynamic>(
        settings: settings,
        builder: (BuildContext context) {
          return CampaignView(
            key: ValueKey<String>(settings.name),
          );
        },
      );
      break;
    case '/chatgroup':
      _route = MaterialPageRoute<dynamic>(
        settings: settings,
        builder: (BuildContext context) {
          return ChatGroupFeed(
            key: ValueKey<String>(settings.name),
          );
        },
      );
      break;
    case '/home':
/*       if (kIsWeb) {
        _route = HomeScreen.route();
      } else { */
      _route = MaterialPageRoute<dynamic>(
        settings: settings,
        builder: (BuildContext context) {
          return HomeScreen(
            key: ValueKey<String>(settings.name),
          );
        },
      );
      // }
      break;
    case '/login':
      _route = MaterialPageRoute<dynamic>(
        settings: settings,
        builder: (BuildContext context) {
          return LoginScreen(
            key: ValueKey<String>(settings.name),
          );
        },
      );
      break;
    case '/news':
      _route = MaterialPageRoute<dynamic>(
        settings: settings,
        builder: (BuildContext context) {
          return NewsFeed(
            key: ValueKey<String>(settings.name),
          );
        },
      );
      break;

    case '/signout':
      _route = MaterialPageRoute<dynamic>(
        settings: settings,
        builder: (BuildContext context) {
          return LoginScreen(
            key: ValueKey<String>(settings.name),
          );
        },
      );
      break;
    case '/userinfo':
      _route = MaterialPageRoute<dynamic>(
        settings: settings,
        builder: (BuildContext context) {
          return UserInfoView(
            key: ValueKey<String>(settings.name),
          );
        },
      );
      break;
    default:
      // TODO(FlutterDevelopers): Add the path to module as a 'case' - user this when data needs to be
      // passed to the module
      final List<String> info = settings.name.split('/');
      switch (info[1]) {
        case 'campaigndetails':
          // /campaigndetails/{campaignID}
          _route = MaterialPageRoute<dynamic>(
            settings: settings,
            builder: (BuildContext context) {
              return CampainDetailsView(
                key: ValueKey<String>(settings.name),
                campaignID: info[2],
                showUserButtonBar: false,
                // need to add campaign
              );
            },
          );
          break;
        case 'mycampaigndetails':
          // /campaigndetails/{campaignID}
          _route = MaterialPageRoute<dynamic>(
            settings: settings,
            builder: (BuildContext context) {
              return CampainDetailsView(
                key: ValueKey<String>(settings.name),
                campaignID: info[2],
                showUserButtonBar: true,
                // need to add campaign
              );
            },
          );
          break;
        case 'conditional':
          // /campaigndetails/{campaignID}
          _route = MaterialPageRoute<dynamic>(
            settings: settings,
            builder: (BuildContext context) {
              return ConditionalCommitmentView(
                key: ValueKey<String>(settings.name),
                campaignID: info[2],
                // need to add campaign
              );
            },
          );
          break;
        case 'chatfeed':
          // /chatfeed/{conversationID}
          _route = MaterialPageRoute<dynamic>(
            settings: settings,
            builder: (BuildContext context) {
              return ChatFeed(
                key: ValueKey<String>(settings.name),
                chatGroupId: info[2],
                //         user: ,
              );
            },
          );
          break;
        case 'newsview':
          // /newsview/{news.id}
          _route = MaterialPageRoute<dynamic>(
            settings: settings,
            builder: (BuildContext context) {
              return NewsView(
                key: ValueKey<String>(settings.name),
                newsId: info[2],
                //         user: ,
              );
            },
          );
          break;
        case 'notready':
          _route = MaterialPageRoute<dynamic>(
            settings: settings,
            builder: (BuildContext context) {
              return NotReadyView(
                key: ValueKey<String>(settings.name),
                campaignID: info[2],
              );
            },
          );
          break;
        case 'signup':
          _route = MaterialPageRoute<dynamic>(
            settings: settings,
            builder: (BuildContext context) {
              return SignUpView(
                key: ValueKey<String>(settings.name),
                campaignID: info[2],
              );
            },
          );
          break;
        case 'supportroles':
          _route = MaterialPageRoute<dynamic>(
            settings: settings,
            builder: (BuildContext context) {
              return SupportRolesView(
                key: ValueKey<String>(settings.name),
                campaignID: info[2],
              );
            },
          );
          break;
        default:
          _route = MaterialPageRoute<dynamic>(
            settings: settings,
            builder: (BuildContext context) {
              return HomeScreen(
                key: ValueKey<String>(settings.name),
              );
            },
          );
          break;
      }
      break;
  }
  return _route;
}
