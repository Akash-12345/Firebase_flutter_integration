import 'package:chatapp/services/auth.dart';
import 'package:chatapp/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/shared/constants.dart';
class SignIn extends StatefulWidget {
  final Function toggleview;

  SignIn({required this.toggleview});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading=false;


  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return  loading ? Loading():Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign In To Brew Crew'),
        actions: [
          FloatingActionButton.extended(

            onPressed: () {
              widget.toggleview();
            },
            icon: Icon(Icons.person),
            backgroundColor: Colors.brown[400],
            elevation:0.0,
            label: Text('Register'),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              SizedBox(height: 20.0),
              TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Email'),
                  validator: (String? val) {
                if (val!.isEmpty) {
                  return "Enter a valid Email";
                }
                return null;
              }, onChanged: (val) {
                setState(() {
                  email = val;
                });
              }),
              SizedBox(height: 20.0),
              TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Password'),
                  validator: (String? val) {
                    if (val!.length < 6) {
                      return "Enter a strong password";
                    }
                    return null;
                  },
                  obscureText: true,
                  onChanged: (val) {
                    setState(() {
                      password = val;
                    });
                  }),
              SizedBox(height: 20.0),
              FloatingActionButton(
                  backgroundColor: Colors.pink,
                  onPressed: () async {
                    //print(email);
                    // print(password);
                    if (_formkey.currentState!.validate()) {
                      setState(() {
                        loading=true;
                      });
                       dynamic result=await  _auth.signInWithEmailAndPassword(email, password);
                       if(result==null){
                         setState(() {
                           error='Could not signin with these credentials';
                           loading=false;
                         });
                       }
                      //if (result == null) {
                        //setState(() {
                          //error = 'please enter a valid email id';
                        //);
                      }
                    }
                  ,
                  child: (Text(
                    'signin',
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
