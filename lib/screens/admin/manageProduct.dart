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
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: .8,
              ),
              itemBuilder: (context, index) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: GestureDetector(
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
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Image(
                          fit: BoxFit.fitWidth,
                          image: NetworkImage(products[index].pImage),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  products[index].pName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '\$ ${products[index].pInterest}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
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
