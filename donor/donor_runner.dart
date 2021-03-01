import "package:flutter/material.dart";
import 'package:fundme/donor/donor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DonorApp extends StatelessWidget {
  final DonorRepository donorRepository;

  DonorApp({@required this.donorRepository})
      : assert(donorRepository != null);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: this.donorRepository,
      child: BlocProvider(
        create: (context) => DonorBloc(donorRepository: this.donorRepository)
          ..add(DonorLoad()),
        child: MaterialApp(
          title: 'Fundme',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          onGenerateRoute: DonorAppRoute.generateRoute,
        ),
      ),
    );
  }
}
