import 'datum_offers.dart';

class OffersResponse {
  List<DatumOffers>? data;
  dynamic successMessage;
  int? statusCode;
  List<dynamic>? errorList;
  dynamic validationErrorList;
  bool? isSuccess;
  dynamic totalRecords;

  OffersResponse({
    this.data,
    this.successMessage,
    this.statusCode,
    this.errorList,
    this.validationErrorList,
    this.isSuccess,
    this.totalRecords,
  });

  factory OffersResponse.fromJson(Map<String, dynamic> json) {
    return OffersResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DatumOffers.fromJson(e as Map<String, dynamic>))
          .toList(),
      successMessage: json['successMessage'] as dynamic,
      statusCode: json['statusCode'] as int?,
      errorList: json['errorList'] as List<dynamic>?,
      validationErrorList: json['validationErrorList'] as dynamic,
      isSuccess: json['isSuccess'] as bool?,
      totalRecords: json['totalRecords'] as dynamic,
    );
  }

  Map<String, dynamic> toJson() => {
    'data': data?.map((e) => e.toJson()).toList(),
    'successMessage': successMessage,
    'statusCode': statusCode,
    'errorList': errorList,
    'validationErrorList': validationErrorList,
    'isSuccess': isSuccess,
    'totalRecords': totalRecords,
  };
}
