class OrderRequest {
  String? dvyType;
  String? endTime;
  String? startTime;
  String? mergeQueryStr;
  String? orderStatus;
  int? current;
  int? size = 20;

  OrderRequest({
    this.dvyType,
    this.endTime,
    this.startTime,
    this.mergeQueryStr,
    this.orderStatus,
    this.current,
    this.size = 20,
  });

  Map<String, dynamic> toMap() {
    return {
      'dvyType': dvyType,
      'endTime': endTime,
      'startTime': startTime,
      'mergeQueryStr': mergeQueryStr,
      'orderStatus': orderStatus,
      'current': current,
      'size': size,
    };
  }
}
