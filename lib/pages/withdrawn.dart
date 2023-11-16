

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loanmanagementsystem/pages/application.dart';
import 'package:loanmanagementsystem/pages/customerprofile.dart';
import 'package:loanmanagementsystem/pages/emicalculator.dart';
import 'package:loanmanagementsystem/pages/payment.dart';
import 'package:loanmanagementsystem/pages/paymentstatus.dart';

import '../auth/auth_form.dart';

class Withdrawn extends  StatefulWidget {
  const Withdrawn({super.key});



  @override
  State<Withdrawn> createState() => WithdrawnState();
}

class WithdrawnState extends State<Withdrawn> {



  TextEditingController paymentRemain = TextEditingController();
  TextEditingController totalPayment = TextEditingController();

  String? uid;
  late String customerName,customerEmail,gender,netincome, customerAGe,
      loanType,loanAmount,numberOfMonths,installmentsRemain,eCharge,
      interestRate,interestAmount,monthlyPayble,totalyPayble,payRemain,approvalDay,
      status,paymentHistory;
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
      getPayemntAndTotalPay();
      getAllApprovedData();
    });
  }
  //----------------------
  String? lastPayDay;
  //______________________
  String? payDay;
  String? firstPay;
  String? lastPay;
  paidDay(){
    final date = DateTime.now();
    payDay = DateTime(date.year, date.month, date.day).toString();
  }
  loanWithdrawn() async {
    paidDay();
    //-------------Check date and condition------------
   //---calculations----------
    double getPayMentsDue = double.parse(payRemain.toString())-double.parse(paymentRemain.text);
      if (getPayMentsDue == 0) {
        installmentsRemain = '0';
        payRemain = getPayMentsDue.toString();
        paymentHistory = 'paid';
        status = 'withdrawn';
        firstPay = '0';
        lastPay = '0';
        eCharge = '0';
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "Payment Successful!",
            style: TextStyle(color: Colors.white, fontSize: 20),textAlign: TextAlign.center,
          ),
        ));
        loansPaid();
      }
  }
  getPayemntAndTotalPay() async{
    DocumentReference documentReference = await FirebaseFirestore.instance.collection('approval').doc(uid).collection('approved').doc(uid);
    documentReference.get().then((snapshot){
      paymentRemain.text = snapshot.get('payRemain');
      totalPayment.text = snapshot.get('totalyPayble');

    });

  }
  getAllApprovedData() async {
    DocumentReference documentReference = await FirebaseFirestore.instance
        .collection('approval')
        .doc(uid)
        .collection('approved')
        .doc(uid);
    documentReference.get().then((snapshot) {

      //-----------------------------------------------------
      customerName = snapshot.get('name');
      customerEmail = snapshot.get('email');
      gender = snapshot.get('gender');
      netincome = snapshot.get('netIncome');
      customerAGe = snapshot.get('age');
      loanType = snapshot.get('loanType');
      loanAmount = snapshot.get('loanAmount');
      numberOfMonths = snapshot.get('numberOfMonths');
      installmentsRemain = snapshot.get('installmentsRemain');
      interestRate = snapshot.get('interestRate');
      interestAmount = snapshot.get('interestAmount');
      monthlyPayble = snapshot.get('monthlyPayble');
      totalyPayble = snapshot.get('totalyPayble');
      payRemain = snapshot.get('payRemain');
      print('pay remain: '+payRemain);
      print(snapshot.get('amountPaid'));
      print(snapshot.get('eCharge'));
      print(snapshot.get('paidDay'));
      approvalDay = snapshot.get('approvalDay');
      print(snapshot.get('firstPay'));
      print(snapshot.get('lastPay'));
      paymentHistory = snapshot.get('paymentHistory');
      status = snapshot.get('status');
    });
  }
  loansPaid() async {
    //String id = DateTime.now().millisecondsSinceEpoch.toString();
    await FirebaseFirestore.instance
        .collection('approval')
        .doc(uid)
        .collection('approved')
        .doc(uid)
        .set({
      'name': customerName,
      'email': customerEmail,
      'gender': gender,
      'netIncome': netincome,
      'age': customerAGe,
      'loanType': loanType,
      'loanAmount': loanAmount,
      'numberOfMonths': numberOfMonths,
      "installmentsRemain": installmentsRemain,//
      'interestRate': interestRate,
      'interestAmount': interestAmount,
      'monthlyPayble': monthlyPayble,
      'totalyPayble': totalyPayble,
      "payRemain": payRemain,//
      "amountPaid": paymentRemain.text,//
      "eCharge":eCharge,//
      "paidDay": payDay,//
      "approvalDay": approvalDay,
      "firstPay": firstPay,//
      "lastPay": lastPay,//
      "paymentHistory": paymentHistory,//
      "status": status,
    });
    loansPaids();
  }
  loansPaids() async {
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    await FirebaseFirestore.instance
        .collection('payment')
        .doc(uid)
        .collection('paid')
        .doc(id)
        .set({
      'name': customerName,
      'email': customerEmail,
      'gender': gender,
      'netIncome': netincome,
      'age': customerAGe,
      'loanType': loanType,
      'loanAmount': loanAmount,
      'numberOfMonths': numberOfMonths,
      "installmentsRemain": installmentsRemain,//
      'interestRate': interestRate,
      'interestAmount': interestAmount,
      'monthlyPayble': monthlyPayble,
      'totalyPayble': totalyPayble,
      "payRemain": payRemain,//
      "amountPaid": paymentRemain.text,//
      "eCharge":eCharge,//
      "paidDay": payDay,//
      "approvalDay": approvalDay,
      "firstPay": firstPay,//
      "lastPay": lastPay,//
      "paymentHistory": paymentHistory,//
      "status": status,
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
                  accountName: Text('tanvir'),
                  accountEmail: Text('tanvir@gmail.com'),
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
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>PaymentStatus()), (route) => false);
            }),
            ListTile(leading:Icon(Icons.arrow_circle_right,color: Colors.black,),title: Text('Withdrawn'),onTap: (){}),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(
          'Withdrawn',
          style: TextStyle(color: Colors.black,fontSize: 20),
        ),
        backgroundColor: Colors.white,
        leading: Builder(builder: (context) {
          return IconButton(onPressed: (){
            Scaffold.of(context).openDrawer();
          }, icon: Icon(Icons.menu),color: Colors.black,);
        }),
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>AuthForm()), (route) => false);
            },
            icon: Icon(
              Icons.logout,
              color: Colors.black,
            ),
          )
        ],
      ),

        body:Container(
          padding: EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                TextField(
                  decoration: InputDecoration(
                    prefixIcon: new Icon(Icons.payment,color: Colors.black,),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)
                    ),
                    labelText: 'Pay Remain',
                  ),
                  controller: paymentRemain,
                ),
                SizedBox(height: 15.0),
                TextField(
                  decoration: InputDecoration(
                    prefixIcon: new Icon(Icons.info,color: Colors.black,),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)
                    ),
                    labelText: 'Total Pay',
                  ),
                  controller: totalPayment,
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                    onPressed: () {
                      loanWithdrawn();
                    },
                    child: Text('Pay',style: TextStyle(fontSize: 20),),
                    style: ElevatedButton.styleFrom(
                     backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      minimumSize: Size(double.infinity, 45),
                      // Background color
                    ),
                  ),


              ],
            ),
          ),
        );




  }
}