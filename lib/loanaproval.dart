


import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:loanmanagementsystem/main.dart';

import 'dashboasrd.dart';
import 'main.dart';

Future<void> mainapprove() async {
  await WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp( MyApprove());
}


class MyApprove extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoanAproval()
    );
  }
}

class LoanAproval extends  StatefulWidget {


  @override
  State<LoanAproval> createState() => LoanAprovalState();
}

class LoanAprovalState extends State<LoanAproval> {

  final CollectionReference _application = FirebaseFirestore.instance.collection("application");
  final CollectionReference _payments = FirebaseFirestore.instance.collection("payments");

  TextEditingController customerId = TextEditingController();

  String? searchId;

  DocumentSnapshot? documentSnapshot;

  String? name;
  String age = " ";
  String netincome = " ";
  String? loantype;
  String? loanamount;
  String? months;
  String? interests;
  String? interestamt;
  String? mpay;
  String? tpay;
  String? status;
  m1(){

    name = documentSnapshot!.get('name');
    age = documentSnapshot!.get('age');
    netincome = documentSnapshot!.get('netincome');
    loantype = documentSnapshot!.get('loantype');
    loanamount = documentSnapshot!.get('loanamount');
    months = documentSnapshot!.get('months');
    interests = documentSnapshot!.get('interestrate');
    interestamt = documentSnapshot!.get('interestamount');
    mpay = documentSnapshot!.get('monthlypay');
    tpay = documentSnapshot!.get('totalpay');
    status = documentSnapshot!.get('status');
  }


  m2(){
    int ageNum = int.parse(age);
    int netincomeNum = int.parse(netincome);
    if(ageNum >= 18 || netincomeNum >= 300000 ){
      final String customerId1 = customerId.text.toString();
      final String status1 = "approved";

      if (status1 != null) {
        _application
            .doc(customerId1)
            .update({"status": status1});

      }
    }else{
      final String customerId1 = customerId.text.toString();
      final String status1 = "not "
          "approved";

      if (status1 != null) {
        _application
            .doc(customerId1)
            .update({"status": status1});

      }
    }
  }

  String? payDay1;
  String? payDay2;
  String? payDay3;

  paymentDate(){
    final date = DateTime.now();
    payDay1 = DateTime(date.year, date.month, date.day).toString();
    payDay2 = DateTime(date.year, date.month, date.day + 30).toString();
    payDay3 = DateTime(date.year, date.month, date.day + 35).toString();
  }


