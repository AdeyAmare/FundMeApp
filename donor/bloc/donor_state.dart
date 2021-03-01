import 'package:equatable/equatable.dart';
import 'package:fundme/donor/model/models.dart';

class DonorState extends Equatable {
  const DonorState();

  @override
  List<Object> get props => [];
}

class DonorLoading extends DonorState {}

class DonorsLoadSuccess extends DonorState {
  final List<Donor> donors;

  DonorsLoadSuccess([this.donors = const []]);

  @override
  List<Object> get props => [donors];
}

class DonorOperationFailure extends DonorState {}
