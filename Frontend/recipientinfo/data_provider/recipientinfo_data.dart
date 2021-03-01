import 'dart:convert';
import 'package:fundme/config/config.dart';
import 'package:meta/meta.dart';
import 'package:fundme/recipientinfo/model/recipientinfo.dart';
import 'package:http/http.dart' as http;

class RecipientInfoDataProvider {
 
  final http.Client httpClient;
  

  RecipientInfoDataProvider({@required this.httpClient}) : assert(httpClient != null);

  Future<RecipientInfo> createRecipientInfo(RecipientInfo recipientinfo) async {
    final response = await httpClient.post(
      '${Config.url}/${Config.recipientinfoURL}',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(recipientinfo.toJson()),
    );
    print('rrrrrrrrrr${recipientinfo}');
 print('bbbbbbb${response.body}');
  print('plssssssssss${RecipientInfo.fromJson(jsonDecode(response.body))}');
 try{
    if (response.statusCode == 201) {
     print('plssssssssss${RecipientInfo.fromJson(jsonDecode(response.body))}');
      return RecipientInfo.fromJson(jsonDecode(response.body));
    } else {
      //throw Exception('Failed to create recipientinfo.');
    }
 }catch(e){
   print('eeeeeeeeee$e');
 }
  }

    Future<Transfer> transferCash(Transfer transfer) async {
    final response = await httpClient.post(
      '${Config.url}/transfer',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(transfer.toJson()),
    );
    print('rrrrrrrrrr${transfer.donorAct}');
 print('bbbbbbb${response.body}');

 try{
    if (response.statusCode == 201) {
     print('plssssssssss${RecipientInfo.fromJson(jsonDecode(response.body))}');
      return Transfer.fromJson(jsonDecode(response.body));
    } else {
      //throw Exception('Failed to create recipientinfo.');
    }
 }catch(e){
   print('eeeeeeeeee$e');
 }
  }

  Future<List<RecipientInfo>> getRecipientInfos() async {
     print('yayeeee0');
    final response = await httpClient.get('${Config.url}/${Config.recipientinfosURL}');
    print('yayeeee');
    if (response.statusCode == 200) {
      print('yayeeee22');
      print(response.body);
      var recipientinfos = [];
      try{
       recipientinfos = jsonDecode(response.body) as List;
      }catch(e){
        print('eeeeeeeeeeee$e');
      }
    
      return recipientinfos.map((recipientinfo) => RecipientInfo.fromJson(recipientinfo)).toList();
    } else {
      throw Exception('Failed to load recipientinfos');
    }
  }

  Future<RecipientInfo> getRecipientInfo(int id) async {
    final response = await httpClient.get('${Config.url}/${Config.recipientinfoURL}/${id.toString()}');

    if (response.statusCode == 200) {
      final recipientinfo = RecipientInfo.fromJson(jsonDecode(response.body));
      return recipientinfo;
    } else {
      throw Exception('Failed to load recipientinfo');
    }
  }

  Future<void> deleteRecipientInfo(int id) async {
    final http.Response response = await httpClient.delete(
      '${Config.url}/${Config.recipientinfoDeleteURL}/${id.toString()}',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete recipientinfo.');
    }
  }

  Future<void> updateRecipientInfo(RecipientInfo recipientinfo) async {
    final http.Response response = await httpClient.put(
      '${Config.url}/${Config.recipientinfoUpdateURL}/${recipientinfo.recipientId.toString()}',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      //body: jsonEncode(recipientinfo.toJson()),
    );
    print(recipientinfo.recipientId);
  if(response.statusCode == 200){
    print("Okay");
  }
    if (response.statusCode != 200) {
      print('${response.body} ${response.statusCode}');
      throw Exception('Failed to update recipientinfo.');
    }
  }
}
