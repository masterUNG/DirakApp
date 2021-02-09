import 'package:dirakapp/utility/my_style.dart';
import 'package:flutter/material.dart';

class CustomerService extends StatefulWidget {
  @override
  _CustomerServiceState createState() => _CustomerServiceState();
}

class _CustomerServiceState extends State<CustomerService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome Customer'),
      ),drawer: Drawer(child: MyStyle().buildSignOut(context),),
    );
  }
}
