import 'package:chatapp/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chatapp/models/user.dart';

class AuthService{
  //sign in anonymous
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on firebase user
  MyUser _userFromFirebaseUser(User? user){
    return MyUser(uid:user!.uid);
  }

  // Auth change user stream
  Stream<MyUser?> get user{
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future signInAnon() async{
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign in with email and password

  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user= result.user;
      return _userFromFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      return null;

    }
  }

  //register with email and password

  Future registerWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user= result.user;
      // create a new document for the user for the uid
      await DatabaseService(uid: user!.uid).updateUserData('0','new crew member',100);
      return _userFromFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      return null;

    }
  }

  //sign out

Future signOut()async{
    try{
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
      return null;
    }
}

}
