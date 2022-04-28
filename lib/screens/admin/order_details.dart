// ignore_for_file: deprecated_member_use, must_be_immutable

import 'package:dr_bankawy/constants.dart';
import 'package:dr_bankawy/models/product.dart';
import 'package:dr_bankawy/services/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderDetails extends StatelessWidget {
  static String id = 'OrderDetails';
  Store store = Store();
  var format = DateFormat("yyyy-MM-dd");

  OrderDetails({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Map pasData = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: kThiredColor,
      body: FutureBuilder<DocumentSnapshot>(
          future: store.getProdcut(pasData['product_id']),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Product products = Product(
                pName: snapshot.data[kProductName],
                pImage: snapshot.data[kProductImage],
                pInterest: snapshot.data[kProductInterest],
                pDuration: snapshot.data[kProductDuration],
                pPhone: snapshot.data[kProductPhone],
              );

              return Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height * .2,
                      color: kSecondaryColor,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(
                              height: 50,
                            ),
                            Text(
                                'تاريخ الطلب : ${format.format(DateTime.fromMillisecondsSinceEpoch(pasData['date_created']))}',
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(
                              height: 25,
                            ),
                            const Center(
                              child: Text('بيانات القرض',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                                child: Image.network(
                              products.pImage,
                              width: 250,
                              height: 250,
                            )),
                            const SizedBox(
                              height: 10,
                            ),
                            Text('قرض بنك : ${products.pName}',
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(
                              height: 10,
                            ),
                            Text('فائدة : ${products.pInterest}',
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(
                              height: 10,
                            ),
                            Text('المدة : ${products.pDuration}',
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(
                              height: 10,
                            ),
                            Text('هاتف : ${products.pPhone}',
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(
                              height: 25,
                            ),
                            const Center(
                              child: Text('بيانات صاحب الطلب',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text('البريد : ${pasData['user_email']}',
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: ButtonTheme(
                            buttonColor: kMainColor,
                            child: RaisedButton(
                              onPressed: () {
                                try {
                                  store.editOrder({
                                    kisReviewed: true,
                                    kisAccepted: true,
                                  }, pasData['documentId']);
                                  Navigator.pop(context);
                                } catch (e) {
                                  print(e);
                                }
                              },
                              child: const Text('قبول الطلب',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: ButtonTheme(
                            buttonColor: kMainColor,
                            child: RaisedButton(
                              onPressed: () {
                                try {
                                  store.editOrder({
                                    kisReviewed: true,
                                    kisAccepted: false,
                                  }, pasData['documentId']);
                                  Navigator.pop(context);
                                } catch (e) {
                                  print(e);
                                }
                              },
                              child: const Text('رفض الطلب',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: Text('Loading Order Details'),
              );
            }
          }),
    );
  }
}
