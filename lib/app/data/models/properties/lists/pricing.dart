
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
    int? basePrice;
    int? maintenanceCharges;
    int? securityDeposit;
    bool? priceNegotiable;

    Map<String, dynamic> toJson()
    {
        final map = <String, dynamic>{};
        if (basePrice != null) 
        {
            map['basePrice'] = basePrice;
        }
        if(maintenanceCharges != null) {
          map['maintenanceCharges'] = maintenanceCharges;
        }
        if (securityDeposit != null) {
          map['securityDeposit'] = securityDeposit;
        }
        map['priceNegotiable'] = priceNegotiable;
        return map;
    }
}
