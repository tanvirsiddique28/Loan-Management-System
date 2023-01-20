


import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'dashboasrd.dart';
import 'main.dart';

Future<void> mainMyProfile() async {
  await WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyProfile());
}


class MyProfile extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CustomerProfile()
    );
  }
}

class CustomerProfile extends  StatefulWidget {




  @override
  State<CustomerProfile> createState() => CustomerProfileState();
}

class CustomerProfileState extends State<CustomerProfile> {

  final CollectionReference _payments = FirebaseFirestore.instance.collection("payments");

  TextEditingController customerId = TextEditingController();

  String? searchId;

  DocumentSnapshot? documentSnapshot;

  String? name;
  String? age;
  String? netincome;
  String? loantype;
  String? loanamount;
  String? months;
  String? installmentsdue;
  String? payremain;
  String? interests;
  String? interestamt;
  String? mpay;
  String? tpay;
  String? statuss;
  String? paydate;
  String? lastpaydate;

  m1(){

    name = documentSnapshot!.get('name');
    loantype = documentSnapshot!.get('loantype');
    statuss = documentSnapshot!.get('status');
    loanamount = documentSnapshot!.get('loanamount');
    mpay = documentSnapshot!.get('monthlypayble');
    tpay = documentSnapshot!.get('totalypayble');
    months = documentSnapshot!.get('numberofmonths');
    installmentsdue = documentSnapshot!.get('installmentsremain');
    payremain = documentSnapshot!.get('payremain');

    paydate = documentSnapshot!.get('paydate');
    lastpaydate = documentSnapshot!.get('lastpaydate');
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
          title: Text('Customer Profile',style: TextStyle(color: Colors.black, fontSize: 20),),
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
                    prefixIcon: new Icon(Icons.search,color: Colors.black,),
                    border: OutlineInputBorder(),
                    hintText: 'Enter Customer Id',
                  ),
                  controller: customerId,
                ),
                SizedBox(height: 15.0),
                SizedBox(
                  width: 300.0,
                  height: 40.0,
                  child: ElevatedButton(
                    onPressed: () async {

                      m1();
                      searchId = customerId.text.toString();

                      setState(() {

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
                SizedBox(height: 15.0),
                Flexible(
                  child: StreamBuilder(
                    stream: _payments.where('id', isEqualTo: searchId).snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            documentSnapshot = snapshot.data!.docs[snapshot.data!.docs.length-1];


                            return Container(
                              child: Table(
                                defaultColumnWidth: FixedColumnWidth(120.0),
                                border: TableBorder.all(
                                    color: Colors.black,
                                    style: BorderStyle.solid,
                                    width: 2),
                                children: [
                                  TableRow( children: [

                                    Column(children:[Text('Name:-', style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.bold)),]),
                                    Column(children:[Text('${name}', style: TextStyle(fontSize: 20.0))]),
                                  ]),
                                  TableRow( children: [

                                    Column(children:[Text('Loan Type:-', style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.bold)),]),
                                    Column(children:[Text('${loantype}', style: TextStyle(fontSize: 20.0))]),
                                  ]),
                                  TableRow( children: [

                                    Column(children:[Text('Account Status:-', style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.bold))]),
                                    Column(children:[Text('${statuss}', style: TextStyle(fontSize: 20.0))]),
                                  ]),
                                  TableRow( children: [
                                    Column(children:[Text('Loan Amount:-', style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.bold))]),
                                    Column(children:[Text('${loanamount}', style: TextStyle(fontSize: 20.0))]),

                                  ]),
                                  TableRow( children: [
                                    Column(children:[Text('Monthly Payble:-', style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.bold))]),
                                    Column(children:[Text('${mpay}', style: TextStyle(fontSize: 20.0))]),

                                  ]),
                                  TableRow( children: [
                                    Column(children:[Text('Total Payble:-', style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.bold))]),
                                    Column(children:[Text('${tpay}', style: TextStyle(fontSize: 20.0))]),

                                  ]),
                                  TableRow( children: [

                                    Column(children:[Text('Pay Remain:-', style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.bold)),]),
                                    Column(children:[Text('${payremain}', style: TextStyle(fontSize: 20.0))]),
                                  ]),
                                  TableRow( children: [

                                    Column(children:[Text('Total Installments:-', style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.bold)),]),
                                    Column(children:[Text('${months}', style: TextStyle(fontSize: 20.0))]),
                                  ]),
                                  TableRow( children: [

                                    Column(children:[Text('Installment Due:-', style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.bold)),]),
                                    Column(children:[Text('${installmentsdue}', style: TextStyle(fontSize: 20.0))]),
                                  ]),

                                  TableRow( children: [
                                    Column(children:[Text('Next Pay Date:-', style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.bold))]),
                                    Column(children:[Text('          ${paydate}', style: TextStyle(fontSize: 20.0))]),

                                  ]),
                                  TableRow( children: [
                                    Column(children:[Text('Last Pay Date:-', style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.bold))]),
                                    Column(children:[Text('          ${lastpaydate}', style: TextStyle(fontSize: 20.0))]),

                                  ]),
                                ],
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