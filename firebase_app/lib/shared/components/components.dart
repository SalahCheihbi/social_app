import 'package:firebase_app/shared/styles/icons_broken.dart';
import 'package:flutter/material.dart';

Widget defaultFromField({
  required String label,
  required IconData prefix,
  required String? Function(String?)? validate,
  required TextEditingController controller,
  bool? isPassword = false,
  TextInputType? type,
  IconData? suffix,
  Function()? suffixPressed,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword!,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: suffix != null
            ? IconButton(onPressed: suffixPressed, icon: Icon(suffix))
            : null,
        prefixIcon: Icon(prefix),
        border: OutlineInputBorder(),
      ),
    );

Widget defaultButton({
  double radius = 3.0,
  Color background = Colors.orange,
  double width = double.infinity,
  required void Function()? function,
  required String text,
}) =>
    Container(
      height: 40.0,
      width: width,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
      decoration: BoxDecoration(
          color: background, borderRadius: BorderRadius.circular(radius)),
    );

Widget defaultTextButton({
  required String text,
  required void Function()? function,
}) =>
    TextButton(onPressed: function, child: Text(text));

defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? action,
}) =>
    AppBar(
      actions: action,
      titleSpacing: 5.0,
      title: Text(
        title!,
        style: TextStyle(color: Colors.black, fontFamily: 'Jannah'),
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(IconBroken.Arrow___Left_2),
      ),
    );
