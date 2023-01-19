import 'package:flutter/material.dart';
import 'package:riderapp/pages/secondpage.dart';

import '../auth/auth_service.dart';
import 'log_in_page.dart';



class LauncherPage extends StatefulWidget {
  static const String routeName='/';
  const LauncherPage({Key? key}) : super(key: key);

  @override
  State<LauncherPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      if(AuthService.user == null) {
        Navigator.pushReplacementNamed(context, LogInPage.routeName);
      } else {
        Navigator.pushReplacementNamed(context, SecondPage.routeName);
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
