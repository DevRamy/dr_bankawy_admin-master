// ignore_for_file: file_names

import 'dart:convert';

import 'package:dr_bankawy/constants.dart';
import 'package:dr_bankawy/screens/admin/order_details.dart';
import 'package:dr_bankawy/services/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dr_bankawy/models/order.dart';
import 'package:intl/intl.dart';

import '../../models/product.dart';

class OrdersScreen extends StatelessWidget {
  static String id = 'OrdersScreen';
  final Store _store = Store();
  var format = DateFormat("yyyy-MM-dd");

  // Future<Product> loadProducts(documentId) async {
  //   final product = await _store.getProdcut(documentId);
  //   //print(product.data[kProductName]);
  //   return Product(
  //     pId: product.data[kProductId],
  //     pName: product.data[kProductName],
  //     pImage: product.data[kProductImage],
  //     pInterest: product.data[kProductInterest],
  //     pDescription: product.data[kProductDescription],
  //     pPhone: product.data[kProductPhone],
  //     pDuration: product.data[kProductDuration],
  //     pPapers: product.data[kProductPapers],
  //   );
  // }

  OrdersScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadOrders(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text('there is no orders'),
            );
          } else {
            List<Order> orders = [];
            for (var doc in snapshot.data.documents) {
              //var productLoad = loadProducts(doc.data[kProductId]);
              orders.add(Order(
                documentId: doc.documentID,
                userEmail: doc.data[kUserEmail],
                isAccepted: doc.data[kisAccepted],
                isReviewed: doc.data[kisReviewed],
                createdDate: doc.data[kCreatedDate],
                productId: doc.data[kProductId],
              ));
            }
            return ListView.builder(
              itemBuilder: (context, index) => Visibility(
                // visible: orders[index].isReviewed && !orders[index].isAccepted
                //     ? false
                //     : true,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: GestureDetector(
                    onTap: () {
                      orders[index].isReviewed
                          ? null
                          : Navigator.pushNamed(
                              context,
                              OrderDetails.id,
                              arguments: {
                                "documentId": orders[index].documentId,
                                "product_id": orders[index].productId,
                                "user_email": orders[index].userEmail,
                                "date_created": orders[index].createdDate,
                              },
                            );
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * .2,
                      decoration: BoxDecoration(
                        color: orders[index].isReviewed
                            ? orders[index].isAccepted
                                ? const Color.fromARGB(255, 24, 255, 71)
                                : const Color.fromARGB(255, 255, 84, 71)
                            : kSecondaryColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'بريد المستخدم : ${orders[index].userEmail}',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                                'حالة الطلب: ${orders[index].isAccepted && orders[index].isReviewed ? 'تم قبول' : !orders[index].isAccepted && orders[index].isReviewed ? 'تم رفض' : 'قيض المراجعة'}',
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                                'تارخ الطلب: ${format.format(DateTime.fromMillisecondsSinceEpoch(orders[index].createdDate))}',
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
                ),
              ),
              itemCount: orders.length,
            );
          }
        },
      ),
    );
  }
}
