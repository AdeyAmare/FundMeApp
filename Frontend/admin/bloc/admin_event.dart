import 'package:equatable/equatable.dart';
import 'package:fundme/recipient/model/models.dart';

abstract class RecipientEvent extends Equatable {
  const RecipientEvent();
}

class RecipientLoad extends RecipientEvent {
  const RecipientLoad();

  @override
  List<Object> get props => [];
}

class RecipientCreate extends RecipientEvent {
  final Recipient recipient;

  const RecipientCreate(this.recipient);

  @override
  List<Object> get props => [recipient];

  @override
  String toString() => 'Recipient Created {recipient: $recipient}';
}

class RecipientGet extends RecipientEvent {
  final Recipient recipient;

  const RecipientGet(this.recipient);

  @override
  List<Object> get props => [recipient];

  @override
  toString() => 'Recipient Got {recipient: $recipient}';
}



class RecipientUpdate extends RecipientEvent {
  final Recipient recipient;

  const RecipientUpdate(this.recipient);

  @override
  List<Object> get props => [recipient];

  @override
  String toString() => 'Recipient Updated {recipient: $recipient}';
}

class RecipientDelete extends RecipientEvent {
  final Recipient recipient;

  const RecipientDelete(this.recipient);

  @override
  List<Object> get props => [recipient];

  @override
  toString() => 'Recipient Deleted {recipient: $recipient}';
}
