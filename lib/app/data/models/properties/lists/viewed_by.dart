
class ViewedBy
{
  ViewedBy({
    this.user,
    this.viewedAt,
    this.id});

  ViewedBy.fromJson(dynamic json)
  {
    user = json['user'];
    viewedAt = json['viewedAt'];
    id = json['_id'];
  }
  String? user;
  String? viewedAt;
  String? id;

  Map<String, dynamic> toJson()
  {
    final map = <String, dynamic>{};
    map['user'] = user;
    map['viewedAt'] = viewedAt;
    map['_id'] = id;
    return map;
  }

}