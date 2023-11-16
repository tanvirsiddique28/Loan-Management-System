import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loanmanagementsystem/pages/emicalculator.dart';
import 'package:loanmanagementsystem/pages/payment.dart';
import '../auth/auth_form.dart';
import 'paymentstatus.dart';
import 'withdrawn.dart';
import 'customerprofile.dart';

class Application extends StatefulWidget {
  @override
  State<Application> createState() => ApplicationState();
}

class ApplicationState extends State<Application> {
  //controllers_____________________
  TextEditingController loanType = TextEditingController();
  TextEditingController customerName = TextEditingController();
  TextEditingController customerEmail = TextEditingController();
  String? gender; //selection
  TextEditingController netincome = TextEditingController();
  TextEditingController customerAGe = TextEditingController();

  //functions of get user unique id_____________
  String? uid;
  void initState() {
    getUid();
    super.initState();
  }
  getUid() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final firebaseUser = await auth.currentUser;
    setState(() {
      uid = firebaseUser?.uid;
      getUserAndCalculations();
      getAllCalculations();
    });
  }

  getUserAndCalculations() async {
    DocumentReference documentReference =
        await FirebaseFirestore.instance.collection('users').doc(uid);
    documentReference.get().then((snapshot) {
      customerName.text = snapshot.get('username');
      customerEmail.text = snapshot.get('email');
    });

    DocumentReference documentReferencee = await FirebaseFirestore.instance
        .collection('calculations')
        .doc(uid)
        .collection('calculates')
        .doc(uid);
    documentReferencee.get().then((snapshot) {
      loanType.text = snapshot.get('loanType');
    });
  }

  //functions of save and approved loan_____________

  late String loanAmount,numberOfMonths,interestRate,interestAmount,monthlyPayble,totalyPayble;


  getAllCalculations() async {
    DocumentReference documentReferencee = await FirebaseFirestore.instance
        .collection('calculations')
        .doc(uid)
        .collection('calculates')
        .doc(uid);
    setState(() {
      documentReferencee.get().then((snapshot) {
        loanType.text = snapshot.get('loanType');
        loanAmount = snapshot.get('loanAmount');
        numberOfMonths = snapshot.get('numberOfMonths');
        interestRate = snapshot.get('interestRate');
        interestAmount = snapshot.get('interestAmount');
        monthlyPayble = snapshot.get('monthlyPayble');
        totalyPayble = snapshot.get('totalyPayble');
      });
    });
  }

  String? approvalDay;
  String? firstPay;
  String? lastPay;
  paymentDate() {
    final date = DateTime.now();
    approvalDay = DateTime(date.year, date.month, date.day).toString();
    firstPay = DateTime(date.year, date.month, date.day + 30).toString();
    lastPay = DateTime(date.year, date.month, date.day + 35).toString();
  }

  loansAproval() async {
    int ageNum = int.parse(customerAGe.text);
    int netIncome = int.parse(netincome.text);
    if (ageNum >= 18 || netIncome >= 300000) {
      paymentDate();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Congratulations! \n Your Next day:- $firstPay \n Last pay day$lastPay:-",
          style: TextStyle(color: Colors.white, fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ));
      await FirebaseFirestore.instance
          .collection('approval')
          .doc(uid)
          .collection('approved')
          .doc(uid)
          .set({
        'name': customerName.text,
        'email': customerEmail.text,
        'gender': gender,
        'netIncome': netincome.text,
        'age': customerAGe.text,
        'loanType': loanType.text,
        'loanAmount': loanAmount,
        'numberOfMonths': numberOfMonths,
        "installmentsRemain": numberOfMonths,
        'interestRate': interestRate,
        'interestAmount': interestAmount,
        'monthlyPayble': monthlyPayble,
        'totalyPayble': totalyPayble,
        "payRemain": totalyPayble,
        "amountPaid": "null",
        "eCharge":"null",
        "paidDay": "null",
        "approvalDay": approvalDay,
        "firstPay": firstPay,
        "lastPay": lastPay,
        "paymentHistory": "null",
        "status": "running",
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Your application has not approved \nage should be greter than 18 and \n net income should be greater than 300,000 ",
          style: TextStyle(color: Colors.white, fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ));
    }
  }

  //-----------------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                padding: EdgeInsets.all(0),
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.grey),
                  accountName: Text('Abir'),
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
                onTap: () {}),
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
        title: Text(
          'Apply for Loan',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        backgroundColor: Colors.white,
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(Icons.menu),
            color: Colors.black,
          );
        }),
        actions: [
          Column(
            children: [
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
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: new Icon(
                  Icons.info,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                labelText: 'Loantype',
              ),
              controller: loanType,
            ),
            SizedBox(height: 10.0),
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: new Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                labelText: 'Name',
              ),
              controller: customerName,
            ),
            SizedBox(height: 10.0),
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: new Icon(
                  Icons.email,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                labelText: 'Email Address',
              ),
              controller: customerEmail,
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                SizedBox(width: 40.0),
                Column(
                  children: [
                    Text(
                      'Select Gender:-',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10.0),
                Column(
                  children: [
                    Radio(
                        value: "male",
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value.toString();
                          });
                        }),
                    SizedBox(width: 10.0),
                    Text("Male")
                  ],
                ),
                SizedBox(width: 10.0),
                Column(
                  children: [
                    Radio(
                        value: "female",
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value.toString();
                          });
                        }),
                    SizedBox(width: 10.0),
                    Text("Female")
                  ],
                ),
                SizedBox(width: 10.0),
                Column(
                  children: [
                    Radio(
                        value: "other",
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value.toString();
                          });
                        }),
                    SizedBox(width: 10.0),
                    Text("Other")
                  ],
                ),
              ],
            ),
            SizedBox(height: 10.0),
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: new Icon(
                  Icons.wallet,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                labelText: 'Net Income',
              ),
              controller: netincome,
            ),
            SizedBox(height: 10.0),
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: new Icon(
                  Icons.info,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                labelText: 'Age',
              ),
              controller: customerAGe,
            ),
            SizedBox(height: 15.0),
            ElevatedButton(
              onPressed: () {
                loansAproval();
              },
              child: Text(
                'Apply',
                style: TextStyle(fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: Size(double.infinity, 45)
                  // Background color

                  ),
            ),
          ],
        ),
      ),
    );
  }
}
