import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loanmanagementsystem/auth/auth_form.dart';
import 'package:loanmanagementsystem/pages/emicalculator.dart';
import 'package:loanmanagementsystem/pages/payment.dart';
import 'paymentstatus.dart';
import 'withdrawn.dart';
import 'application.dart';

class CustomerProfile extends StatefulWidget {
  const CustomerProfile({super.key});

  @override
  State<CustomerProfile> createState() => CustomerProfileState();
}

class CustomerProfileState extends State<CustomerProfile> {

String? uid;
@override
  void initState() {
  getUid();
    super.initState();
  }
  getUid()async{
  FirebaseAuth auth = FirebaseAuth.instance;
  final firebaseUser = await auth.currentUser;
  setState(() {
    uid = firebaseUser?.uid;

  });
  }
  //___________________________________
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
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
            ListTile(leading:Icon(Icons.arrow_circle_right,color: Colors.black,),title: Text('Customer Profile'),onTap: (){}),
            ListTile(leading:Icon(Icons.arrow_circle_right,color: Colors.black,),title: Text('Payement'),onTap: (){
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Payment()), (route) => false);
            }),
            ListTile(leading:Icon(Icons.arrow_circle_right,color: Colors.black,),title: Text('Payment Status'),onTap: (){
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>PaymentStatus()), (route) => false);
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
          'Customer Profile',
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
      body: Container(
        padding: EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/person.png",width: 150,height: 150,),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("approval").doc(uid).collection('approved')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot  documentSnapshot = snapshot.data!.docs[index];
                          return Table(
                            border: TableBorder.all(color: Colors.black),
                            children: [

                              TableRow(children: [
                                Text(' Name:-',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                Text(documentSnapshot.get('name'),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                              ]),
                              TableRow(children: [
                                Text(' Loan Type:-',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                Text(documentSnapshot.get('email'),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                              ]),
                              TableRow(children: [
                                Text(' Account Status:-',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                Text(documentSnapshot.get('status'),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                              ]),
                              TableRow(children: [
                                Text(' Loan Amount:-',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                Text(documentSnapshot.get('loanAmount'),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                              ]),
                              TableRow(children: [
                                Text(' Monthly Payble:-',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                Text(documentSnapshot.get('monthlyPayble'),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                              ]),
                              TableRow(children: [
                                Text(' Total Payble:-',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                Text(documentSnapshot.get('totalyPayble'),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                              ]),
                              TableRow(children: [
                                Text(' Pay Remain:-',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                Text(documentSnapshot.get('payRemain'),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                              ]),
                              TableRow(children: [
                                Text(' Total Installments:-',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                Text(documentSnapshot.get('numberOfMonths'),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                              ]),
                              TableRow(children: [
                                Text(' Installment Due:-',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                Text(documentSnapshot.get('installmentsRemain'),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                              ]),
                              TableRow(children: [
                                Text(' Next Pay Date:-',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                Text(documentSnapshot.get('firstPay'),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                              ]),
                              TableRow(children: [
                                Text(' Last Pay Date:-',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                Text(documentSnapshot.get('lastPay'),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
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
    );
  }
}
