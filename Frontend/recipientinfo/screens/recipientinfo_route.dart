import 'package:flutter/material.dart';
import 'package:fundme/recipientinfo/recipientinfo.dart';
import 'package:fundme/recipient/recipient.dart';

class RecipientInfoAppRoute {
  static Route generateRoute(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) => RecipientInfosList());
    }

    if (settings.name == AddUpdateRecipientInfo.routeName) {
      RecipientInfoArgument args = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => AddUpdateRecipientInfo(
                args: args,
              ));
    }

    if (settings.name == RecipientInfoDetail.routeName) {
      RecipientInfo recipientinfo = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => RecipientInfoDetail(
                recipientinfo: recipientinfo,
              ));
    }

    return MaterialPageRoute(builder: (context) => RecipientInfosList());
  }
}

class RecipientInfoArgument {
  final RecipientInfo recipientinfo;
  final bool edit;
  RecipientInfoArgument({this.recipientinfo, this.edit});
}
