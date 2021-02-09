import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dirakapp/models/user_model.dart';
import 'package:dirakapp/utility/dialog.dart';
import 'package:dirakapp/utility/my_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  double screen;
  String user, password;

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyStyle().buildSizedBox(),
          MyStyle().titleH3('Non Account ?'),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/createAccount'),
            child: MyStyle().titleH3pink('Create Account'),
          ),
        ],
      ),
      body: Stack(
        children: [
          MyStyle().wallpaper(screen, context),
          buildContent(),
        ],
      ),
    );
  }

  Center buildContent() {
    return Center(
      child: SingleChildScrollView(
              child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildLogo(),
            MyStyle().buildSizedBox(),
            MyStyle().titleH1('Ung Coffee'),
            buildUser(),
            buildPassword(),
            buildLogin(),
          ],
        ),
      ),
    );
  }

  Container buildLogin() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.6,
      child: ElevatedButton(
        onPressed: () {
          if ((user?.isEmpty ?? true) || (password?.isEmpty ?? true)) {
            normalDialog(context, 'มีช่องว่าง ?', 'กรุณากรอกทุกช่อง คะ');
          } else {
            cheackAuthen();
          }
        },
        child: Text('Login'),
        style: ElevatedButton.styleFrom(
            primary: MyStyle().darkColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
      ),
    );
  }

  Future<Null> cheackAuthen() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: user, password: password)
          .then((value) async {
        await FirebaseFirestore.instance
            .collection('user')
            .doc(value.user.uid)
            .snapshots()
            .listen((event) {
          UserModel model = UserModel.fromMap(event.data());
          Navigator.pushNamedAndRemoveUntil(
              context, '/${model.typeuser}Service', (route) => false);
        });
      }).catchError((onError) =>
              normalDialog(context, onError.code, onError.message));
    });
  }

  Container buildUser() {
    return Container(
      decoration: MyStyle().myBox(),
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.6,
      child: TextField(
        style: TextStyle(color: MyStyle().primaryColor),
        onChanged: (value) => user = value.trim(),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyStyle().darkColor),
          hintText: 'User :',
          prefixIcon: Icon(
            Icons.perm_identity,
            color: MyStyle().darkColor,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: MyStyle().darkColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: MyStyle().lightColor),
          ),
        ),
      ),
    );
  }

  Container buildPassword() {
    return Container(
      decoration: MyStyle().myBox(),
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.6,
      child: TextField(
        style: TextStyle(color: MyStyle().primaryColor),
        onChanged: (value) => password = value.trim(),
        obscureText: true,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyStyle().darkColor),
          hintText: 'Password :',
          prefixIcon: Icon(
            Icons.lock_outline,
            color: MyStyle().darkColor,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: MyStyle().darkColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: MyStyle().lightColor),
          ),
        ),
      ),
    );
  }

  Container buildLogo() {
    return Container(
      width: screen * 0.35,
      child: MyStyle().showLogo(),
    );
  }
}
