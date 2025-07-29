/*class ApiConstants {
  static const String baseUrl = 'http://www.MechPro.somee.com/';
  //static const String mainServices = 'api/Services/GetAllServices/1';
  static const String mainServices = 'api/Services/GetAllServices/1';
  static const String regularMaintenanceServices =
      'api/SubServices/GetAllSubServices/Regular maintenance';
  static const String makeOrder = 'api/Order/MakeOrder';
  static const String getOrders = 'api/Order/GetAllOrdersOfUser/2';
  static const String sellingOriginalParts =
      'api/SubServices/GetAllSubServices/Selling original spare parts';
  // static const String getAllOrders = 'api/Order/GetAllOrders';
}
*/
class ApiConstants {
  static const String baseUrl = 'http://www.MechPro.somee.com/';
  static const String offers = 'api/Offer/GetAllActiveOffers';

  static const String mainServices = 'api/Services/GetAllServices/1';
  static const String otherServices =
      'api/SubServices/GetAllSubServices/Other services';
  static const String regularMaintenanceServices =
      'api/SubServices/GetAllSubServices/Regular maintenance';
  static const String carRental =
      "api/SubServices/GetAllSubServices/Car Rental";
  static const String toolRental =
      "api/SubServices/GetAllSubServices/Tool Rental";
  static const String mechanicalFaults =
      'api/SubServices/GetAllSubServices/Repairing mechanical faults';

  static const String electricalfaults =
      'api/SubServices/GetAllSubServices/Repairing electrical faults';

  static const String makeOrder = 'api/Order/MakeOrder';

  static const String getOrders = 'api/Order/GetAllOrdersOfUser';

  static const String autoBodyRepair =
      'api/SubServices/GetAllSubServices/Auto body repair';

  static const String sellingOriginalParts =
      'api/SubServices/GetAllSubServices/Selling original spare parts';
}
