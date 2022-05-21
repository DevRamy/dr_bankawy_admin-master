
class Order {
  String documentId;
  String userEmail;
  bool isAccepted;
  bool isReviewed;
  dynamic createdDate;
  String productId;
  String productName;
  Order({
    this.documentId,
    this.userEmail,
    this.isAccepted,
    this.isReviewed,
    this.createdDate,
    this.productId,
    this.productName,
  });
}
