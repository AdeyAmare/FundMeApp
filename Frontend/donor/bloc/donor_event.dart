import 'package:equatable/equatable.dart';
import 'package:fundme/donor/model/models.dart';

abstract class DonorEvent extends Equatable {
  const DonorEvent();
}

class DonorLoad extends DonorEvent {
  const DonorLoad();

  @override
  List<Object> get props => [];
}

class DonorCreate extends DonorEvent {
  final Donor donor;

  const DonorCreate(this.donor);

  @override
  List<Object> get props => [donor];

  @override
  String toString() => 'Donor Created {course: $donor}';
}

class DonorLogin extends DonorEvent {
  final Donor donor;

  const DonorLogin(this.donor);

  @override
  List<Object> get props => [donor];

  @override
  String toString() => 'Donor Created {course: $donor}';
}

class DonorGet extends DonorEvent {
  final Donor donor;

  const DonorGet(this.donor);

  @override
  List<Object> get props => [donor];

  @override
  toString() => 'Donor Got {donor: $donor}';
}



class DonorUpdate extends DonorEvent {
  final Donor donor;

  const DonorUpdate(this.donor);

  @override
  List<Object> get props => [donor];

  @override
  String toString() => 'Donor Updated {donor: $donor}';
}

class DonorDelete extends DonorEvent {
  final Donor donor;

  const DonorDelete(this.donor);

  @override
  List<Object> get props => [donor];

  @override
  toString() => 'Donor Deleted {donor: $donor}';
}
