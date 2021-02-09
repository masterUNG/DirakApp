import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dirakapp/models/user_model.dart';
import 'package:dirakapp/router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

String initialRoute = '/authen';

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) async {
    await FirebaseAuth.instance.authStateChanges().listen((event) async {
      if (event != null) {
        await FirebaseFirestore.instance
            .collection('user')
            .doc(event.uid)
            .snapshots()
            .listen((event) {
          UserModel model = UserModel.fromMap(event.data());
          initialRoute = '/${model.typeuser}Service';
          print('#### initlalRoute = $initialRoute');
          runApp(MyApp());
        });
      } else {
        runApp(MyApp());
      }
    });
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.black),
      routes: map,
      initialRoute: initialRoute,
    );
  }
}
