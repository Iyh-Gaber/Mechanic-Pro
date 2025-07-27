// lib/feature/orders/data/models/response/order_response/order_number_model.dart

import 'package:json_annotation/json_annotation.dart';

import 'package:json_annotation/json_annotation.dart';
part 'order_number_model.g.dart'; // أضف/تأكد من هذا السطر
// ... بقية الكلاس

@JsonSerializable()
class OrderNumberModel {
  final int? orderNumber;

  OrderNumberModel({this.orderNumber});

  factory OrderNumberModel.fromJson(Map<String, dynamic> json) =>
      _$OrderNumberModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderNumberModelToJson(this);
}
