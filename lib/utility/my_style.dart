import 'package:flutter/material.dart';

class MyStyle {
  Color darkColor = Color(0xffb7cc00);
  Color primaryColor = Color(0xffedff3d);
  Color lightColor = Color(0xffffff75);

  Widget wallpaper(double screen, BuildContext context) => Container(
        width: screen,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/wall.jpg'), fit: BoxFit.cover),
        ),
      );

  BoxDecoration myBox() => BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(20),
      );

  SizedBox buildSizedBox() {
    return SizedBox(
      height: 16,
      width: 50,
    );
  }

  Widget showLogo() => Image(image: AssetImage('images/logo.png'));

  Widget titleH1(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: darkColor,
        ),
      );

  Widget titleH3(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: darkColor,
        ),
      );

  Widget titleH3pink(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.pink.shade600,
        ),
      );

  MyStyle();
}
