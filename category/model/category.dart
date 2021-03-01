import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Category extends Equatable {
  final int id;
  final String name;
  final String type;
  final String description;
  final String image;
  final String account;
 
  
  Category(
      {
        this.id,
      @required this.name,
      @required this.type,
      @required this.description,
      @required this.image,
      @required this.account,
     });


   Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = new Map<String, dynamic>();

    json['name'] = this.name;
    json['type'] = this.type;
    json['image'] = this.image;
    json['description'] = this.description;
    json['account'] = this.account;
    return json;
  }

 

  @override
  List<Object> get props => [id,name, type, image,description, account];

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
     
      name: json['name'],
      type: json['type'],
      image: json['image'],
      description: json['description'],
      account: json['account']
     
    );
  }

  @override
  String toString() => 'Category {id: $id, name: $name, type: $type, image: $image, description: $description, account: $account}';
}
