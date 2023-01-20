import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:loanmanagementsystem/main.dart';


Future<void> main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const MyApy());
}

class MyApy extends StatelessWidget {
  const MyApy({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: HomeApy(),
    );
  }
}

class HomeApy extends StatefulWidget {
  const HomeApy({Key? key}) : super(key: key);

  @override
  State<HomeApy> createState() => _HomeApyState();
}

class _HomeApyState extends State<HomeApy> {


  final CollectionReference _payments = FirebaseFirestore.instance.collection("payments");

  TextEditingController customerId = TextEditingController();

  String? searchId;

  DocumentSnapshot? documentSnapshot;
  String? name;
  String? tpay;
  String? paidamount;
  String? mpay;
  String? lastpaydate;

  m1(){

    name = documentSnapshot!.get('name');
    mpay = documentSnapshot!.get('monthlypayble');
    tpay = documentSnapshot!.get('totalypayble');
    paidamount = documentSnapshot!.get('paidamount');
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
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LogIn()),
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
                    Column(children:[Text('${paidamount}', style: TextStyle(fontSize: 20.0))]),
                  ]),
                  TableRow( children: [
                    Column(children:[Text('Current Pay:-', style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.bold))]),
                    Column(children:[Text('${mpay}', style: TextStyle(fontSize: 20.0,))]),

                  ]),
                  TableRow( children: [
                    Column(children:[Text('Last Pay Date:-', style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.bold))]),
                    Column(children:[Text('${lastpaydate}', style: TextStyle(fontSize: 20.0))]),

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
            ),

            SizedBox(height: 10.0),


            TextField(
              decoration: InputDecoration(
                prefixIcon: new Icon(Icons.info,color: Colors.black,),
                border: OutlineInputBorder(),
                labelText: 'Extra Charge',
              ),
            ),
            SizedBox(height: 20.0),
            SizedBox(
              width: 300.0,
              height: 40.0,
              child: ElevatedButton(
                onPressed: () {

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
                        documentSnapshot = snapshot.data!.docs[index];

                         return ListTile(
                          title: Text(
                            "Print ID IS: "+'${name}' ,
                            style:
                            TextStyle(color: Colors.black, fontSize: 25),
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
