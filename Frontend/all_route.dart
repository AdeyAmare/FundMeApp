import 'package:flutter/material.dart';
import 'package:fundme/recipient/recipient.dart';
import 'package:fundme/home/home.dart';

class AllAppRoute {
  
  static Route generateRoute(RouteSettings settings) {
    if(settings.name == FundMain.routeName){
      return MaterialPageRoute(builder: (context) => FundMain());
    }
    if (settings.name == '/recipients') {
      return MaterialPageRoute(builder: (context) => RecipientsList());
    }

    if (settings.name == AddUpdateRecipient.routeName) {
      RecipientArgument args = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => AddUpdateRecipient(
                args: args,
              ));
    }

    if (settings.name == RecipientDetail.routeName) {
      Recipient recipient = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => RecipientDetail(
                recipient: recipient,
              ));
    }

    return MaterialPageRoute(builder: (context) => RecipientsList());
  }
}

class RecipientArgument {
  final Recipient recipient;
  final bool edit;
  RecipientArgument({this.recipient, this.edit});
}
