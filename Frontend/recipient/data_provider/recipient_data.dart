import 'dart:convert';
import 'dart:io';
import 'package:fundme/config/config.dart';
import 'package:meta/meta.dart';
import 'package:fundme/recipient/model/recipient.dart';
import 'package:http/http.dart' as http;


class RecipientDataProvider {
 
  final http.Client httpClient;
  

  RecipientDataProvider({@required this.httpClient}) : assert(httpClient != null);

  Future<Recipient> createRecipient(Recipient recipient) async {
    final  response = await httpClient.post(
      '${Config.url}/${Config.recipientURL}',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(recipient.toJson()),
    );
   
    Map<String,String> data = response.headers;
    print(data);
  print(response.statusCode);
   print('bbbbbbb${response.body}');
    print('plssssssssss${Recipient.fromJson(jsonDecode(response.body))}');
    if (response.statusCode == 201) {
      //print(response.header);
     // Config.recID = response.message;
      return Recipient.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create recipient.');
    }
  }

  Future<List<Recipient>> getRecipients() async {
     print('yayeeee0');
    final response = await httpClient.get('${Config.url}/${Config.recipientsURL}');
    print('yayeeee');
    if (response.statusCode == 200) {
      print('yayeeee2');
      final recipients = jsonDecode(response.body) as List;
      return recipients.map((recipient) => Recipient.fromJson(recipient)).toList();
    } else {
      throw Exception('Failed to load recipients');
    }
  }

  Future<Recipient> getRecipient(String id) async {
    final response = await httpClient.get('${Config.url}/${Config.recipientURL}/${id}');

    if (response.statusCode == 201) {
      final recipient = Recipient.fromJson(jsonDecode(response.body));
      return recipient;
    } else {
      throw Exception('Failed to load recipient');
    }
  }

  Future<void> deleteRecipient(int id) async {
    final http.Response response = await httpClient.delete(
      '${Config.url}/${Config.recipientDeleteURL}/${id.toString()}',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete recipient.');
    }
  }

  Future<void> updateRecipient(Recipient recipient) async {
    final http.Response response = await httpClient.put(
      '${Config.url}/${Config.recipientUpdateURL}/${recipient.id.toString()}',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(recipient.toJson()),
    );

    if (response.statusCode != 200) {
      print('${response.body} ${response.statusCode}');
      throw Exception('Failed to update recipient.');
    }
  }
}
