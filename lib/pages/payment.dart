import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../auth/auth_form.dart';

import 'paymentstatus.dart';
import 'withdrawn.dart';
import 'application.dart';
import 'customerprofile.dart';
import 'emicalculator.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => PaymentState();
}

class PaymentState extends State<Payment> {
  TextEditingController payMent = TextEditingController();
  TextEditingController extraCharge = TextEditingController();
  //---------------------------------------
  String? uid;
  late String customerName,customerEmail,gender,netincome, customerAGe,
      loanType,loanAmount,numberOfMonths,installmentsRemain,
      interestRate,interestAmount,monthlyPayble,totalyPayble,payRemain,approvalDay,
      status,paymentHistory;
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
   firstPay = DateTime(date.year, date.month, date.day + 30).toString();
   lastPay = DateTime(date.year, date.month, date.day + 35).toString();
  }
  paymentDate() async {
    paidDay();
    //-------------eCharge calculation------------
    String eCharge = extraCharge.text;
    double amount = double.parse(payMent.text);
    double decimalValue = (amount/100)*3;
    String fixeDecimalValue = decimalValue.toStringAsFixed(0);
    double lateFee = double.parse(fixeDecimalValue);
    //-------------Date Time------------
    DateTime dateTime = await DateTime.now();
    DateTime getLastPayDate = await DateTime.parse(lastPayDay.toString());
    //-------------Check date and condition------------
    if (getLastPayDate.compareTo(dateTime) < 0) {
       if (eCharge.isNotEmpty && double.parse(eCharge) == lateFee) {
         double getinstallMentsDue = double.parse(installmentsRemain)-1;
         installmentsRemain = getinstallMentsDue.toString();
         double getPayMentsDue = double.parse(payRemain.toString())-double.parse(monthlyPayble.toString());
         payRemain = getPayMentsDue.toString();
         if (getPayMentsDue == 0) {
           installmentsRemain = '0';
           payRemain = getPayMentsDue.toString();
           paymentHistory = 'paid';
           status = 'withdrawn';
           firstPay = '0';
           lastPay = '0';
           extraCharge.text = '0';
           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
             content: Text(
               "Payment Successful!",
               style: TextStyle(color: Colors.white, fontSize: 20),textAlign: TextAlign.center,
             ),
           ));
         }else{
           paymentHistory = 'paid';
           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
             content: Text(
               "Payment done! \n Your Next day:- ${firstPay} \n Last pay day:- $lastPay",
               style: TextStyle(color: Colors.white, fontSize: 20),textAlign: TextAlign.center,
             ),
           ));
         }
         loansPaid();

    }else{
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
           content: Text(
             "You have to pay 3% extra charge\n"
                 "on current payment as late\n fee which is '$lateFee'.",
             style: TextStyle(color: Colors.white, fontSize: 20),
             textAlign: TextAlign.center,
           ),
         ));
       }
    }else{
      double getinstallMentsDue = double.parse(installmentsRemain.toString())-1;
      installmentsRemain = getinstallMentsDue.toString();
      double getPayMentsDue = double.parse(payRemain.toString())-double.parse(monthlyPayble.toString());
      payRemain = getPayMentsDue.toString();
      if (getPayMentsDue == 0) {
        installmentsRemain = '0';
        payRemain = getPayMentsDue.toString();
        paymentHistory = 'paid';
        status = 'withdrawn';
        firstPay = '0';
        lastPay = '0';
        extraCharge.text = '0';
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "Payment Successful!",
            style: TextStyle(color: Colors.white, fontSize: 20),textAlign: TextAlign.center,
          ),
        ));
      }else{
        paymentHistory = 'paid';
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "Payment done! \n Your Next day:- $firstPay \n Last pay day:- $lastPay",
            style: TextStyle(color: Colors.white, fontSize: 20),textAlign: TextAlign.center,
          ),
        ));
      }
      loansPaid();

    }

  }

  getAllApprovedData() async {
    DocumentReference documentReference = await FirebaseFirestore.instance
        .collection('approval')
        .doc(uid)
        .collection('approved')
        .doc(uid);
    documentReference.get().then((snapshot) {
      payMent.text = snapshot.get('monthlyPayble');
      lastPayDay = snapshot.get('lastPay');
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
        "amountPaid": payMent.text,//
        "eCharge":extraCharge.text,//
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
      "amountPaid": payMent.text,//
      "eCharge":extraCharge.text,//
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
                  accountName: Text('abir'),
                  accountEmail: Text('abir@gmail.com'),
                )),
            ListTile(
              leading: Icon(
                Icons.arrow_circle_right,
                color: Colors.black,
              ),
              title: Text('Emi Calculator'),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => EmiCalculator()),
                    (route) => false);
              },
            ),
            ListTile(
                leading: Icon(
                  Icons.arrow_circle_right,
                  color: Colors.black,
                ),
                title: Text('Loan Application'),
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Application()),
                      (route) => false);
                }),
            ListTile(
                leading: Icon(
                  Icons.arrow_circle_right,
                  color: Colors.black,
                ),
                title: Text('Customer Profile'),
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CustomerProfile()),
                      (route) => false);
                }),
            ListTile(
                leading: Icon(
                  Icons.arrow_circle_right,
                  color: Colors.black,
                ),
                title: Text('Payement'),
                onTap: () {}),
            ListTile(
                leading: Icon(
                  Icons.arrow_circle_right,
                  color: Colors.black,
                ),
                title: Text('Payment Status'),
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => PaymentStatus()),
                      (route) => false);
                }),
            ListTile(
                leading: Icon(
                  Icons.arrow_circle_right,
                  color: Colors.black,
                ),
                title: Text('Withdrawn'),
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Withdrawn()),
                      (route) => false);
                }),
          ],
        ),
      ),
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(Icons.menu),
            color: Colors.black,
          );
        }),
        title: Text(
          'Payment',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => AuthForm()),
                  (route) => false);
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 15.0),
            TextField(
              decoration: InputDecoration(
                prefixIcon: new Icon(
                  Icons.payment,
                  color: Colors.black,
                ),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                labelText: 'Payment',
              ),
              controller: payMent,
            ),
            SizedBox(height: 10.0),
            TextField(
              decoration: InputDecoration(
                prefixIcon: new Icon(
                  Icons.info,
                  color: Colors.black,
                ),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                labelText: 'Extra Charge',
              ),
              controller: extraCharge,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  paymentDate();
                });
              },
              child: Text(
                'Pay',
                style: TextStyle(fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: Size(double.infinity, 45),
                // Background color
              ),
            ),
            SizedBox(height: 20.0),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("approval")
                    .doc(uid)
                    .collection('approved')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot documentSnapshot =
                              snapshot.data!.docs[index];
                          return Table(
                            border: TableBorder.all(
                                color: Colors.black,
                                style: BorderStyle.solid,
                                width: 2),
                            children: [
                              TableRow(children: [
                                Text(
                                  ' Name:-',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text(
                                  documentSnapshot.get('name'),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ]),
                              TableRow(children: [
                                Text(
                                  ' Total Payble:-',
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
                              ]),
                              TableRow(children: [
                                Text(
                                  ' Pay Remain:-',
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
                              ]),
                              TableRow(children: [
                                Text(
                                  ' Current Payble:-',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text(
                                  documentSnapshot.get('monthlyPayble'),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ]),
                              TableRow(children: [
                                Text(
                                  ' Next Pay Date:-',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text(
                                  documentSnapshot.get('firstPay'),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ]),
                              TableRow(children: [
                                Text(
                                  ' Last Pay Date:-',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text(
                                  documentSnapshot.get('lastPay'),
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
    );
  }
}
