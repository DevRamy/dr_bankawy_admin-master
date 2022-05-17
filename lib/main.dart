import 'package:dr_bankawy/constants.dart';
import 'package:dr_bankawy/provider/adminMode.dart';
import 'package:dr_bankawy/provider/cartItem.dart';
import 'package:dr_bankawy/provider/modelHud.dart';
import 'package:dr_bankawy/screens/admin/OrdersScreen.dart';
import 'package:dr_bankawy/screens/admin/addProduct.dart';
import 'package:dr_bankawy/screens/admin/adminHome.dart';
import 'package:dr_bankawy/screens/admin/editProduct.dart';
import 'package:dr_bankawy/screens/admin/manageProduct.dart';
import 'package:dr_bankawy/screens/admin/order_details.dart';
import 'package:dr_bankawy/screens/login_screen.dart';
import 'package:dr_bankawy/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  bool isUserLoggedIn = false;

  MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const MaterialApp(
            title: "dr bankawy admin",
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: Text('Loading....'),
              ),
            ),
          );
        } else {
          isUserLoggedIn = snapshot.data.getBool(kKeepMeLoggedIn) ?? false;
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<ModelHud>(
                create: (context) => ModelHud(),
              ),
              ChangeNotifierProvider<CartItem>(
                create: (context) => CartItem(),
              ),
              ChangeNotifierProvider<AdminMode>(
                create: (context) => AdminMode(),
              )
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: isUserLoggedIn ? AdminHome.id : LoginScreen.id,
              routes: {
                OrderDetails.id: (context) => OrderDetails(),
                OrdersScreen.id: (context) => OrdersScreen(),
                EditProduct.id: (context) => EditProduct(),
                ManageProducts.id: (context) => const ManageProducts(),
                LoginScreen.id: (context) => LoginScreen(),
                SignupScreen.id: (context) => SignupScreen(),
                AdminHome.id: (context) => AdminHome(),
                AddProduct.id: (context) => AddProduct(),
              },
              theme: ThemeData(
                  fontFamily: 'Tajawal-Regular',
                  scaffoldBackgroundColor: kMainColor,
                  appBarTheme: const AppBarTheme(
                      backgroundColor: Colors.transparent, elevation: 0)),
              builder: (context, child) {
                return Directionality(
                    textDirection: TextDirection.rtl, child: child);
              },
            ),
          );
        }
      },
    );
  }
}
