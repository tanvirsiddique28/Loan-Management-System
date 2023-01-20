import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'dashboasrd.dart';
import 'main.dart';

Future<void> reg() async{
  await WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyReg());
}

class MyReg extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Registration()
    );
  }
}

class Registration extends  StatefulWidget {
  @override
  State<Registration> createState() => RegistrationState();
}

class RegistrationState extends State<Registration> {
  String? gender;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController netincome = TextEditingController();

  //FIREBASE
  final CollectionReference _registration = FirebaseFirestore.instance.collection("registration");

  DocumentSnapshot? documentSnapshot;

  String? printId;
  String? customerID;


  void calculateId(){
    try{
      String s1 = documentSnapshot!.get('id');
      int i1 = int.parse(s1)+1;
      printId = i1.toString();
      customerID = i1.toString();
    }catch(e){
      printId = "1";
      customerID = "1";
    }

  }
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()),);
                },
              ),
            ],
          ),
          title: Text('Customer Registration',style: TextStyle(color: Colors.black, fontSize: 20),),
          backgroundColor: Colors.white,
          centerTitle: true,
          actions: [
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.logout,color: Colors.black,),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LogIn()),);
                  },
                ),
              ],
            ),
          ],
        ),

        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            margin: EdgeInsets.all(10.0),
            height: containerheight,
            width: containerwidth,
            child: Column(
              children:<Widget> [

                    TextField(
                      decoration: InputDecoration(
                        prefixIcon: new Icon(Icons.person,color: Colors.black,),
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                      ),
                      controller: name,
                    ),

                SizedBox(height: 15.0),

                    TextField(
                      decoration: InputDecoration(
                        prefixIcon: new Icon(Icons.email,color: Colors.black,),
                        border: OutlineInputBorder(),
                        labelText: 'Email Address',
                      ),
                      controller: email,
                    ),

                SizedBox(height: 15.0),


                    TextField(
                      decoration: InputDecoration(
                        prefixIcon: new Icon(Icons.info,color: Colors.black,),
                        border: OutlineInputBorder(),
                        labelText: 'Age',
                      ),
                      controller: age,
                    ),

                SizedBox(height: 10.0),
                Row(
                  children: [
                    SizedBox(width: 40.0),
                    Column(children: [
                      Text('Select Gender:-',
                        style: TextStyle(color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ],),
                    SizedBox(width: 10.0),
                    Column(children: [
                      Radio(value: "male", groupValue: gender, onChanged:(value){
                        setState(() {
                          gender = value.toString();
                        });
                      }),
                      SizedBox(width: 10.0),
                      Text("Male")
                    ],),
                    SizedBox(width: 10.0),
                    Column(children: [
                      Radio(value: "female", groupValue: gender, onChanged:(value){
                        setState(() {
                          gender = value.toString();
                        });
                      }),
                      SizedBox(width: 10.0),
                      Text("Female")
                    ],),
                    SizedBox(width: 10.0),
                    Column(children: [
                      Radio(value: "other", groupValue: gender, onChanged:(value){
                        setState(() {
                          gender = value.toString();
                        });
                      }),
                      SizedBox(width: 10.0),
                      Text("Other")
                    ],),
                  ],
                ),
                SizedBox(height: 5.0),


                    TextField(
                      decoration: InputDecoration(
                        prefixIcon: new Icon(Icons.info,color: Colors.black,),
                        border: OutlineInputBorder(),
                        labelText: 'Net Income',
                      ),
                      controller: netincome,
                    ),

                SizedBox(height: 15.0),
                SizedBox(
                    width: 300.0,
                    height: 60.0,
                  child: ElevatedButton(
                    onPressed: () async {
                      calculateId();
                      String id = DateTime.now().millisecondsSinceEpoch.toString();

                      final String gender1 = gender.toString();
                      final String name1 = name.text.toString();
                      final String email1 = email.text.toString();
                      final String age1 = age.text.toString();
                      final String netincome1 = netincome.text.toString();

                      if (netincome1 != null) {
                        await _registration.doc(id).set(
                            { "id": customerID,
                              "gender": gender1,
                              "name": name1,
                              "email": email1,
                              "age": age1,
                              "netincome": netincome1,

                            });

                       name.text = " ";
                       email.text= " ";
                       age.text= " ";
                       netincome.text= " ";

                      }


                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Saved",
                          style: TextStyle(color: Colors.white,fontSize: 20 ),
                        ),
                      ));
                      setState(() {


                      });
                    },

                    child: Text('     SAVE     ',style: TextStyle(fontSize: 20),),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      shape: StadiumBorder(),
                      // Background color
                    ),
                  ),
                ),

                SizedBox(height: 15.0),

                Flexible(
                  child: StreamBuilder(

                    stream: _registration.snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {

                        return ListView.builder(
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            documentSnapshot = snapshot.data!.docs[snapshot.data!.docs.length-1];
                            return Card(
                              margin: EdgeInsets.all(10),
                              child: ListTile(
                                title: Text("Customer ID IS: "+'${printId}',style: TextStyle(color: Colors.white, fontSize: 25),),
                              ),
                              color: Colors.black,
                            );
                          },
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),






              ],
            ),
          ),
        )



    );
  }
}