import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Donor extends Equatable {
  final int id;
  final String firstName; 
  final String lastName;
  final String address;
  final String occupation;
  final String username;
  final String password;
  final String phoneNumber;
  final String emailAddress;
  
  Donor(
      {this.id,
      @required this.firstName,
      @required this.lastName,
      @required this.address,
      @required this.occupation,
      @required this.username,
      @required this.password,
      @required this.phoneNumber,
      @required this.emailAddress});


   Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = new Map<String, dynamic>();
    json['id'] = this.id;
    json['firstname'] = this.firstName;
    json['lastname'] = this.lastName;
    json['address'] = this.address;
    json['occupation'] = this.occupation;
    json['username'] = this.username;
    json['password'] = this.password;
    json['phone'] = this.phoneNumber;
    json['email'] = this.emailAddress;

    return json;
  }

 

  @override
  List<Object> get props => [id, firstName, lastName, address, occupation, username, password, phoneNumber, emailAddress];

  factory Donor.fromJson(Map<String, dynamic> json) {
    return Donor(
      id : json['id'],
      firstName : json['firstname'],
      lastName : json['lastname'],
      address : json['address'],
      occupation : json['occupation'],
      username : json['username'],
      password : json['password'],
      phoneNumber : json['phone'],
      emailAddress : json['email']
    );
  }

  @override
  String toString() => 'Donor { id: $id, firstName: $firstName, lastName: $lastName, address: $address, occupation: $occupation, username: $username, password: $password, phoneNumber: $phoneNumber, emailAddress: $emailAddress}';
}
