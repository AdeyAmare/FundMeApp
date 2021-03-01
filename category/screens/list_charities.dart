import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fundme/category/category.dart';

class ListCharities extends StatefulWidget {
  @override
  _ListCharitiesState createState() => _ListCharitiesState();
}

class _ListCharitiesState extends State<ListCharities> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('Orders', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.cyan,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
             child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (_, state) {
          if (state is CategoryOperationFailure) {
            return Text('Could not do category operation');
          }

          if (state is CategoriesLoadSuccess) {
            final categories = state.categories.where((category)=> category.type == 'Hospital');
              return ListView.builder(
                  itemCount: 5,//snapshot.data.length, //items.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    // downloadImagee(snap.data.documents[index]['image']);
                    return GestureDetector(
                      child: Card(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 100,
                                height: 100,
                                child: Image.asset('images/im.jpg'),
                                //color: containerColor,
                              ),
                              Text('Title'),
                              IconButton(
                                icon: Icon(Icons.chevron_right,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {},
                    );
                  }
                  );
          }
          return Center(child:CircularProgressIndicator());
          }
             )
          )
                  
        ));
  }
}
