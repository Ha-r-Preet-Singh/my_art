
import 'package:flutter/material.dart';
import 'package:my_art/ui_helper.dart';


class CustomTextField extends StatelessWidget {

  String hintTxt;
  IconData? suffIcon;
  TextEditingController? TextEditContoller;
  String? Function(String?)? validate;


   CustomTextField({
   required this.hintTxt,
     this.suffIcon,
     this.validate,
     this.TextEditContoller,


  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: TextEditContoller,
      decoration: InputDecoration(

        filled: true,
        fillColor: AppColors.textfieldColor,
        hintText: hintTxt,



        suffixIcon:Icon(suffIcon),
        suffixIconColor:AppColors.hintextColor ,
        hintStyle: mTextStyle15(
          fFamily: "poppinsbold",
          mColor: AppColors.hintextColor,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color:AppColors.textfieldColor ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color:AppColors.textfieldColor ),
        ),

      ),
        validator: validate,
    );
  }
}
