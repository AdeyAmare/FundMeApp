import 'package:equatable/equatable.dart';
import 'package:fundme/category/model/models.dart';

class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryLoading extends CategoryState {}

class CategoriesLoadSuccess extends CategoryState {
  final List<Category> categories;

  CategoriesLoadSuccess([this.categories = const []]);

  @override
  List<Object> get props => [categories];
}

class CategoryOperationFailure extends CategoryState {}
