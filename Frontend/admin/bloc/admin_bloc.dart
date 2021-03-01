import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fundme/recipient/bloc/bloc.dart';
import 'package:fundme/recipient/model/recipient.dart';
import 'package:fundme/recipient/repository/repository.dart';

class RecipientBloc extends Bloc<RecipientEvent, RecipientState> {
  final RecipientRepository recipientRepository;

  RecipientBloc({@required this.recipientRepository})
      : assert(recipientRepository != null),
        super(RecipientLoading());

  @override
  Stream<RecipientState> mapEventToState(RecipientEvent event) async* {
    if (event is RecipientLoad) {
      yield RecipientLoading();
      try {
        final recipients = await recipientRepository.getRecipients();
        yield RecipientsLoadSuccess(recipients);
      } catch (e) {
        print(e);
        yield RecipientOperationFailure();
      }
    }

    if (event is RecipientCreate) {
      try {
        await recipientRepository.createRecipient(event.recipient);
        final recipients = await recipientRepository.getRecipients();
        yield RecipientsLoadSuccess(recipients);
      } catch (e) {
        print(e);
        yield RecipientOperationFailure();
      }
    }

    if (event is RecipientGet) {
      try {
        await recipientRepository.getRecipient(event.recipient.username);
        final recipients = await recipientRepository.getRecipients();
        yield RecipientsLoadSuccess(recipients);
      } catch (_) {
        yield RecipientOperationFailure();
      }
    }

    if (event is RecipientUpdate) {
      try {
        await recipientRepository.updateRecipient(event.recipient);
         final recipients = await recipientRepository.getRecipients();
        yield RecipientsLoadSuccess(recipients);
      } catch (e) {
        print(e);
        yield RecipientOperationFailure();
      }
    }

    if (event is RecipientDelete) {
      try {
        await recipientRepository.deleteRecipient(event.recipient.id);
         final recipients = await recipientRepository.getRecipients();
        yield RecipientsLoadSuccess(recipients);
      } catch (_) {
        yield RecipientOperationFailure();
      }
    }
  }
}