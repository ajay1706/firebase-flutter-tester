import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
   final FirebaseAuth _auth = FirebaseAuth.instance;
   final GoogleSignIn googleSignIn = new GoogleSignIn();


   Future<FirebaseUser> _signIn() async{
     GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
     GoogleSignInAuthentication gsa = await googleSignInAccount.authentication;


     FirebaseUser user = await _auth.signInWithGoogle(
       idToken:gsa.idToken;
    accessToken:gsa.accessToken
     );
     print("username: ${user.displayName}");
   }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("firebase demo",
        style: TextStyle(
          color: Colors.black
        ),),
        backgroundColor: Colors.yellow.shade800,
      ),
      body:
      new Padding(
        padding: const EdgeInsets.all(20.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new RaisedButton(
              onPressed: null,
              child: Text("Sign-In"),
              color: Colors.green,
            ),
            new RaisedButton(
              onPressed: null,
              child: Text("Sign-out"),
              color: Colors.red,
            )
          ],
        ),
      )
    );
  }
}
