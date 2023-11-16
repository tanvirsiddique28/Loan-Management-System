

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loanmanagementsystem/pages/application.dart';
import 'package:loanmanagementsystem/pages/customerprofile.dart';
import 'package:loanmanagementsystem/pages/emicalculator.dart';
import 'package:loanmanagementsystem/pages/payment.dart';
import '../auth/auth_form.dart';
import 'withdrawn.dart';



class PaymentStatus extends  StatefulWidget {
  const PaymentStatus({super.key});



  @override
  State<PaymentStatus> createState() => PaymentStatusState();
}

class PaymentStatusState extends State<PaymentStatus> {
  final CollectionReference _payments = FirebaseFirestore.instance.collection("payments");

  String? uid;
  @override
  void initState() {
    getUid();
    super.initState();
  }
  getUid() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final firebaseUser = await auth.currentUser;
    setState(() {
      uid = firebaseUser?.uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                  padding: EdgeInsets.all(0),
                  child: UserAccountsDrawerHeader(
                    decoration: BoxDecoration(color: Colors.grey),
                    accountName: Text('abir'),
                    accountEmail: Text('abir@gmail.com'),
                  )),
              ListTile(leading:Icon(Icons.arrow_circle_right,color: Colors.black,),title: Text('Emi Calculator'),onTap: (){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>EmiCalculator()), (route) => false);
              },),
              ListTile(leading:Icon(Icons.arrow_circle_right,color: Colors.black,),title: Text('Loan Application'),onTap: (){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Application()), (route) => false);
              }),
              ListTile(leading:Icon(Icons.arrow_circle_right,color: Colors.black,),title: Text('Customer Profile'),onTap: (){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>CustomerProfile()), (route) => false);
              }),
              ListTile(leading:Icon(Icons.arrow_circle_right,color: Colors.black,),title: Text('Payement'),onTap: (){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Payment()), (route) => false);
              }),
              ListTile(leading:Icon(Icons.arrow_circle_right,color: Colors.black,),title: Text('Payment Status'),onTap: (){

              }),
              ListTile(leading:Icon(Icons.arrow_circle_right,color: Colors.black,),title: Text('Withdrawn'),onTap: (){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Withdrawn()), (route) => false);
              }),
            ],
          ),
        ),
        appBar: AppBar(
          leading: Builder(builder: (context) {
            return IconButton(onPressed: (){
              Scaffold.of(context).openDrawer();
            }, icon: Icon(Icons.menu),color: Colors.black,);
          }),
          title: Text(
            'Payment Status',
            style: TextStyle(color: Colors.black,),
          ),
          backgroundColor: Colors.white,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.logout,
                color: Colors.black,
              ),
              onPressed: () async{
                await FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>AuthForm()), (route) => false);
              },
            ),
          ],
        ),

        body:SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
padding: EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  SizedBox(height: 10,),
              Table(
                border: TableBorder.all(
                    color: Colors.black,
                    style: BorderStyle.solid,
                    width: 2),
                children: [
                  TableRow(children: [
                    Text(
                      'Pay Day',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Text(
                      'Paid Amount',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Text(
                      'Instaments Due',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Text(
                      'Payment Due',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Text(
                      'Total Payble',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Text(
                      'Account Status',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ]),
                ],
              ),
                  SizedBox(height: 10,),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('payment').doc(uid).collection('paid').snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot  documentSnapshot = snapshot.data!.docs[index];
                                return Table(
                                  border: TableBorder.all(
                                      color: Colors.black,
                                      style: BorderStyle.solid,
                                      width: 2),
                                  children: [
                                    TableRow(children: [
                                      Text(
                                        documentSnapshot.get('paidDay'),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      Text(
                                            documentSnapshot.get('amountPaid'),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      Text(
                                        documentSnapshot.get('installmentsRemain'),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      Text(
                                        documentSnapshot.get('payRemain'),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      Text(
                                        documentSnapshot.get('totalyPayble'),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      Text(
                                        documentSnapshot.get('status'),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ]),
                                  ],
                                );
                              });
                        } else {
                          return CircularProgressIndicator();
                        }
                      }),
                ],
              ),
            ),
        ),
        );
  }
}