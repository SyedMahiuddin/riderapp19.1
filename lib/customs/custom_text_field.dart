import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final String? labelText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool? isPassword;
  final bool? readOnly;
  final Color borderColor;
  final TextInputType? textInputType;

  const CustomTextField(
      {required this.controller,
      this.hintText,
      this.labelText,
      this.prefixIcon,
      this.suffixIcon,
      this.isPassword,
      this.readOnly,
      required this.borderColor,
      this.textInputType
      });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      child: TextFormField(

        keyboardType: widget.textInputType == null ? TextInputType.text : widget.textInputType,
        controller: widget.controller,
        readOnly: widget.readOnly == null ? false : true,
        obscureText: widget.isPassword == null ? false : true,
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: widget.borderColor, width: 1.2)),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1.2)),
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1.2)),
            hintText: widget.hintText == null ? "" : widget.hintText,
            labelText: widget.labelText == null ? "" : widget.labelText,
            prefixIcon:
                widget.prefixIcon == null ? null : Icon(widget.prefixIcon,color: Colors.white,),
            suffixIcon:
                widget.suffixIcon == null ? null : Icon(widget.suffixIcon),
            labelStyle: TextStyle(color: Colors.black)),
      ),
    );
  }
}
