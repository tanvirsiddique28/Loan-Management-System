

import 'package:flutter/material.dart';
import 'package:loanmanagementsystem/demo.dart';
import 'package:loanmanagementsystem/payment.dart';
import 'package:loanmanagementsystem/paymentstatus.dart';
import 'package:loanmanagementsystem/registration.dart';
import 'package:loanmanagementsystem/withdrawn.dart';

import 'application.dart';
import 'customerprofile.dart';
import 'emicalculator.dart';
import 'loanaproval.dart';
import 'main.dart';



class MyDashBoard extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Dashboard()
    );
  }
}

class Dashboard extends  StatefulWidget {
  @override
  State<Dashboard> createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {

  @override
  Widget build(BuildContext context) {
    var containerheight = MediaQuery.of(context).size.height;
    var containerwidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(

          iconTheme: IconThemeData(color: Colors.black),
          title:  Text(
            'Dashboard',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
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

          backgroundColor:Colors.white,
        ),

        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                child: Text('Loan Management System',style: TextStyle(
                    color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold
                ),


                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.dashboard,
                  color: Colors.black,
                ),
                title: const Text('DashBoard'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.calculate,
                  color: Colors.black,
                ),
                title: const Text('Emi Calculator'),
                onTap: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context) => Myemi()),);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.settings_applications,
                  color: Colors.black,
                ),
                title: const Text('Application'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Application()),);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.approval,
                  color: Colors.black,
                ),
                title: const Text('Aproval'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoanAproval()),);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                title: const Text('Profile'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CustomerProfile()),);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.payment,
                  color: Colors.black,
                ),
                title: const Text('Payment'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Payment()),);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.info,
                  color: Colors.black,
                ),
                title: const Text('Payment Status'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentStatus()),);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
                title: const Text('Withdrawn'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Withdrawn()),);
                },
              ),
            ],
          ),
        ),
        body:Container(
          margin: EdgeInsets.all(10.0),
          child: Column(
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        height: 150.0,
                        width: 180.0,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "4",
                              style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.bold, color: Colors.white),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              "Loan Types",
                              style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.bold, color: Colors.white),
                            )
                          ],
                        ),
                      ),

                      Container(
                        height: 150.0,
                        width: 180.0,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "9",
                              style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.bold, color: Colors.white),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              "Customers",
                              style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.bold, color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ]),
                SizedBox(height: 15.0),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        height: 150.0,
                        width: 180.0,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "9",
                              style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.bold, color: Colors.white),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              "Applicants",
                              style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.bold, color: Colors.white),
                            )
                          ],
                        ),
                      ), //first item container
                      SizedBox(
                        width: 10.0,
                      ),
                      Container(
                        height: 150.0,
                        width: 180.0,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "9",
                              style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.bold, color: Colors.white),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              "Approved",
                              style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.bold, color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ]),

                SizedBox(height: 15.0),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        height: 150.0,
                        width: 180.0,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "12",
                              style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.bold, color: Colors.white),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              "Not Approved",
                              style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.bold, color: Colors.white),
                            )
                          ],
                        ),
                      ), //first item container
                      SizedBox(
                        width: 10.0,
                      ),
                      Container(
                        height: 150.0,
                        width: 180.0,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(15.0)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "10",
                              style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.bold, color: Colors.white),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              "Dismissed",
                              style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.bold, color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ]),



              ]
          ),
        )
    );



  }
}

