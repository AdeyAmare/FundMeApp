import 'package:flutter/material.dart';
import 'package:fundme/category/category.dart';

class CategoryAppRoute {
  static Route generateRoute(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) => CategoriesList());
    }

    if (settings.name == AddUpdateCategory.routeName) {
      CategoryArgument args = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => AddUpdateCategory(
                args: args,
              ));
    }

    if (settings.name == CategoryDetail.routeName) {
      Category category = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => CategoryDetail(
                category: category,
              ));
    }

    return MaterialPageRoute(builder: (context) => CategoriesList());
  }
}

class CategoryArgument {
  final Category category;
  final bool edit;
  CategoryArgument({this.category, this.edit});
}
