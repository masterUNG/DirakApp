import 'dart:io';
import 'dart:math';

import 'package:dirakapp/utility/dialog.dart';
import 'package:dirakapp/utility/my_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class InformationShop extends StatefulWidget {
  @override
  _InformationShopState createState() => _InformationShopState();
}

class _InformationShopState extends State<InformationShop> {
  String nameLogin, photoLogin;
  double screen;
  File file;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findLogin();
  }

  Future<Null> findLogin() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance.authStateChanges().listen((event) {
        setState(() {
          nameLogin = event.displayName;
          photoLogin = event.photoURL;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => uploadToFirebase(),
        child: Text('Up'),
      ),
      body: Column(
        children: [
          buildPhoto(),
          buildNameLogin(),
        ],
      ),
    );
  }

  Future<Null> uploadToFirebase() async {
    if (file == null) {
      normalDialog(
          context, 'Image Not Change ?', 'Please Click Camera or Gallery');
    } else {
      Random random = Random();
      int i = random.nextInt(1000000);
      String nameFile = 'shop$i.jpg';

      await Firebase.initializeApp().then((value) async {
        var refer = FirebaseStorage.instance.ref().child('imageShop/$nameFile');
        UploadTask task = refer.putFile(file);
        await task.whenComplete(() async {
          print('Upload Complete');
          String url = await refer.getDownloadURL();
          print('url = $url');

          await FirebaseAuth.instance.authStateChanges().listen((event) async {
            await event.updateProfile(photoURL: url).then((value) => Navigator.pushNamedAndRemoveUntil(context, '/shoperService', (route) => false));
          });
        });
      });
    }
  }

  Future<Null> chooseSource(ImageSource source) async {
    try {
      var object = await ImagePicker().getImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
      );
      setState(() {
        file = File(object.path);
      });
    } catch (e) {}
  }

  Padding buildPhoto() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              icon: Icon(Icons.add_a_photo),
              onPressed: () => chooseSource(ImageSource.camera)),
          Container(
            width: screen * 0.6,
            height: screen * 0.6,
            child: file != null
                ? Image(image: FileImage(file))
                : photoLogin == null
                    ? Image(image: AssetImage('images/question.png'))
                    : Image(image: NetworkImage(photoLogin)),
          ),
          IconButton(
              icon: Icon(Icons.add_photo_alternate),
              onPressed: () => chooseSource(ImageSource.gallery)),
        ],
      ),
    );
  }

  Widget buildNameLogin() =>
      MyStyle().titleH1(nameLogin == null ? '' : nameLogin);
}
