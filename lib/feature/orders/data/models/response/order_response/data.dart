class Data {
  int? orderNumber;

  Data({this.orderNumber});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        orderNumber: json['orderNumber'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'orderNumber': orderNumber,
      };
}
