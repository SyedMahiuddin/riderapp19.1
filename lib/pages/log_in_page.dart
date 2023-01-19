
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:riderapp/customs/custom_snack_bar_icon.dart';
import 'package:riderapp/pages/secondpage.dart';
import 'package:riderapp/utils/colors.dart';

import '../auth/auth_service.dart';
import '../customs/custom_snack_bar.dart';
import '../customs/custom_text_field.dart';


class LogInPage extends StatefulWidget {
  static const String routeName='/logpage';
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final IconData iconData = Icons.visibility;
  bool ActiveConnection = false;
  bool visiblepass=false;
  bool status = false;
  String errMsg = '';

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    EasyLoading.addStatusCallback((status) {
      if (status == EasyLoadingStatus.dismiss) {
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Connectivity connectivity=Connectivity();
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.only(left: 30.w, right: 30.w, top: 0.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('images/bg.png',height: 250.h,width: 250.w,),
                Container(
                  height: 450.h,
                  width: 400.w,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        logoblue,
                        logogold,
                      ],
                    ),
                    color: themeColorBlue,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: logogold, width: 1.5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Log In',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color:Colors.white),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        CustomTextField(
                          controller: emailController,
                          borderColor: Colors.white,
                          prefixIcon: Icons.mail_outline,
                         // hintText: 'Enter Email',
                          labelText: 'Email',
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          height: 50.h,
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: !visiblepass,
                            decoration:  InputDecoration(
                             prefixIcon: Icon(Icons.lock_outlined,color: Colors.white,),
                              focusedBorder:OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white, width: 1.2)),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black, width: 1.2)),
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black, width: 1.2)),
                                suffixIcon: visiblepass?IconButton(onPressed: (){
                                  setState(() {
                                  visiblepass? visiblepass=false: visiblepass=true;
                                });}, icon: Icon(Icons.visibility,color: Colors.white)):
                                IconButton(onPressed: (){setState(() {
                                  visiblepass? visiblepass=false: visiblepass=true;
                                });}, icon: Icon(Icons.visibility_off,color: Colors.white,)),
                              labelText: 'Password',
                              labelStyle: TextStyle(color: Colors.black)
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: mediaQuery.size.width,
                          height: 40,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: logoblue

                                ,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(10), // <-- Radius
                                ),
                              ),
                              onPressed: () async {
                                EasyLoading.show(status: 'Please wait...');
                                if (emailController.text == '') {
                                  CustomSnackBar().showSnackBar(
                                      context: context,
                                      content: 'Enter Email',
                                      backgroundColor: Colors.red);
                                  return;
                                }
                                if (passwordController.text == '') {
                                  CustomSnackBar().showSnackBar(
                                      context: context,
                                      content: 'Enter Password',
                                      backgroundColor: Colors.red);
                                  return;
                                }
                                if (passwordController.text.length < 6) {
                                  CustomSnackBar().showSnackBar(
                                      context: context,
                                      content: 'Password length must be at least 6',
                                      backgroundColor: Colors.red);
                                  return;
                                }
                                if(ActiveConnection==false)
                                  {
                                    try {
                                      final result = await InternetAddress.lookup('example.com');
                                      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                                        EasyLoading.show(status: 'Please wait...');
                                        logIn();
                                      }
                                    } on SocketException catch (_) {
                                      CustomIconSnackBar().showSnackBar(
                                          context: context,
                                          content: Icon(Icons.wifi),
                                         );
                                    }
                                  }
                                else {
                                 EasyLoading.show(status: 'Please wait...');
                                  logIn();

                                }
                              },
                              child:  Text(
                                'Login',
                                style: TextStyle(color: Colors.white,fontSize: 18.h),
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                         Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Forgot Password',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.h,
                                  fontWeight: FontWeight.bold),
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(



                          children: [
                             Text(
                              'Dont have an account?',
                              style: TextStyle(
                                color: Colors.white,fontSize: 15.h
                              ),
                            ),
                             SizedBox(
                              width: 30.w,
                            ),
                            Text('Contact With Admin',style: TextStyle(fontSize: 15.h),)
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void logIn() async {
    try {
      await AuthService.logIn(
          emailController.text, passwordController.text).then((value) {
        Navigator.pushReplacementNamed(
            context, SecondPage.routeName);
        CustomSnackBar().showSnackBar(
            context: context,
            content: 'Log in Successful',
            backgroundColor: Colors.green);
      });
    } on FirebaseAuthException catch (e) {
      CustomSnackBar().showSnackBar(
          context: context,
          content: 'Wrong Email or Password',
          backgroundColor: Colors.green);
      setState(() {
        errMsg = e.message!;
      });
    }
  }


}
