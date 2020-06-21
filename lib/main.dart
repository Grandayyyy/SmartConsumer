
import 'dart:async';
import 'dart:io';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterapp/todoui.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:auto_size_text/auto_size_text.dart';
//import 'package:flutter_launcher_icons/android.dart';
//import 'package:flutter_launcher_icons/constants.dart';
//import 'package:flutter_launcher_icons/custom_exceptions.dart';
//import 'package:flutter_launcher_icons/main.dart';
//import 'package:flutter_launcher_icons/utils.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
        // brightness: Brightness.dark,
        fontFamily: 'NexaDemo',
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  String barcode = "";
  final List<String> names = <String>[];
  final List<int> msgCount = <int>[];
  var isLargeScreen = false;

  @override
  initState() {
    super.initState();
  }

  File galleryFile;

  TextEditingController nameController = TextEditingController();

  void addItemToList(){
    setState(() {
      if (barcode. length == 0) {

      } else {
        names.insert(0, barcode);
        msgCount.insert(0, 0);
    }
    });
  }

  void remove(){
    setState(() {
      if (barcode. length == 0) {

      } else {
        barcode = "";
        names.insert(0, barcode);
        msgCount.insert(0, 0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    var screenSize = MediaQuery.of(context).size;
//    var wid = MediaQuery.of(context).size.width;
//    var hei = MediaQuery.of(context).size.height;

    double screenWidth(BuildContext context, {double dividedBy = 1}) {
      return screenSize.width / dividedBy;
    }
    double screenHeight(BuildContext context, {double dividedBy = 1, double reducedBy = 0.0}) {
      return (screenSize.height - reducedBy) / dividedBy;
    }
    double screenHeightExcludingToolbar(BuildContext context, {double dividedBy = 1}) {
      return screenHeight(context, dividedBy: dividedBy, reducedBy: kToolbarHeight);
    }
//    double screenWidthExcludingToolbar(BuildContext context, {double dividedBy = 1}) {
//      return screenWidth(context, dividedBy: dividedBy);
//    }


      return Scaffold(
          appBar: new AppBar(
            backgroundColor: Colors.black,
            title: Align(
              alignment: Alignment.topLeft,
              child: Text(
                  'Scan Barcode',
              ),
            )
          ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Shopping cart',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.shopping_cart),
                title: Text('Shopping cart'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => todoui()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.shopping_cart),
                title: Text('Search on Amazon'),
                onTap: () {
                  _launchURL();
                },
              ),
              ListTile(
                leading: Icon(Icons.shopping_cart),
                title: Text('Search on Google'),
                onTap: () {
                  _launchURL2()();
                },
              ),
            ],
          ),
        ),
          body: new Center(
            child: new Column(
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.all(8.0),
                ),
                new  Container(

                  height: screenHeightExcludingToolbar(context, dividedBy: 2),
                  width: (MediaQuery.of(context).size.width),
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 10),

                  child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 30,
                      child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Stack(
                              children: <Widget>[
                                Column(
                                    children: <Widget>[
                                      new Text(
                                          "Barcode Value",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'NexaDemo',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                      ),
                                      new Padding(
                                        padding: const EdgeInsets.all(10.0),
                                      ),
                                      new ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: Center(
                                          child: Container(
                                            height: screenHeightExcludingToolbar(context, dividedBy: 4),
                                            color:Colors.grey,
                                            child: numdisplay(),
                                          ),
                                        )
                                      ),
                                    ]
                                )
                              ]
                          )
                      )
                  ),
                ),
              ],
            ),
          ),
        floatingActionButton: Container(
          padding: EdgeInsets.only(bottom: 20.0),
          //width: screenWidth(context, dividedBy: 2),
          height: 80,
          child: FloatingActionButton.extended(
            onPressed: barcodeScanning,
            label: Text(
                'Scan',
              style: TextStyle(
                color:Colors.white70,
              ),
            ),
            icon: Icon(Icons.camera, color: Colors.white70),
            backgroundColor: Colors.black54,
          ),
        ),
        //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
  }

  Widget numdisplay() {
    return Align(
        alignment: Alignment.center,
      child: Padding(
        padding:const EdgeInsets.only(left:62.0),
        child: Row(
          children: <Widget>[
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: barcode,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                )
              ),
            ),
          ]
        )
      )
    );
  }

  _launchURL() async {
    if (barcode.length == 0) {

    } else {
      if (barcode == 'Nothing Captured.') {

      } else {
        var url = 'https://www.amazon.in/s?k=' + barcode + '&ref=nb_sb_noss';
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
      }
    }
  }

  _launchURL2() async {
    if (barcode.length == 0) {

    } else {
      if (barcode == 'Nothing Captured.') {

      } else {
        var url = 'https://www.google.com/search?q=' + barcode;
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
      }
    }
  }


// Method for scanning barcode....
  Future barcodeScanning() async {
//imageSelectorGallery();

    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'No camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode =
      '');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
}

//class HomePage extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    final size = MediaQuery.of(context).size;
//
//  }
//}

