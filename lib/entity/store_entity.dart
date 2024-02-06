class StoreEntity {
  String? supplierName;
  String? shopName;
  String? supplierCategoryName;
  String? supplierType;
  num? amount;
  num? collectAmount;
  num? refundAmount;
  int? orderProgress;
  int? completeOrder;
  int? cancelOrder;
  int? refundValidOrder;
  int? toBeBilled;
  int? toBeFound;
  int? toBeDeliver;
  int? agent;

  StoreEntity(
      {this.supplierName,
        this.shopName,
        this.supplierCategoryName,
        this.supplierType,
        this.amount,
        this.collectAmount,
        this.refundAmount,
        this.orderProgress,
        this.completeOrder,
        this.cancelOrder,
        this.refundValidOrder,
        this.toBeBilled,
        this.toBeFound,
        this.toBeDeliver,
        this.agent});

  StoreEntity.fromJson(Map<String, dynamic> json) {
    supplierName = json['supplierName'];
    shopName = json['shopName'];
    supplierCategoryName = json['supplierCategoryName'];
    supplierType = json['supplierType'];
    amount = json['amount'];
    collectAmount = json['collectAmount'];
    refundAmount = json['refundAmount'];
    orderProgress = json['orderProgress'];
    completeOrder = json['completeOrder'];
    cancelOrder = json['cancelOrder'];
    refundValidOrder = json['refundValidOrder'];
    toBeBilled = json['toBeBilled'];
    toBeFound = json['toBeFound'];
    toBeDeliver = json['toBeDeliver'];
    agent = json['agent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['supplierName'] = this.supplierName;
    data['shopName'] = this.shopName;
    data['supplierCategoryName'] = this.supplierCategoryName;
    data['supplierType'] = this.supplierType;
    data['amount'] = this.amount;
    data['collectAmount'] = this.collectAmount;
    data['refundAmount'] = this.refundAmount;
    data['orderProgress'] = this.orderProgress;
    data['completeOrder'] = this.completeOrder;
    data['cancelOrder'] = this.cancelOrder;
    data['refundValidOrder'] = this.refundValidOrder;
    data['toBeBilled'] = this.toBeBilled;
    data['toBeFound'] = this.toBeFound;
    data['toBeDeliver'] = this.toBeDeliver;
    data['agent'] = this.agent;
    return data;
  }
}
