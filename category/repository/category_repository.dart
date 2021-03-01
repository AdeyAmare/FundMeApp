import 'package:meta/meta.dart';
import 'package:fundme/category/model/category.dart';
import 'package:fundme/category/data_provider/data_provider.dart';

class CategoryRepository {
  final CategoryDataProvider dataProvider;

  CategoryRepository({@required this.dataProvider})
      : assert(dataProvider != null);

  Future<Category> createCategory(Category category) async {
    return await dataProvider.createCategory(category);
  }

  Future<List<Category>> getCategories() async {
    return await dataProvider.getCategories();
  }

  Future<List<Category>> getCategory(String type) async {
    return await dataProvider.getCategory(type);
  }

  // Future<void> updateCategory(Category category) async {
  //   await dataProvider.updateCategory(category);
  // }

  Future<void> deleteCategory(int id) async {
    await dataProvider.deleteCategory(id);
  }
}
