import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class RecipientInfo extends Equatable {
  
  final int recipientId;
  final String firstName;
  final String lastName;
  final String address;
  final String phoneNumber;
  final String email;
  final String image;
  final String description;
  final String attachment;
//  final String date;
  final String accountNo;
  final String goal;
  final String balance;
  final String current;
  final String approval;
  
  RecipientInfo(
      {
      this.recipientId,
      this.firstName,
      this.lastName,
      this.address,
      this.phoneNumber,
      this.email,
      @required this.image,
      @required this.description,
      @required this.attachment,
   //   @required this.date,
      @required this.accountNo,
      @required this.goal,
      this.balance,
      this.current,
      @required this.approval});


   Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = new Map<String, dynamic>();
   
    // json['recipient_id'] = this.recipientId;
    // json['firstname'] = this.firstName;
    // json['lastname'] = this.lastName;
    // json['address'] = this.address;
    // json['phone'] = this.phoneNumber;
    // json['email'] = this.email;
    json['image'] = this.image;
    json['description'] = this.description;
    json['attachment'] = this.attachment;
    
    json['account'] = this.accountNo;
     json['goal'] = double.parse(this.goal);
    // json['balance'] = this.balance;
    // json['current'] = this.current;
    json['approval'] = this.approval;
 //   json['submitteddate'] = this.date;
    
    return json;
  }

 

  @override
  List<Object> get props => [ recipientId, firstName, lastName, address, phoneNumber, email,image, description, attachment,  accountNo, goal, balance, current,approval];

  factory RecipientInfo.fromJson(Map<String, dynamic> json) {
    return RecipientInfo(
    
      recipientId : json['recipient_id'],
      firstName : json['firstname'],
      lastName : json['lastname'],
      address : json['address'],
      phoneNumber: json['phone'],
      email: json['email'],
      image : json['image'],
      description : json['description'],
      attachment : json['attachment'],
   //   date : json['submitteddate'],
      accountNo : json['account'],
      goal : json['goal'].toString(),
      balance: json['balance'].toString(),
      current: json['current'].toString(),
      approval : json['approval']
    );
  }

  @override
  String toString() => 'RecipientInfo {  recipientId: $recipientId, firstName: $firstName, lastName: $lastName, address: $address, phoneNumber: $phoneNumber, email: $email, image: $image, description: $description, attachment: $attachment, accountNo: $accountNo, goal: $goal, balance: $balance, current: $current,approval: $approval}';
}

class Transfer extends Equatable{

  String donorAct, recAct, transAmt;
  Transfer(
    {
      @required this.donorAct,
      @required this.recAct,
      @required this.transAmt,

    }
 
  );
   Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = new Map<String, dynamic>();
    json['dAcct'] = this.donorAct;
    json['rAcct'] = this.recAct;
    json['transAmt'] = this.transAmt;
    return json;
   }

   factory Transfer.fromJson(Map<String,dynamic> json){
     return Transfer(
       donorAct: json['dAcct'],
       recAct: json['rAcct'],
       transAmt: json['transAmt'],
       );

   }

  @override
  // TODO: implement props
  List<Object> get props => [donorAct,recAct,transAmt];




}
