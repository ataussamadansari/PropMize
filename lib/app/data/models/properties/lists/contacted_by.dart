class ContactedBy
{
  ContactedBy({
    this.user,
    this.contactedAt
  });

  ContactedBy.fromJson(dynamic json)
  {
    user = json['user'];
    contactedAt = json['contactedAt'];
    id = json['_id'];
  }
  String? user;
  String? contactedAt;
  String? id;

  Map<String, dynamic> toJson()
  {
    final map = <String, dynamic>{};
    map['user'] = user;
    map['contactedAt'] = contactedAt;
    map['_id'] = id;
    return map;
  }
}