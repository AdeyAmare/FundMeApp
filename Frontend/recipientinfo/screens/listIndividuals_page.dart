import 'package:flutter/material.dart';

class ListIndividuals extends StatefulWidget {
  @override
  _ListIndividualsState createState() => _ListIndividualsState();
}

class _ListIndividualsState extends State<ListIndividuals> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
              child: ListView.builder(
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
                              Text('Individual Name'),
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
                  })),
        );
  }
}
