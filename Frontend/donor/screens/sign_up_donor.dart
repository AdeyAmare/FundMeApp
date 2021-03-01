
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fundme/donor/donor.dart';

class SignUp1 extends StatefulWidget{

  @override
  _SignUp1State createState() => _SignUp1State();
}

class _SignUp1State extends State<SignUp1> {


  @override
  void initstate(){
    super.initState();

    GlobalKey<FormState> globalKey = GlobalKey<FormState>();


  }
  bool isAPIcallProcess = false;
  final _formKey = GlobalKey<FormState>();
  bool _formChanged = false;
  String _password;
  final Map<String, dynamic> _donor = {};
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFFFFA500),
        fontFamily: 'Helvetica',
      ),
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
                                Text('Sign Up', style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 30,
                                    fontFamily: 'helvetica'),),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                            child: Text('Welcome To FundMe. Please fill in the form below to sign up.', style: TextStyle(fontFamily: 'helvetica', color: Colors.grey),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              onSaved: (value) {
                                  setState(() {
                                    this._donor['firstname']= value;
                                  });
                                },
                              decoration: const InputDecoration(
                                hintText: 'Enter your first name',
                                labelText: 'First Name',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0, left: 20, right: 20),
                            child: TextFormField(
                              onSaved: (value) {
                                  setState(() {
                                    this._donor['lastname']= value;
                                  });
                                },
                              decoration: const InputDecoration(
                                hintText: 'Enter your last name',
                                labelText: 'Last Name',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0, left: 20, right: 20),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              onSaved: (value) {
                                  setState(() {
                                    this._donor['phone']= value;
                                  });
                                },
                              decoration: const InputDecoration(
                                hintText: 'Enter your phone number',
                                labelText: 'Phone Number',
                              ),
                            ),
                          ),Padding(
                            padding: const EdgeInsets.only(top: 15.0, left: 20, right: 20),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              onSaved: (value) {
                                  setState(() {
                                    this._donor['address']= value;
                                  });
                                },
                              decoration: const InputDecoration(
                                hintText: 'Enter your address',
                                labelText: 'Address',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0, left: 20, right: 20),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              onSaved: (value) {
                                  setState(() {
                                    this._donor['occupation']= value;
                                  });
                                },
                              decoration: const InputDecoration(
                                hintText: 'Enter your occupation',
                                labelText: 'Occupation',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0, left: 20, right: 20),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (value) {
                                  setState(() {
                                    this._donor['email']= value;
                                  });
                                },
                              decoration: const InputDecoration(
                                hintText: 'Enter your email',
                                labelText: 'Email',
                              ),

                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0, left: 20, right: 20),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              onSaved: (value) {
                                  setState(() {
                                    this._donor['username']= value;
                                  });
                                },
                              decoration: const InputDecoration(
                                hintText: 'Enter your username',
                                labelText: 'Username',
                              ),
                            ),

                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0, left: 20, right: 20),
                            child: TextFormField(
                              obscureText: true,
                              keyboardType: TextInputType.text,
                              onChanged: (val) =>  _password = val,
                              decoration: const InputDecoration(
                                hintText: 'Enter your password',
                                labelText: 'Password',
                              ),
                            ),

                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0, left: 20, right: 20),
                            child: TextFormField(
                              obscureText: true,
                              keyboardType: TextInputType.text,
                              onSaved: (value) {
                                  setState(() {
                                    this._donor['password']= value;
                                  });
                                },
                              decoration: const InputDecoration(
                                hintText: 'Confirm your password',
                                labelText: 'Confirm Password',
                              ),
                            ),

                          ),
                          Padding(
                              padding: const EdgeInsets.only(left: 10.0, right: 10, top: 40, bottom: 40),
                              child: ButtonTheme(
                                height: 50,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      side: BorderSide(color: Theme.of(context).primaryColor)),
                                  onPressed: (){
                                     final form = _formKey.currentState;
                                if (form.validate()) {
                                  form.save();
                                  final DonorEvent event = 
                                  DonorCreate(
                                      Donor(
                                        firstName: this._donor['firstname'],
                                        lastName: this._donor['lastname'],
                                        phoneNumber: this._donor['phone'],
                                        address: this._donor['address'],
                                        emailAddress: this._donor['email'],
                                        occupation: this._donor['occupation'],
                                        username: this._donor['username'],
                                        password: this._donor['password'],
                                      ),
                                    );

                                  BlocProvider.of<DonorBloc>(context).add(event);
                                  
                                  // Navigator.of(context).pushNamed(
                                  //     DonorsList.routeName);
                          

                    }
                                  },
                                  textColor: Colors.white,
                                  color: Theme.of(context).primaryColor,
                                  child: Text("Sign up".toUpperCase(),
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
}