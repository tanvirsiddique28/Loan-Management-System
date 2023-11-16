import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loanmanagementsystem/auth/auth_form.dart';
import 'package:loanmanagementsystem/pages/payment.dart';
import 'package:loanmanagementsystem/pages/withdrawn.dart';

import 'paymentstatus.dart';
import 'application.dart';
import 'customerprofile.dart';

class EmiCalculator extends StatefulWidget {
  const EmiCalculator({super.key});

  @override
  State<EmiCalculator> createState() => EmiCalculatorState();
}

class EmiCalculatorState extends State<EmiCalculator> {
// Initial Selected Value
  String dropdownvalue = 'Select Loan Type';

  // List of items in our dropdown menu
  var items = [
    'Select Loan Type',
    'Personal',
    'Home',
    'Car',
    'Home Appliances',
  ];
  //controllers
  TextEditingController loanamount = TextEditingController();
  TextEditingController numberofmonths = TextEditingController();
  TextEditingController interestrate = TextEditingController();
  TextEditingController interestamount = TextEditingController();
  TextEditingController monthlypayble = TextEditingController();
  TextEditingController totalypayble = TextEditingController();

  double amount = 0;
  int months = 0;
  int interests = 0;
  String? errorAmount;
  String? errorMonths;

  //getUid---------
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

  void calculate() {
    amount = double.parse(loanamount.text);
    months = int.parse(numberofmonths.text);

    if (dropdownvalue == 'Personal') {
      if (amount < 100000 || amount > 2000000 || months < 12 || months > 60) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "loan amount must be between 100,000 to 200,000,0 and months must be between 12 to 60",
            style: TextStyle(color: Colors.white, fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ));
      } else {
        interestrate.text = '11';
        double interestamt = (amount / 100) * int.parse(interestrate.text);
        String decimalAmt1 = interestamt.toStringAsFixed(0);
        interestamount.text = decimalAmt1;

        double totalamount = amount + interestamt;
        String decimalAmt2 = totalamount.toStringAsFixed(0);
        totalypayble.text = decimalAmt2;

        double monamount = totalamount / months;
        String decimalAmt3 = monamount.toStringAsFixed(0);
        monthlypayble.text = decimalAmt3;
      }
    }

    if (dropdownvalue == 'Home') {
      if (amount < 300000 || amount > 3000000 || months < 12 || months > 72) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "loan amount must be between 300,000 to 300,000,0 and months must be between 12 to 72",
            style: TextStyle(color: Colors.white, fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ));
      } else {
        interestrate.text = '9';

        double interestamt = (amount / 100) * int.parse(interestrate.text);
        String decimalAmt1 = interestamt.toStringAsFixed(0);
        interestamount.text = decimalAmt1;

        double totalamount = amount + interestamt;
        String decimalAmt2 = totalamount.toStringAsFixed(0);
        totalypayble.text = decimalAmt2;

        double monamount = totalamount / months;
        String decimalAmt3 = monamount.toStringAsFixed(0);
        monthlypayble.text = decimalAmt3;
      }
    }
    if (dropdownvalue == 'Car') {
      if (amount < 100000 || amount > 4000000 || months < 12 || months > 120) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "loan amount must be between 500,000 to 400,000,0 and months must be between 12 to 120",
            style: TextStyle(color: Colors.white, fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ));
      } else {
        interestrate.text = '8';

        double interestamt = (amount / 100) * int.parse(interestrate.text);
        String decimalAmt1 = interestamt.toStringAsFixed(0);
        interestamount.text = decimalAmt1;

        double totalamount = amount + interestamt;
        String decimalAmt2 = totalamount.toStringAsFixed(0);
        totalypayble.text = decimalAmt2;

        double monamount = totalamount / months;
        String decimalAmt3 = monamount.toStringAsFixed(0);
        monthlypayble.text = decimalAmt3;
      }
    }

    if (dropdownvalue == 'Home Appliances') {
      if (amount < 50000 || amount > 500000 || months < 12 || months > 36) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "loan amount must be between 50,000 to 500,000 and months must be between 12 to 36",
            style: TextStyle(color: Colors.white, fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ));
      } else {
        interestrate.text = '10';

        double interestamt = (amount / 100) * int.parse(interestrate.text);
        String decimalAmt1 = interestamt.toStringAsFixed(0);
        interestamount.text = decimalAmt1;

        double totalamount = amount + interestamt;
        String decimalAmt2 = totalamount.toStringAsFixed(0);
        totalypayble.text = decimalAmt2;

        double monamount = totalamount / months;
        String decimalAmt3 = monamount.toStringAsFixed(0);
        monthlypayble.text =decimalAmt3;
      }
    }
  }

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
                  accountName: Text('tanvir'),
                  accountEmail: Text('tanvir@gmail.com'),
                )),
            ListTile(leading:Icon(Icons.arrow_circle_right,color: Colors.black,),title: Text('Emi Calculator'),onTap: (){},),
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
            ListTile(leading:Icon(Icons.arrow_circle_right,color: Colors.black,),title: Text('Withdrawn'),onTap: (){
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Withdrawn()), (route) => false);
            }),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(
          'Emi Calculator',
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
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 45,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(12)),
              child: Center(
                child: DropdownButton(
                  dropdownColor: Colors.black,
                  // Initial Value
                  value: dropdownvalue,
                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),
                  // Array list of items
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(
                        items,
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 15.0),
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: new Icon(
                  Icons.money,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                labelText: 'Loan Amount',
              ),
              controller: loanamount,
            ),
            SizedBox(height: 10.0),
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: new Icon(
                  Icons.calendar_month_sharp,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                labelText: 'Number of Months',
              ),
              controller: numberofmonths,
            ),
            SizedBox(height: 10.0),
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: new Icon(
                  Icons.percent,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                labelText: 'Interest Rate',
              ),
              controller: interestrate,
            ),
            SizedBox(height: 10.0),
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: new Icon(
                  Icons.money,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                labelText: 'Interest Amount',
              ),
              controller: interestamount,
            ),
            SizedBox(height: 10.0),
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: new Icon(
                  Icons.payment,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                labelText: 'Monthly Payble',
              ),
              controller: monthlypayble,
            ),
            SizedBox(height: 10.0),
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: new Icon(
                  Icons.payment,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                labelText: 'Total Payble',
              ),
              controller: totalypayble,
            ),
            SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      calculate();
                    });
                  },
                  child: Text(
                    'Calculate',
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: Size(150, 45),
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    saveEmiData();
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Application()), (route) => false);
                  },
                  child: Text(
                    'Apply',
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      // Background color
                    ),
                    minimumSize: Size(150, 45),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  saveEmiData()async{

    if(interestrate.text.toString() != null){
      await FirebaseFirestore.instance.collection('calculations').doc(uid).collection('calculates').doc(uid).set({
        'loanType':dropdownvalue,
        'loanAmount':loanamount.text.toString(),
        'numberOfMonths':numberofmonths.text.toString(),
        'interestRate':interestrate.text.toString(),
        'interestAmount':interestamount.text.toString(),
        'monthlyPayble':monthlypayble.text.toString(),
        'totalyPayble':totalypayble.text.toString(),

      });
    }
  }
}
