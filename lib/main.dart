

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


import 'package:loanmanagementsystem/signup.dart';
import 'dashboasrd.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LogIn()
    );
  }
}

class LogIn extends  StatefulWidget {
  @override
  State<LogIn> createState() => LogInState();
}

class LogInState extends State<LogIn> {
  final CollectionReference _prints =
  FirebaseFirestore.instance.collection("prints");

  @override
  Widget build(BuildContext context) {
    var containerheight = MediaQuery.of(context).size.height;
    var containerwidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(

          title: Text('Sign In',style: TextStyle(color: Colors.black, fontSize: 20),),
          backgroundColor: Colors.white,
          centerTitle: true,
        ),

        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            margin: EdgeInsets.all(10.0),
            height: containerheight,
            width: containerwidth,
            child: Column(
              children:<Widget> [
                Image.asset('images/person.png',height: 150,),

                SizedBox(height: 15.0),

                TextField(
                  decoration: InputDecoration(
                    prefixIcon: new Icon(Icons.person,color: Colors.black,),
                    border: OutlineInputBorder(),
                    hintText: 'User Name',
                  ),
                ),

                SizedBox(height: 15.0),

                TextField(
                  decoration: InputDecoration(
                    prefixIcon: new Icon(Icons.info,color: Colors.black,),
                    border: OutlineInputBorder(),
                    hintText: 'Password',
                  ),
                ),

                SizedBox(height: 15.0),

                Text("Forgot Password",
                  style: TextStyle(color: Colors.black,fontSize:20),
                  textAlign: TextAlign.center,

                ),

                SizedBox(height: 15.0),
                SizedBox(
                  width: 300.0,
                  height: 50.0,
child:  ElevatedButton(
  onPressed: () {
    Navigator.push(context, MaterialPageRoute(builder: (context) => MyDashBoard()),);
  },
  child: Text('     Sign In     ',style: TextStyle(fontSize: 20),),
  style: ElevatedButton.styleFrom(
    primary: Colors.black,
    shape: StadiumBorder(),
    // Background color
  ),
),
                    
                ),



                SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("New User?",
                      style: TextStyle(color: Colors.black,fontSize:20),
                      textAlign: TextAlign.center,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()),);
                      },
                      child: const Text(
                        " Create Account",
                        style: TextStyle(color: Colors.black, fontSize: 20.0),

                      ),
                    ),
                  ],
                ),


              ],
            ),
          ),
        )



    );
  }
}