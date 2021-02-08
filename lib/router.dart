import 'package:dirakapp/states/authen.dart';
import 'package:dirakapp/states/create_account.dart';
import 'package:dirakapp/states/customer_service.dart';
import 'package:dirakapp/states/shopper_service.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => Authen(),
  '/createAccount':(BuildContext context)=>CreateAccount(),
  '/customerService':(BuildContext context)=>CustomerService(),
  '/shopperService':(BuildContext context)=>ShopperService(),
};
