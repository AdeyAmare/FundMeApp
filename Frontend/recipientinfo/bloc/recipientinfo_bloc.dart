import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fundme/recipientinfo/bloc/bloc.dart';
import 'package:fundme/recipientinfo/model/models.dart';
import 'package:fundme/recipientinfo/repository/repository.dart';

class RecipientInfoBloc extends Bloc<RecipientInfoEvent, RecipientInfoState> {
  final RecipientInfoRepository recipientinfoRepository;

  RecipientInfoBloc({@required this.recipientinfoRepository})
      : assert(recipientinfoRepository != null),
        super(RecipientInfoLoading());

  @override
  Stream<RecipientInfoState> mapEventToState(RecipientInfoEvent event) async* {
    if (event is RecipientInfoLoad) {
      yield RecipientInfoLoading();
      try {
        final recipientinfos = await recipientinfoRepository.getRecipientInfos();
        yield RecipientInfosLoadSuccess(recipientinfos);
      } catch (e) {
        print(e);
        yield RecipientInfoOperationFailure();
      }
    }

    if (event is RecipientInfoCreate) {
      try {
        await recipientinfoRepository.createRecipientInfo(event.recipientinfo);
        final recipientinfos = await recipientinfoRepository.getRecipientInfos();
        yield RecipientInfosLoadSuccess(recipientinfos);
      } catch (e) {
        print(e);
        yield RecipientInfoOperationFailure();
      }
    }

    if (event is RecipientInfoGet) {
      try {
        await recipientinfoRepository.getRecipientInfo(event.recipientinfo.recipientId);
        final recipientinfos = await recipientinfoRepository.getRecipientInfos();
        yield RecipientInfosLoadSuccess(recipientinfos);
      } catch (_) {
        yield RecipientInfoOperationFailure();
      }
    }

    if (event is RecipientInfoUpdate) {
      try {
        await recipientinfoRepository.updateRecipientInfo(event.recipientinfo);
         final recipientinfos = await recipientinfoRepository.getRecipientInfos();
        yield RecipientInfosLoadSuccess(recipientinfos);
      } catch (e) {
        print(e);
        yield RecipientInfoOperationFailure();
      }
    }

    if (event is RecipientInfoDelete) {
      try {
        await recipientinfoRepository.deleteRecipientInfo(event.recipientinfo.recipientId);
         final recipientinfos = await recipientinfoRepository.getRecipientInfos();
        yield RecipientInfosLoadSuccess(recipientinfos);
      } catch (_) {
        yield RecipientInfoOperationFailure();
      }
    }

     if (event is TransferCash) {
      try {
        await recipientinfoRepository.transferCash(event.transfer);
        final recipientinfos = await recipientinfoRepository.getRecipientInfos();
        yield RecipientInfosLoadSuccess(recipientinfos);
      } catch (e) {
        print(e);
        yield RecipientInfoOperationFailure();
      }
    }
  }
}