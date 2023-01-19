import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:riderapp/pages/Provider/user_provider.dart';
import 'package:riderapp/pages/MapPage/google_map.dart';
import 'package:riderapp/pages/launcher_page.dart';
import 'package:riderapp/pages/log_in_page.dart';
import 'package:riderapp/pages/secondpage.dart';
import 'package:riderapp/pages/firstpage.dart';
import 'package:riderapp/pages/home_screen.dart';
import 'package:provider/provider.dart';
import 'auth/auth_service.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider()
            ..getUserData(AuthService.user!.uid)
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // double sch=MediaQuery.of(context).size.height;
    // double scw=MediaQuery.of(context).size.height;
   // Connectivity connectivity=Connectivity();
       return ScreenUtilInit(
           designSize: const Size(450, 900),
           minTextAdapt: true,
           splitScreenMode: true,
           builder: (context, child) {

         return MaterialApp(
           debugShowCheckedModeBanner: false,
           title: 'Flutter Demo',
           theme: ThemeData(
             primarySwatch: Colors.blue,
           ),
           initialRoute: LauncherPage.routeName,
           routes: {
             LauncherPage.routeName:(context)=> LauncherPage(),
             FirstPage.routeName: (context)=>FirstPage(),
             SecondPage.routeName: (context)=>SecondPage(),
             HomeScreen.routeName: (context)=>HomeScreen(),
             LogInPage.routeName:(context)=> LogInPage(),
             MapPage.routeName:(context)=> MapPage(),
           },
         );
       });

  }
}



