import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fundme/donor/bloc/bloc.dart';
import 'package:fundme/donor/donor.dart';

class DonorsList extends StatelessWidget {
  static const routeName = '/';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Donors'),
      ),
      body: BlocBuilder<DonorBloc, DonorState>(
        builder: (_, state) {
          if (state is DonorOperationFailure) {
            return Text('Could not do donor operation');
          }

          if (state is DonorsLoadSuccess) {
            final donors = state.donors;

            return ListView.builder(
              itemCount: donors.length,
              itemBuilder: (_, idx) => ListTile(
                title: Text('${donors[idx].firstName} ${donors[idx].lastName}'),
                subtitle: Text('${donors[idx].phoneNumber}'),
                onTap: () => Navigator.of(context)
                    .pushNamed(DonorDetail.routeName, arguments: donors[idx]),
              ),
            );
          }

          return CircularProgressIndicator();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(
          AddUpdateDonor.routeName,
          arguments: DonorArgument(edit: false),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
