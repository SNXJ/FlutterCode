class OrderEntity {
  List<Records>? records;
  num? total;
  num? size;
  num? current;
  List<Orders>? orders;
  bool? optimizeCountSql;
  bool? searchCount;
  String? countId;
  String? maxLimit;
  num? pages;

  OrderEntity(
      {this.records,
      this.total,
      this.size,
      this.current,
      this.orders,
      this.optimizeCountSql,
      this.searchCount,
      this.countId,
      this.maxLimit,
      this.pages});

  OrderEntity.fromJson(Map<String, dynamic> json) {
    if (json['records'] != null) {
      records = <Records>[];
      json['records'].forEach((v) {
        records!.add(new Records.fromJson(v));
      });
    }
    total = json['total'];
    size = json['size'];
    current = json['current'];
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(new Orders.fromJson(v));
      });
    }
    optimizeCountSql = json['optimizeCountSql'];
    searchCount = json['searchCount'];
    countId = json['countId'];
    maxLimit = json['maxLimit'];
    pages = json['pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.records != null) {
      data['records'] = this.records!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['size'] = this.size;
    data['current'] = this.current;
    if (this.orders != null) {
      data['orders'] = this.orders!.map((v) => v.toJson()).toList();
    }
    data['optimizeCountSql'] = this.optimizeCountSql;
    data['searchCount'] = this.searchCount;
    data['countId'] = this.countId;
    data['maxLimit'] = this.maxLimit;
    data['pages'] = this.pages;
    return data;
  }
}

class Records {
  String? lifeRefunds;
  SupplierOrder? supplierOrder;

  Records({this.lifeRefunds, this.supplierOrder});

