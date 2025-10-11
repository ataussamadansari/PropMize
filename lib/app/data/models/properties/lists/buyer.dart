
class Buyer
{
  Buyer({
    this.id,
    this.phone,
    this.email,
    this.name});

  Buyer.fromJson(dynamic json)
  {
    id = json['_id'];
    phone = json['phone'];
    email = json['email'];
    name = json['name'];
  }
  String? id;
  String? phone;
  String? email;
  String? name;

  Map<String, dynamic> toJson()
  {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['phone'] = phone;
    map['email'] = email;
    map['name'] = name;
    return map;
  }

}
