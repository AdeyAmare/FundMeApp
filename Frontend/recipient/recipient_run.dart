import "package:flutter/material.dart";
import 'package:fundme/recipient/recipient.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fundme/all_route.dart';
class RecipientApp extends StatelessWidget {
  final RecipientRepository recipientRepository;

  RecipientApp({@required this.recipientRepository})
      : assert(recipientRepository != null);
RecipientArgument args = RecipientArgument(edit: false);
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: this.recipientRepository,
      child: BlocProvider(
        create: (context) => RecipientBloc(recipientRepository: this.recipientRepository)
          ..add(RecipientLoad()),
        child: MaterialApp(
          title: 'Fundme',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          onGenerateRoute: AllAppRoute.generateRoute,
          home: AddUpdateRecipient(args:args)
        ),
      ),
    );
  }
}