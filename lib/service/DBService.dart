import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glimpse_my_feeds/model/FeedItem.dart';

class DBService {
  final _db = FirebaseFirestore.instance;

  Future<void> saveFeed(FeedItem feed) {
    return _db
        .collection('users')
        .doc('ushn@gmail.com')
        .collection('feeds')
        .doc()
        .set(feed.toMap());
  }

  Stream<List<FeedItem>> getFeeds() {
    print('get feeds called');
    return _db
        .collection('users')
        .doc('ushn@gmail.com')
        .collection('feeds')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((document) =>
                FeedItem.fromFirestore(document.data(), document.id))
            .toList());
  }

  Future<void> deleteFeed(String feedId) {
    return _db
        .collection('users')
        .doc('ushn@gmail.com')
        .collection('feeds')
        .doc(feedId)
        .delete();
  }

  // Stream<List<SupplierQuotation>> getSupplierQuatations() {
  //   var object = _db
  //       .collection('supplierQuotation')
  //       .snapshots()
  //       .map((snapshot) => snapshot.documents
  //           .map(
  //             (document) => SupplierQuotation.fromFirestore(document.data),
  //           )
  //           .toList());

  //   return object;
  // }

  // Stream<List<SupplierQuotation>> getSupplierQuatationsOnly(String req) {
  //   var object = _db
  //       .collection('supplierQuotation')
  //       .where('requisition.reqNo', isEqualTo: req)
  //       .snapshots()
  //       .map((snapshot) => snapshot.documents
  //           .map(
  //             (document) => SupplierQuotation.fromFirestore(document.data),
  //           )
  //           .toList());

  //   return object;
  // }

  // Stream<List<PurchaseOrder>> getPurchaseOrders() {
  //   return Firestore.instance
  //       .collection('purchaseOrders')
  //       .snapshots()
  //       .map(_purchaseOrdersFromSnapshot);
  //   // return list;
  // }

  // List<PurchaseOrder> _purchaseOrdersFromSnapshot(QuerySnapshot snapshot) {
  //   return snapshot.documents.map((doc) {
  //     List<PurchaseOrderItem> items = [];
  //     List<dynamic> itemsMap = doc['poItems'];

  //     itemsMap.forEach((element) {
  //       print(element['quotation']);
  //       items.add(new PurchaseOrderItem(
  //         approvedBy: element['approvedBy'],
  //         department: element['department'],
  //         diliveryAddress: element['diliveryAddress'],
  //         phone: element['phone'],
  //         diliveryDate: element['diliveryDate'],
  //         requestedBy: element['requestedBy'],
  //         quotation: new SupplierQuotation(
  //             details: element['quotation']['details'].toString(),
  //             supplier: Supplier(
  //                 supplierName: element['quotation']['supplier']['supplierName']
  //                         .toString() ??
  //                     'N/A',
  //                 supplierTerm: element['quotation']['supplier']['supplierTerm']
  //                         .toString() ??
  //                     'N/A',
  //                 phoneNo:
  //                     element['quotation']['supplier']['phoneNo'].toString() ??
  //                         'N/A',
  //                 email: element['quotation']['supplier']['email'].toString() ??
  //                     'N/A'),
  //             product: Product(
  //               desc:
  //                   element['quotation']['product']['desc'].toString() ?? 'N/A',
  //               price: double.parse(
  //                       element['quotation']['product']['price'].toString() ??
  //                           0) ??
  //                   0,
  //               qty: double.parse(
  //                       element['quotation']['product']['qty'].toString() ??
  //                           0) ??
  //                   0,
  //               discount: element['quotation']['product']['discount'] == null
  //                   ? 0
  //                   : element['quotation']['product']['discount'],
  //               code:
  //                   element['quotation']['product']['code'].toString() ?? 'N/A',
  //             ),
  //             requisition: Requisition(
  //               reqNo: element['quotation']['requisition']['reqNo'].toString(),
  //               location:
  //                   element['quotation']['requisition']['location'].toString(),
  //             )),
  //       ));
  //     });
  //     // print(items);
  //     return PurchaseOrder(
  //       date: doc['date'] ?? 'N/A',
  //       poItems: items,
  //       reqNo: doc['reqNo'] ?? 'N/A',
  //       totPrice: double.parse(doc['total'].toString()) ?? 'N/A',
  //     );
  //   }).toList();
  // }

  // Future<void> savePurchaseOrder(PurchaseOrder order) {
  //   return _db
  //       .collection('purchaseOrders')
  //       .document(order.reqNo)
  //       .setData(order.toMap());
  // }

  // Future<void> savePurchaseOrderDraft(PurchaseOrder order) {
  //   return _db
  //       .collection('purchaseOrdersDrafts')
  //       .document(order.reqNo)
  //       .setData(order.toMap());
  // }

  // Future<void> removePO(String productId) {
  //   return _db.collection('purchaseOrders').document(productId).delete();
  // }

  // Future<void> savePurchaseOrderPayments(PurchaseOrderPayment order) {
  //   return _db
  //       .collection('purchaseOrderPayment')
  //       .document(order.payment.paymentID)
  //       .setData(order.toMap());
  // }
}
