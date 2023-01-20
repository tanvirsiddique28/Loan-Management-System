

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'dashboasrd.dart';
import 'main.dart';

Future<void> mainMyPaymentStatus() async {
  await WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyPaymentStatus());
}

class MyPaymentStatus extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: PaymentStatus()
    );
  }
}

class PaymentStatus extends  StatefulWidget {


  @override
  State<PaymentStatus> createState() => PaymentStatusState();
}

class PaymentStatusState extends State<PaymentStatus> {
  final CollectionReference _payments = FirebaseFirestore.instance.collection("payments");

  TextEditingController customerId = TextEditingController();

  String? searchId;

  DocumentSnapshot? documentSnapshot;


  String? paidday;
  String? amountpaid;


  m1(){
    amountpaid = documentSnapshot!.get('amountpaid');
    paidday = documentSnapshot!.get('paidday');
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
          title: Text('Payment Status',style: TextStyle(color: Colors.black, fontSize: 20),),
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
                Flexible(
                  child: StreamBuilder(

                    stream: _payments.where('id', isEqualTo: searchId).snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            documentSnapshot = snapshot.data!.docs[index];

                            return Card(
                              margin: EdgeInsets.all(10),
                              child: ListTile(
                                leading: Icon(Icons.payment),
                                title: Text('${amountpaid}'),
                                trailing: Text('${paidday}'),
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