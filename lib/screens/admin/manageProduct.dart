// ignore_for_file: file_names

import 'package:dr_bankawy/models/product.dart';
import 'package:dr_bankawy/screens/admin/editProduct.dart';
import 'package:dr_bankawy/widgets/custom_menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dr_bankawy/services/store.dart';
import 'package:dr_bankawy/constants.dart';

class ManageProducts extends StatefulWidget {
  static String id = 'ManageProducts';

  const ManageProducts({Key key}) : super(key: key);
  @override
  _ManageProductsState createState() => _ManageProductsState();
}

class _ManageProductsState extends State<ManageProducts> {
  final _store = Store();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product> products = [];
            for (var doc in snapshot.data.documents) {
              var data = doc.data;
              products.add(
                Product(
                  pId: doc.documentID,
                  pInterest: data[kProductInterest],
                  pName: data[kProductName],
                  pDescription: data[kProductDescription],
                  pDuration: data[kProductDuration],
                  pPhone: data[kProductPhone],
                  pPapers: data[kProductPapers],
                  pLongitude: data[kProductLongitude],
                  pLatitude: data[kProductLatitude],
                  pImage: data[kProductImage],
                ),
              );
            }
            return ListView.builder(
              itemBuilder: (context, index) => GestureDetector(
                onTapUp: (details) async {
                  double dx = details.globalPosition.dx;
                  double dy = details.globalPosition.dy;
                  double dx2 = MediaQuery.of(context).size.width - dx;
                  double dy2 = MediaQuery.of(context).size.width - dy;
                  await showMenu(
                      context: context,
                      position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
                      items: [
                        MyPopupMenuItem(
                          onClick: () {
                            Navigator.pushNamed(context, EditProduct.id,
                                arguments: products[index]);
                          },
                          child: const Text('Edit'),
                        ),
                        MyPopupMenuItem(
                          onClick: () {
                            _store.deleteProduct(products[index].pId);
                            Navigator.pop(context);
                          },
                          child: const Text('Delete'),
                        ),
                      ]);
                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              products[index].pName,
                            ),
                            Text(products[index].pDescription.length > 11
                                ? products[index]
                                        .pDescription
                                        .substring(0, 10) +
                                    '...'
                                : products[index].pDescription),
                            const Text("قرض شخصي"),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            products[index].pImage,
                            height: MediaQuery.of(context).size.height * 0.2,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              itemCount: products.length,
            );
          } else {
            return const Center(child: Text('Loading...'));
          }
        },
      ),
    );
  }
}

 // Column(
                  //   children: <Widget>[
                  //     Positioned.fill(
                  //       child: Image(
                  //         fit: BoxFit.fitWidth,
                  //         image: NetworkImage(products[index].pImage),
                  //       ),
                  //     ),
                  //     Text(
                  //       products[index].pName,
                  //       style: const TextStyle(fontWeight: FontWeight.bold),
                  //     ),
                  //     Text(
                  //       '\$ ${products[index].pInterest}',
                  //       style: const TextStyle(fontWeight: FontWeight.bold),
                  //     )
                  //   ],
                  // ),