import 'package:meta/meta.dart';
import 'package:fundme/recipient/model/recipient.dart';
import 'package:fundme/recipient/data_provider/data_provider.dart';

class RecipientRepository {
  final RecipientDataProvider dataProvider;

  RecipientRepository({@required this.dataProvider})
      : assert(dataProvider != null);

  Future<Recipient> createRecipient(Recipient recipient) async {
    return await dataProvider.createRecipient(recipient);
  }

  Future<List<Recipient>> getRecipients() async {
    return await dataProvider.getRecipients();
  }

  Future<Recipient> getRecipient(String id) async {
    return await dataProvider.getRecipient(id);
  }

  Future<void> updateRecipient(Recipient recipient) async {
    await dataProvider.updateRecipient(recipient);
  }

  Future<void> deleteRecipient(int id) async {
    await dataProvider.deleteRecipient(id);
  }
}
