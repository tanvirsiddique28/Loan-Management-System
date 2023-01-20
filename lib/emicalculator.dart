
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'dashboasrd.dart';
import 'main.dart';

Future<void> MyEmiCalculation() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Myemi());
}


class Myemi extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: EmiCalculator()
    );
  }
}

class EmiCalculator extends  StatefulWidget {


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

  //firebase
  final CollectionReference _calculates = FirebaseFirestore.instance.collection("calculates");
  DocumentSnapshot? documentSnapshot;

  String? printId;
  String? calculateID;


  void calculateId(){
   try{
     String s1 = documentSnapshot!.get('id');
     int i1 = int.parse(s1)+1;
     printId = i1.toString();
     calculateID = i1.toString();
   }catch(e){
     printId = "1";
     calculateID = "1";
   }

  }
  void calculate(){
     amount = double.parse(loanamount.text);
     months = int.parse(numberofmonths.text);


    if(dropdownvalue == 'Personal'){
      if(amount < 100000 ||amount > 2000000|| months < 12 || months > 60){

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("loan amount must be between 100000 to 2000000 and months must be between 12 to 60",
            style: TextStyle(color: Colors.red,fontSize: 20 ),
          ),
        ));
          }else{
         interestrate.text = '11';
         double interestamt = (amount/100)*int.parse(interestrate.text);
         interestamount.text = interestamt.toString();

        double totalamount = amount+interestamt;
        totalypayble.text = totalamount.toString();

        double monamount = totalamount/months;
        monthlypayble.text = monamount.toString();
      }
    }


    if(dropdownvalue == 'Home'){
      if(amount < 300000 ||amount > 3000000|| months < 12 || months > 72){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("loan amount must be between 300000 to 3000000 and months must be between 12 to 72",
            style: TextStyle(color: Colors.red,fontSize: 20 ),
          ),
        ));
      }else{
        interestrate.text = '9';

        double interestamt = (amount/100)*int.parse(interestrate.text);
        interestamount.text = interestamt.toString();

        double totalamount = amount+interestamt;
        totalypayble.text = totalamount.toString();

        double monamount = totalamount/months;
        monthlypayble.text = monamount.toString();
      }
    }
    if(dropdownvalue == 'Car'){
      if(amount < 100000 ||amount > 4000000|| months < 12 || months > 120){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("loan amount must be between 500000 to 4000000 and months must be between 12 to 120",
            style: TextStyle(color: Colors.red,fontSize: 20 ),
          ),
        ));
      }else{
        interestrate.text = '8';

        double interestamt = (amount/100)*int.parse(interestrate.text);
        interestamount.text = interestamt.toString();

        double totalamount = amount+interestamt;
        totalypayble.text = totalamount.toString();

        double monamount = totalamount/months;
        monthlypayble.text = monamount.toString();
      }
    }

    if(dropdownvalue == 'Home Appliances'){
      if(amount < 50000 ||amount > 500000|| months < 12 || months > 36){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("loan amount must be between 50000 to 500000 and months must be between 12 to 36",
            style: TextStyle(color: Colors.red,fontSize: 20 ),
          ),
        ));
      }else{
        interestrate.text = '10';

        double interestamt = (amount/100)*int.parse(interestrate.text);
        interestamount.text = interestamt.toString();

        double totalamount = amount+interestamt;
        totalypayble.text = totalamount.toString();

        double monamount = totalamount/months;
        monthlypayble.text = monamount.toString();
      }
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
                icon: const Icon(Icons.arrow_back,color: Colors.black,),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()),);
                },
              ),
            ],
          ),
          title: Text('Emi Calculator',style: TextStyle(color: Colors.black, fontSize: 20),),
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

                SizedBox(height:10.0),


                DropdownButton(

                  // Initial Value
                  value: dropdownvalue,

                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),

                  // Array list of items
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),

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



                SizedBox(height:10.0),

                TextField(
                  decoration: InputDecoration(
                    prefixIcon: new Icon(Icons.money,color: Colors.black,),
                    border: OutlineInputBorder(),
                    labelText: 'Loan Amount',

                  ),
                  controller: loanamount,
                ),

                SizedBox(height: 10.0),

                TextField(
                  decoration: InputDecoration(
                    prefixIcon: new Icon(Icons.calendar_month_sharp,color: Colors.black,),
                    border: OutlineInputBorder(),
                    labelText: 'Number of Months',

                  ),
                  controller: numberofmonths,
                ),
                SizedBox(height: 10.0),

                TextField(
                  decoration: InputDecoration(
                    prefixIcon: new Icon(Icons.percent,color: Colors.black,),
                    border: OutlineInputBorder(),
                    labelText: 'Interest Rate',
                  ),
                  controller: interestrate,
                ),
                SizedBox(height: 10.0),

                TextField(
                  decoration: InputDecoration(
                    prefixIcon: new Icon(Icons.money,color: Colors.black,),
                    border: OutlineInputBorder(),
                    labelText: 'Interest Amount',
                  ),
                  controller: interestamount,
                ),
                SizedBox(height: 10.0),

                TextField(
                  decoration: InputDecoration(
                    prefixIcon: new Icon(Icons.payment,color: Colors.black,),
                    border: OutlineInputBorder(),
                    labelText: 'Monthly Payble',
                  ),
                  controller: monthlypayble,
                ),
                SizedBox(height: 10.0),

                TextField(
                  decoration: InputDecoration(
                    prefixIcon: new Icon(Icons.payment,color: Colors.black,),
                    border: OutlineInputBorder(),
                    labelText: 'Total Payble',
                  ),
                  controller: totalypayble,
                ),
                SizedBox(height: 15.0),
Row(
  children: [
    SizedBox(
      width: 200.0,
      height: 40.0,
      child: ElevatedButton(
        onPressed: () async {

          calculate();


          setState(() {


          });
        },

        child: Text('CALCULATE',style: TextStyle(fontSize: 20),),
        style: ElevatedButton.styleFrom(
          primary: Colors.black,
          shape: StadiumBorder(),
          // Background color
        ),
      ),
    ),
    SizedBox(width: 20.0,),
    SizedBox(
      width: 150.0,
      height: 40.0,
      child: ElevatedButton(
        onPressed: () async {


          calculateId();
          String id = DateTime.now().millisecondsSinceEpoch.toString();

          final String loantype1 = dropdownvalue;
          final String loanamount1 = loanamount.text.toString();
          final String numberofmonths1 = numberofmonths.text.toString();
          final String iinterestrate1 = interestrate.text.toString();
          final String interestamount1 = interestamount.text.toString();
          final String monthlypayble1 = monthlypayble.text.toString();
          final String totalypayble1 = totalypayble.text.toString();

          if (loantype1 != null) {
            await _calculates.doc(id).set(
                { "id": calculateID,
                  "loantype": loantype1,
                  "loanamount": loanamount1,
                  "numberofmonths": numberofmonths1,
                  "interestrate": iinterestrate1,
                  "interestamount": interestamount1,
                  "monthlypayble": monthlypayble1,
                  "totalypayble": totalypayble1,
                });



          }


          setState(() {


          });
        },

        child: Text('  SAVE  ',style: TextStyle(fontSize: 20),),
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

                    stream: _calculates.snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {

                        return ListView.builder(
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            documentSnapshot = snapshot.data!.docs[snapshot.data!.docs.length-1];
                            return Card(
                              margin: EdgeInsets.all(10),
                              child: ListTile(
                                title: Text("Calculate ID IS: "+'${printId}',style: TextStyle(color: Colors.white, fontSize: 25),),
                              ),
                              color: Colors.black,
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