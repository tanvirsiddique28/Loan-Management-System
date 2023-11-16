

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:loanmanagementsystem/auth/auth_form.dart';
import 'package:loanmanagementsystem/pages/emicalculator.dart';


Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp(),);

}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      primaryIconTheme: IconThemeData(color: Colors.black),
      ),
      home: StreamBuilder(
        stream:FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return EmiCalculator();
          }else{
            return AuthForm();
          }
        },
      ),
    );
  }
}
