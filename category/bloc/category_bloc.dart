import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fundme/category/bloc/bloc.dart';
import 'package:fundme/category/model/models.dart';
import 'package:fundme/category/repository/repository.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository categoryRepository;

  CategoryBloc({@required this.categoryRepository})
      : assert(categoryRepository != null),
        super(CategoryLoading());

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    if (event is CategoryLoad) {
      yield CategoryLoading();
      try {
        final categories = await categoryRepository.getCategories();
        yield CategoriesLoadSuccess(categories);
      } catch (e) {
        print(e);
        yield CategoryOperationFailure();
      }
    }

    if (event is CategoryCreate) {
      try {
        await categoryRepository.createCategory(event.category);
        final categories = await categoryRepository.getCategories();
        yield CategoriesLoadSuccess(categories);
      } catch (e) {
        print(e);
        yield CategoryOperationFailure();
      }
    }

    if (event is CategoryGet) {
      try {
        await categoryRepository.getCategory(event.category.type);
        final categories = await categoryRepository.getCategories();
        yield CategoriesLoadSuccess(categories);
      } catch (_) {
        yield CategoryOperationFailure();
      }
    }

    // if (event is CategoryUpdate) {
    //   try {
    //     await categoryRepository.updateCategory(event.category);
    //      final categories = await categoryRepository.getCategories();
    //     yield CategoriesLoadSuccess(categories);
    //   } catch (e) {
    //     print(e);
    //     yield CategoryOperationFailure();
    //   }
    // }

    if (event is CategoryDelete) {
      try {
        await categoryRepository.deleteCategory(event.category.id);
         final categories = await categoryRepository.getCategories();
        yield CategoriesLoadSuccess(categories);
      } catch (_) {
        yield CategoryOperationFailure();
      }
    }
  }
}