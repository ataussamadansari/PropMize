
class Seller
{
  Seller({
    this.id,
    this.name,
    this.email,
    this.avatar,
    // this.phone,
    // this.isEmailVerified,
    // this.isPhoneVerified,
  });

  Seller.fromJson(dynamic json)
  {
    id = json['_id'];
    name = json['name'];
    email = json['email'];
    avatar = json['avatar'];
    // phone = json['phone'];
    // isEmailVerified = json['isEmailVerified'];
    // isPhoneVerified = json['isPhoneVerified'];
  }
  String? id;
  String? name;
  String? email;
  String? avatar;
  // String? phone;
  // bool? isEmailVerified;
  // bool? isPhoneVerified;

  Map<String, dynamic> toJson()
  {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['avatar'] = avatar;
    // map['phone'] = phone;
    // map['isEmailVerified'] = isEmailVerified;
    // map['isPhoneVerified'] = isPhoneVerified;
    return map;
  }

}
