import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dirakapp/models/user_model.dart';
import 'package:dirakapp/utility/dialog.dart';
import 'package:dirakapp/utility/my_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  double screen;
  String typeUser, name, user, password;

  Container buildDisplayName() {
    return Container(
      decoration: MyStyle().myBox(),
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.6,
      child: TextField(
        onChanged: (value) => name = value.trim(),
        style: TextStyle(color: MyStyle().primaryColor),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyStyle().darkColor),
          hintText: 'Display Name :',
          prefixIcon: Icon(
            Icons.fingerprint,
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

  Container buildUser() {
    return Container(
      decoration: MyStyle().myBox(),
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.6,
      child: TextField(
        onChanged: (value) => user = value.trim(),
        style: TextStyle(color: MyStyle().primaryColor),
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
        onChanged: (value) => password = value.trim(),
        style: TextStyle(color: MyStyle().primaryColor),
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

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyStyle().primaryColor,
        child: Icon(
          Icons.cloud_upload,
          color: MyStyle().darkColor,
        ),
        onPressed: () {
          print(
              'name = $name, \n typeUser = $typeUser, \n user = $user, \n password = $password');

          if ((name?.isEmpty ?? true) ||
              (user?.isEmpty ?? true) ||
              (password?.isEmpty ?? true)) {
            print('Have Space');
            normalDialog(context, 'Have Space ?', 'Please Fill Every Blank');
          } else if (typeUser == null) {
            normalDialog(context, 'No Type User ?', 'Please Choose Type User');
          } else {
            createAccountAnInsertData();
          }
        },
      ),
      appBar: AppBar(
        title: Text('Create Account'),
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          MyStyle().wallpaper(screen, context),
          Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  buildDisplayName(),
                  buildTypeUser(context),
                  buildUser(),
                  buildPassword(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<Null> createAccountAnInsertData() async {
    await Firebase.initializeApp().then((value) async {
      print('Initialapp Succces');
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: user, password: password)
          .then((value) async {
        print('Create Account Success');
        value.user.updateProfile(displayName: name);
        String uid = value.user.uid;
        UserModel model = UserModel(name: name, typeuser: typeUser);
        Map<String, dynamic> data = model.toMap();
        await FirebaseFirestore.instance
            .collection('user')
            .doc(uid)
            .set(data)
            .then((value) {
          switch (typeUser) {
            case 'customer':
              Navigator.pushNamedAndRemoveUntil(
                  context, '/customerService', (route) => false);
              break;
            case 'shoper':
              Navigator.pushNamedAndRemoveUntil(
                  context, '/shoperService', (route) => false);
              break;
            default:
          }
        });
      }).catchError(
              (value) => normalDialog(context, value.code, value.message));
    });
  }

  Theme buildTypeUser(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        unselectedWidgetColor: MyStyle().lightColor,
        selectedRowColor: MyStyle().darkColor,
      ),
      child: Column(
        children: [
          buildRadioCustomer(),
          buildRadioShoper(),
        ],
      ),
    );
  }

  Container buildRadioCustomer() {
    return Container(
      width: screen * 0.6,
      child: RadioListTile(
        title: MyStyle().titleH3('Customer'),
        value: 'customer',
        groupValue: typeUser,
        onChanged: (value) {
          setState(() {
            typeUser = value;
            print('typeUser = $typeUser');
          });
        },
      ),
    );
  }

  Container buildRadioShoper() {
    return Container(
      width: screen * 0.6,
      child: RadioListTile(
        title: MyStyle().titleH3('Shoper'),
        value: 'shoper',
        groupValue: typeUser,
        onChanged: (value) {
          setState(() {
            typeUser = value;
            print('typeUser = $typeUser');
          });
        },
      ),
    );
  }
}
