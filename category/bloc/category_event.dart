import 'package:equatable/equatable.dart';
import 'package:fundme/category/model/models.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();
}

class CategoryLoad extends CategoryEvent {
  const CategoryLoad();

  @override
  List<Object> get props => [];
}

class CategoryCreate extends CategoryEvent {
  final Category category;

  const CategoryCreate(this.category);

  @override
  List<Object> get props => [category];

  @override
  String toString() => 'Category Created {course: $category}';
}

class CategoryGet extends CategoryEvent {
  final Category category;

  const CategoryGet(this.category);

  @override
  List<Object> get props => [category];

  @override
  toString() => 'Category Got {category: $category}';
}



// class CategoryUpdate extends CategoryEvent {
//   final Category category;

//   const CategoryUpdate(this.category);

//   @override
//   List<Object> get props => [category];

//   @override
//   String toString() => 'Category Updated {category: $category}';
// }

class CategoryDelete extends CategoryEvent {
  final Category category;

  const CategoryDelete(this.category);

  @override
  List<Object> get props => [category];

  @override
  toString() => 'Category Deleted {category: $category}';
}