  Records.fromJson(Map<String, dynamic> json) {
    lifeRefunds = json['lifeRefunds'];
    supplierOrder = json['supplierOrder'] != null
        ? new SupplierOrder.fromJson(json['supplierOrder'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lifeRefunds'] = this.lifeRefunds;
    if (this.supplierOrder != null) {
      data['supplierOrder'] = this.supplierOrder!.toJson();
    }
    return data;
  }
}

class SupplierOrder {
  String? orderNumber;
  String? shopOrderNumber;
  String? tripartiteOrderNumber;
  String? supplierOrderNumber;
  String? sequenceOrderNumber;
  String? dataSource;
  String? orderClient;
  String? orderType;
  String? orderTypeStr;
  UserInfoVO? userInfoVO;
  String? ownUserInfoVO;
  String? shopId;
  String? shopName;
  String? shopLogo;
  String? shopTel;
  String? fansConcern;
  double? pvRate;
  double? fansPvRate;
  double? memberPvRate;
  double? orderPvRate;
  String? fansOpenTime;
  String? supplierId;
  String? supplierName;
  String? userId;
  String? validBeginDate;
  String? validEndDate;
  String? owenUserId;
  String? splitStatus;
  bool? fansStatus;
  String? orderStatus;
  String? orderStatusStr;
  String? afterSaleStatus;
  String? afterSaleStatusStr;
  String? remarks;
  String? supplierOrderRemarksList;
  String? payTime;
  String? confirmTime;
  String? payMethodType;
  String? payMethodTypeStr;
  String? dvyType;
  double? totalFreightPrice;
  double? platFreightPrice;
  double? freightPrice;
  double? totalPrice;
  double? changePrice;
  double? maxOutChangePrice;
  double? accPrice;
  double? accAmount;
  double? totalPv;
  double? sharePv;
  double? accChiobeans;
  double? accCoin;
  double? gainCoin;
  double? coinRate;
  double? totalUserPayAmount;
  double? preIncome;
  num? refundAmount;
  String? invoiceStatus;
  String? createTime;
  String? expirePayTime;
  List<SkuItemInfoList>? skuItemInfoList;
  String? bindEventList;
  String? orderPickupVO;
  String? coinTag;
  String? tagEntityVO;
  String? isSettlement;
  String? shopGainPv;
  String? payNo;
  String? refundedSkuList;
  String? refundableSkuList;
  String? refundFlag;
  String? activityFlag;
  bool? readFlag;
  num? totalOriPrice;
  String? userVirtualPv;
  String? companyVirtualPv;
  String? contactNumber;
  String? kfcWaitCodeTime;
  String? pickupCode;
  String? lifeTradeVO;
  OrderAddrVO? orderAddrVO;
  List<OrderDeliverRecordVOList>? orderDeliverRecordVOList;
  String? orderBizRecords;
  String? transferRecordVOS;
  String? supplierRefundReason;
  String? shareUserInfoVO;

  SupplierOrder(
      {this.orderNumber,
      this.shopOrderNumber,
      this.tripartiteOrderNumber,
      this.supplierOrderNumber,
      this.sequenceOrderNumber,
      this.dataSource,
      this.orderClient,
      this.orderType,
      this.orderTypeStr,
      this.userInfoVO,
      this.ownUserInfoVO,
      this.shopId,
      this.shopName,
      this.shopLogo,
      this.shopTel,
      this.fansConcern,
      this.pvRate,
      this.fansPvRate,
      this.memberPvRate,
      this.orderPvRate,
      this.fansOpenTime,
      this.supplierId,
      this.supplierName,
      this.userId,
      this.validBeginDate,
      this.validEndDate,
      this.owenUserId,
      this.splitStatus,
      this.fansStatus,
      this.orderStatus,
      this.orderStatusStr,
      this.afterSaleStatus,
      this.afterSaleStatusStr,
      this.remarks,
      this.supplierOrderRemarksList,
      this.payTime,
      this.confirmTime,
      this.payMethodType,
      this.payMethodTypeStr,
      this.dvyType,
      this.totalFreightPrice,
      this.platFreightPrice,
      this.freightPrice,
      this.totalPrice,
      this.changePrice,
      this.maxOutChangePrice,
      this.accPrice,
      this.accAmount,
      this.totalPv,
      this.sharePv,
      this.accChiobeans,
      this.accCoin,
      this.gainCoin,
      this.coinRate,
      this.totalUserPayAmount,
      this.preIncome,
      this.refundAmount,
      this.invoiceStatus,
      this.createTime,
      this.expirePayTime,
      this.skuItemInfoList,
      this.bindEventList,
      this.orderPickupVO,
      this.coinTag,
      this.tagEntityVO,
      this.isSettlement,
      this.shopGainPv,
      this.payNo,
      this.refundedSkuList,
      this.refundableSkuList,
      this.refundFlag,
      this.activityFlag,
      this.readFlag,
      this.totalOriPrice,
      this.userVirtualPv,
      this.companyVirtualPv,
      this.contactNumber,
      this.kfcWaitCodeTime,
      this.pickupCode,
      this.lifeTradeVO,
      this.orderAddrVO,
      this.orderDeliverRecordVOList,
      this.orderBizRecords,
      this.transferRecordVOS,
      this.supplierRefundReason,
      this.shareUserInfoVO});

  SupplierOrder.fromJson(Map<String, dynamic> json) {
    orderNumber = json['orderNumber'];
    shopOrderNumber = json['shopOrderNumber'];
    tripartiteOrderNumber = json['tripartiteOrderNumber'];
    supplierOrderNumber = json['supplierOrderNumber'];
    sequenceOrderNumber = json['sequenceOrderNumber'];
    dataSource = json['dataSource'];
    orderClient = json['orderClient'];
    orderType = json['orderType'];
    orderTypeStr = json['orderTypeStr'];
    userInfoVO = json['userInfoVO'] != null
        ? new UserInfoVO.fromJson(json['userInfoVO'])
        : null;
    ownUserInfoVO = json['ownUserInfoVO'];
    shopId = json['shopId'];
    shopName = json['shopName'];
    shopLogo = json['shopLogo'];
    shopTel = json['shopTel'];
    fansConcern = json['fansConcern'];
    pvRate = json['pvRate'];
    fansPvRate = json['fansPvRate'];
    memberPvRate = json['memberPvRate'];
    orderPvRate = json['orderPvRate'];
    fansOpenTime = json['fansOpenTime'];
    supplierId = json['supplierId'];
    supplierName = json['supplierName'];
    userId = json['userId'];
    validBeginDate = json['validBeginDate'];
    validEndDate = json['validEndDate'];
    owenUserId = json['owenUserId'];
    splitStatus = json['splitStatus'];
    fansStatus = json['fansStatus'];
    orderStatus = json['orderStatus'];
    orderStatusStr = json['orderStatusStr'];
    afterSaleStatus = json['afterSaleStatus'];
    afterSaleStatusStr = json['afterSaleStatusStr'];
    remarks = json['remarks'];
    supplierOrderRemarksList = json['supplierOrderRemarksList'];
    payTime = json['payTime'];
    confirmTime = json['confirmTime'];
    payMethodType = json['payMethodType'];
    payMethodTypeStr = json['payMethodTypeStr'];
    dvyType = json['dvyType'];
    totalFreightPrice = json['totalFreightPrice'];
    platFreightPrice = json['platFreightPrice'];
    freightPrice = json['freightPrice'];
    totalPrice = json['totalPrice'];
    changePrice = json['changePrice'];
    maxOutChangePrice = json['maxOutChangePrice'];
    accPrice = json['accPrice'];
    accAmount = json['accAmount'];
    totalPv = json['totalPv'];
    sharePv = json['sharePv'];
    accChiobeans = json['accChiobeans'];
    accCoin = json['accCoin'];
    gainCoin = json['gainCoin'];
    coinRate = json['coinRate'];
    totalUserPayAmount = json['totalUserPayAmount'];
    preIncome = json['preIncome'];
    refundAmount = json['refundAmount'];
    invoiceStatus = json['invoiceStatus'];
    createTime = json['createTime'];
    expirePayTime = json['expirePayTime'];
    if (json['skuItemInfoList'] != null) {
      skuItemInfoList = <SkuItemInfoList>[];
      json['skuItemInfoList'].forEach((v) {
        skuItemInfoList!.add(new SkuItemInfoList.fromJson(v));
      });
    }
    bindEventList = json['bindEventList'];
    orderPickupVO = json['orderPickupVO'];
    coinTag = json['coinTag'];
    tagEntityVO = json['tagEntityVO'];
    isSettlement = json['isSettlement'];
    shopGainPv = json['shopGainPv'];
    payNo = json['payNo'];
    refundedSkuList = json['refundedSkuList'];
    refundableSkuList = json['refundableSkuList'];
    refundFlag = json['refundFlag'];
    activityFlag = json['activityFlag'];
    readFlag = json['readFlag'];
    totalOriPrice = json['totalOriPrice'];
    userVirtualPv = json['userVirtualPv'];
    companyVirtualPv = json['companyVirtualPv'];
    contactNumber = json['contactNumber'];
    kfcWaitCodeTime = json['kfcWaitCodeTime'];
    pickupCode = json['pickupCode'];
    lifeTradeVO = json['lifeTradeVO'];
    orderAddrVO = json['orderAddrVO'] != null
        ? new OrderAddrVO.fromJson(json['orderAddrVO'])
        : null;
    if (json['orderDeliverRecordVOList'] != null) {
      orderDeliverRecordVOList = <OrderDeliverRecordVOList>[];
      json['orderDeliverRecordVOList'].forEach((v) {
        orderDeliverRecordVOList!.add(new OrderDeliverRecordVOList.fromJson(v));
      });
    }
    orderBizRecords = json['orderBizRecords'];
    transferRecordVOS = json['transferRecordVOS'];
    supplierRefundReason = json['supplierRefundReason'];
    shareUserInfoVO = json['shareUserInfoVO'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderNumber'] = this.orderNumber;
    data['shopOrderNumber'] = this.shopOrderNumber;
    data['tripartiteOrderNumber'] = this.tripartiteOrderNumber;
    data['supplierOrderNumber'] = this.supplierOrderNumber;
    data['sequenceOrderNumber'] = this.sequenceOrderNumber;
    data['dataSource'] = this.dataSource;
    data['orderClient'] = this.orderClient;
    data['orderType'] = this.orderType;
    data['orderTypeStr'] = this.orderTypeStr;
    if (this.userInfoVO != null) {
      data['userInfoVO'] = this.userInfoVO!.toJson();
    }
    data['ownUserInfoVO'] = this.ownUserInfoVO;
    data['shopId'] = this.shopId;
    data['shopName'] = this.shopName;
    data['shopLogo'] = this.shopLogo;
    data['shopTel'] = this.shopTel;
    data['fansConcern'] = this.fansConcern;
    data['pvRate'] = this.pvRate;
    data['fansPvRate'] = this.fansPvRate;
    data['memberPvRate'] = this.memberPvRate;
    data['orderPvRate'] = this.orderPvRate;
    data['fansOpenTime'] = this.fansOpenTime;
    data['supplierId'] = this.supplierId;
    data['supplierName'] = this.supplierName;
    data['userId'] = this.userId;
    data['validBeginDate'] = this.validBeginDate;
    data['validEndDate'] = this.validEndDate;
    data['owenUserId'] = this.owenUserId;
    data['splitStatus'] = this.splitStatus;
    data['fansStatus'] = this.fansStatus;
    data['orderStatus'] = this.orderStatus;
    data['orderStatusStr'] = this.orderStatusStr;
    data['afterSaleStatus'] = this.afterSaleStatus;
    data['afterSaleStatusStr'] = this.afterSaleStatusStr;
    data['remarks'] = this.remarks;
    data['supplierOrderRemarksList'] = this.supplierOrderRemarksList;
    data['payTime'] = this.payTime;
    data['confirmTime'] = this.confirmTime;
    data['payMethodType'] = this.payMethodType;
    data['payMethodTypeStr'] = this.payMethodTypeStr;
    data['dvyType'] = this.dvyType;
    data['totalFreightPrice'] = this.totalFreightPrice;
    data['platFreightPrice'] = this.platFreightPrice;
    data['freightPrice'] = this.freightPrice;
    data['totalPrice'] = this.totalPrice;
    data['changePrice'] = this.changePrice;
    data['maxOutChangePrice'] = this.maxOutChangePrice;
    data['accPrice'] = this.accPrice;
    data['accAmount'] = this.accAmount;
    data['totalPv'] = this.totalPv;
    data['sharePv'] = this.sharePv;
    data['accChiobeans'] = this.accChiobeans;
    data['accCoin'] = this.accCoin;
    data['gainCoin'] = this.gainCoin;
    data['coinRate'] = this.coinRate;
    data['totalUserPayAmount'] = this.totalUserPayAmount;
    data['preIncome'] = this.preIncome;
    data['refundAmount'] = this.refundAmount;
    data['invoiceStatus'] = this.invoiceStatus;
    data['createTime'] = this.createTime;
    data['expirePayTime'] = this.expirePayTime;
    if (this.skuItemInfoList != null) {
      data['skuItemInfoList'] =
          this.skuItemInfoList!.map((v) => v.toJson()).toList();
    }
    data['bindEventList'] = this.bindEventList;
    data['orderPickupVO'] = this.orderPickupVO;
    data['coinTag'] = this.coinTag;
    data['tagEntityVO'] = this.tagEntityVO;
    data['isSettlement'] = this.isSettlement;
    data['shopGainPv'] = this.shopGainPv;
    data['payNo'] = this.payNo;
    data['refundedSkuList'] = this.refundedSkuList;
    data['refundableSkuList'] = this.refundableSkuList;
    data['refundFlag'] = this.refundFlag;
    data['activityFlag'] = this.activityFlag;
    data['readFlag'] = this.readFlag;
    data['totalOriPrice'] = this.totalOriPrice;
    data['userVirtualPv'] = this.userVirtualPv;
    data['companyVirtualPv'] = this.companyVirtualPv;
    data['contactNumber'] = this.contactNumber;
    data['kfcWaitCodeTime'] = this.kfcWaitCodeTime;
    data['pickupCode'] = this.pickupCode;
    data['lifeTradeVO'] = this.lifeTradeVO;
    if (this.orderAddrVO != null) {
      data['orderAddrVO'] = this.orderAddrVO!.toJson();
    }
    if (this.orderDeliverRecordVOList != null) {
      data['orderDeliverRecordVOList'] =
          this.orderDeliverRecordVOList!.map((v) => v.toJson()).toList();
    }
    data['orderBizRecords'] = this.orderBizRecords;
    data['transferRecordVOS'] = this.transferRecordVOS;
    data['supplierRefundReason'] = this.supplierRefundReason;
    data['shareUserInfoVO'] = this.shareUserInfoVO;
    return data;
  }
}

class UserInfoVO {
  String? userId;
  String? registerSource;
  String? userMobile;
  String? userName;
  String? nickName;
  String? sex;
  int? picFileId;
  String? pic;
  String? createTime;
  num? status;
  String? userType;
  String? accountBizId;

  UserInfoVO(
      {this.userId,
      this.registerSource,
      this.userMobile,
      this.userName,
      this.nickName,
      this.sex,
      this.picFileId,
      this.pic,
      this.createTime,
      this.status,
      this.userType,
      this.accountBizId});

  UserInfoVO.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    registerSource = json['registerSource'];
    userMobile = json['userMobile'];
    userName = json['userName'];
    nickName = json['nickName'];
    sex = json['sex'];
    picFileId = json['picFileId'];
    pic = json['pic'];
    createTime = json['createTime'];
    status = json['status'];
    userType = json['userType'];
    accountBizId = json['accountBizId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['registerSource'] = this.registerSource;
    data['userMobile'] = this.userMobile;
    data['userName'] = this.userName;
    data['nickName'] = this.nickName;
    data['sex'] = this.sex;
    data['picFileId'] = this.picFileId;
    data['pic'] = this.pic;
    data['createTime'] = this.createTime;
    data['status'] = this.status;
    data['userType'] = this.userType;
    data['accountBizId'] = this.accountBizId;
    return data;
  }
}

class SkuItemInfoList {
  String? id;
  String? orderSkuId;
  double? price;
  String? refundType;
  double? refundUnitPrice;
  String? availableRefundPrice;
  String? refundPrice;
  double? oriPrice;
  double? costPrice;
  double? changePrice;
  double? maxOutChangePrice;
  double? accPrice;
  double? totalPrice;
  double? accAmount;
  double? accChiobeans;
  String? prodId;
  String? platProdId;
  String? productType;
  String? prodName;
  String? skuNumber;
  String? prodPic;
  num? brandId;
  String? brandName;
  String? categoryId;
  String? categoryName;
  String? skuId;
  String? skuJson;
  num? qty;
  num? productCoin;
  num? accCoin;
  num? gainCoin;
  String? coinRate;
  String? afterSalesStatus;
  String? sharePv;
  String? availableRefundAmount;
  String? refuseReason;
  String? orderProductStatua;
  String? refundStatus;
  String? refundSubStatusStr;
  String? refundSubStatus;
  String? refundTime;
  String? unit;
  num? afterSalePeriod;
  String? extendAfterSalePeriod;
  String? refundNumber;
  String? supplierId;
  String? supplierName;
  String? qrImgUrl;
  String? ticketCode;
  String? locationId;

  SkuItemInfoList(
      {this.id,
      this.orderSkuId,
      this.price,
      this.refundType,
      this.refundUnitPrice,
      this.availableRefundPrice,
      this.refundPrice,
      this.oriPrice,
      this.costPrice,
      this.changePrice,
      this.maxOutChangePrice,
      this.accPrice,
      this.totalPrice,
      this.accAmount,
      this.accChiobeans,
      this.prodId,
      this.platProdId,
      this.productType,
      this.prodName,
      this.skuNumber,
      this.prodPic,
      this.brandId,
      this.brandName,
      this.categoryId,
      this.categoryName,
      this.skuId,
      this.skuJson,
      this.qty,
      this.productCoin,
      this.accCoin,
      this.gainCoin,
      this.coinRate,
      this.afterSalesStatus,
      this.sharePv,
      this.availableRefundAmount,
      this.refuseReason,
      this.orderProductStatua,
      this.refundStatus,
      this.refundSubStatusStr,
      this.refundSubStatus,
      this.refundTime,
      this.unit,
      this.afterSalePeriod,
      this.extendAfterSalePeriod,
      this.refundNumber,
      this.supplierId,
      this.supplierName,
      this.qrImgUrl,
      this.ticketCode,
      this.locationId});

  SkuItemInfoList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderSkuId = json['orderSkuId'];
    price = json['price'];
    refundType = json['refundType'];
    refundUnitPrice = json['refundUnitPrice'];
    availableRefundPrice = json['availableRefundPrice'];
    refundPrice = json['refundPrice'];
    oriPrice = json['oriPrice'];
    costPrice = json['costPrice'];
    changePrice = json['changePrice'];
    maxOutChangePrice = json['maxOutChangePrice'];
    accPrice = json['accPrice'];
    totalPrice = json['totalPrice'];
    accAmount = json['accAmount'];
    accChiobeans = json['accChiobeans'];
    prodId = json['prodId'];
    platProdId = json['platProdId'];
    productType = json['productType'];
    prodName = json['prodName'];
    skuNumber = json['skuNumber'];
    prodPic = json['prodPic'];
    brandId = json['brandId'];
    brandName = json['brandName'];
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    skuId = json['skuId'];
    skuJson = json['skuJson'];
    qty = json['qty'];
    productCoin = json['productCoin'];
    accCoin = json['accCoin'];
    gainCoin = json['gainCoin'];
    coinRate = json['coinRate'];
    afterSalesStatus = json['afterSalesStatus'];
    sharePv = json['sharePv'];
    availableRefundAmount = json['availableRefundAmount'];
    refuseReason = json['refuseReason'];
    orderProductStatua = json['orderProductStatua'];
    refundStatus = json['refundStatus'];
    refundSubStatusStr = json['refundSubStatusStr'];
    refundSubStatus = json['refundSubStatus'];
    refundTime = json['refundTime'];
    unit = json['unit'];
    afterSalePeriod = json['afterSalePeriod'];
    extendAfterSalePeriod = json['extendAfterSalePeriod'];
    refundNumber = json['refundNumber'];
    supplierId = json['supplierId'];
    supplierName = json['supplierName'];
    qrImgUrl = json['qrImgUrl'];
    ticketCode = json['ticketCode'];
    locationId = json['locationId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['orderSkuId'] = this.orderSkuId;
    data['price'] = this.price;
    data['refundType'] = this.refundType;
    data['refundUnitPrice'] = this.refundUnitPrice;
    data['availableRefundPrice'] = this.availableRefundPrice;
    data['refundPrice'] = this.refundPrice;
    data['oriPrice'] = this.oriPrice;
    data['costPrice'] = this.costPrice;
    data['changePrice'] = this.changePrice;
    data['maxOutChangePrice'] = this.maxOutChangePrice;
    data['accPrice'] = this.accPrice;
    data['totalPrice'] = this.totalPrice;
    data['accAmount'] = this.accAmount;
    data['accChiobeans'] = this.accChiobeans;
    data['prodId'] = this.prodId;
    data['platProdId'] = this.platProdId;
    data['productType'] = this.productType;
    data['prodName'] = this.prodName;
    data['skuNumber'] = this.skuNumber;
    data['prodPic'] = this.prodPic;
    data['brandId'] = this.brandId;
    data['brandName'] = this.brandName;
    data['categoryId'] = this.categoryId;
    data['categoryName'] = this.categoryName;
    data['skuId'] = this.skuId;
    data['skuJson'] = this.skuJson;
    data['qty'] = this.qty;
    data['productCoin'] = this.productCoin;
    data['accCoin'] = this.accCoin;
    data['gainCoin'] = this.gainCoin;
    data['coinRate'] = this.coinRate;
    data['afterSalesStatus'] = this.afterSalesStatus;
    data['sharePv'] = this.sharePv;
    data['availableRefundAmount'] = this.availableRefundAmount;
    data['refuseReason'] = this.refuseReason;
    data['orderProductStatua'] = this.orderProductStatua;
    data['refundStatus'] = this.refundStatus;
    data['refundSubStatusStr'] = this.refundSubStatusStr;
    data['refundSubStatus'] = this.refundSubStatus;
    data['refundTime'] = this.refundTime;
    data['unit'] = this.unit;
    data['afterSalePeriod'] = this.afterSalePeriod;
    data['extendAfterSalePeriod'] = this.extendAfterSalePeriod;
    data['refundNumber'] = this.refundNumber;
    data['supplierId'] = this.supplierId;
    data['supplierName'] = this.supplierName;
    data['qrImgUrl'] = this.qrImgUrl;
    data['ticketCode'] = this.ticketCode;
    data['locationId'] = this.locationId;
    return data;
  }
}

class OrderAddrVO {
  num? id;
  String? orderNumber;
  String? receiveName;
  String? receiveMobile;
  String? addrName;
  num? provinceId;
  String? province;
  num? cityId;
  String? city;
  num? areaId;
  String? area;
  String? addr;
  String? lat;
  String? lng;
  String? postCode;
  String? createTime;
  String? updateTime;
  num? createUserId;
  num? updateUserId;
  String? tag;
  String? homeAddr;
  String? townId;

  OrderAddrVO(
      {this.id,
      this.orderNumber,
      this.receiveName,
      this.receiveMobile,
      this.addrName,
      this.provinceId,
      this.province,
      this.cityId,
      this.city,
      this.areaId,
      this.area,
      this.addr,
      this.lat,
      this.lng,
      this.postCode,
      this.createTime,
      this.updateTime,
      this.createUserId,
      this.updateUserId,
      this.tag,
      this.homeAddr,
      this.townId});

  OrderAddrVO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNumber = json['orderNumber'];
    receiveName = json['receiveName'];
    receiveMobile = json['receiveMobile'];
    addrName = json['addrName'];
    provinceId = json['provinceId'];
    province = json['province'];
    cityId = json['cityId'];
    city = json['city'];
    areaId = json['areaId'];
    area = json['area'];
    addr = json['addr'];
    lat = json['lat'];
    lng = json['lng'];
    postCode = json['postCode'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
    createUserId = json['createUserId'];
    updateUserId = json['updateUserId'];
    tag = json['tag'];
    homeAddr = json['homeAddr'];
    townId = json['townId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['orderNumber'] = this.orderNumber;
    data['receiveName'] = this.receiveName;
    data['receiveMobile'] = this.receiveMobile;
    data['addrName'] = this.addrName;
    data['provinceId'] = this.provinceId;
    data['province'] = this.province;
    data['cityId'] = this.cityId;
    data['city'] = this.city;
    data['areaId'] = this.areaId;
    data['area'] = this.area;
    data['addr'] = this.addr;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['postCode'] = this.postCode;
    data['createTime'] = this.createTime;
    data['updateTime'] = this.updateTime;
    data['createUserId'] = this.createUserId;
    data['updateUserId'] = this.updateUserId;
    data['tag'] = this.tag;
    data['homeAddr'] = this.homeAddr;
    data['townId'] = this.townId;
    return data;
  }
}

class OrderDeliverRecordVOList {
  num? id;
  String? orderNumber;
  String? shopOrderNumber;
  String? orderSkuId;
  String? deliverCompany;
  String? deliverCompanyCode;
  String? transportNumber;
  String? createTime;
  String? updateTime;
  num? createUserId;
  num? updateUserId;
  String? dvyType;
  String? deliverStatus;
  String? shopName;
  String? supplierName;
  String? receiveMobile;

  OrderDeliverRecordVOList(
      {this.id,
      this.orderNumber,
      this.shopOrderNumber,
      this.orderSkuId,
      this.deliverCompany,
      this.deliverCompanyCode,
      this.transportNumber,
      this.createTime,
      this.updateTime,
      this.createUserId,
      this.updateUserId,
      this.dvyType,
      this.deliverStatus,
      this.shopName,
      this.supplierName,
      this.receiveMobile});

  OrderDeliverRecordVOList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNumber = json['orderNumber'];
    shopOrderNumber = json['shopOrderNumber'];
    orderSkuId = json['orderSkuId'];
    deliverCompany = json['deliverCompany'];
    deliverCompanyCode = json['deliverCompanyCode'];
    transportNumber = json['transportNumber'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
    createUserId = json['createUserId'];
    updateUserId = json['updateUserId'];
    dvyType = json['dvyType'];
    deliverStatus = json['deliverStatus'];
    shopName = json['shopName'];
    supplierName = json['supplierName'];
    receiveMobile = json['receiveMobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['orderNumber'] = this.orderNumber;
    data['shopOrderNumber'] = this.shopOrderNumber;
    data['orderSkuId'] = this.orderSkuId;
    data['deliverCompany'] = this.deliverCompany;
    data['deliverCompanyCode'] = this.deliverCompanyCode;
    data['transportNumber'] = this.transportNumber;
    data['createTime'] = this.createTime;
    data['updateTime'] = this.updateTime;
    data['createUserId'] = this.createUserId;
    data['updateUserId'] = this.updateUserId;
    data['dvyType'] = this.dvyType;
    data['deliverStatus'] = this.deliverStatus;
    data['shopName'] = this.shopName;
    data['supplierName'] = this.supplierName;
    data['receiveMobile'] = this.receiveMobile;
    return data;
  }
}

class Orders {
  num? id;

  Orders({
    this.id,
  });

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}
