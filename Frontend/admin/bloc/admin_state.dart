import 'package:equatable/equatable.dart';
import 'package:fundme/recipient/model/models.dart';

class RecipientState extends Equatable {
  const RecipientState();

  @override
  List<Object> get props => [];
}

class RecipientLoading extends RecipientState {}

class RecipientsLoadSuccess extends RecipientState {
  final List<Recipient> recipients;

  RecipientsLoadSuccess([this.recipients = const []]);

  @override
  List<Object> get props => [recipients];
}

class RecipientOperationFailure extends RecipientState {}


