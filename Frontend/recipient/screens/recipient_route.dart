import 'package:flutter/material.dart';
import 'package:fundme/recipient/recipient.dart';
import 'package:fundme/recipientinfo/recipientinfo.dart';

// class RecipientAppRoute {
  
//   static Route generateRoute(RouteSettings settings) {
//     if (settings.name == '/') {
//       return MaterialPageRoute(builder: (context) => RecipientsList());
//     }

//     if (settings.name == AddUpdateRecipient.routeName) {
//       RecipientArgument args = settings.arguments;
//       return MaterialPageRoute(
//           builder: (context) => AddUpdateRecipient(
//                 args: args,
//               ));
//     }

//     if (settings.name == RecipientDetail.routeName) {
//       Recipient recipient = settings.arguments;
//       return MaterialPageRoute(
//           builder: (context) => RecipientDetail(
//                 recipient: recipient,
//               ));
//     }

//     return MaterialPageRoute(builder: (context) => RecipientsList());
//   }
// }

// class RecipientArgument {
//   final Recipient recipient;
//   final bool edit;
//   RecipientArgument({this.recipient, this.edit});
// }
