import 'package:flutter/material.dart';

class ApproveIndividuals extends StatelessWidget {
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
        body: ListView(
          shrinkWrap: true,
          children: [
            Image.asset('images/im.jpg'),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(right: 30.0, left: 30),
              child: Text('Description'),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(right: 30.0, left: 30),
              child: Text('Date: '),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(right: 30.0, left: 30),
              child: Text('Goal: '),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10, top: 40, bottom: 40),
                child: ButtonTheme(
                  height: 50,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: BorderSide(color: Theme.of(context).primaryColor)),
                    onPressed: (){},
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    child: Text("Approve".toUpperCase(),
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  ),
                )
            ),
          ]
        )
    );
  }


}