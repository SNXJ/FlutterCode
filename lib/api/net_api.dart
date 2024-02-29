class NetApi {
  static String TOKEN = '';
  static String BASE_URL = "https://backend.shwoody.com";

  static const String TOKEN_REFRESH =
      "/wd-base-user/o/api/supplier/refreshToken";
  static const String LOGIN = "/wd-base-user/o/api/supplier/login";
  static const String LOGIN_MULTI = "/wd-base-user/o/api/supplier/multi/login";
  static const String TOKEN_SWITCH = "/wd-base-user/o/api/supplier/switchToken";

  static const String STORE =
      "/wd-life-app-supplier/api/v2/consumer/finance/storeFlow";

  static const String ORDER_PAGE = "/wd-life-app-supplier/order/page";

  static const String SHARE_INFO = "/wd-life-app-supplier/share/statistics";
  static const String SHARE_LIST_PAGE = "/wd-life-app-supplier/share/page";
  static const String SHARE_DETAIL_PAGE =
      "/wd-life-app-supplier/share/detail/page";

  static const String ORDER_STATUS_COUNT =
      "/wd-life-app-supplier/order/orderStatusCount";

  static const String ORDER_APGE =
      "/wd-life-app-supplier/order/page";
}
