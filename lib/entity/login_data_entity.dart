import 'package:wd_store/entity/shop_entity.dart';

class LoginData {
  String? accessToken;
  String? refreshToken;
  int? expiresIn;
  String? isNew;
  List<Shop>? shopList;

  LoginData(
      {this.accessToken,
      this.refreshToken,
      this.expiresIn,
      this.isNew,
      this.shopList});

  LoginData.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    expiresIn = json['expiresIn'];
    isNew = json['isNew'];
    if (json['shopList'] != null) {
      shopList = <Shop>[];
      json['shopList'].forEach((v) {
        shopList!.add(new Shop.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    data['refreshToken'] = this.refreshToken;
    data['expiresIn'] = this.expiresIn;
    data['isNew'] = this.isNew;
    if (this.shopList != null) {
      data['shopList'] = this.shopList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
