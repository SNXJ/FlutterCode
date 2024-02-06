class Shop {
  String? shopId;
  String? shopName;
  String? employeeId;

  Shop({this.shopId, this.shopName, this.employeeId});

  Shop.fromJson(Map<String, dynamic> json) {
    shopId = json['shopId'];
    shopName = json['shopName'];
    employeeId = json['employeeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shopId'] = this.shopId;
    data['shopName'] = this.shopName;
    data['employeeId'] = this.employeeId;
    return data;
  }
}