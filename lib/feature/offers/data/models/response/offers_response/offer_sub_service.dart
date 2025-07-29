/*class OfferSubService {
  OfferSubService();

  factory OfferSubService.fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    throw UnimplementedError(
      'OfferSubService.fromJson($json) is not implemented',
    );
  }

  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
*/
class OfferSubService {
  int? offerId;
  int? subServiceId;

  OfferSubService({
    this.offerId,
    this.subServiceId,
  });

  factory OfferSubService.fromJson(Map<String, dynamic> json) => OfferSubService(
        offerId: json['offerId'] as int?,
        subServiceId: json['subServiceId'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'offerId': offerId,
        'subServiceId': subServiceId,
      };
}
