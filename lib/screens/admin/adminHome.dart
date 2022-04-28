// ignore_for_file: file_names

import 'package:dr_bankawy/constants.dart';
import 'package:dr_bankawy/screens/admin/OrdersScreen.dart';
import 'package:dr_bankawy/screens/admin/addProduct.dart';
import 'package:dr_bankawy/screens/admin/manageProduct.dart';
import 'package:dr_bankawy/screens/login_screen.dart';
import 'package:dr_bankawy/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminHome extends StatelessWidget {
  static String id = 'AdminHome';
  final _auth = Auth();

  AdminHome({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            width: double.infinity,
          ),
          FlatButton(
            onPressed: () {
              Navigator.pushNamed(context, AddProduct.id);
            },
            color: Colors.white,
            padding: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Text(
              ' اضافة قرض ',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          FlatButton(
            onPressed: () {
              Navigator.pushNamed(context, ManageProducts.id);
            },
            color: Colors.white,
            padding: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Text(
              ' تعديل قرض ',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          FlatButton(
            onPressed: () {
              Navigator.pushNamed(context, OrdersScreen.id);
            },
            color: Colors.white,
            padding: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Text(
              'عرض الطلبات',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          FlatButton(
            onPressed: () async {
              SharedPreferences pref = await SharedPreferences.getInstance();
              pref.clear();
              await _auth.signOut();
              Navigator.popAndPushNamed(context, LoginScreen.id);
            },
            color: Colors.white,
            padding: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Text(
              'تسجيل خروج',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          /*
                            SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  pref.clear();
                  await _auth.signOut();
                  Navigator.popAndPushNamed(context, LoginScreen.id);
                  */
        ],
      ),
    );
  }
}
