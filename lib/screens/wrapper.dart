import 'package:chatapp/models/user.dart';
import 'package:chatapp/screens/authenticate/authenticate.dart';
import 'package:chatapp/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class wrapper extends StatelessWidget {
  const wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    print(user);
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
    // return either Home or authenticate widget
  }
}
