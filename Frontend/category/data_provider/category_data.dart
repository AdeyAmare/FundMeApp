import 'dart:convert';
import 'package:fundme/config/config.dart';
import 'package:meta/meta.dart';
import 'package:fundme/category/model/category.dart';
import 'package:http/http.dart' as http;

class CategoryDataProvider {
 
  final http.Client httpClient;
  

  CategoryDataProvider({@required this.httpClient}) : assert(httpClient != null);

  Future<Category> createCategory(Category category) async {
    final response = await httpClient.post(
      '${Config.url}/${Config.categoryURL}',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(category.toJson()),
    );

    if (response.statusCode == 200) {
      return Category.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create category.');
    }
  }

  Future<List<Category>> getCategories() async {
     print('yayeeee0');
    final response = await httpClient.get('${Config.url}/${Config.categoriesURL}');
    print('yayeeee');
    if (response.statusCode == 200) {
      print('yayeeee2');
      final categories = jsonDecode(response.body) as List;
      return categories.map((category) => Category.fromJson(category)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<List<Category>> getCategory(String type) async {
    final response = await httpClient.get('${Config.url}/${Config.categoryURL}/${type}');

    if (response.statusCode == 200) {
     final categories = jsonDecode(response.body) as List;
      return categories.map((category) => Category.fromJson(category)).toList();
    } else {
      throw Exception('Failed to load category');
    }
  }

  Future<void> deleteCategory(int id) async {
    final http.Response response = await httpClient.delete(
      '${Config.url}/${Config.categoryDeleteURL}/${id.toString()}',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete category.');
    }
  }

  // Future<void> updateCategory(Category category) async {
  //   final http.Response response = await httpClient.put(
  //     '${Config.url}/${Config.categoryUpdateURL}/${category.id.toString()}',
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(category.toJson()),
  //   );

  //   if (response.statusCode != 200) {
  //     print('${response.body} ${response.statusCode}');
  //     throw Exception('Failed to update category.');
  //   }
  // }
}
