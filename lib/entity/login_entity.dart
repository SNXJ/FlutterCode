class LoginEntity {
  int? code;
  String? message;
  Data? data;

  LoginEntity({this.code, this.message, this.data});

  LoginEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? supplierName;
  String? shopName;
  String? supplierCategoryName;
  Null? supplierType;
  double? amount;
  double? collectAmount;
  int? refundAmount;
  int? orderProgress;
  int? completeOrder;
  int? cancelOrder;
  int? refundValidOrder;
  int? toBeBilled;
  int? toBeFound;
  int? toBeDeliver;
  int? agent;

  Data(
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

  Data.fromJson(Map<String, dynamic> json) {
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
