import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'listIndividuals_page.dart';
import 'list_charities.dart';

class Admin extends StatelessWidget {
  List<Widget> containers = [
    ListIndividuals(),
    Container(
      child: MyCustomForm(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
              title: Text("Admin", style: TextStyle(color: Colors.white)),
              bottom: TabBar(
                tabs: [
                  Tab(text: "Individual recipients"),
                  Tab(text: "Organization")
                ],
              )),
          body: TabBarView(
            children: containers,
          ),
        ));
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  File fileImage;
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  String value;
  List items = ["Medical", "Religious", "Educational", "Others"];
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextFormField(
              keyboardType: TextInputType.text,
              //onChanged: (val) => user.first_name = val,
              decoration: const InputDecoration(
                hintText: 'Enter your charity organization name',
                labelText: 'Charity Name',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 20, right: 20),
            child: TextFormField(
              //keyboardType: TextInputType.number,
              //onChanged: (val) => user.last_name = val,
              decoration: const InputDecoration(
                hintText: 'Enter description',
                labelText: 'Description',
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20),
                child: Text('Choose Type: ' ,style: TextStyle(fontSize: 18),),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20),
                child: Container(
                    child: Center(
                        child: DropdownButton(
                            hint: Text("Category"),
                            value: value,
                            icon: Icon(Icons.arrow_drop_down),
                            onChanged: (newvalue) {
                              setState(() {
                                value = newvalue;
                              });
                            },
                            items: items.map((valueItem) {
                              return DropdownMenuItem(
                                  value: valueItem, child: Text(valueItem));
                            }).toList()))),
              ),
            ],
          ),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 20, right: 20),
                child: OutlineButton(
                  borderSide: BorderSide(color: Colors.grey, width: 2.5),
                  onPressed: (){
                    _selectImage(ImagePicker.pickImage(source: ImageSource.gallery));
                  },
                  child: _displayImg(),
                )
            ),
          ),
          SizedBox(height: 20),
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
                  child: Text("Create".toUpperCase(),
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ),
              )
          ),
        ],
      ),
    );
  }
  void _selectImage(Future<File> pickImage) async{
    File tempImage = await pickImage;
    setState((){
      fileImage = tempImage;
    });
  }

  Widget _displayImg() {
    if(fileImage == null){
      return Center(
        child: Icon(Icons.add, color: Colors.grey),
      );
    } else{
      return Image.file(fileImage);
    }

  }

}

class ListItems {
  final String description;
  final String imageURL;

  ListItems({this.description, this.imageURL});
}

List<ListItems> listitems = [
  ListItems(description: "Description 1", imageURL: ""),
  ListItems(description: "Description 2", imageURL: ""),
  ListItems(description: "Description 3", imageURL: ""),
  ListItems(description: "Description 4", imageURL: ""),
];
