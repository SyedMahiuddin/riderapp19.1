import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:riderapp/pages/home_screen.dart';
import 'package:riderapp/pages/secondpage.dart';


import '../utils/colors.dart';

class FirstPage extends StatefulWidget {
  static const String routeName='/firstpage';
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    double scheight= MediaQuery.of(context).size.height;
    double scwidth= MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColorBlue,
        title: Text('Hello, Martin!'),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.notifications,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Center(
        child: Stack(
          children: [
            Image.asset('images/nointernet.PNG',height: scheight,width: scwidth,fit: BoxFit.contain,),
            Positioned(
              bottom: scheight-700,
                left: scwidth-320,
                child: Column(
                  children: [
                    Text('You Are Offline Now!',style: TextStyle(color: orangetextcol,fontSize: 20,fontWeight: FontWeight.bold),),
                    SizedBox(height: 20,),
                    Text('Go online, accept your orders and make',style: TextStyle(color: orangetextcol,fontSize: 15)),
                    SizedBox(height: 5,),
                    Text('customer happy with your service',style: TextStyle(color:orangetextcol,fontSize: 15)),
                  ],
                )
            ),
            Positioned(
              bottom:20,
                left: 15,
                child: SizedBox(
                  width: scwidth-30,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: firstbuttoncolor,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(8), // <-- Radius
                      ),
                    ),
                    onPressed: (){
                      Navigator.pushReplacementNamed(context, SecondPage.routeName);
                    },
                    child: Text('Go Online',style: TextStyle(fontSize: 20),),
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
