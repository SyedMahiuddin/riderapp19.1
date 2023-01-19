import 'package:flutter/material.dart';
import 'package:riderapp/utils/colors.dart';

class DeliveryScreen extends StatelessWidget {
  const DeliveryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xFF565d91),
        ),
      body: Center(child: Text('No Data')),
    );
  }
}

