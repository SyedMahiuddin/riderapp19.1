import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:riderapp/pages/profile_screen.dart';
import '../utils/colors.dart';
import 'delivery_screen.dart';
import 'home_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class SecondPage extends StatefulWidget {
  static const String routeName='/bottomnavipage';
  const SecondPage({Key? key}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}
class _SecondPageState extends State<SecondPage> {
  int pageIndex = 0;

  List<Widget> widgetList = const [
    HomeScreen(),
    DeliveryScreen(),
    ProfileScreen()

  ];

  @override
  Widget build(BuildContext context) {
    double scheight= MediaQuery.of(context).size.height;
    double scwidth= MediaQuery.of(context).size.width;
    Connectivity connectivity=Connectivity();
    return Scaffold(

      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        onTap: (index) {
          setState(() {
            pageIndex = index;
          });
        },

        currentIndex: pageIndex,

        items:  [
          BottomNavigationBarItem(
              icon: Icon(Icons.home,size: 32.h,),
              activeIcon: Icon(
                  Icons.home,
                  size: 32.h,
                  color: Color(0xFF565d91)
              ),
              label: 'Home'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.pedal_bike_outlined,size: 32.h,),
              activeIcon: Icon(
                  Icons.pedal_bike_outlined,
                  size: 32.h,
                  color: Color(0xFF565d91)
              ),
              label: 'Ride'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person,size: 32.h,),
              activeIcon: Icon(
                  Icons.person,
                  size: 32.h,
                  color: Color(0xFF565d91)
              ),
              label: 'Profile'
          ),


        ],
      ),

      body:StreamBuilder(
        stream: connectivity.onConnectivityChanged,
        builder: (_, snapshot){
        return snapshot.connectionState==ConnectionState.active?
        snapshot.data!=ConnectivityResult.none?
        Center(
          child: widgetList[pageIndex],
        ): Center(
          child: Center(
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
        ):Center(
          child: widgetList[pageIndex],
        );
      },)
    );
  }
}
