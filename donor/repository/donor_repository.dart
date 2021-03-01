import 'package:meta/meta.dart';
import 'package:fundme/donor/model/donor.dart';
import 'package:fundme/donor/data_provider/data_provider.dart';

class DonorRepository {
  final DonorDataProvider dataProvider;

  DonorRepository({@required this.dataProvider})
      : assert(dataProvider != null);

  Future<Donor> createDonor(Donor donor) async {
    return await dataProvider.createDonor(donor);
  }

  Future<Donor> loginDonor(Donor donor) async{
    return await dataProvider.loginDonor(donor);
  }

  Future<List<Donor>> getDonors() async {
    return await dataProvider.getDonors();
  }

  Future<Donor> getDonor(int id) async {
    return await dataProvider.getDonor(id);
  }

  Future<void> updateDonor(Donor donor) async {
    await dataProvider.updateDonor(donor);
  }

  Future<void> deleteDonor(int id) async {
    await dataProvider.deleteDonor(id);
  }
}
