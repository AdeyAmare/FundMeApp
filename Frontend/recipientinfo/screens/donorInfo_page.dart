import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class DonorInfoPage extends StatefulWidget{

  @override
  _DonorInfoPageState createState() => _DonorInfoPageState();
}

class _DonorInfoPageState extends State<DonorInfoPage> {
  File fileImage;

  @override
  void initstate(){
    super.initState();

    GlobalKey<FormState> globalKey = GlobalKey<FormState>();


  }
  bool isAPIcallProcess = false;
  final _formKey = GlobalKey<FormState>();
  bool _formChanged = false;
  String _username;
  String _password;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        //backgroundColor: Colors.white,
        body: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Card(
                elevation: 5.0,
                margin: EdgeInsets.fromLTRB(15, 50, 15, 0),
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.9,
                    child: Form(
                      key: _formKey,
                      onChanged: _onFormChange,
                      child: ListView(
                        shrinkWrap: true,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('FundMe ', style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 30, color: Colors.cyan,
                                    fontFamily: 'helvetica'),),
                                Text('Donation Page', style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 30,
                                    fontFamily: 'helvetica'),),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                            child: Text('Welcome To FundMe. Please fill in the form below.', style: TextStyle(fontFamily: 'helvetica', color: Colors.grey),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
                            child: Text('Name: ' ,style: TextStyle(fontSize: 18),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              //onChanged: (val) => user.first_name = val,
                              decoration: const InputDecoration(
                                hintText: 'Enter your account number',
                                labelText: 'Account Number',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0, left: 20, right: 20),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              //onChanged: (val) =>  user.store_name = val,
                              decoration: const InputDecoration(
                                hintText: 'Enter your amount',
                                labelText: 'Amount',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20, top:40),
                            child: Text('Bank Info: ' ,style: TextStyle(fontSize: 18),),
                          ),
                          //SizedBox(height: 20),
                          Padding(
                              padding: const EdgeInsets.only(left: 10.0, right: 10, top: 60, bottom: 40),
                              child: ButtonTheme(
                                height: 50,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      side: BorderSide(color: Theme.of(context).primaryColor)),
                                  onPressed: (){},
                                  textColor: Colors.white,
                                  color: Theme.of(context).primaryColor,
                                  child: Text("Donate".toUpperCase(),
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                ),
                              )
                          ),
                        ],
                      ),
                    )

                ),
              )
            ]
        ),
      ),
      //Text('kjfdjfb')
    );

  }

  void _onFormChange() {
    if (_formChanged) return;
    setState(() {
      _formChanged = true;
    });
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