
import 'package:flutter/material.dart';

import 'home_page.dart';


class FundMain extends StatefulWidget {
  static const String routeName = '/home';
  // This widget is the root of your application.
  @override
  _FundMainState createState() => _FundMainState();
}

class _FundMainState extends State<FundMain> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text('FundMe'),
          backgroundColor: Colors.cyan,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ],
        ),
        body:  Home(),
        drawer: Drawer(
                child: Padding(
                  padding: const EdgeInsets.only(top: 40.0, left: 10.0),
                  child: ListView(
                    children: <Widget>[
                      Text('FundMe ', style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 30, color: Colors.cyan,
                          fontFamily: 'helvetica'),),
                      SizedBox(height: 30),
                      Row(
                          children: <Widget>[
                            Text("Categories", style: TextStyle(fontSize: 18),),
                            Expanded(child: Divider()),
                          ]
                      ),
                      SizedBox(height: 10),
                      InkWell(
                        onTap: (){
                          //Navigator.pop(context);
                          // Navigator.of(context).pushNamed('/edit');
                          /*Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context)=> EditAccountPage(),
                              settings: RouteSettings(
                                  arguments: ''
                              ),
                            ),
                          );*/
                        },
                        child: ListTile(
                          title: Text('Medical'),
                          leading: Icon(Icons.accessible, color: Colors.cyan,),
                        ),
                      ),
                      InkWell(
                        onTap: (){},
                        child: ListTile(
                          title: Text('Religious'),
                          leading: Icon(Icons.account_balance, color: Colors.cyan,),
                        ),
                      ),
                      InkWell(
                        onTap: (){},
                        child: ListTile(
                          title: Text('Educational'),
                          leading: Icon(Icons.assignment, color: Colors.cyan,),
                        ),
                      ),
                      InkWell(
                        onTap: (){},
                        child: ListTile(
                          title: Text('Individuals'),
                          leading: Icon(Icons.accessibility, color: Colors.cyan,),
                        ),
                      ),
                      InkWell(
                        onTap: (){},
                        child: ListTile(
                          title: Text('Others'),
                          leading: Icon(Icons.apps, color: Colors.cyan,),
                        ),
                      ),
                      Divider(),
                      InkWell(
                        onTap: (){},
                        child: ListTile(
                          title: Text('Edit Profile'),
                          leading: Icon(Icons.edit, color: Colors.cyan,),
                        ),
                      ),
                      InkWell(
                        child: ListTile(
                          title: Text('About'),
                          leading: Icon(Icons.help, color: Colors.cyan,),
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              )
      ),
    );
  }
}