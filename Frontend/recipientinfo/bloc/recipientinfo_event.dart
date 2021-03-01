import 'package:equatable/equatable.dart';
import 'package:fundme/recipientinfo/model/models.dart';

abstract class RecipientInfoEvent extends Equatable {
  const RecipientInfoEvent();
}

class RecipientInfoLoad extends RecipientInfoEvent {
  const RecipientInfoLoad();

  @override
  List<Object> get props => [];
}

class RecipientInfoCreate extends RecipientInfoEvent {
  final RecipientInfo recipientinfo;

  const RecipientInfoCreate(this.recipientinfo);

  @override
  List<Object> get props => [recipientinfo];

  @override
  String toString() => 'RecipientInfo Created {recipientInfo: $recipientinfo}';
}

class RecipientInfoGet extends RecipientInfoEvent {
  final RecipientInfo recipientinfo;

  const RecipientInfoGet(this.recipientinfo);

  @override
  List<Object> get props => [recipientinfo];

  @override
  toString() => 'RecipientInfo Got {recipientinfo: $recipientinfo}';
}



class RecipientInfoUpdate extends RecipientInfoEvent {
  final RecipientInfo recipientinfo;

  const RecipientInfoUpdate(this.recipientinfo);

  @override
  List<Object> get props => [recipientinfo];

  @override
  String toString() => 'RecipientInfo Updated {recipientinfo: $recipientinfo}';
}

class RecipientInfoDelete extends RecipientInfoEvent {
  final RecipientInfo recipientinfo;

  const RecipientInfoDelete(this.recipientinfo);

  @override
  List<Object> get props => [recipientinfo];

  @override
  toString() => 'RecipientInfo Deleted {recipientinfo: $recipientinfo}';
}

class TransferCash extends RecipientInfoEvent {
  final Transfer transfer;

  const TransferCash(this.transfer);

  @override
  List<Object> get props => [transfer];

  @override
  String toString() => 'Transfering cash {transfer: $transfer}';
}

