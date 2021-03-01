import 'package:flutter/material.dart';
import 'package:fundme/config/config.dart';
import 'package:fundme/donor/donor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignIn extends StatefulWidget{

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  @override
  void initstate() {
    super.initState();
    
  }

  bool isAPIcallProcess = false;
  final _formKey = GlobalKey<FormState>();
  bool _formChanged = false;
    final Map<String, dynamic> _donor = {};


  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        //backgroundColor: Colors.white,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: Text('FundMe ', style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 38, color: Colors.cyan,
                  fontFamily: 'helvetica'),),
            ),
            Card(
                    elevation: 5.0,
                    margin: EdgeInsets.fromLTRB(20, 50, 20, 0),
                    child: Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.7,
                        child:Form(
                          key: _formKey,
                          onChanged: _onFormChange,
                          child: ListView(
                            //shrinkWrap: true,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
                                    child: Text('Sign In', style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 30,
                                        fontFamily: 'helvetica'),),

                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20, 0, 0, 5),
                                child: Text(
                                  'Welcome To FundMe. Please enter your username to log in',
                                  style: TextStyle(fontFamily: 'helvetica',
                                      color: Colors.grey),),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                    onSaved: (value) {
                                  setState(() {
                                    this._donor['username']= value;
                                  });
                                },
                                  decoration: const InputDecoration(
                                    icon: const Icon(Icons.account_circle),
                                    hintText: 'Enter your username',
                                    labelText: 'Username',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20.0, left: 20, right: 20),
                                child: TextFormField(
                                    onSaved: (value) {
                                  setState(() {
                                    this._donor['lastname']= value;
                                  });
                                },
                                 obscureText: true,
                              keyboardType: TextInputType.text,
                                  decoration: const InputDecoration(
                                    icon: const Icon(Icons.vpn_key),
                                    hintText: 'Enter your password',
                                    labelText: 'Password',
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10, top: 40),
                                  child: ButtonTheme(
                                    height: 50,
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30.0),
                                          side: BorderSide(color: Theme
                                              .of(context)
                                              .primaryColor)),
                                      onPressed: () {
                                         final form = _formKey.currentState;
                                if (form.validate()) {
                                  form.save();
                                  final DonorEvent event = 
                                  DonorLogin(
                                      Donor(
                                        firstName: '',
                                        lastName: '',
                                        phoneNumber: '',
                                        address: '',
                                        emailAddress: '',
                                        occupation: '',
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
                                      color: Theme
                                          .of(context)
                                          .primaryColor,
                                      child: Text("Sign In".toUpperCase(),
                                          style: TextStyle(fontSize: 14,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  )
                              ),
                              (Config.loggedIn)?SizedBox():Text('Username or Password is incorrect',style:TextStyle(color: Colors.red)),
                              Padding(
                                padding: const EdgeInsets.only(top: 30.0, left: 10, right: 10),
                                child: Row(
                                    children: <Widget>[
                                      Expanded(child: Divider()),
                                      Text("OR"),
                                      Expanded(child: Divider()),
                                    ]
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Center(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text('Don\'t have an account? '),
                                      Text('Sign up', style: TextStyle(color: Colors.cyan),)
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                    ),
                  ),
          ],
        )
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