
class Contact
{
  Contact({
    this.name,
    this.phone,
    this.whatsapp,
    this.type});

  Contact.fromJson(dynamic json)
  {
    name = json['name'];
    phone = json['phone'];
    whatsapp = json['whatsapp'];
    type = json['type'];
  }
  String? name;
  String? phone;
  String? whatsapp;
  String? type;

  Map<String, dynamic> toJson()
  {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['phone'] = phone;
    map['whatsapp'] = whatsapp;
    map['type'] = type;
    return map;
  }

}
