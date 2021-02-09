import 'package:dirakapp/body/information_shop.dart';
import 'package:dirakapp/body/shop_product_shop.dart';
import 'package:dirakapp/body/show_order_shop.dart';
import 'package:dirakapp/utility/my_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ShopperService extends StatefulWidget {
  @override
  _ShopperServiceState createState() => _ShopperServiceState();
}

class _ShopperServiceState extends State<ShopperService> {
  String nameShop, photoShop;
  Widget currentWidget = ShowOrderShop();

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
          nameShop = event.displayName;
          photoShop = event.photoURL;
          print('photoShop = $photoShop');
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome Shoper'),
      ),
      drawer: buildDrawer(context),
      body: currentWidget,
    );
  }

  Drawer buildDrawer(BuildContext context) {
    findLogin();
    return Drawer(
      child: Stack(
        children: [
          Column(
            children: [
              buildUserAccountsDrawerHeader(),
              buildMenuShowOrder(context),
              buildMenuShowProduct(context),
              buildMenuInformation(context),
            ],
          ),
          MyStyle().buildSignOut(context),
        ],
      ),
    );
  }

  ListTile buildMenuShowOrder(BuildContext context) {
    return ListTile(
      onTap: () {
        setState(() {
          currentWidget = ShowOrderShop();
         
        });
        Navigator.pop(context);
      },
      leading: Icon(Icons.home),
      title: Text('Show Order'),
      subtitle: Text('แสดงรายการสินค้า ที่ลูกค้า Order'),
    );
  }

  ListTile buildMenuShowProduct(BuildContext context) {
    return ListTile(
      onTap: () {
        setState(() {
          currentWidget = ShowProductShop();
         
        });
        Navigator.pop(context);
      },
      leading: Icon(Icons.car_rental),
      title: Text('Show Product'),
      subtitle: Text('แสดงรายการสินค้า ที่ร้านเราขาย'),
    );
  }

  ListTile buildMenuInformation(BuildContext context) {
    return ListTile(
      onTap: () {
        setState(() {
          currentWidget = InformationShop();
         
        });
        Navigator.pop(context);
      },
      leading: Icon(Icons.info),
      title: Text('Information'),
      subtitle: Text('Display Information'),
    );
  }

  UserAccountsDrawerHeader buildUserAccountsDrawerHeader() {
    return UserAccountsDrawerHeader(
      currentAccountPicture: photoShop == null
          ? Image(image: AssetImage('images/question.png'))
          : Image(image: NetworkImage(photoShop)),
      accountName: Text(nameShop == null ? 'Name' : nameShop),
      accountEmail: Text('Shoper Type'),
    );
  }
}
