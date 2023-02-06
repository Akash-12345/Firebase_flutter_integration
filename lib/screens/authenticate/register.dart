import 'package:chatapp/services/auth.dart';
import 'package:chatapp/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/screens/authenticate/authenticate.dart';
import 'package:chatapp/shared/constants.dart';
class Register extends StatefulWidget {
  final Function toggleview;
  Register({required this.toggleview});
  @override
  State<Register> createState() => _RegisterState();
}


class _RegisterState extends State<Register> {


  final AuthService _auth =AuthService();
  final _formkey=GlobalKey<FormState>();
  String email='';
  String password='';
  String error='';
  bool loading=false;

  @override
  Widget build(BuildContext context) {
    return loading?Loading(): Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Register To Brew Crew'),
        actions: [
          FloatingActionButton.extended(
            elevation: 0.0,
            backgroundColor: Colors.brown[400],
            onPressed: (){
              widget.toggleview();
            }, icon: Icon(Icons.person),
            label: Text('Sign In'),)
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key:_formkey,
          child: Column(
            children: [
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),

                //validator: (val)=> val.isEmpty?'Enter an email':null,
                  validator: (String? val) {
                    if (val!.isEmpty) {
                      return "Enter a valid Email";
                    }
                    return null;
                  },
                  onChanged: (val) {
                setState(() {
                  email=val;
                });
              }),
              SizedBox(height: 20.0),
              TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Password'),
                  validator: (String? val) {
                    if (val!.length<6) {
                      return "Enter a strong password";
                    }
                    return null;
                  },
                  obscureText: true, onChanged: (val) {
                setState(() {
                  password=val;
                });
              }),
              SizedBox(height: 20.0),
              FloatingActionButton.extended(
                  backgroundColor: Colors.pink,
                  onPressed: () async{
                    if(_formkey.currentState!.validate()){
                      setState(() {
                        loading=true;
                      });
                      dynamic result=await _auth.registerWithEmailAndPassword(email, password);
                      if (result==null){
                        setState(() {
                          error='please enter a valid email id';
                          loading=false;
                        });
                      }
                    }

                  },
                  label: (Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ))),
              SizedBox(height: 20.0),
              Text(
                error,
                style: TextStyle(color: Colors.red,fontSize: 14.0),
              )

            ],
          ),
        ),
      ),
    );
  }
}

