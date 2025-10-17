
class RelatedLeads {
  RelatedLeads({
    this.id,
    this.name,
    this.phone,});

  RelatedLeads.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    phone = json['phone'];
  }
  String? id;
  String? name;
  String? phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['phone'] = phone;
    return map;
  }

}