import 'package:dr_bankawy/constants.dart';
import 'package:dr_bankawy/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Store {
  final Firestore _firestore = Firestore.instance;

  addProduct(Product product) {
    _firestore.collection(kProductsCollection).add({
      kProductName: product.pName,
      kProductImage: product.pImage,
      kProductInterest: product.pInterest,
      kProductDescription: product.pDescription,
      kProductPhone: product.pPhone,
      kProductLatitude: product.pLatitude,
      kProductLongitude: product.pLongitude,
      kProductCategory: product.pCategory,
      kProductDuration: product.pDuration,
      kProductPapers: product.pPapers,
      //kProductType: product.pType,
    });
  }

  Stream<QuerySnapshot> loadProducts() {
    return _firestore.collection(kProductsCollection).snapshots();
  }

  deleteProduct(documentId) {
    _firestore.collection(kProductsCollection).document(documentId).delete();
  }

  Future<DocumentSnapshot> getProdcut(documentId) {
    return _firestore
        .collection(kProductsCollection)
        .document(documentId)
        .get();
  }

  editProduct(data, documentId) {
    _firestore
        .collection(kProductsCollection)
        .document(documentId)
        .updateData(data);
  }

  editOrder(data, documentId) {
    _firestore.collection(kOrders).document(documentId).updateData(data);
  }

  Stream<QuerySnapshot> loadOrders() {
    return _firestore.collection(kOrders).snapshots();
  }

  Stream<QuerySnapshot> loadOrderDetails(documentId) {
    return _firestore
        .collection(kOrders)
        .document(documentId)
        .collection(kOrderDetails)
        .snapshots();
  }

  storeOrders(data, List<Product> products) {
    var documentRef = _firestore.collection(kOrders).document();
    documentRef.setData(data);
    for (var product in products) {
      documentRef.collection(kOrderDetails).document().setData({
        kProductName: product.pName,
        kProductInterest: product.pInterest,
        kProductQuantity: product.pQuantity,
        kProductLatitude: product.pLatitude,
        kProductLongitude: product.pLongitude,
        kProductCategory: product.pCategory
      });
    }
  }
}
