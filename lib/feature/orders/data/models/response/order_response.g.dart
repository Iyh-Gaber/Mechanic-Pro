// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderResponse _$OrderResponseFromJson(Map<String, dynamic> json) =>
    OrderResponse(
      data: json['data'],
      successMessage: json['successMessage'] as String?,
      statusCode: (json['statusCode'] as num?)?.toInt(),
      errorList: (json['errorList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      validationErrorList: (json['validationErrorList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      isSuccess: json['isSuccess'] as bool?,
      totalRecords: (json['totalRecords'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OrderResponseToJson(OrderResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'successMessage': instance.successMessage,
      'statusCode': instance.statusCode,
      'errorList': instance.errorList,
      'validationErrorList': instance.validationErrorList,
      'isSuccess': instance.isSuccess,
      'totalRecords': instance.totalRecords,
    };
