
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loanmanagementsystem/pages/emicalculator.dart';
class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  //--------------------------------------
  final _formKey = GlobalKey<FormState>();
  bool _isLoginPage = false;
  //form fields value--------------------
  var _name = '';
  var _email = '';
  var _password = '';
  //functions------------
  startSignup(){
    final validity = _formKey.currentState?.validate();
    if(validity!){
      _formKey.currentState?.save();
      submitForm(_name, _email, _password);

    }
  }
  submitForm(String name,String email,String password,)async{

    final auth = FirebaseAuth.instance;

    try{
      if(_isLoginPage){
        final authResult = await auth.signInWithEmailAndPassword(email: email, password: password);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>EmiCalculator()), (route) => false);
      }else{
        final authResult = await auth.createUserWithEmailAndPassword(email: email, password: password);
        String? uid = authResult.user?.uid;
        await FirebaseFirestore.instance.collection('users').doc(uid).set(
            {
              'username':name,
              'email':email,
            }
        );
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>EmiCalculator()), (route) => false);
      }


    }catch(e){
        print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset("images/person.png",width: 150,height: 150,),
                SizedBox(height: 10,),
                if(!_isLoginPage)
                TextFormField(
                  keyboardType: TextInputType.name,
                  key: ValueKey('username'),
                  validator: (String?value){
                      if(value!.isEmpty){
                        return 'Enter Username';
                      }else{
                        return null;
                      }
                  },
                  onSaved: (value){
                    _name = value!;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: new BorderSide(),
                    ),
                    labelText: 'Enter Username',
                    labelStyle: GoogleFonts.roboto(),
                  ),
                ),
                SizedBox(height: 15,),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  key: ValueKey('email'),
                  validator: (String?value){
                    if(value!.isEmpty){
                      return 'enter email';
                    }else{
                      return null;
                    }
                  },
                  onSaved: (value){
                    _email = value!;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: new BorderSide(),
                    ),
                    labelText: 'Enter Email',
                    labelStyle: GoogleFonts.roboto(),
                  ),
                ),
                SizedBox(height: 15,),
                TextFormField(
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  key: ValueKey('password'),
                  validator: (String?value){
                    if(value!.isEmpty){
                      return 'Enter Password';
                    }else{
                      return null;
                    }
                  },
                  onSaved: (value){
                    _password = value!;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: new BorderSide(),
                    ),
                    labelText: 'Enter Password',
                    labelStyle: GoogleFonts.roboto(),
                  ),
                ),
                SizedBox(height: 15,),
                ElevatedButton(onPressed: (){
                  startSignup();
                },
                  child: _isLoginPage?Text('Log In'):Text('Sign Up'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    minimumSize: Size(double.infinity, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    )
                  ),
                ),
                SizedBox(height: 15,),
                TextButton(onPressed: (){
                  setState(() {
                    _isLoginPage = !_isLoginPage;
                  });
                }, child: _isLoginPage?Text('Not a member?',style: TextStyle(color: Colors.black),):Text('Already a member?',style: TextStyle(color: Colors.black),))
              ],
            ),
          ),
    );
  }
}
