
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'dashboasrd.dart';
import 'main.dart';

Future<void> app() async{
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
   runApp(MyApply());
}


class MyApply extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Application()
    );
  }
}

class Application extends  StatefulWidget {
  @override
  State<Application> createState() => ApplicationState();
}

class ApplicationState extends State<Application> {

  //FIREBASE
  final CollectionReference _application = FirebaseFirestore.instance.collection("application");
  final CollectionReference _calculates = FirebaseFirestore.instance.collection("calculates");

  String? gender;
  TextEditingController calculationId = TextEditingController();
  TextEditingController customerName = TextEditingController();
  TextEditingController customerEmail = TextEditingController();
  TextEditingController netIncome = TextEditingController();
  TextEditingController customerAGe = TextEditingController();


  TextEditingController loantType = TextEditingController();


  String? calculationsId;


  String? loanamount;
  String? months;
  String? interestrate;
  String? interestamount;
  String? monthlypay;
  String? totallypay;

  DocumentSnapshot? documentSnapshot;



 serachIds(){
   loantType.text = documentSnapshot!['loantype'];
   loanamount = documentSnapshot!['loanamount'];
   months = documentSnapshot!['numberofmonths'];
   interestrate = documentSnapshot!['interestrate'];
   interestamount = documentSnapshot!['interestamount'];
   monthlypay = documentSnapshot!['monthlypayble'];
   totallypay = documentSnapshot!['totalypayble'];
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
          title: Text('Apply for Loan',style: TextStyle(color: Colors.black, fontSize: 20),),
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

                SizedBox(height:5.0),
                    TextField(
                      decoration: InputDecoration(
                        prefixIcon: new Icon(Icons.search,color: Colors.black,),
                        border: OutlineInputBorder(),
                        hintText: 'Enter Calculation Id',
                      ),
                      controller: calculationId,
                    ),

                SizedBox(height: 10.0),
                SizedBox(
                  width: 300.0,
                  height: 40.0,
                  child: ElevatedButton(
                    onPressed: () async {

                    serachIds();
                      setState(() {
                        calculationsId = calculationId.text.toString();

                      });


                    },

                    child: Text('     SEARCH     ',style: TextStyle(fontSize: 20),),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      shape: StadiumBorder(),
                      // Background color

                    ),

                  ),
                ),
                SizedBox(height: 10.0),
                TextField(
                  decoration: InputDecoration(
                    prefixIcon: new Icon(Icons.info,color: Colors.black,),
                    border: OutlineInputBorder(),
                    labelText: 'Loantype',
                  ),
                  controller: loantType,
                ),
                SizedBox(height:5.0),
                TextField(
                  decoration: InputDecoration(
                    prefixIcon: new Icon(Icons.person,color: Colors.black,),
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                  ),
                  controller: customerName,
                ),
                SizedBox(height: 5.0),
                TextField(
                  decoration: InputDecoration(
                    prefixIcon: new Icon(Icons.email,color: Colors.black,),
                    border: OutlineInputBorder(),
                    labelText: 'Email Address',
                  ),
                  controller: customerEmail,
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
                SizedBox(height:5.0),
                TextField(
                  decoration: InputDecoration(
                    prefixIcon: new Icon(Icons.wallet,color: Colors.black,),
                    border: OutlineInputBorder(),
                    labelText: 'Net Income',
                  ),
                  controller: netIncome,
                ),
                SizedBox(height:5.0),
                TextField(
                  decoration: InputDecoration(
                    prefixIcon: new Icon(Icons.info,color: Colors.black,),
                    border: OutlineInputBorder(),
                    labelText: 'Age',
                  ),
                  controller: customerAGe,
                ),
                SizedBox(height: 15.0),
                SizedBox(
                  width: 300.0,
                  height: 40.0,
                  child: ElevatedButton(
                    onPressed: () async {

                      int i1 = int.parse(calculationId.text.toString())*2;
                      String customerId = i1.toString();

                      final String customerName1 = customerName.text.toString();
                      final String gender1 = gender.toString();
                      final String customerEmail1 = customerEmail.text.toString();
                      final String netIncome1 = netIncome.text.toString();
                      final String customerAGe1 = customerAGe.text.toString();

                      final String loantype1 = loantType.text.toString();

                      String id = DateTime.now().millisecondsSinceEpoch.toString();


                      if (customerName1 != null) {
                        await _application.doc(id).set(
                            { "id": customerId,
                              "name": customerName1,
                              "email": customerEmail1,
                              "gender": gender1,
                              "netincome": netIncome1,
                              "age": customerAGe1,

                              "loantype":loantype1,
                              "loanamount": loanamount,
                              "months": months,
                              "interestrate": interestrate,
                              "interestamount": interestamount,
                              "monthlypay": monthlypay,
                              "totalpay": totallypay,
                              "status": "pending",
                            });
                        calculationId.text = " ";
                        loantType.text = " ";
                        customerName.text = " ";
                        customerEmail.text =" ";
                        netIncome.text = " ";
                        customerAGe.text = " ";


                      }
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Your customer id is: "+'${customerId}',
                          style: TextStyle(color: Colors.white,fontSize: 20 ),
                        ),
                      ));

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
                    stream: _calculates.where('id', isEqualTo: calculationsId ).snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: 1,
                          itemBuilder: (context, index) {
                         documentSnapshot = snapshot.data!.docs[index];


                         return ListTile(
                           title: Text(
                             "Print ID IS: " ,
                             style:
                             TextStyle(color: Colors.white, fontSize: 25),
                           ),
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