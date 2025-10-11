

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
  }
  String? user;
  String? contactedAt;

  Map<String, dynamic> toJson()
  {
    final map = <String, dynamic>{};
    map['user'] = user;
    map['contactedAt'] = contactedAt;
    return map;
  }
}