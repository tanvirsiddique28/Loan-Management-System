import 'package:flutter/material.dart';
import 'package:loanmanagementsystem/auth/auth_screen.dart';
class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar:AppBar(
        title: Text('Authentication',style: TextStyle(color: Colors.black,fontSize: 20),),
        backgroundColor: Colors.white,
      ),
      body: AuthScreen(),
    );
  }
}

