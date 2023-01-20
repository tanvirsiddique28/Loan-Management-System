
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loanmanagementsystem/main.dart';
import 'package:flutter/material.dart';



class MySignup extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SignUp()
    );
  }
}

class SignUp extends  StatefulWidget {
  @override
  State<SignUp> createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    var containerheight = MediaQuery.of(context).size.height;
    var containerwidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          leading: Column(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back,color: Colors.black,),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LogIn()),);
                },
              ),
            ],
          ),
          title: Text('SignUp Form',style: TextStyle(color: Colors.black, fontSize: 20),),
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
                Column(
                  children: [
                    Image.asset('images/person.png',height: 150,),
                  ],
                ),
                SizedBox(height: 15.0),

                    TextField(
                      decoration: InputDecoration(
                        prefixIcon: new Icon(Icons.person,color: Colors.black,),
                        border: OutlineInputBorder(),
                        hintText: 'Email',
                      ),
                      controller: email,
                    ),

                SizedBox(height: 15.0),

                    TextField(
                      decoration: InputDecoration(
                        prefixIcon: new Icon(Icons.info,color: Colors.black,),
                        border: OutlineInputBorder(),
                        hintText: 'Password',
                      ),
                      controller: password,

                ),


                SizedBox(height: 15.0),
                SizedBox(
                  width: 300.0,
                  height: 40.0,
                  child:  ElevatedButton(
                    onPressed: () {
            _auth.createUserWithEmailAndPassword(
                email: email.text.toString(),
                password: password.text.toString(),
            );
                    },
                    child: Text('     Sign Up     ',style: TextStyle(fontSize: 20),),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      shape: StadiumBorder(),
                      // Background color
                    ),
                  ),

                ),

              ],
            ),
          ),
        )



    );
  }
}