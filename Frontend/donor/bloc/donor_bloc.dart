import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fundme/donor/bloc/bloc.dart';
import 'package:fundme/donor/model/donor.dart';
import 'package:fundme/donor/repository/repository.dart';

class DonorBloc extends Bloc<DonorEvent, DonorState> {
  final DonorRepository donorRepository;

  DonorBloc({@required this.donorRepository})
      : assert(donorRepository != null),
        super(DonorLoading());

  @override
  Stream<DonorState> mapEventToState(DonorEvent event) async* {
    if (event is DonorLoad) {
      yield DonorLoading();
      try {
        final donors = await donorRepository.getDonors();
        yield DonorsLoadSuccess(donors);
      } catch (e) {
        print(e);
        yield DonorOperationFailure();
      }
    }

    if (event is DonorCreate) {
      try {
        await donorRepository.createDonor(event.donor);
        final donors = await donorRepository.getDonors();
        yield DonorsLoadSuccess(donors);
      } catch (e) {
        print(e);
        yield DonorOperationFailure();
      }
    }

    if (event is DonorLogin) {
      try {
        await donorRepository.loginDonor(event.donor);
      final donors = await donorRepository.getDonors();
        yield DonorsLoadSuccess(donors);
      } catch (e) {
        print(e);
        yield DonorOperationFailure();
      }
    }

    if (event is DonorGet) {
      try {
        await donorRepository.getDonor(event.donor.id);
        final donors = await donorRepository.getDonors();
        yield DonorsLoadSuccess(donors);
      } catch (_) {
        yield DonorOperationFailure();
      }
    }

    if (event is DonorUpdate) {
      try {
        await donorRepository.updateDonor(event.donor);
         final donors = await donorRepository.getDonors();
        yield DonorsLoadSuccess(donors);
      } catch (e) {
        print(e);
        yield DonorOperationFailure();
      }
    }

    if (event is DonorDelete) {
      try {
        await donorRepository.deleteDonor(event.donor.id);
         final donors = await donorRepository.getDonors();
        yield DonorsLoadSuccess(donors);
      } catch (_) {
        yield DonorOperationFailure();
      }
    }
  }
}