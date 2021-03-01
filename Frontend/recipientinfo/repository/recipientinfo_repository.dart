import 'package:meta/meta.dart';
import 'package:fundme/recipientinfo/model/recipientinfo.dart';
import 'package:fundme/recipientinfo/data_provider/data_provider.dart';

class RecipientInfoRepository {
  final RecipientInfoDataProvider dataProvider;

  RecipientInfoRepository({@required this.dataProvider})
      : assert(dataProvider != null);

  Future<RecipientInfo> createRecipientInfo(RecipientInfo recipientinfo) async {
    return await dataProvider.createRecipientInfo(recipientinfo);
  }

  Future<Transfer> transferCash(Transfer transfer) async {
    return await dataProvider.transferCash(transfer);
  }

  Future<List<RecipientInfo>> getRecipientInfos() async {
    return await dataProvider.getRecipientInfos();
  }

  Future<RecipientInfo> getRecipientInfo(int id) async {
    return await dataProvider.getRecipientInfo(id);
  }

  Future<void> updateRecipientInfo(RecipientInfo recipientinfo) async {
    await dataProvider.updateRecipientInfo(recipientinfo);
  }

  Future<void> deleteRecipientInfo(int id) async {
    await dataProvider.deleteRecipientInfo(id);
  }
}
