
class Pricing
{
  Pricing({
    this.basePrice,
    this.maintenanceCharges,
    this.securityDeposit,
    this.priceNegotiable});

  Pricing.fromJson(dynamic json)
  {
    basePrice = json['basePrice'];
    maintenanceCharges = json['maintenanceCharges'];
    securityDeposit = json['securityDeposit'];
    priceNegotiable = json['priceNegotiable'];
  }
  dynamic basePrice;
  dynamic maintenanceCharges;
  dynamic securityDeposit;
  bool? priceNegotiable;

  Map<String, dynamic> toJson()
  {
    final map = <String, dynamic>{};
    map['basePrice'] = basePrice;
    map['maintenanceCharges'] = maintenanceCharges;
    map['securityDeposit'] = securityDeposit;
    map['priceNegotiable'] = priceNegotiable;
    return map;
  }

}