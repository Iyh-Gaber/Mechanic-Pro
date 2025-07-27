// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderService _$OrderServiceFromJson(Map<String, dynamic> json) => OrderService(
  orderServiceName: json['orderServiceName'] as String?,
  orderSubServices: (json['orderSubServices'] as List<dynamic>?)
      ?.map((e) => OrderRequestSubService.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$OrderServiceToJson(OrderService instance) =>
    <String, dynamic>{
      'orderServiceName': instance.orderServiceName,
      'orderSubServices': instance.orderSubServices,
    };
