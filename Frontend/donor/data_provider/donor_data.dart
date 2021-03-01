import 'dart:convert';
import 'package:fundme/config/config.dart';
import 'package:meta/meta.dart';
import 'package:fundme/donor/model/donor.dart';
import 'package:http/http.dart' as http;

class DonorDataProvider {
 
  final http.Client httpClient;
  

  DonorDataProvider({@required this.httpClient}) : assert(httpClient != null);

  Future<Donor> createDonor(Donor donor) async {
    final response = await httpClient.post(
      '${Config.url}/${Config.donorURL}',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(donor.toJson()),
    );
    print(response.statusCode);

    if (response.statusCode == 201) {
      return Donor.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create donor.');
    }
  }

   Future<Donor> loginDonor(Donor donor) async {
    final response = await httpClient.post(
      '${Config.url}/${Config.donorLoginURL}',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(donor.toJson()),
    );
    print('logged${response.statusCode}');

    if (response.statusCode == 200) {
      print('logged in');
      Config.loggedIn = true;
      return Donor.fromJson(jsonDecode(response.body));
    } else {
      Config.loggedIn = false;
      throw Exception('Failed to create donor.');
    }
  }

  Future<List<Donor>> getDonors() async {
     print('yayeeee0');
    final response = await httpClient.get('${Config.url}/${Config.donorsURL}');
    print('yayeeee');
    print('statusCode${response.statusCode}');
    if (response.statusCode == 200) {
      print('yayeeee2');
      final donors = jsonDecode(response.body) as List;
      return donors.map((donor) => Donor.fromJson(donor)).toList();
    } else {
      throw Exception('Failed to load donors');
    }
  }

  Future<Donor> getDonor(int id) async {
    final response = await httpClient.get('${Config.url}/${Config.donorURL}/${id.toString()}');

    if (response.statusCode == 200) {
      final donor = Donor.fromJson(jsonDecode(response.body));
      return donor;
    } else {
      throw Exception('Failed to load donor');
    }
  }

  Future<void> deleteDonor(int id) async {
    final http.Response response = await httpClient.delete(
      '${Config.url}/${Config.donorDeleteURL}/${id.toString()}',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete donor.');
    }
  }

  Future<void> updateDonor(Donor donor) async {
    final http.Response response = await httpClient.put(
      '${Config.url}/${Config.donorUpdateURL}/${donor.id.toString()}',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(donor.toJson()),
    );

    if (response.statusCode != 200) {
      print('${response.body} ${response.statusCode}');
      throw Exception('Failed to update donor.');
    }
  }
}
