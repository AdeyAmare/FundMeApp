import 'package:flutter/material.dart';
import 'package:fundme/all_route.dart';

class DetailCharities extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Title",
            style: TextStyle(color: Colors.white, fontSize: 24.0),
          ),
          backgroundColor: Colors.cyan,
        ),
        body: Column(
          children: [
            Image.asset('images/im.jpg'),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(right: 30.0, left: 30),
              child: Text('Description'),
            ),
            RaisedButton(
              child: Text('Donate'),
              onPressed:(){}
            )
          ],
        )
    );
  }

}