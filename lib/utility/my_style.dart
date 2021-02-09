import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MyStyle {
  Color darkColor = Color(0xffb7cc00);
  Color primaryColor = Color(0xffedff3d);
  Color lightColor = Color(0xffffff75);

  Column buildSignOut(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ListTile(
          onTap: () async {
            Navigator.pop(context);
            await Firebase.initializeApp().then((value) async {
              await FirebaseAuth.instance.signOut().then((value) =>
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/authen', (route) => false));
            });
          },
          tileColor: Colors.red.shade700,
          leading: Icon(
            Icons.exit_to_app,
            size: 36,
            color: Colors.white,
          ),
          title: MyStyle().titleH2('Sign Out'),
        ),
      ],
    );
  }

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

  Widget titleH2(String title) => Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
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
