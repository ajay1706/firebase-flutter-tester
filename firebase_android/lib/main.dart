import 'package:firebase_android/model/model.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:firebase_database/firebase_database.dart';
final FirebaseDatabase database = FirebaseDatabase.instance;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Community Board',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {



  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Board> boardMessages = List();
  Board board;
  final FirebaseDatabase database = FirebaseDatabase.instance;

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
DatabaseReference databaseReference;

  @override
  void initState() {
    super.initState();
    board = Board("","");
    databaseReference = database.reference().child("Community Board");
    databaseReference.onChildAdded.listen(_onEntryAdded);
databaseReference.onChildAdded.listen(_onEntryChanged);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Board"),
      ),
      body:Column(
        children: <Widget>[


          FlatButton(
          child: Text("Google-Sign In"),
      color: Colors.red,
      onPressed: () => _googleSignin(),
      ),
          FlatButton(
          child: Text("Signin with Email"),
            onPressed: (){},

          ),

          FlatButton(
    child: Text("Create account"),
    onPressed: () {},
    ),


          Flexible(
            flex: 0,
            child: Form(

              child: Form(
              key: formkey,
              child: Flex(
                direction: Axis.vertical,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.subject),
                    title: TextFormField(
                      initialValue: "",
                      onSaved: (val) => board.subject = val,
                      validator: (val) => val == "" ? val:null,
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.message),
                    title: TextFormField(
                      initialValue: "",
                      onSaved: (val) =>board.body = val,
                      validator: (val) =>val=="" ? val:null,
                    ),

                  ),
                  //Send or post button

FlatButton(
  child: Text("post",
  style: TextStyle(
    color: Colors.white
  ),),
  color: Colors.redAccent,
  onPressed: () {
    handleSubmit();
  },
),

                ],

              ),
            ),
          ),
          ),
         new Padding(
           padding: const EdgeInsets.fromLTRB(0.0,2.0,0.0,12.0),

         ) ,
          Flexible(
            child: FirebaseAnimatedList(
              query: databaseReference,
              itemBuilder: (_,DataSnapshot snapshot,
                  Animation<double> animation, int index){

                return new Card(
                  child: ListTile(
                    leading:CircleAvatar(
                      backgroundColor: Colors.red,
                    ) ,
                    title: Text(boardMessages[index].subject),
                    subtitle:Text(boardMessages[index].body) ,
                  ),
                );

              },


            ),
          )



        ],
      )
    );
  }

  void _onEntryAdded(Event event) {

    setState(() {

      boardMessages.add(Board.fromSnapshot(event.snapshot));


    });




  }

  void handleSubmit() {

    final FormState form = formkey.currentState;
    if (form.validate()){
      form.save();
    form.reset();
    // save data to the database


databaseReference.push().set(board.toJson());



    }





  }

  void _onEntryChanged(Event event) {
    var oldEntry = boardMessages.singleWhere((entry){
      return entry.key == event.snapshot.key;


    }
  );

   setState(() {
     boardMessages[boardMessages.indexOf(oldEntry)] = Board.fromSnapshot(event.snapshot);
   });

  }

  _googleSignin() {}
}
