class ContactedSellerRequest {
  final String propertyId;
  final String message;
  final BuyerContact buyerContact;

  ContactedSellerRequest({
    required this.propertyId,
    required this.message,
    required this.buyerContact,
  });

  Map<String, dynamic> toJson() => {
    'propertyId': propertyId,
    'message': message,
    'buyerContact': buyerContact.toJson(),
  };
}

class BuyerContact {
  final String contactMethod;
  final String phone;

  BuyerContact({
    required this.contactMethod,
    required this.phone,
  });

  Map<String, dynamic> toJson() => {
    'contactMethod': contactMethod,
    'phone': phone,
  };
}