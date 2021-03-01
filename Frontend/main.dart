import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fundme/bloc_observer.dart';
import 'package:fundme/donor/donor.dart';
import 'package:fundme/category/category.dart';
import 'package:fundme/recipient/recipient.dart';
import 'package:fundme/recipientinfo/recipientinfo.dart';
import 'package:http/http.dart' as http;
import 'package:fundme/all_route.dart';
import 'package:fundme/home/home.dart';

// void main() {
//   Bloc.observer = SimpleBlocObserver();

//   final CategoryRepository categoryRepository = CategoryRepository(
//     dataProvider: CategoryDataProvider(
//       httpClient: http.Client(),
//     ),
//   );

//   runApp(
//     CategoryApp(categoryRepository: categoryRepository),
//   );
// }

class CategoryApp extends StatelessWidget {
  final CategoryRepository categoryRepository;

  CategoryApp({@required this.categoryRepository})
      : assert(categoryRepository != null);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: this.categoryRepository,
      child: BlocProvider(
        create: (context) => CategoryBloc(categoryRepository: this.categoryRepository)
          ..add(CategoryLoad()),
        child: MaterialApp(
          title: 'Fundme',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          onGenerateRoute: CategoryAppRoute.generateRoute,
        ),
      ),
    );
  }
}


//Donor
void main() {
  Bloc.observer = SimpleBlocObserver();

  final DonorRepository donorRepository = DonorRepository(
    dataProvider: DonorDataProvider(
      httpClient: http.Client(),
    ),
  );

   final CategoryRepository categoryRepository = CategoryRepository(
    dataProvider: CategoryDataProvider(
      httpClient: http.Client(),
    ),
  );

  runApp(
    DonorApp(donorRepository: donorRepository),
  );
}

class DonorApp extends StatelessWidget {
  final DonorRepository donorRepository;
  final CategoryRepository categoryRepository;

  DonorApp({@required this.donorRepository, @required this.categoryRepository})
      : assert(donorRepository != null);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
     providers: [
   RepositoryProvider.value(
      value: this.donorRepository,
      child: BlocProvider(
        create: (context) => DonorBloc(donorRepository: this.donorRepository),
          
        // child: MaterialApp(
        //   title: 'Fundme',
        //   theme: ThemeData(
        //     primarySwatch: Colors.blue,
        //     visualDensity: VisualDensity.adaptivePlatformDensity,
            
        //   ),
        //   onGenerateRoute: DonorAppRoute.generateRoute,
        // ),
      ),
   ),
   RepositoryProvider.value(
      value: this.categoryRepository,
      child: BlocProvider(
        create: (context) => CategoryBloc(categoryRepository: this.categoryRepository)
         
        // child: MaterialApp(
        //   title: 'Fundme',
        //   theme: ThemeData(
        //     primarySwatch: Colors.blue,
        //     visualDensity: VisualDensity.adaptivePlatformDensity,
        //   ),
        //   onGenerateRoute: DonorAppRoute.generateRoute,
        // ),
      ),
   ),
      ],
      child: MaterialApp(
          title: 'Fundme',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: FundMain() ,
          onGenerateRoute: DonorAppRoute.generateRoute,
        ),
    );
  }
}

//Recipient
// void main() {
//   Bloc.observer = SimpleBlocObserver();

//   final RecipientRepository recipientRepository = RecipientRepository(
//     dataProvider: RecipientDataProvider(
//       httpClient: http.Client(),
//     ),
//   );

//   runApp(
//     RecipientApp(recipientRepository: recipientRepository),
//   );
// }

class RecipientApp extends StatelessWidget {
  final RecipientRepository recipientRepository;

  RecipientApp({@required this.recipientRepository})
      : assert(recipientRepository != null);

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
        ),
      ),
    );
  }
}


// void main() {
//   Bloc.observer = SimpleBlocObserver();

//   final RecipientInfoRepository recipientinfoRepository = RecipientInfoRepository(
//     dataProvider: RecipientInfoDataProvider(
//       httpClient: http.Client(),
//     ),
//   );

//   runApp(
//     RecipientInfoApp(recipientinfoRepository: recipientinfoRepository),
//   );
// }

class RecipientInfoApp extends StatelessWidget {
  final RecipientInfoRepository recipientinfoRepository;

  RecipientInfoApp({@required this.recipientinfoRepository})
      : assert(recipientinfoRepository != null);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: this.recipientinfoRepository,
      child: BlocProvider(
        create: (context) => RecipientInfoBloc(recipientinfoRepository: this.recipientinfoRepository)
          ..add(RecipientInfoLoad()),
        child: MaterialApp(
          title: 'Fundme',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          onGenerateRoute: RecipientInfoAppRoute.generateRoute,
        ),
      ),
    );
  }
}
