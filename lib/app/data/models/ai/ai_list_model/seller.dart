class Seller {
  final String? id;
  final String? phone;
  final String? name;

  Seller({this.id, this.phone, this.name});

  factory Seller.fromJson(Map<String, dynamic> json) {
    return Seller(
      id: json['_id'],
      phone: json['phone'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'phone': phone,
      'name': name,
    };
  }
}