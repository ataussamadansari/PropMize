
class Seller
{
  Seller({
    this.id,
    this.phone,
    this.avatar,
    this.isEmailVerified,
    this.isPhoneVerified,
    this.email,
    this.name});

  Seller.fromJson(dynamic json)
  {
    id = json['_id'];
    phone = json['phone'];
    avatar = json['avatar'];
    isEmailVerified = json['isEmailVerified'];
    isPhoneVerified = json['isPhoneVerified'];
    email = json['email'];
    name = json['name'];
  }
  String? id;
  String? phone;
  String? avatar;
  bool? isEmailVerified;
  bool? isPhoneVerified;
  String? email;
  String? name;

  Map<String, dynamic> toJson()
  {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['phone'] = phone;
    map['avatar'] = avatar;
    map['isEmailVerified'] = isEmailVerified;
    map['isPhoneVerified'] = isPhoneVerified;
    map['email'] = email;
    map['name'] = name;
    return map;
  }

}
