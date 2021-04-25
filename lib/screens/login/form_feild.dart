import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputField extends StatelessWidget {
  final String hint;
  final String prefixText;
  final bool obscureText;
  final List inputFormatters;
  final TextInputType textInputType;
  final Function validator;
  final IconData prefixIcon;
  final IconData suffixIcon;

  final Function sufixTap;
  final Function onSaved;
  final TextEditingController controller;

  InputField(
      {this.hint,
      this.prefixText,
      this.obscureText = false,
      this.inputFormatters,
      this.textInputType,
      this.validator,
      this.prefixIcon,
      this.suffixIcon,
      this.sufixTap,
      this.onSaved,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: textInputType,
        validator: validator,
        inputFormatters: inputFormatters,
        textAlign: TextAlign.start,
        style: GoogleFonts.k2d(
            fontSize: 17, color: Colors.orange[500], fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          prefixText: prefixText,
          prefixStyle: TextStyle(
            
          ),
          fillColor: Colors.white12,
          focusColor: Colors.orange,
          hoverColor: Colors.orange,
          filled: true,
          contentPadding: EdgeInsets.symmetric(vertical: 1, horizontal: 5),
          prefixIcon: Padding(
            padding: EdgeInsets.all(5),
            child: Icon(
              prefixIcon,
              color: Colors.green[400],
            ),
          ),
          suffix: GestureDetector(
            onTap: sufixTap,
            child: Padding(
              padding: EdgeInsets.all(1.0),
              child: Icon(
                suffixIcon,
                color: Colors.green,
              ),
            ),
          ),
          helperMaxLines: 1,
          errorStyle: TextStyle(color: Colors.red),
          errorMaxLines: 12,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Colors.orange
          )),
          hintText: hint,
          hintStyle:
              TextStyle(color: Colors.white38, fontWeight: FontWeight.w400),
        ),
        onSaved: onSaved,
      ),
    );
  }
}