  // m3() async{
  //   // int ageNum = int.parse("20");
  //   // int netincomeNum = int.parse("400000");
  //   // if(ageNum >= 18 || netincomeNum >= 300000 ){
  //
  //
  //
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Column(
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>Dashboard()),
                );
              },
            ),
          ],
        ),
        title: Text(
          'Apply',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: [
          Column(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 15.0),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: new Icon(Icons.search,color: Colors.black,),
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

            SizedBox(height: 20.0),
            Row(
              children: [
                SizedBox(width: 25.0),
                SizedBox(
                  width: 130.0,
                  height: 40.0,
                  child: ElevatedButton(
                    onPressed: () async{
                      int ageNum = int.parse(age);
                        int netincomeNum = int.parse(netincome);
                        if(ageNum >= 18 || netincomeNum >= 300000 ){



                          paymentDate();
                          String id = DateTime.now().millisecondsSinceEpoch.toString();

                          final String customerId1 = customerId.text.toString();
                          final String name1 = name.toString();
                          final String age1 = age.toString();
                          final String netincome1 = netincome.toString();
                          final String loantype1 = loantype.toString();
                          final String loanamount1 = loanamount.toString();
                          final String numberofmonths1 = months.toString();
                          final String iinterestrate1 = interests.toString();
                          final String interestamount1 = interestamt.toString();
                          final String monthlypayble1 = mpay.toString();
                          final String totalypayble1 = tpay.toString();

                          if (loantype1 != null) {
                            await _payments.doc(id).set(
                                { "id": customerId1,
                                  "name": name1,
                                  "age": age1,
                                  "netincome": netincome1,
                                  "loantype": loantype1,
                                  "loanamount": loanamount1,
                                  "numberofmonths": numberofmonths1,
                                  "installmentsremain": numberofmonths1,
                                  "interestrate": iinterestrate1,
                                  "interestamount": interestamount1,
                                  "monthlypayble": monthlypayble1,
                                  "totalypayble": totalypayble1,
                                  "payremain": totalypayble1,
                                  "amountpaid": "null",
                                  "paidday": "null",
                                  "aprovaldate": payDay1,
                                  "paydate": payDay2,
                                  "lastpaydate": payDay3,
                                  "paymenthistory": "null",
                                  "status": "running",
                                });



                          }

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Congratulations!!!\nYour next pay date is: "+'${payDay2}'+"\nLast pay day is: "+'${payDay3}',
                              style: TextStyle(color: Colors.white,fontSize: 20 ),
                            ),
                          ));


                          final String status1 = "approved";
                          if (status1 != null) {
                            await  _application
                                .doc(documentSnapshot!.id)
                                .update({"status": status1});

                          }

                      }else{



                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("age and net incomemust be gretaer \nthan or equal to 18 \n and  300000",
                              style: TextStyle(color: Colors.red,fontSize: 20 ),
                            ),
                          ));

                          final String status1 = "not approved";
                          if (status1 != null) {
                            await  _application
                                .doc(documentSnapshot!.id)
                                .update({"status": status1});

                          }


                        }



                    },
                    child: Text('Approved',style: TextStyle(fontSize: 20),),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      shape: StadiumBorder(),
                      // Background color
                    ),
                  ),
                ),
                SizedBox(width: 15.0),
                SizedBox(
                  width: 180.0,
                  height: 40.0,
                  child: ElevatedButton(
                    onPressed: () {

                    },
                    child: Text('Not Approved',style: TextStyle(fontSize: 20),),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      shape: StadiumBorder(),
                      // Background color
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.0),
            Flexible(
              child: StreamBuilder(
                stream: _application.where('id', isEqualTo: searchId).snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        documentSnapshot = snapshot.data!.docs[index];
                        // netIncome = documentSnapshot.get('income').toString();
                        // aGe = documentSnapshot.get('age').toString();

                        return Container(
                          child: Table(
                            defaultColumnWidth: FixedColumnWidth(120.0),
                            border: TableBorder.all(
                                color: Colors.black,
                                style: BorderStyle.solid,
                                width: 2),
                            children: [
                              TableRow( children: [
                                Column(children:[Text('Name', style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.bold))]),
                                Column(children:[Text('Age', style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.bold))]),
                                Column(children:[Text('Net Income', style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.bold))]),
                              ]),
                              TableRow( children: [
                                Column(children:[Text('${name}', style: TextStyle(fontSize: 20.0))]),
                                Column(children:[Text('${age}', style: TextStyle(fontSize: 20.0))]),
                                Column(children:[Text('${netincome}', style: TextStyle(fontSize: 20.0))]),
                              ]),
                              TableRow( children: [
                                Column(children:[Text('Loan Type', style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.bold))]),
                                Column(children:[Text('Loan Amt', style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.bold))]),
                                Column(children:[Text('Months', style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.bold))]),
                              ]),
                              TableRow( children: [
                                Column(children:[Text('${loantype}', style: TextStyle(fontSize: 20.0))]),
                                Column(children:[Text('${loanamount}', style: TextStyle(fontSize: 20.0))]),
                                Column(children:[Text('${months}', style: TextStyle(fontSize: 20.0))]),
                              ]),
                              TableRow( children: [
                                Column(children:[Text('Interests', style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.bold))]),
                                Column(children:[Text('Interest Amt', style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.bold))]),
                                Column(children:[Text('Monthly Pay', style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.bold))]),
                              ]),
                              TableRow( children: [
                                Column(children:[Text('${interests}', style: TextStyle(fontSize: 20.0))]),
                                Column(children:[Text('${interestamt}', style: TextStyle(fontSize: 20.0))]),
                                Column(children:[Text('${mpay}', style: TextStyle(fontSize: 20.0))]),
                              ]),
                              TableRow( children: [
                                Column(children:[Text('Total Pay', style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.bold))]),
                                Column(children:[Text('', style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.bold))]),
                                Column(children:[Text('Status', style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.bold))]),
                              ]),
                              TableRow( children: [
                                Column(children:[Text('${tpay}', style: TextStyle(fontSize: 20.0))]),
                                Column(children:[Text('', style: TextStyle(fontSize: 20.0))]),
                                Column(children:[Text('${status}', style: TextStyle(fontSize: 20.0))]),
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
    );
  }
}