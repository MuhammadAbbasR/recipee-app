
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

 class Textfield extends StatelessWidget{

  final TextEditingController controller;
  final String hinttext;
  final bool obscuretext;

  Textfield(
  {
    super.key,
    required this.controller,
   required this.hinttext,
   required this.obscuretext
});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscuretext,
        decoration: InputDecoration(
          hintText: hinttext,
          hintStyle: TextStyle(
            color: Colors.black
          ),
            enabledBorder:OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green)
          )
        ),
      ),
    );
  }

}