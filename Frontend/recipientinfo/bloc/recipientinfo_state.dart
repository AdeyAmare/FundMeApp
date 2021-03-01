import 'package:equatable/equatable.dart';
import 'package:fundme/recipientinfo/model/models.dart';

class RecipientInfoState extends Equatable {
  const RecipientInfoState();

  @override
  List<Object> get props => [];
}

class RecipientInfoLoading extends RecipientInfoState {}

class RecipientInfosLoadSuccess extends RecipientInfoState {
  final List<RecipientInfo> recipientinfos;

  RecipientInfosLoadSuccess([this.recipientinfos = const []]);

  @override
  List<Object> get props => [recipientinfos];
}

class RecipientInfoOperationFailure extends RecipientInfoState {}
