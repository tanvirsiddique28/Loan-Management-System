

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'dashboasrd.dart';
import 'main.dart';

Future<void> mainMyPayment() async {
  await WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyPayment());
}

class MyPayment extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Payment()
    );
  }
}

class Payment extends  StatefulWidget {


  @override
  State<Payment> createState() => PaymentState();
}

class PaymentState extends State<Payment> {
  final CollectionReference _payments = FirebaseFirestore.instance.collection("payments");

  TextEditingController customerId = TextEditingController();
  TextEditingController payMent = TextEditingController();
  TextEditingController extraCharge = TextEditingController();

  String? searchId;

  DocumentSnapshot? documentSnapshot;
  String? name;
  String? age ;
  String? netincome;
  String? loantype;
  String? loanamount;
  String? months;
  String? interests;
  String? interestamt;
  String? tpay;
  String? payremain;
  String? mpay;
  String? lastpaydate;
  String? approvaldate;
  String? status;

  m1(){
    name = documentSnapshot!.get('name');
    age = documentSnapshot!.get('age');
   netincome = documentSnapshot!.get('netincome');
    loantype = documentSnapshot!.get('loantype');
    loanamount = documentSnapshot!.get('loanamount');
    months = documentSnapshot!.get('numberofmonths');
    interests = documentSnapshot!.get('interestrate');
    interestamt = documentSnapshot!.get('interestamount');
    mpay = documentSnapshot!.get('monthlypayble');
    tpay = documentSnapshot!.get('totalypayble');
    payremain = documentSnapshot!.get('payremain');
    lastpaydate = documentSnapshot!.get('lastpaydate');
    approvaldate = documentSnapshot!.get('aprovaldate');
    //status = documentSnapshot!.get('status');
  }

  String? payDay1;
  String? payDay2;
  String? payDay3;
  m2(){
    final date = DateTime.now();
    payDay1 = DateTime(date.year, date.month, date.day).toString();
    payDay2 = DateTime(date.year, date.month, date.day + 30).toString();
    payDay3 = DateTime(date.year, date.month, date.day + 35).toString();
  }

  paymentDate() async{

    DateTime dateTime = DateTime.now();
    DateTime getlastPayDate = DateTime.parse(lastpaydate.toString());

    double eCharge = double.parse(extraCharge.text.toString());

    // if(getlastPayDate.compareTo(dateTime) < 0){
    //   double currentpay = double.parse(mpay.toString());
    //   double extracharge = (currentpay/100)*3;
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     content: Text("You have to pay 3% extra charge\n"
    //         "on current payment as late\n fee which is '${extracharge}'.",
    //       style: TextStyle(color: Colors.red,fontSize: 20 ),
    //     ),
    //   ));
    // }else

      if(getlastPayDate.compareTo(dateTime) < 0 && eCharge == 0 ) {
      double currentpay = double.parse(mpay.toString());
      double extracharge = (currentpay / 100) * 3;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("You have to pay 3% extra charge\n"
            "on current payment as late\n fee which is '${extracharge}'.",
          style: TextStyle(color: Colors.red, fontSize: 20),
        ),
      ));
    }else if(getlastPayDate.compareTo(dateTime) < 0 && eCharge != 0){
      double getinstallMentsDue = double.parse(months.toString())-1;
      double getPayMentsDue = double.parse(tpay.toString())-double.parse(mpay.toString());
      double getPaidAmount = double.parse(payMent.text.toString())+double.parse(extraCharge.text.toString());

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
      final String aprovaldate1 = approvaldate.toString();

      if (loantype1 != null) {
        await _payments.doc(id).set(
            { "id": customerId1,
              "name": name1,
              "age": age1,
              "netincome": netincome1,
              "loantype": loantype1,
              "loanamount": loanamount1,
              "numberofmonths": numberofmonths1,
              "installmentsremain": getinstallMentsDue.toString(),
              "interestrate": iinterestrate1,
              "interestamount": interestamount1,
              "monthlypayble": monthlypayble1,
              "totalypayble": totalypayble1,
              "payremain": getPayMentsDue.toString(),
              "amountpaid": getPaidAmount.toString(),
              "paidday": payDay1.toString(),
              "aprovaldate": aprovaldate1,
              "paydate": payDay2.toString(),
              "lastpaydate": payDay3.toString(),
              "paymenthistory": "null",
              "status": "running",
            });



      }


      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("payment successful!!\nYour next pay date is '${payDay2}'\nLast pay day is '${payDay3}'",
          style: TextStyle(color: Colors.white,fontSize: 20 ),
        ),
      ));
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
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Dashboard()),
                );
              },
            ),
          ],
        ),
        title: Text(
          'Payment',
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: EdgeInsets.all(10.0),
          height: containerheight,
          width: containerwidth,
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
                    payMent.text = "0";
                    extraCharge.text = "0";
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
              SizedBox(height: 10.0),
              Container(
                child: Table(
                  defaultColumnWidth: FixedColumnWidth(180.0),
                  textDirection: TextDirection.ltr,
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

                      Column(children:[Text('Total Pay:-', style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.bold)),]),
                      Column(children:[Text('${tpay}', style: TextStyle(fontSize: 20.0))]),
                    ]),
                    TableRow( children: [

                      Column(children:[Text('Pay Remain:-', style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.bold))]),
                      Column(children:[Text('${payremain}', style: TextStyle(fontSize: 20.0))]),
                    ]),
                    TableRow( children: [
                      Column(children:[Text('Current Pay:-', style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.bold))]),
                      Column(children:[Text('${mpay}', style: TextStyle(fontSize: 20.0,))]),

                    ]),
                    TableRow( children: [
                      Column(children:[Text('Last Pay Date:-', style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.bold))]),
                      Column(children:[Text('        ${lastpaydate}', style: TextStyle(fontSize: 20.0))]),

                    ]),
                  ],
                ),
              ),
              SizedBox(height: 15.0),

              TextField(
                decoration: InputDecoration(
                  prefixIcon: new Icon(Icons.payment,color: Colors.black,),
                  border: OutlineInputBorder(),
                  labelText: 'Payment',
                ),
                controller: payMent,
              ),

              SizedBox(height: 10.0),


              TextField(
                decoration: InputDecoration(
                  prefixIcon: new Icon(Icons.info,color: Colors.black,),
                  border: OutlineInputBorder(),
                  labelText: 'Extra Charge',
                ),
                controller: extraCharge,
              ),
              SizedBox(height: 20.0),
              SizedBox(
                width: 300.0,
                height: 40.0,
                child: ElevatedButton(
                  onPressed: () async {

                  paymentDate();
                  m2();


                  },
                  child: Text('     PAY     ',style: TextStyle(fontSize: 20),),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    shape: StadiumBorder(),
                    // Background color
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Flexible(
                child: StreamBuilder(

                  stream: _payments.where('id', isEqualTo: searchId).snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          documentSnapshot =  snapshot.data!.docs[snapshot.data!.docs.length-1];

                          return ListTile(
                            title: Text(
                              "Print ID IS: "+'${name}',
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
      ),

    );
  }
}
