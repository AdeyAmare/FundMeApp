import 'package:flutter/material.dart';
import 'package:fundme/donor/donor.dart';

class DonorAppRoute {
  static Route generateRoute(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) => DonorsList());
    }

    if (settings.name == AddUpdateDonor.routeName) {
      DonorArgument args = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => AddUpdateDonor(
                args: args,
              ));
    }

    if (settings.name == DonorDetail.routeName) {
      Donor donor = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => DonorDetail(
                donor: donor,
              ));
    }

    return MaterialPageRoute(builder: (context) => AddUpdateDonor());
  }
}

class DonorArgument {
  final Donor donor;
  final bool edit;
  DonorArgument({this.donor, this.edit});
}
